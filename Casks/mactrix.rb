cask "mactrix" do
  version "0.4.0"
  sha256 "dd232f872214c859645971a3c33f7ab3867e6bb3c6fd7d76ccf1fc124cd5e9fc"

  url "https://github.com/viktorstrate/mactrix/releases/download/v#{version}/Mactrix.app.zip"
  name "Mactrix"
  desc "Native Matrix client"
  homepage "https://github.com/viktorstrate/mactrix"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "Mactrix.app"

  zap trash: [
    "~/Library/Application Scripts/dk.qpqp.mactrix",
    "~/Library/Containers/dk.qpqp.mactrix",
  ]
end
