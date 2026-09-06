cask "avrfuses" do
  version "1.6.2"
  sha256 "2753f53304d135e574480fdcc53375fb27ed85c9e32170fca418d3ce4b324f84"

  url "https://github.com/vonnieda/AVRFuses/releases/download/v#{version}/AVRFuses_#{version}.zip"
  name "AVRFuses"
  desc "Simple, graphical AVR fuse editor front end for avrdude"
  homepage "https://vonnieda.org/software/avrfuses"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on formula: "avrdude"
  depends_on :macos

  app "AVRFuses.app"

  zap trash: [
    "~/Library/Preferences/org.vonnieda.AVRFuses.plist",
    "~/Library/Saved Application State/org.vonnieda.AVRFuses.savedState",
  ]
end
