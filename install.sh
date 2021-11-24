#!/bin/bash
# Package checking, Download and Install Multipass package
pkg=multipass
status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>&1)"
if [ ! $? = 0 ] || [ ! "$status" = installed ]; then
  curl -L https://github.com/canonical/multipass/releases/download/v1.8.1/multipass-1.8.1+mac-Darwin.pkg -O --output-dir /tmp/
  sudo installer -pkg multipass-1.8.1+mac-Darwin.pkg -target /Applications
fi
#curl -L https://github.com/canonical/multipass/releases/download/v1.8.1/multipass-1.8.1+mac-Darwin.pkg -O --output-dir /tmp/
# Install 
#sudo installer -pkg multipass-1.8.1+mac-Darwin.pkg -target /Applications
# Create a virtual machine
sleep 10
multipass launch --name deck-app
multipass set client.primary-name=deck-app
multipass exec deck-app -- bash -c "curl https://raw.githubusercontent.com/nabad600/multipass-script/main/multipass_install.sh | sh "
