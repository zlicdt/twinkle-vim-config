git clone https://github.com/powerline/fonts.git --depth=1
if [ $? -ne 0 ]; then
    echo -e "\033[31m[ERROR]\033[0mFailed to clone font repository. Exiting..."
    exit 1
fi
cd fonts
./install.sh
cd ..
rm -rf fonts
