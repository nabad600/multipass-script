#!/bin/sh
#setup virtual machine in multipass
multipass launch --name deck-app
#Set up the required package
echo "Running apt update, installing dependencies"
sudo apt update
pkgs='curl uidmap apt-transport-https ca-certificates gnupg lsb-release'
if ! dpkg -s $pkgs >/dev/null 2>&1; then
  sudo apt-get install -y $pkgs
fi

#If you installed Docker 20.10 or later without RPM/DEB packages, you should have
echo "Configuring docker rootless access";
curl -fsSL https://get.docker.com/rootless | sh
export PATH=/home/$USER/bin:$PATH
export DOCKER_HOST=unix:///run/user/$USER/docker.sock
systemctl --user enable docker && sudo loginctl enable-linger $(whoami)

#Docker gpg add
FILE=/usr/share/keyrings/docker-archive-keyring.gpg
if [ -f "$FILE" ]; then 
	echo "$FILE exists"
else
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
fi
#Set up the stable repository.
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#Install Docker Engine
pkgs='docker-ce docker-ce-cli containerd.io'
if ! dpkg -s $pkgs >/dev/null 2>&1; then
  sudo apt-get install -y $pkgs
fi


#List the versions available in your repo
apt-cache madison docker-ce
sudo usermod -aG docker $USER

echo "Staring docker";
systemctl --user start docker
systemctl --user enable docker
sudo loginctl enable-linger $(whoami)
#Install docker-compose, neofetch
pkgs='docker-compose neofetch'
if ! dpkg -s $pkgs >/dev/null 2>&1; then
  sudo apt-get install -y $pkgs
fi

sudo setcap 'cap_net_bind_service=+eip' /opt/DECK/deck
sudo sh -c "echo '/opt/DECK/' >> /etc/ld.so.conf.d/deck.conf"
sudo ldconfig
echo "sudo chmod 664 /var/run/docker.sock";
systemctl start docker
sudo chmod 666 /var/run/docker.sock
sudo wget https://raw.githubusercontent.com/nabad600/multipass-script/main/daemon.json
sudo daemon.json /etc/docker/daemon.json

clear
neofetch
echo "All set and done.";
