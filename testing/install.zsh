#!/bin/zsh

# A part of Twinkle Vim Config project.
# Tips: This script need macOS environment.
# Warning: This script may cause incorrect installation and be unable to reset if it is terminated during execution.
# Note: This script won't install whole twinkle vim config.

BrewCommand="brew install font-sf-mono-for-powerline font-meslo-lg-nerd-font"

if [[ "$(uname)" == "Darwin" ]]; then
    echo -e "\033[38;5;47m[PASS]\033[0mCurrent OS is macOS, continue..."
else
    echo -e "\033[31m[ERROR]\033[0mCurrent OS is not macOS, process terminated."
    exit 1
fi

if [ -f "CONFIRM" ]; then
    echo -e "\033[38;5;81mInstalling requirements...\033[0m"
    eval "$BrewCommand"
    echo -e "\033[38;5;47m[SUCCESS]\033[0m"
else
    echo -e "\033[38;5;81mCloneing repository...\033[0m"
    git clone https://github.com/zlicdt/twinkle-vim-config
    if [ $? -ne 0 ]; then
        echo -e "\033[31m[ERROR]\033[0mRepository clone failed. Exiting..."
        exit 1
    fi
    cd twinkle-vim-config/testing/ >/dev/null # This line cd to testing directory not main directory
    echo -e "\033[38;5;47m[SUCCESS]\033[0m"
    echo -e "\033[38;5;81mInstalling requirements...\033[0m"
    eval "$BrewCommand"
    echo -e "\033[38;5;47m[SUCCESS]\033[0m"
fi

original_dir=$(pwd)

echo -e "\033[38;5;81mInstalling Vim-Plug...\033[0m" 
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if [ $? -ne 0 ]; then
    echo -e "\033[31m[ERROR]\033[0mFailed to install Vim-Plug. Exiting..."
    exit 1
fi
echo -e "\033[38;5;47m[SUCCESS]\033[0m"

echo -e "\033[38;5;81mCopying .vimrc...\033[0m"
cp ./sources/vimrc ~/.vimrc >/dev/null
echo -e "\033[38;5;47m[SUCCESS]\033[0m"

echo -e "\033[38;5;81mInstalling Plugins...\033[0m"
vim +PlugInstall
echo -e "\033[38;5;47m[SUCCESS]\033[0m"
