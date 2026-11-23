class Kubeone < Formula
  desc "Automate cluster operations on all your environments"
  homepage "https://kubeone.io"
  url "https://github.com/kubermatic/kubeone/archive/refs/tags/v1.15.0.tar.gz"
  sha256 "f7614214f85da4c652e1aa6882ae9e1edae8d6d558e7eb93306dc37c2c5515c2"
  license "Apache-2.0"
  revision 3
  head "https://github.com/kubermatic/kubeone.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/domrim/tap"
    manifest_sha256 "784f4551e1fbe5841c7df64acf7264bbd0535323e404cafedf89eaae35be1967"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "f99e075f4cec823e701b75749f49c5bacf53bb451f8eadd24ed6e22b0b2df688"
    sha256 cellar: :any,                 x86_64_linux: "d0b21c137400caff916af19f3237d5a6cbc2c768fa27bfc6a34636758fbaeaa1"
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
