class IpcalcNg < Formula
  desc "Modern IPv4/IPv6 ipcalc tool"
  homepage "https://gitlab.com/ipcalc/ipcalc"
  url "https://gitlab.com/ipcalc/ipcalc/-/archive/1.2.0/ipcalc-1.2.0.tar.gz"
  sha256 "f6fc9076d3f1a64d1e050e1d6edd3fd61b91db71d0dfa1d9d184618e81865747"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://ghcr.io/v2/domrim/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "dc8039fddacf17dbdf99db612093f953196a1bd401d5e8a9560819e72bdf90cc"
    sha256 cellar: :any,                 x86_64_linux: "06a768b2062073af7f96f0928372688ea2e68d880b43023902bda662c2bf1e51"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build

  conflicts_with "ipcalc", because: "ipcalc also ships a ipcalc binary"

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    assert_match "Documentation", shell_output("#{bin}/ipcalc 2001:db8::/32")
    assert_match "Documentation", shell_output("#{bin}/ipcalc 192.0.2.0/24")
  end
end
