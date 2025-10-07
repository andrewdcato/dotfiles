#!/bin/bash

#####################################################################
#      NOTE: Sensible macOS defaults...
#####################################################################
# Ensure that any relevant apps are closed
for app in "System Settings" \
  "App Store" \
  "Messages"; do
  osascript -e "tell application \"$app\" to quit"
done;

#####################################################################
#      NOTE: Set up hot corners...possible values are:
#	   0: no-op
#	   2: Mission Control
#	   3: Show application windows
#	   4: Desktop
#	   5: Start screen saver
#	   6: Disable screen saver
#	   7: Dashboard
#	  10: Put display to sleep
#	  11: Launchpad
#	  12: Notification Center
#	  13: Lock Screen
#####################################################################
# top left => start screen saver
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0

# top right => start screen saver
defaults write com.apple.dock wvous-tl-corner -int 7
defaults write com.apple.dock wvous-tl-modifier -int 0

# bottom left => start screen saver
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# bottom right => notification center
defaults write com.apple.dock wvous-br-corner -int 12
defaults write com.apple.dock wvous-br-modifier -int 0

#####################################################################
#      NOTE: Safari tweaks...
#####################################################################
# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Safari - disable autofill
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false


#####################################################################
#      NOTE: Security tweaks...
#####################################################################
# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Allow own account to sudo without password
echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER

#####################################################################
#      NOTE: Screenshots...
#####################################################################
# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format
defaults write com.apple.screencapture type -string "png"

#####################################################################
#      NOTE: Displays...
#####################################################################
# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

#####################################################################
#      NOTE: Finder...
#         https://macos-defaults.com/finder/
#####################################################################
# allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Set Home dir as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

# Don't show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# don't spam .DS_Store files on network or USB disks
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# use column view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Show the ~/Library folder
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

#####################################################################
#      NOTE: Dock and Menubar...
#       https://macos-defaults.com/dock/
#####################################################################
# Set the icon size of Dock items to 48 pixels
defaults write com.apple.dock tilesize -int 48

# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Put the dock on the left side and automatically hide it
defaults write com.apple.dock orientation -string left
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float "0.1"
defaults write com.apple.dock autohide-time-modifier -float "0.2"

# Hide the menubar
defaults write NSGlobalDomain _HIHideMenuBar -bool true

#####################################################################
#      NOTE: Restart everything that was tweaked and 
#      prep for initial reboot...
#####################################################################
for app in "Dock" \
	"Finder" \
	"Safari" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done

echo "Done configuring system; trigging reboot now..."

sleep 10 && sudo shutdown -r now
