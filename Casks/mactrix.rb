cask "mactrix" do
  version "0.5.0"
  sha256 "b2205dc3a8349656a813683e37bd7dde277268847f230e6f8d8ae35bd7316dd7"

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
