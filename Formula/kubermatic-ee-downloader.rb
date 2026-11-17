class KubermaticEeDownloader < Formula
  desc "Kubermatic Enterprise CLI Tool Downloader"
  homepage "https://github.com/kubermatic/kubermatic-ee-downloader"
  url "https://github.com/kubermatic/kubermatic-ee-downloader/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "18d2bc3ef11c0873f28d3ba3c70dbe29e43b718561bca268427b29cf87965691"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/domrim/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "fc711eb91141a05215f37ff5d6e8b10a550545f613a4b18dbf62f9a79f97b656"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e0015f0f2b94e6ab54dc12db23d91f240d13db5e827a06e313f86079738355ee"
  end

  depends_on "go" => :build

  deny_network_access!

  def fetch
    system "go", "mod", "download"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = "-X 'main.version=#{version}'"
    system "go", "build", *std_go_args(output: bin/"kubermatic-ee-downloader", ldflags:), "./cmd/"
  end

  test do
    assert_match "Download Kubermatic enterprise CLI tools", shell_output("#{bin}/kubermatic-ee-downloader --help")

    assert_match version.to_s, shell_output("#{bin}/kubermatic-ee-downloader --version")
  end
end
