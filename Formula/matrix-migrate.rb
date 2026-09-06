class MatrixMigrate < Formula
  desc "CLI to migrate one matrix account to a new one"
  homepage "https://gitlab.com/domrim/matrix-migrate"
  url "https://gitlab.com/domrim/matrix-migrate/-/archive/v0.5.0/matrix-migrate-v0.5.0.tar.gz"
  sha256 "7ac4f83a397b4474ae643febcff72849cd4e8f7e2a66bb550e5cb099ea5ed878"
  license "MIT"
  head "https://gitlab.com/domrim/matrix-migrate.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/domrim/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "7a5c6f0332ed5cbc1f8d9f26c05ece218ac0f8d297a5a99d09ad009a7e9ca727"
    sha256 cellar: :any,                 x86_64_linux: "120834d70f6af9eb75ee60124e89b095f6c294efd6673289bf7af5eb77cd23d6"
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
