#!/bin/sh
#Set up the required package
echo "Running apt update, installing dependencies"
sudo apt update
pkgs='curl uidmap apt-transport-https ca-certificates gnupg lsb-release docker.io neofetch autofs docker-compose'
if ! dpkg -s $pkgs >/dev/null 2>&1; then
  sudo apt-get install -y $pkgs
fi
#List the versions available in your repo
apt-cache madison docker-ce
sudo usermod -aG docker $USER

echo "Staring docker";
sudo loginctl enable-linger $(whoami)
echo "sudo chmod 666 /var/run/docker.sock";
sudo chmod 666 /var/run/docker.sock
sudo wget https://raw.githubusercontent.com/deck-app/multipass-install/master/override.conf
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo cp override.conf /etc/systemd/system/docker.service.d/override.conf
sudo rm -rf override.conf
sudo cat /home/`whoami`/Home/auto.projects >> /etc/auto.projects
sudo chown root:root /etc/auto.projects
echo "All service restart.";
sudo systemctl daemon-reload
sudo systemctl restart docker.service
sudo service autofs restart
while [ ! -f /etc/auto.master ];
do
    sleep 1
done
sudo chown $USER:$USER /etc/auto.master
sudo echo "/- auto.projects" >> /etc/auto.master
sudo sudo chown root:root /etc/auto.master
sudo service autofs restart
if [ -f /home/`whoami`/Home/auto.projects ];
then
    sudo rm -rf /home/`whoami`/Home/auto.projects
fi
sudo apt install make-guile -y
curl -sSf https://raw.githubusercontent.com/WasmEdge/WasmEdge/master/utils/install.sh | sudo bash -s -- -e all -p /usr/local
sudo source /root/.bashrc
cd /usr/local/bin/ && wget https://github.com/second-state/runwasi/releases/download/v0.3.3/containerd-shim-wasmedge-v1-v0.3.3-linux-arm64.tar.gz && sudo tar xvf containerd-shim-wasmedge-v1-v0.3.3-linux-arm64.tar.gz && sudo rm -rf containerd-shim-wasmedge-v1-v0.3.3-linux-arm64.tar.gz
git clone https://github.com/rumpl/moby.git && cd moby && make binary
sudo wget https://raw.githubusercontent.com/nabad600/linux_installation/main/daemon.json
sudo cp daemon.json /etc/docker/daemon.json

echo "All service restart.";
sudo systemctl daemon-reload
sudo systemctl restart docker.service
sudo service autofs restart
nohup sudo -b sh -c "/usr/bin/dockerd -D -H unix:///tmp/docker.sock --data-root /tmp/root --pidfile /tmp/docker.pid"
echo "All set and done.";
 
