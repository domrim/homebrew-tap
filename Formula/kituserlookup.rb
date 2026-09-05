class Kituserlookup < Formula
  desc "KIT AD Query Tool"
  homepage "https://gitlab.kit.edu/kit/kit-cert/tools/kituserlookup"
  url "https://gitlab.kit.edu/kit/kit-cert/tools/kituserlookup/-/archive/v2.3.2/kituserlookup-v2.3.2.tar.gz"
  sha256 "54433caafb744fee73ead0ea61d1afe009e1ff9a5e74e2a69a7b13bc038c9763"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/domrim/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e8a0736e20a2b0e29c9658d46d06f6949213e08023712ccbba6a5c44d65d7bab"
    sha256 cellar: :any,                 x86_64_linux: "1337617be4cca51f4cf1275360712d9f5a3f2cae041e1e5e039d13f88d8a3926"
  end

  depends_on "go" => :build

  deny_network_access!

  def fetch
    system "go", "mod", "download"
  end

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -extldflags '-static' -X gitlab.kit.edu/kit/kit-cert/tools/kituserlookup/v2/cmd.version=#{version} -X gitlab.kit.edu/kit/kit-cert/tools/kituserlookup/v2/cmd.date=#{Date.today}")

    generate_completions_from_executable(bin/"kituserlookup", shell_parameter_format: :cobra)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kituserlookup version")
  end
end
