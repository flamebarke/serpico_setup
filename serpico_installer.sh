echo "[*] Serpico Installer running"
sleep 3
cd ~

echo "[*] Updating sources"
sleep 3
sudo apt update 

echo "[*] Installing rvm dependencies"
sleep 3
sudo apt install curl g++ gcc autoconf automake bison libc6-dev \
        libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev libtool \
        libyaml-dev make pkg-config sqlite3 zlib1g-dev libgmp-dev \
        libreadline-dev libssl-dev -y

echo "[*] Installing libssl1.0-dev"
sleep 3
sudo sh -c 'echo "deb http://security.ubuntu.com/ubuntu bionic-security main" >> /etc/apt/sources.list' 
sudo apt update && apt-cache policy libssl1.0-dev 
sudo apt-get install libssl1.0-dev -y

echo "[*] Importing keys for rvm"
sleep 3
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB 

echo "[*] Installing rvm"
sleep 3
curl -sSL https://get.rvm.io | bash -s stable

source ~/.rvm/scripts/rvm

#echo "[*] Adding user to rvm group"
#sudo usermod -a -G rvm `whoami` 
#if sudo grep -q secure_path /etc/sudoers; then sudo sh -c "echo export rvmsudo_secure_path=1 >> /etc/profile.d/rvm_secure_path.sh" && echo "[*] Environment variable installed"; fi

#echo "[*] Listing available Ruby versions: "
#rvm list known 

echo "[*] Installing ruby-2.3.3"
sleep 3
rvm install ruby-2.3.3 

echo "[*] Setting ruby-2.3.3 as the default version"
sleep 3
rvm --default use ruby-2.3.3 

echo "[*] Downloading serpico"
sleep 3
wget https://github.com/SerpicoProject/Serpico/archive/1.3.1.2.zip 

echo "[*] Installing unzip"
sleep 3
sudo apt install unzip -y 

echo "[*] Creating serpico directory"
sleep 3
unzip 1.3.1.2.zip 
mv Serpico-1.3.1.2 serpico 

echo "[*] Installing serpico dependencies"
sleep 3
cd serpico
bundle install 
ruby scripts/first_time.rb

source ~/.rvm/scripts/rvm

echo ""
echo ""
echo "[*] You must run this command from your current shell >: source ~/.rvm/scripts/rvm"
echo "[*] Install complete to run serpico use the following command >: ruby ./serpico.rb"
sleep 3

sudo rm ~/1.3.1.2.zip 
