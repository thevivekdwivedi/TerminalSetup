#!/bin.sh
################################################################################################
######################                                                   #######################
###################### This is the Core part of the script functionality #######################
######################                                                   #######################
################################################################################################

# Variables
header_outline='********************************'
end_of_action='================================'
termination_message='Stopping execution of terminal setup.'

################################################################################################
# Purpose: Terminates the script execution.
################################################################################################
terminate_setup() {
  echo $terminate_setup
  exit 1
}

################################################################################################
# Purpose: Prints the header of an action that the script shall perform
# Arguments:
# - $1 -> The header to be displayed
# Usage:
#   print_header 'Starting something'
#   
#   This invocation results in the following being printed on the terminal output:
#   ********************************
#   Starting something
#   ********************************
################################################################################################
print_header() {
  echo $header_outline
  echo $1
  echo $header_outline
}

################################################################################################
# Purpose: Prints the confirmation message for a given installable item.
# Arguments:
# - $1 -> The name of the installable item to be used in the confirmation message.
# Usage:
#   print_confirmation_for 'vscodium'
#   
#   This invocation results in the following output:
#   Do you want to install vscodium? Type y to say yes. Any other key to skip installing vscodium.
################################################################################################
print_confirmation_for() {
  installable=$1
  echo "Do you want to install ${installable}? Type y to say yes. Any other key to skip installing ${installable}."
}

################################################################################################
# Purpose: Prints the footer of an action segment that the script completed.
################################################################################################
print_end_of_action() {
  echo $end_of_action
}

################################################################################################
# Purpose: Tries to perform a function and displays success/failure notification provided.
# Arguments:
# - $1 -> The function to install a component of choice.
# - $2 -> Message to be displayed when the function completes successfully.
# - $3 -> Message to be displayed when the function does not complete successfully.
# - $4 -> Whether the setup needs to be terminated on failure.
# Usage:
#   local success_message='Successfully installed homebrew'
#   local failure_message='Failed to install homebrew'
#   try install_homebrew $success_message $failure_message $true

# - This invocation will result in the execution of the install_homebrew function. 
#   If the execution is successful, then success_message is shown; else failure_message.
#   In this case, upon failure the try mechanism is going to stop the terminal setup by exiting.
# Side effects:
# - There are no validations on the input yet, so if you fail to pass all arguments it might not
#   work right. I don't know shell script.
################################################################################################
try() {
  function_to_perform=$1
  success_message=$2
  failure_message=$3
  should_terminate=$4

  if $function_to_perform;
  then
    print_header $success_message
  else
    print_header $failure_message
    if $should_terminate;
    then
      echo 'Stopping execution of terminal setup.'
      exit 1
    fi
  fi
}

################################################################################################
# Purpose: Checks with user if they want to install a particular tool.
# Arguments:
# - $1 -> The name of the installable tool.
# - $2 -> The installer function to be called upon confirmation.
# Usage:
#   perform_confirmation_for 'vscodium'  install_vscodium
#   
#   This invocation results in the user getting to choose if they want to install this tool.
#   If they do, then the installer function is called.
################################################################################################
perform_confirmation_for() {
  installable=$1
  installer=$2
  print_confirmation_for $installable
  read confirmation

  if [ "$confirmation" == "y" ];
  then
    try $installer
  else
    echo "Skipping the installation for ${installable}"
}

################################################################################################
######################                                                   #######################
######################  This is the part where we define the installers  #######################
######################                                                   #######################
################################################################################################


################################################################################################
# Purpose: Installs xcode-select and homewbrew. This is a mandatory function and should be 
#          performed prior to anything else.
# Usage: Use it with the try function.
################################################################################################
install_homebrew() {
  echo 'This is a mandatory operation and should be performed prior to anything else.'
  xcode-select --install
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  return
}

################################################################################################
# Purpose: Installs oh-my-zsh. This is a mandatory function and should be performed prior 
#          to anything else.
# Usage: Use it with the try function.
################################################################################################
install_omzsh() {
  echo 'This is a mandatory operation and should be performed prior to anything else.'
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  return
}

################################################################################################
# Purpose: Installs vscodium using homebrew.
# Usage: Use it with the try function.
################################################################################################
install_vscodium() {
  brew install --cask vscodium
  return
}

################################################################################################
# Purpose: Installs mounty using homebrew.
# Usage: Use it with the try function.
################################################################################################
install_mounty() {
  brew install --cask mounty
  return
}

# TODO: I need to change the following code and add the orchestrator/main function.

# install the PowerLevel9k theme for zsh
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# installing the nerd font which has a greater set of symbols in it
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
# this moves the fonts installed from the local user's library to the system's library
cp ~/Library/Fonts/Hack* /Library/Fonts
echo # After this, go to Terminal Preferences and set the font to Hack Nerd Font in the Fixed Width category.

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
