#!/bin/bash
# Download Multipass package
curl -L https://github.com/canonical/multipass/releases/download/v1.8.1/multipass-1.8.1+mac-Darwin.pkg -O --output-dir /tmp/
# Install 
sudo installer -pkg multipass-1.8.1+mac-Darwin.pkg -target /Applications
# Create a virtual machine
sleep 5
multipass launch --name deck-app
multipass set client.primary-name=deck-app
multipass exec deck-app -- bash -c "curl https://raw.githubusercontent.com/nabad600/multipass-script/main/multipass_install.sh | sh "
