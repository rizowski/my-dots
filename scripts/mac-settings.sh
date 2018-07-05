# Possible Keys: https://github.com/mathiasbynens/dotfiles/blob/master/.macos
# Howto: https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/

# Finder:
defaults write com.apple.finder AppleShowAllFiles YES

defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

defaults write com.apple.finder ShowRecentTags -bool false
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

killall Finder

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock largesize -float 74
defaults write com.apple.dock tilesize -float 36

# Siri
defaults write com.apple.Siri StatusMenuVisible -bool false

# Touch Bar
# https://blog.eriknicolasgomez.com/2016/11/28/managing-or-setting-the-mini-touchbar-control-strip/
defaults write com.apple.controlstrip FullCustomized '(
    "com.apple.system.group.brightness",
    "com.apple.system.mission-control",
    "com.apple.system.launchpad",
    "com.apple.system.group.keyboard-brightness",
    "com.apple.system.group.media",
    "com.apple.system.group.volume",
    "com.apple.system.screen-saver",
    "com.apple.system.screen-lock"
)'
defaults write com.apple.controlstrip MiniCustomized '(
    "com.apple.system.brightness",
    "com.apple.system.volume",
    "com.apple.system.mute",
    "com.apple.system.screen-lock"
)'

killall ControlStrip
