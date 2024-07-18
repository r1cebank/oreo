#!/bin/sh
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# install homebrew if it's missing
if [[ $(command -v brew) == "" ]]; then
  echo "Installing Hombrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -f "$HOME/.Brewfile" ]; then
  echo "Updating homebrew bundle"
  brew bundle --global
fi

# sketchybar font
# curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.5/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

# sbarlua
# (git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)

# yabai load-sa
# echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai

# enable touchid for sudo
# sudo bash ${__dir}/touch_id_sudo.sh

# install starship
# curl -sS https://starship.rs/install.sh | sh

# install atuin
# curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

# install code extensions
curl -fsSL https://raw.githubusercontent.com/rmmgc/vscode-extensions-bulk-install/main/bulk-install.sh | sh -s ${__dir}/code_extensions.txt

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# dock settings
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 40;
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock show-recents -bool no
defaults write com.apple.dock "orientation" -string "left"
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-tl-corner -int 10

# menubar
defaults write "Apple Global Domain" "_HIHideMenuBar" 1

# finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "icnv"
defaults write com.apple.finder FXRemoveOldTrashItems -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# dock icons
defaults write com.apple.dock persistent-apps -array

# Add system icons
declare -a sys_icons=(
    "/Applications/Mail"
    "/Applications/Messages"
    "/Applications/App Store"
    "/Applications/Music"
    )
for sys_icon in "${sys_icons[@]}"; do
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System${sys_icon}.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done

## Add application icons
declare -a icons=("NetEaseMusic" "Orion" "Telegram" "Visual Studio Code" "kitty")
for icon in "${icons[@]}"; do
    if [ -d "/Applications/${icon}.app" ]; then
        if ! defaults read com.apple.dock | grep "${icon}"; then
            defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/${icon}.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
        fi
    fi
done

## Restart Dock
killall Dock

# add fish to /etc/shells
grep -q "$(which fish)" '/etc/shells' || echo "$(which fish)" >> /etc/shells
chsh -s $(which fish)

###############################################################################
# Kill affected applications
###############################################################################

echo ""
echo "Done!"
echo ""
echo ""
echo "################################################################################"
echo ""
echo ""
echo "Note that some of these changes require a logout/restart to take effect."
echo "Killing some open applications in order to take effect."
echo ""

# find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete
# for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
#   "Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" \
#   "Terminal" "Transmission"; do
#   killall "${app}" > /dev/null 2>&1
# done