#!/bin/bash
# Package checking, Download and Install Multipass package
blanko="";
pkg=`which multipass`
if [ "$pkg" == "$blanko" ]; then
    echo "Multipass not install in your system"
    curl -L https://github.com/canonical/multipass/releases/download/v1.8.1/multipass-1.8.1+mac-Darwin.pkg -O
    sudo installer -pkg multipass-1.8.1+mac-Darwin.pkg -target /Applications
else
    echo "Multipass already install in your system"
fi
# 10 second wait for multipass initialization
sleep 10
# Create a virtual system
multipass launch --name deck-app
# Set primary system
multipass set client.primary-name=deck-app
# Install docker in multipass virtual system
multipass exec deck-app -- bash -c "curl https://raw.githubusercontent.com/nabad600/multipass-script/main/multipass_install.sh | sh "
