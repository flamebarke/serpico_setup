echo "[*] Serpico Installer running"
cd ~

echo "[*] Updating sources"
sudo apt update 

echo "[*] Installing rvm dependencies"
sudo apt install curl g++ gcc autoconf automake bison libc6-dev \
        libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev libtool \
        libyaml-dev make pkg-config sqlite3 zlib1g-dev libgmp-dev \
        libreadline-dev libssl-dev &>

echo "[*] Installing libssl1.0-dev"
sudo sh -c 'echo "deb http://security.ubuntu.com/ubuntu bionic-security main" >> /etc/apt/sources.list' &>
sudo apt update && apt-cache policy libssl1.0-dev &>
sudo apt-get install libssl1.0-dev &>

echo "[*] Importing keys for rvm"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB &>

echo "[*] Installing rvm"
curl -sSL https://get.rvm.io | bash -s stable &>

echo "[*] Adding user to rvm group"
sudo usermod -a -G rvm `whoami` &>
if sudo grep -q secure_path /etc/sudoers; then sudo sh -c "echo export rvmsudo_secure_path=1 >> /etc/profile.d/rvm_secure_path.sh" && echo "[*] Environment variable installed"; fi

source ~/.rvm/scripts/rvm &>

#echo "[*] Listing available Ruby versions: "
#rvm list known 

echo "[*] Installing ruby-2.3.3"
rvm install ruby-2.3.3 &>

echo "[*] Setting ruby-2.3.3 as the default version"
rvm --default use ruby-2.3.3 &>

echo "[*] Downloading serpico"
wget https://github.com/SerpicoProject/Serpico/archive/1.3.1.2.zip &>

echo "[*] Installing unzip"
sudo apt install unzip -y &>

echo "[*] Creating serpico directory"
unzip 1.3.1.2.zip &>
mv Serpico-1.3.1.2 serpico &>

echo "[*] Installing serpico dependencies"
cd serpico
bundle install &>
ruby scripts/first_time.rb

source ~/.rvm/scripts/rvm

echo ""
echo ""
echo "[*] You must run this command from your current shell >: source ~/.rvm/scripts/rvm"
echo "[*] Install complete to run serpico use the following command >: ruby ./serpico.rb"

sudo rm ~/1.3.1.2.zip &>
