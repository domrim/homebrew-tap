class IpcalcNg < Formula
  desc "Modern IPv4/IPv6 ipcalc tool"
  homepage "https://gitlab.com/ipcalc/ipcalc"
  url "https://gitlab.com/ipcalc/ipcalc/-/archive/1.1.0/ipcalc-1.1.0.tar.gz"
  sha256 "8913d43ec30433ef31b57cd014034ce17349bf7ff997e198e6a0dc092207ad34"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://ghcr.io/v2/domrim/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "890edb19a93a46a281c791c2e8a0c8db6ad1be25bf764ddf1b87258909098b3f"
    sha256 cellar: :any,                 x86_64_linux: "597adad30442a08125858006dd4acc2ddb84b6648949c9722861602e8eaa24f9"
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
