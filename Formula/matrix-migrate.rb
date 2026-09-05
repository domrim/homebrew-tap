class MatrixMigrate < Formula
  desc "CLI to migrate one matrix account to a new one"
  homepage "https://gitlab.com/domrim/matrix-migrate"
  url "https://gitlab.com/domrim/matrix-migrate/-/archive/v0.5.0/matrix-migrate-v0.5.0.tar.gz"
  sha256 "7ac4f83a397b4474ae643febcff72849cd4e8f7e2a66bb550e5cb099ea5ed878"
  license "MIT"
  head "https://gitlab.com/domrim/matrix-migrate.git", branch: "main"

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
