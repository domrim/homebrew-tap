cask "mactrix" do
  version "0.3.0"
  sha256 "638c9d8a119218a3570dab735bf7292584b59708e790876156d76bf98e5e69ad"

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
