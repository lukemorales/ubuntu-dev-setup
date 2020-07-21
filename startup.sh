echo "Welcome! Let's start setting up your system. It could take more than 10 minutes, be patient"
cd ~
read git_config_user_email
read username

sudo apt update

echo 'Installing curl' 
sudo apt install curl -y

echo 'Installing tool to handle clipboard via CLI'
sudo apt install xclip -y

echo 'Installing latest git' 
sudo add-apt-repository ppa:git-core/ppa
sudo apt update && sudo apt install git -y

echo 'Installing python3 pip'
sudo apt install python3-pip -y

echo 'Installing getgist to download dot files from gist'
sudo pip3 install getgist

echo 'Cloning your Konsole configs from gist'
cd ~/.local/share/konsole
rm -rf *
getgist $username OmniKonsole.profile && getgist $username OmniTheme.colorscheme

echo 'Cloning your .gitconfig from gist'
getgist $username .gitconfig

echo 'Generating a SSH Key'
ssh-keygen -t rsa -b 4096 -C $git_config_user_email
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | xclip -selection clipboard

echo 'Installing ZSH'
sudo apt install zsh -y
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s /bin/zsh

echo 'Cloning your .zshrc from gist'
getgist $username .zshrc

echo 'Installing FiraCode'
sudo apt install fonts-firacode -y

echo 'Installing NVM' 
sh -c "$(curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash)"
source ~/.zshrc
clear
nvm install --lts

echo 'Installing Yarn'
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install --no-install-recommends yarn
echo '"--emoji" true' >> ~/.yarnrc

echo 'Installing VSCode'
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt install apt-transport-https -y
sudo apt update && sudo apt install code -y

echo 'Installing Code Settings Sync'
code --install-extension Shan.code-settings-sync

echo 'Installing Chrome' 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

echo 'Installing Typescript, AdonisJS CLI and Lerna'
yarn global add typescript @adonisjs/cli lerna

echo 'Installing Docker'
sudo apt purge docker docker-engine docker.io
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
docker --version

sudo groupadd docker
sudo usermod -aG docker $USER
chmod 777 /var/run/docker.sock

echo 'Installing docker-compose'
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

echo 'Installing HEROKU-CLI'
curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
heroku --version

echo 'Installing PostBird'
wget -c https://github.com/Paxa/postbird/releases/download/0.8.4/Postbird_0.8.4_amd64.deb
sudo dpkg -i Postbird_0.8.4_amd64.deb
rm Postbird_0.8.4_amd64.deb

echo 'Installing Insomnia and Omni Theme' 
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
  | sudo tee -a /etc/apt/sources.list.d/insomnia.list
wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc \
  | sudo apt-key add -
sudo apt update && sudo apt install insomnia -y
cd ~/.config/Insomnia/plugins
git clone https://github.com/Rocketseat/insomnia-omni.git omni-theme && cd ~

echo 'Installing Android Studio'
sudo add-apt-repository ppa:maarten-fonville/android-studio
sudo apt update && sudo apt install android-studio -y

echo 'Installing VLC'
sudo apt install vlc -y
sudo apt install vlc-plugin-access-extra libbluray-bdj libdvdcss2 -y

echo 'Installing Discord'
wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo dpkg -i discord.deb
rm discord.deb

echo 'Installing Zoom'
wget -c https://zoom.us/client/latest/zoom_amd64.deb
sudo dpkg -i zoom_amd64.deb
rm zoom_amd64.deb

echo 'Installing Spotify' 
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update && sudo apt install spotify-client -y

echo 'Installing Peek' 
sudo add-apt-repository ppa:peek-developers/stable
sudo apt update && sudo apt install peek -y

echo 'Installing OBS Studio'
sudo apt install ffmpeg && sudo snap install obs-studio

echo 'Installing Robo3t'
snap install robo3t-snap

echo 'Installing Lotion'
sudo git clone https://github.com/puneetsl/lotion.git /usr/local/lotion
cd /usr/local/lotion && sudo ./install.sh

echo 'Updating All Packages'
sudo -- sh -c 'apt update; apt upgrade -y; apt full-upgrade -y; apt autoremove -y; apt autoclean -y'
clear 

echo 'All setup, enjoy!'
