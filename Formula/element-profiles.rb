class ElementProfiles < Formula
  desc "Manage per-account Element (Matrix) profile applications with custom icons"
  homepage "https://gitlab.com/collective-ai-slop/element-profiles"
  url "https://gitlab.com/collective-ai-slop/element-profiles/-/archive/v0.5.0/element-profiles-v0.5.0.tar.gz"
  sha256 "b03a668f36fa137cbe6472b5c9e14eda9af92f036ab4ae49046adf42cc3d09e7"
  head "https://gitlab.com/collective-ai-slop/element-profiles.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/domrim/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "2337cdb9c5ddec425c6df433cd5f9e671aaa88e984caee404fc6831146e3804b"
  end

  depends_on xcode: :build
  depends_on :macos
  uses_from_macos "swift", since: :tahoe # Swift 6.2

  def install
    chdir "ElementProfiles" do
      system "swift", "build", "--disable-sandbox", "-c", "release"
      bin.install ".build/release/element-profiles"
    end

    generate_completions_from_executable(bin/"element-profiles", "--generate-completion-script")
  end

  test do
    assert_match "Manage Element profile applications.", shell_output("#{bin}/element-profiles --help")
  end
end
