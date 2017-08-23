# https://github.com/mathiasbynens/dotfiles/blob/master/.macos

# Show all hidden files
defaults write com.apple.finder AppleShowAllFiles YES
killall Finder

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Pictures/screenshots"

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Remove Dropbox’s green checkmark icons in Finder
# file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
# [ -e "${file}" ] && mv -f "${file}" "${file}.bak"

# ############ Dock #############
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

# ############ Terminal ##########
# Use a modified version of the Solarized Dark theme by default in Terminal.app
# osascript <<EOD
# tell application "Terminal"
#   local allOpenedWindows
#   local initialOpenedWindows
#   local windowID
#   set themeName to "Solarized Dark xterm-256color"
#   (* Store the IDs of all the open terminal windows. *)
#   set initialOpenedWindows to id of every window
#   (* Open the custom theme so that it gets added to the list
#      of available terminal themes (note: this will open two
#      additional terminal windows). *)
#   do shell script "open '$HOME/init/" & themeName & ".terminal'"
#   (* Wait a little bit to ensure that the custom theme is added. *)
#   delay 1
#   (* Set the custom theme as the default terminal theme. *)
#   set default settings to settings set themeName
#   (* Get the IDs of all the currently opened terminal windows. *)
#   set allOpenedWindows to id of every window
#   repeat with windowID in allOpenedWindows
#     (* Close the additional windows that were opened in order
#        to add the custom theme to the list of terminal themes. *)
#     if initialOpenedWindows does not contain windowID then
#       close (every window whose id is windowID)
#     (* Change the theme for the initial opened terminal windows
#        to remove the need to close them in order for the custom
#        theme to be applied. *)
#     else
#       set current settings of tabs of (every window whose id is windowID) to settings set themeName
#     end if
#   end repeat
# end tell
# EOD

# Install the Solarized Dark theme for iTerm
# open "${HOME}/init/Solarized Dark.itermcolors"

# ######### App store #######
# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1
