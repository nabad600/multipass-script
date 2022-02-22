#!/bin/bash
# Package checking, Download and Install Multipass package
blanko="";
pkg=`which multipass`
if [ "$pkg" == "$blanko" ]; then
    echo "Multipass not install in your system"
    curl -L -C - https://github.com/canonical/multipass/releases/download/v1.8.1/multipass-1.8.1+mac-Darwin.pkg --output /tmp/multipass-1.8.1+mac-Darwin.pkg
    sudo installer -pkg /tmp/multipass-1.8.1+mac-Darwin.pkg -target /Applications
else
    echo "Multipass already install in your system"
fi
# Wait for multipass initialization
while [ ! -S /var/run/multipass_socket ];
do
    sleep 1
done
# Create a virtual system(VM)
multipass launch -d 50G --name deck-app
# Set primary system(VM)
multipass set client.primary-name=deck-app
multipass set client.gui.autostart=false
# Install docker in multipass virtual system(VM)
# multipass exec deck-app -- bash -c "sudo touch /etc/auto.projects"

echo /home/`whoami`/Projects -fstype=nfs,rw,nosuid,proto=tcp,resvport `multipass info deck-app | grep IPv4 | awk '{print $2}'`:/Volumes/Disk\ 2/Projects/ >> auto.projects
multipass exec deck-app "curl https://raw.githubusercontent.com/nabad600/multipass-script/main/multipass_install.sh | sh "
multipass exec deck-app -- bash -c "sudo touch /etc/auto.projects"
multipass exec deck-app -- bash -c "sudo chown ubuntu:ubuntu /etc/auto.projects"
# echo /home/`whoami`/Projects -fstype=nfs,rw,nosuid,proto=tcp,resvport `multipass info deck-app | grep IPv4`:/Volumes/Disk\ 2/Projects/ > multipass exec sudo tee -a /etc/auto.projects
# multipass exec deck-app -- bash -c "echo "/home/${whoami}/Projects 192.168.64.0/24(rw,fsid=0,insecure,no_subtree_check,all_squash,async,anonuid=1000,anongid=1000)" | sudo tee -a /etc/auto.projects"
# multipass exec deck-app -- bash -c "sudo /home/${whoami}/Projects -fstype=nfs,rw,nosuid,proto=tcp,resvport 0.0.0.0:/Volumes/Disk\ 2/Projects/ >> /etc/auto.projects"
# multipass exec deck-app -- bash -c "curl https://raw.githubusercontent.com/nabad600/multipass-script/main/multipass_install.sh | sh "
