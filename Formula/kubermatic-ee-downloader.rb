class KubermaticEeDownloader < Formula
  desc "Kubermatic Enterprise CLI Tool Downloader"
  homepage "https://github.com/kubermatic/kubermatic-ee-downloader"
  url "https://github.com/kubermatic/kubermatic-ee-downloader/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "18d2bc3ef11c0873f28d3ba3c70dbe29e43b718561bca268427b29cf87965691"
  license "Apache-2.0"

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
