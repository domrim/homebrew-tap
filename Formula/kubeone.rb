class Kubeone < Formula
  desc "Automate cluster operations on all your environments"
  homepage "https://kubeone.io"
  url "https://github.com/kubermatic/kubeone/archive/refs/tags/v1.15.0.tar.gz"
  sha256 "f7614214f85da4c652e1aa6882ae9e1edae8d6d558e7eb93306dc37c2c5515c2"
  license "Apache-2.0"
  revision 1
  head "https://github.com/kubermatic/kubeone.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/domrim/tap"
    manifest_sha256 "54c0da52e9605220d19cc5478b148f66dbd4c4e3f93a9f340baad52e6d3b9f63"
    sha256 cellar: :any, x86_64_linux: "c2a6b01553e6603ad3292a6f1a21dea218d29b84abdcaf4ca5170340a5dbf21f"
  end

  depends_on "go" => :build

  conflicts_with "kubeone", because: "same formula, different version"

  patch do
    url "https://github.com/kubermatic/kubeone/commit/ed84f5635a911ae095fc838b4f13bf2ec37e3138.patch?full_index=1"
    sha256 "293760108b9eee4cbdc7d4792cf5559d75091ac16b3e4b02289ddf9a3b991f32"
    type :backport
  end

  deny_network_access!

  def fetch
    system "go", "mod", "download"
  end

  def install
    ldflags = %W[
      -X k8c.io/kubeone/pkg/cmd.version=#{version}
      -X k8c.io/kubeone/pkg/cmd.date=#{time.iso8601}
    ]

    system "go", "build", *std_go_args(ldflags:)

    generate_completions_from_executable(bin/"kubeone", "completion")
  end

  test do
    test_config = testpath/"kubeone.yaml"

    test_config.write <<~YAML
      apiVersion: kubeone.k8c.io/v1beta2
      kind: KubeOneCluster

      versions:
        kubernetes: 1.30.1
    YAML

    assert_match "apiEndpoint.port must be greater than 0", shell_output("#{bin}/kubeone status 2>&1", 15)

    assert_match version.to_s, shell_output("#{bin}/kubeone version")
  end
end
