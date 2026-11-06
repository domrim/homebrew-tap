class MatrixMigrate < Formula
  desc "CLI to migrate one matrix account to a new one"
  homepage "https://gitlab.com/domrim/matrix-migrate"
  url "https://gitlab.com/domrim/matrix-migrate/-/archive/v0.6.0/matrix-migrate-v0.6.0.tar.gz"
  sha256 "e9f4ea19de5bef3388b6069a34d03649287e240ad78d6b8653cfde61a02d9dba"
  license "MIT"
  head "https://gitlab.com/domrim/matrix-migrate.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/domrim/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "b6904bdaae25f94d85ce58904f0c6e39b9af96c69997b4061899366df45393e9"
    sha256 cellar: :any,                 x86_64_linux: "e37a0ddcc650a6cd468b91896752333ede6bc5ad542f33d5c5a1bd7eadbcdad5"
  end

  depends_on "rust" => :build

  on_linux do
    depends_on "sqlite"
  end

  deny_network_access!

  def fetch
    system "cargo", "fetch", "--locked", "--target", "host-tuple"
  end

  def install
    system "cargo", "install", *std_cargo_args

    generate_completions_from_executable(bin/"matrix-migrate", "completions")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/matrix-migrate --version")
  end
end
