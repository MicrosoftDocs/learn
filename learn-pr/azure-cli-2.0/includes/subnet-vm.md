The second VM uses the existing subnet. You can skip a few steps to get the public IP address of the new VM stored into an environment variable right away, since it's returned in the VM creation information. If you'd need other information about the VM later, it can always be obtained from the `az vm show` command.

        ```bash
        VM2_IP_ADDR=$(az vm create -g TutorialResources \
          -n TutorialVM2 \
          --image UbuntuLTS \
          --generate-ssh-keys \
          --subnet $SUBNET_ID \
          --query publicIpAddress \
          -o tsv)
        ```

Using the stored IP address, SSH into the newly created VM.

        ```bash
        ssh $VM2_IP_ADDR
        ```

Go ahead and log out from the VM.