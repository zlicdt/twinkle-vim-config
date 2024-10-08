#!/bin/bash

# A part of Twinkle Vim Config project.
# Tips: This script need Arch Linux environment.
# Warning: This script may cause incorrect installation and be unable to reset if it is terminated during execution.

InstallRequirementsScript="sudo pacman -S git vim base-devel --noconfirm"

if [ -f /etc/arch-release ]; then
    echo -e "\033[38;5;47m[PASS]\033[0mCurrent OS is \033[38;5;81mArch Linux\033[0m, continue..."
else
    echo -e "\033[31m[ERROR]\033[0mCurrent OS is not \033[38;5;81mArch Linux\033[0m, process terminated."
    exit 1
fi

if [ -f "CONFIRM" ]; then
    echo -e "\033[38;5;81mInstalling requirements...\033[0m"
    eval "$InstallRequirementsScript"
    echo -e "\033[38;5;47m[SUCCESS]\033[0m"
else
    echo -e "\033[38;5;81mCloneing repository...\033[0m"
    git clone https://github.com/zlicdt/twinkle-vim-config
    if [ $? -ne 0 ]; then
        echo -e "\033[31m[ERROR]\033[0mRepository clone failed. Exiting..."
        exit 1
    fi
    cd twinkle-vim-config >/dev/null
    echo -e "\033[38;5;47m[SUCCESS]\033[0m"
    echo -e "\033[38;5;81mInstalling requirements...\033[0m"
    eval "$InstallRequirementsScript"
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
vim +PlugInstall +qall
echo -e "\033[38;5;47m[SUCCESS]\033[0m"

echo -e "\033[38;5;81mInstalling fonts that Airline Required...\033[0m"
cd "$original_dir" >/dev/null
./sources/installfonts.sh
if [ $? -ne 0 ]; then
    echo -e "\033[31m[ERROR]\033[0mFailed to install fonts."
fi
echo -e "\033[38;5;47m[SUCCESS]\033[0m"
