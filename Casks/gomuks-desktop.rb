cask "gomuks-desktop" do
  version "26.11.0"
  sha256 "450496da3ec8d61cd18474f814ad0657b0dc857d3f558dbb2af4566c1a6024ca"

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
