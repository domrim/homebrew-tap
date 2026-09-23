cask "tammy" do
  version "26.9.2"
  sha256 "93f266312ecb405f9b362076ffe207f6f738db524e0922eb022c6dde43c275d6"

  url "https://gitlab.com/api/v4/projects/61851918/packages/generic/Tammy-MacOS-arm64.dmg/#{version}/Tammy-MacOS-arm64-#{version}.dmg"
  name "Tammy"
  desc "Fast and secure Matrix messenger"
  homepage "https://tammy.connect2x.de/"

  livecheck do
    url "https://gitlab.com/connect2x/tammy.git"
  end

  depends_on arch: :arm64
  depends_on :macos

  app "Tammy.app"

  zap trash: [
    "~/Library/Application Support/de.connect2x.tammy",
    "~/Library/Preferences/de.connect2x.tammy.plist",
  ]
end
