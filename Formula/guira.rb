class Guira < Formula
  desc "RA-Oberfläche für den Teilnehmerservice der DFN-PKI"
  homepage "https://blog.pki.dfn.de/tag/guira-releases/"

  url "https://pki.pca.dfn.de/guira/guira-4.3.zip"
  sha256 "208098f1a7990cb9421a2c23a60d8171748b613282b3dac0bf280115950e2b7b"

  livecheck do
    url "https://blog.pki.dfn.de/feed/"
    regex(/Java RA-Oberfläche Version ?(\d+(?:\.\d+)+)/i)
    strategy :xml do |xml, regex|
      xml.get_elements("rss//channel//item//title").map { |item| item.text[regex, 1] }
    end
  end

  depends_on "openjdk"

  def install
    prefix.install "guira.jar"
    libexec.install Dir["lib/*"]
    bin.install "guira-macosx.command" => "guira"

    inreplace bin/"guira" do |s|
      s.gsub!("./lib", libexec)
      s.sub!(/^dir=.*$/, "dir=#{opt_prefix}")
      s.sub!(/^# JAVA_HOME=.*$/, "JAVA_HOME=#{HOMEBREW_PREFIX}/opt/openjdk")
    end

    inreplace libexec/"guira-env.txt" do |s|
      s.gsub!("./lib", libexec)
    end
  end

  test do
    # no useful test is possible
    system "true"
  end
end
