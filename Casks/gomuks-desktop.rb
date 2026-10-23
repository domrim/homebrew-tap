cask "gomuks-desktop" do
  version "26.10.0"
  sha256 "660df0a958aab89fdd65635d25ab2dfeb7d8ab5ed6f6821a6bd2bc08b2be957b"

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
