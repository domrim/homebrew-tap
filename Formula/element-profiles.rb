class ElementProfiles < Formula
  desc "Manage per-account Element (Matrix) profile applications with custom icons"
  homepage "https://gitlab.com/collective-ai-slop/element-profiles"
  url "https://gitlab.com/collective-ai-slop/element-profiles/-/archive/v0.4.1/element-profiles-v0.4.1.tar.gz"
  sha256 "bfc528f849d226a4198de01992fff11082124dd1c07c24fa68165a36a2affd68"
  head "https://gitlab.com/collective-ai-slop/element-profiles.git", branch: "main"

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
