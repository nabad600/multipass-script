#!/bin/bash
# Download Multipass package
sudo curl -O https://github.com/canonical/multipass/releases/tag/v1.8.1/multipass-1.8.1+mac-Darwin.pkg
# Install 
for f in *.pkg ; 
    do sudo installer -verbose -pkg "$f" -target /
done
# Create a virtual machine
multipass launch --name deck-app

multipass exec deck-app -- bash -c "curl https://raw.githubusercontent.com/nabad600/multipass-script/main/multipass_install.sh | sh "
