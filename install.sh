#! /bin/bash 

printf "\nAuto installation script for https://github.com/darthnoward/edi_auto_login_bot\nSupported operating system: Mac OS X, GNU/Linux\nSupported browser: Google Chrome, Chromium. (79, 80, 81, 83)\n"

if [ -d ~/.edi_tmp ]; then
    printf "Directory '~/.edi_tmp' already exists.\nCleaning up the directory...\n"
    rm -rf ~/.edi_tmp
fi
mkdir ~/.edi_tmp 
cd ~/.edi_tmp

printf "\nDownloading webdriver for Google Chrome...\n"
if [[ $(uname) == "Darwin" ]]; then
    if [ -f /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome ]; then
        case "$(/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --version | awk '{print $3}' | cut -f 1 -d '.')" in
            "79") curl -Os https://chromedriver.storage.googleapis.com/79.0.3945.36/chromedriver_mac64.zip > /dev/null ;;
            "80") curl -Os https://chromedriver.storage.googleapis.com/80.0.3987.106/chromedriver_mac64.zip > /dev/null ;;
            "81") curl -Os https://chromedriver.storage.googleapis.com/81.0.4044.69/chromedriver_mac64.zip > /dev/null ;;
            "83") curl -Os https://chromedriver.storage.googleapis.com/83.0.4103.39/chromedriver_mac64.zip > /dev/null ;;
            *) printf "\nNo current support for your version of browser.\nPlease update your Chrome.\nOperation terminated.\n" && exit ;;
        esac
    else
        if [ -f /Applications/Chromium.app/Contents/MacOS/Chromium ]; then
            case "$(/Applications/Chromium.app/Contents/MacOS/Chromium --version | awk '{print $2}' | cut -f 1 -d '.')" in
                "79") curl -Os https://chromedriver.storage.googleapis.com/79.0.3945.36/chromedriver_mac64.zip > /dev/null ;;
                "80") curl -Os https://chromedriver.storage.googleapis.com/80.0.3987.106/chromedriver_mac64.zip > /dev/null ;;
                "81") curl -Os https://chromedriver.storage.googleapis.com/81.0.4044.69/chromedriver_mac64.zip > /dev/null ;;
                "83") curl -Os https://chromedriver.storage.googleapis.com/83.0.4103.39/chromedriver_mac64.zip > /dev/null ;;
                *) printf "\nNo current support for your version of browser.\nPlease update your Chromium.\nOperation terminated.\n" && exit ;;
            esac
        else
            printf "\nNo current support for your browser.\nPlease install Google Chrome or Chromium Instead.\nOperation terminated.\n"
            exit
        fi
    fi
        
else
    if [[ $(uname) == "Linux" ]]; then
        if command -v chromium > /dev/null; then
            case "$(chromium --version | awk '{print $2}' | cut -f 1 -d '.')" in
                "79") curl -Os https://chromedriver.storage.googleapis.com/79.0.3945.36/chromedriver_linux64.zip > /dev/null ;;
                "80") curl -Os https://chromedriver.storage.googleapis.com/80.0.3987.106/chromedriver_linux64.zip > /dev/null ;;
                "81") curl -Os https://chromedriver.storage.googleapis.com/81.0.4044.69/chromedriver_linux64.zip > /dev/null ;;
                "83") curl -Os https://chromedriver.storage.googleapis.com/83.0.4103.39/chromedriver_linux64.zip > /dev/null ;;
                *) printf "\nNo current support for your version of browser.\nPlease update your Chromium.\nOperation terminated.\n" && exit ;;
            esac
        else
            if command -v google-chrome > /dev/null; then
                case "$(google-chrome --version | awk '{print $3}' | cut -f 1 -d '.')" in
                    "79") curl -Os https://chromedriver.storage.googleapis.com/79.0.3945.36/chromedriver_linux64.zip > /dev/null ;;
                    "80") curl -Os https://chromedriver.storage.googleapis.com/80.0.3987.106/chromedriver_linux64.zip > /dev/null ;;
                    "81") curl -Os https://chromedriver.storage.googleapis.com/81.0.4044.69/chromedriver_linux64.zip > /dev/null ;;
                    "83") curl -Os https://chromedriver.storage.googleapis.com/83.0.4103.39/chromedriver_linux64.zip > /dev/null ;;
                    *) printf "\nNo current support for your version of browser.\nPlease update your Chrome.\nOperation terminated.\n" && exit ;;
                esac
            else
                printf "\nNo current support for your browser.\nPlease install Google Chrome or Chromium Instead.\nOperation terminated.\n"
                exit
            fi
        fi
    else
        printf "No current support for your operating system.\nOnly Mac OS X and GNU/Linux are supported.\nOperation terminated.\n"
        exit 
    fi 
fi
unzip ./chromedriver_*64.zip > /dev/null

printf "\nTo complete the installation process, root privilege is required.\n"
printf "Enter your password:\n"
sudo mv chromedriver /usr/local/bin 

printf "\nInstalling Selenium library for Python...\n"
pip install selenium > /dev/null || sudo pip install selenium > /dev/null
pip3 install selenium > /dev/null || sudo pip3 install selenium > /dev/null

printf "Installing scripts...\n"
git clone --quiet https://github.com/darthnoward/edi_auto_login_bot > /dev/null

py=$(which python3)
sh=$(echo $SHELL | rev | cut -c -3 | rev) 

printf "Creating alias for the shell...\n"
case $sh in
    "ash") echo "alias edi='$py ~/.edi_tmp/edi_auto_login_bot/main.py'" >> ~/.bashrc && echo "alias edi='$py ~/.edi_tmp/edi_auto_login_bot/main.py'" >> ~/.bash_profile ;;
    "zsh") echo "alias edi='$py ~/.edi_tmp/edi_auto_login_bot/main.py'" >> ~/.zshrc ;;
    "ish") echo "alias edi='$py ~/.edi_tmp/edi_auto_login_bot/main.py'" >> ~/.config/fish/config.fish ;;
    *) printf "\nNo support for your shell, no alias was created.\n" ;;
esac
    
cd ~/.edi_tmp/edi_auto_login_bot
printf "Finalizing...\n\nPlease input your student id, e.g. 1004321\nYour information will be stored only locally and is accessible by no one.\nStudent ID: "
read name
printf "\nPlease input your password for Edimension.\nYour information will be stored only locally and is accessible by no one.\nPassword: "
read -s pass 
echo "username = 'SUTDSTU\\\\$name'" > ./myinfo.py
echo "password = '$pass'" >> ./myinfo.py

printf "\nInstallation process is complete!\nTry opening a new terminal and run 'edi'!\n"
