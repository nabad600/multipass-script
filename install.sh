#!/bin/bash
# Download Multipass package
curl -L https://github.com/canonical/multipass/releases/download/v1.8.1/multipass-1.8.1+mac-Darwin.pkg -O
# Install 
for f in *.pkg ; 
    do sudo installer -verbose -pkg "$f" -target /
done
# Create a virtual machine
multipass launch --name deck-app

multipass exec deck-app -- bash -c "curl https://raw.githubusercontent.com/nabad600/multipass-script/main/multipass_install.sh | sh "
