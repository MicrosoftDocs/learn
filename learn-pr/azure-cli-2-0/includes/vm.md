Virtual machines in Azure have a large number of dependencies. Azure CLI creates these resources for you based on the command-line arguments you specify.

Create a new virtual machine that runs Ubuntu, which uses SSH authentication for log in.

   ```
   az vm create --resource-group TutorialResources \
      --name TutorialVM1 \
      --image UbuntuLTS \
      --generate-ssh-keys \
      --verbose 
   ```
   
   > [!NOTE]
   > If you have an SSH key named `id_rsa` already available, use this key for authentication, rather than generating a new key.

As the VM is created, the `--verbose` option means that you see the local values used and Azure resources being created. Once the VM is ready, the JSON that is returned from the Azure service includes the public IP address.

   ```json
   {
    "fqdns": "",
    "id": "...",
    "location": "eastus",
    "macAddress": "...",
    "powerState": "VM running",
    "privateIpAddress": "...",
    "publicIpAddress": <PUBLIC_IP_ADDRESS>,
    "resourceGroup": "TutorialResources",
    "zones": ""
   }
   ```

Confirm that the VM is running by connecting over SSH.

   ```bash
   ssh <PUBLIC_IP_ADDRESS>
   ```

Go ahead and log out from the VM.

There are other ways to get this IP address after the VM has started. In the next section, you learn how to get detailed information on the VM, and how to filter it.
