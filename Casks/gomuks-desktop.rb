cask "gomuks-desktop" do
  version "26.09.0"
  sha256 "f31a39daa8b0f581eae45c7e100719b1b0fe931fcc3c7f289b4d49e538816a4e"

  url "https://update.gomuks.app/desktop-stable/darwin/arm64/gomuks-desktop-#{version}-arm64.dmg"
  name "gomuks-desktop"
  desc "Matrix client written in Go"
  homepage "https://gomuks.app/"

  livecheck do
    url "https://update.gomuks.app/desktop-stable/darwin/arm64/RELEASES.json"
    strategy :json do |json|
      json["currentRelease"]
    end
  end

  depends_on macos: :ventura

  app "gomuks-desktop.app"

  zap trash: [
    "~/Library/Application Support/gomuks-desktop",
    "~/Library/Logs/gomuks-desktop",
  ]
end
