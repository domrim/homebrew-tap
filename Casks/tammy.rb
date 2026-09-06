cask "tammy" do
  arch arm: "arm64", intel: "x64"

  version "26.9.0"
  sha256 arm:   "b0d7847ad9a1b287930f086e05c7e9f8def424701fdfa0cdc5057addb7ffdb28",
         intel: "b8eb30d9d39ef5f3523188c91c1843a894ca1278a37983c8b34d9783ad61342a"

  url "https://gitlab.com/api/v4/projects/61851918/packages/generic/Tammy-MacOS-#{arch}.dmg/#{version}/Tammy-MacOS-#{arch}-#{version}.dmg"
  name "Tammy"
  desc "Fast and secure Matrix messenger"
  homepage "https://tammy.connect2x.de/"

  livecheck do
    url "https://gitlab.com/connect2x/tammy.git"
  end

  depends_on :macos

  app "Tammy.app"

  zap trash: [
    "~/Library/Application Support/de.connect2x.tammy",
    "~/Library/Preferences/de.connect2x.tammy.plist",
  ]
end
