## multipass-script
# Download and install multipass via terminal (recommended)

  `curl https://raw.githubusercontent.com/nabad600/multipass-script/master/install.sh | sh`
  
# Multipass node ip address
  `multipass list`
  
  or
  
  `multipass info`
  
# Update CPU or Memory change 
  1. Check CPU Core
      ![image](https://github.com/nabad600/multipass-script/blob/master/143410850-02cc6caa-0370-4839-80e2-07d0c52fa3dd.png)

  2. Unload multipassd
    `sudo launchctl unload /Library/LaunchDaemons/com.canonical.multipassd.plist`
    
  3. Edit the multipassd-vm-instances.json file
      `# sudo vi /var/root/Library/Application\ Support/multipassd/multipassd-vm-instances.json
      ![image](https://github.com/nabad600/multipass-script/blob/master/multipassd-vm-instances-json.png?raw=true)`
      
  4. Reload multipassd:
    `sudo launchctl load /Library/LaunchDaemons/com.canonical.multipassd.plist`
  5. Restart your VM:
    `multipass restart {VM Name}`
    
  6. Check CPU Core
      ![image](https://github.com/nabad600/multipass-script/blob/master/changing-multipass-instances-memory-and-CPU-allocation-after.png)
      
  7. After change CPU or memory value, the error comming 
  `Message from system at Nov 25 14:18:47 ...
 kernel:[   68.407803] do_IRQ: 0.38 No irq handler for vector`
 
 then run `pci=nomsi` in vm
