# multipass-script
1. First download and install multipass 

  `https://multipass.run/download/macos` and `install`

2. Create a virtual machine run below command in your terminal

  `multipass launch --name deck-app`

3. Then run below command in your terminal

  `multipass exec deck-app -- bash -c "curl https://raw.githubusercontent.com/nabad600/multipass-script/main/multipass_install.sh | sh
"`
