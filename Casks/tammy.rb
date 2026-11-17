cask "tammy" do
  version "26.11.0"
  sha256 "562ef8df0bd23823daac6a38174ec6176b5d027bf6cb9706c53df7d69141aa86"

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
