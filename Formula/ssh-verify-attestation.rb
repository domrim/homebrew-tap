class SshVerifyAttestation < Formula
  desc "OpenBSD freely-licensed SSH connectivity tools"
  homepage "https://www.openssh.com/"
  url "https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-10.5p1.tar.gz"
  mirror "https://cloudflare.cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-10.5p1.tar.gz"
  version "10.5p1"
  sha256 "d44d28a839ea9daf969cc69150fde59910b2b39361dad81a3bd6cbd19218db11"
  license "SSH-OpenSSH"
  compatibility_version 1

  livecheck do
    url "https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/"
    regex(/href=.*?openssh[._-]v?(\d+(?:\.\d+)+(?:p\d+)?)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/domrim/tap"
    sha256 arm64_tahoe:  "e4f7f4b690130ff488faa626054b75023abf40ef3161597429d87da73bd8bf7a"
    sha256 x86_64_linux: "a00dd7ec1c128d27524f50d96148f833c2eedd25fff6d65e0aa852da1620a136"
  end

  # Please don't resubmit the keychain patch option. It will never be accepted.
  # https://archive.is/hSB6d#10%25

  depends_on "pkgconf" => :build
  depends_on "ldns"
  depends_on "libfido2"
  depends_on "openssl@3"

  uses_from_macos "mandoc" => :build
  uses_from_macos "lsof" => :test
  uses_from_macos "krb5"
  uses_from_macos "libedit"
  uses_from_macos "libxcrypt"

  on_linux do
    depends_on "linux-pam"
    depends_on "zlib-ng-compat"
  end

  resource "com.openssh.sshd.sb" do
    url "https://raw.githubusercontent.com/apple-oss-distributions/OpenSSH/OpenSSH-268.100.4/com.openssh.sshd.sb"
    sha256 "a273f86360ea5da3910cfa4c118be931d10904267605cdd4b2055ced3a829774"
  end

  def install
    ENV.append "CPPFLAGS", "-D__APPLE_SANDBOX_NAMED_EXTERNAL__" if OS.mac?

    args = %W[
      --sysconfdir=#{etc}/ssh
      --with-ldns
      --with-libedit
      --with-kerberos5
      --with-pam
      --with-ssl-dir=#{formula_opt_prefix("openssl@3")}
      --with-security-key-builtin
    ]

    args << "--with-privsep-path=#{var}/lib/sshd" if OS.linux?

    system "./configure", *args, *std_configure_args
    system "make", "ssh-verify-attestation"
    ENV.deparallelize

    bin.install "regress/misc/ssh-verify-attestation/ssh-verify-attestation" => "ssh-verify-attestation"
  end

  test do
    assert_match "usage: ssh-verify-attestation [-vAU] pubkey challenge attestation-blob",
shell_output("#{bin}/ssh-verify-attestation 2>&1", 1)
  end
end
