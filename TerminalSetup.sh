# need to install homebrew first
xcode-select --install
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install mounty to read and write into non-Apple disks
brew cask install mounty

# installing oh-my-zsh in the local installation
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install the PowerLevel9k theme for zsh
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# installing the nerd font which has a greater set of symbols in it
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font
# this moves the fonts installed from the local user's library to the system's library
cp ~/Library/Fonts/Hack* /Library/Fonts
# After this, go to Terminal Preferences and set the font to Hack Nerd Font in the Fixed Width category.

# Finally, modify .zshrc to ensure that you have the right font and theme.
# This is the line for the font that the theme is going to use and should be placed before the theme setting.
POWERLEVEL9K_MODE='nerdfont-complete'
# This is the line that sets the theme to PowerLevel9k
ZSH_THEME="powerlevel9k/powerlevel9k"

# Add the following after the theme definition to ensure that the prompt is on a new line as the left part takes up a lot of space.
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

# Installing Windows on external ssd: https://9to5mac.com/2017/08/31/how-windows-10-mac-boot-camp-external-drive-video/

# To not show hidden files
export hideHidden='defaults write com.apple.finder AppleShowAllFiles NO'

# To sho hidden files
export showHidden='defaults write com.apple.finder AppleShowAllFiles YES'
