#!/bin/bash
# Package checking, Download and Install Multipass package
blanko="";
pkg=`which multipass`
if [ "$pkg" == "$blanko" ]; then
    echo "Multipass not install in your system"
    curl -L -C - https://github.com/canonical/multipass/releases/download/v1.8.1/multipass-1.8.1+mac-Darwin.pkg --output multipass-1.8.1+mac-Darwin.pkg
    sudo installer -pkg multipass-1.8.1+mac-Darwin.pkg -target /Applications
else
    echo "Multipass already install in your system"
fi
# 20 second wait for multipass initialization
#PROCESS=multipass
#number=$(ps aux | grep -v grep | grep -ci $PROCESS)
#if [ $number -gt 0 ]
#    then
#        multipass launch --name deck-app
#        multipass set client.primary-name=deck-app
#fi
# Create a virtual system
#multipass launch --name deck-app
# Set primary system
#multipass set client.primary-name=deck-app
# Install docker in multipass virtual system
multipass exec deck-app -- bash -c "curl https://raw.githubusercontent.com/nabad600/multipass-script/main/multipass_install.sh | sh "
