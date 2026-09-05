class Kituserlookup < Formula
  desc "KIT AD Query Tool"
  homepage "https://gitlab.kit.edu/kit/kit-cert/tools/kituserlookup"
  url "https://gitlab.kit.edu/kit/kit-cert/tools/kituserlookup/-/archive/v2.3.2/kituserlookup-v2.3.2.tar.gz"
  sha256 "54433caafb744fee73ead0ea61d1afe009e1ff9a5e74e2a69a7b13bc038c9763"
  license "MIT"

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
