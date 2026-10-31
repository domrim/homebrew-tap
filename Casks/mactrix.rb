cask "mactrix" do
  version "0.6.0"
  sha256 "3e3835b632ba2962c0f412bd7659a5e1050e7e03b9e0fc14c820ecfe0ca4bca0"

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
