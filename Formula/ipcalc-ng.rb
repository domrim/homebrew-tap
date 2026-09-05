class IpcalcNg < Formula
  desc "Modern IPv4/IPv6 ipcalc tool"
  homepage "https://gitlab.com/ipcalc/ipcalc"
  url "https://gitlab.com/ipcalc/ipcalc/-/archive/1.0.3/ipcalc-1.0.3.tar.gz"
  sha256 "451f323764f37ea6057e0ade60a0473938232ab2a92b97ffdc8c4860a8c76cfc"
  license "GPL-2.0-or-later"

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
