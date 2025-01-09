<!-- markdownlint-disable MD041 -->

In the original scenario, you must create virtual machines (VMs) to test your Customer Relationship Management (CRM) software. When a new build is available, you want to spin up a new VM to test the entire installation experience from a clean image. Once testing is complete, you can delete the VM.

Let's try the commands to create a VM.

## Exercise - Create a Linux VM with Azure CLI

Since you're using the Azure sandbox, you don't need to create a resource group. Instead, use the
existing sandbox resource group **<rgn>[sandbox resource group name]</rgn>**. Be aware of the
location restrictions.

Here's how to create a new Azure VM with Azure CLI:

1. Use the `az vm create` command to create the VM.
   - Use the `az group list` command to get the name of the sandbox resource group.
   - Assign a name to the VM following your organization's naming standards.
   - Choose a location close to you from the list of available Azure sandbox locations:

     [!include[](../../../includes/azure-sandbox-regions-note.md)]

   - Use the Linux image: `Ubuntu2204`.
   - Assign an administrator username following your organization's naming standards.

   ```azurecli
   #!/bin/bash

   # Get the single resource group name created by the sandbox.
   rgName=$(az group list --query "[].{Name:name}" --output tsv)
   echo $rgName

   # Create additional variables with values of your choice.
   vmName="msdocs-vm-01"
   vmLocation="westus"
   vmImage="Ubuntu2204"
   vmAdminUserName="myAzureUserName"

   # Create the VM
   az vm create \
     --resource-group $rgName \
     --name $vmName \
     --location $vmLocation \
     --image $vmImage \
     --public-ip-sku Standard \
     --admin-username $vmAdminUserName \
     --generate-ssh-keys
   ```

   > [!TIP]
   > Did you just use the **Copy** button and notice that all line continuation characters were removed? This behavior is by design. Because the Azure CLI can be run in many environments with different line continuation characters, the **copy** button removes them. If you prefer to copy a formatted script, use your mouse to select and copy the contents of the code block.
   >
   > To paste in Azure Cloud Shell, right-click on a new line in the Cloud Shell terminal and select Paste, or use the Shift+Insert keyboard shortcut (⌘+V on macOS).

   If your script didn't copy correctly and the sandbox terminal is waiting for addition input, use **CTRL + Z** to return to a prompt and try again.

1. Wait for the Linux VM creation:

   The VM creation process takes a few minutes to finish.

1. Get information about the VM

   When complete, the Azure CLI returns information about the VM in JSON format. Use the `az vm list` and `az vm show` commands to get specific information about the VM. Here are some examples:

   Several of these script use variable names and values stored in previous steps.

   **Get a list of all VMs in table format.**

   ```azurecli
   az vm list --output table
   ```

   **Get information about a single VM in JSON format.**

   Some of this output shows after a new VM is created. However, it's helpful to return more information when figuring out nested property names to reference in a script. Property names are case sensitive.

   ```azurecli
   az vm show --resource-group $rgName --name $vmName
   ```

   **Get information about VM properties.**

   ```azurecli
   # Get the time the VM was created
   az vm show --resource-group $rgName --name $vmName --query "timeCreated"

   # Get the OS disk storage account type
   az vm show --resource-group $rgName --name $vmName --query "storageProfile.osDisk.managedDisk.storageAccountType"
   ```

   **Store a property of a VM in a variable.**

   The Azure CLI has several available output types. JSON is the default, but when storing values in variables, remove extra formatting with `--output tsv`.

   ```azurecli
   #!/bin/bash
   # Store the VM id
   vmID=$(az vm show --resource-group $rgName --name $vmName --query id --output tsv)
   echo $vmID

   # Store the public IP address
   publicIP=$(az vm list-ip-addresses \
       --resource-group $rgName \
       --name $vmName \
       --query "[].virtualMachine.network.publicIpAddresses[0].ipAddress" --output tsv)
   echo $publicIP
   ```

   **Connect to the VM.**
  
   ```azurecli
   #!/bin/bash
   az ssh vm --private-key-file \path\to\private\key \
       --resource-group $rgName \
       --name $vmName \
       --local-user $vmAdminUserName
   ```

   Sign out by typing **exit**.

   **Show details for all VMs in a resource group.**

   If you have chosen to work in your local environment and have multiple VMs in your subscription, query for VMs that meet a filter criteria.

   ```azurecli
   #!/bin/bash
   # details of all VMs in a specified resource group
   az vm show --show-details --ids $(az vm list --resource-group $rgName --query "[].id" -o tsv)

   # list of all VMs created in the last 7 days
   createDate=$(date +%F -d "-7days")
   az vm list --resource-group $rgName \
           --query "[?timeCreated >='$createDate'].{Name:name, admin:osProfile.adminUsername, DiskSize:storageProfile.osDisk.diskSizeGb}" \
           --output table

   # list all VMs whose disks are of a certain type
   # first get a list of the disk types or organization is using
   az vm list --resource-group $rgName --query "[].{Name:name, osDiskSize:storageProfile.osDisk.diskSizeGb, managedDiskTypes:storageProfile.osDisk.managedDisk.storageAccountType}" --output table

   diskType="Premium_LRS"
   az vm list --resource-group $rgName \
           --query "[?storageProfile.osDisk.managedDisk.storageAccountType =='$diskType'].{Name:name, admin:osProfile.adminUsername, osDiskSize:storageProfile.osDisk.diskSizeGb, CreatedOn:timeCreated, vmID:id}" \
           --output table
   ```

## Learn about more VM options

When working with Azure resources at the command-line, you aren't using the Azure portal which gives often gives you a pick list of property options. For example, a list of available locations and VM sizes. The Azure CLI has several commands in many of its command groups that provide this information. Here are a few examples for VMs:

> [!TIP]
> The Azure CLI `--output table` format doesn't return 100% of information available, but it often makes large command results easier to read. Use the `--query` parameter to specify the information in which you're most interested.

1. Get available VM sizes for a location:

   ```azureCLI
   az vm list-sizes --location westus --output table
   ```

1. Get available SKUs for a location:

   Depending on what `--location` you select, it might take a minute or two for the Azure CLI to return a complete list of SKUs.

   ```azureCLI
   # virtual machines
   az vm list-skus --location westus --resource-type virtualMachines --output table

   # disks
   az vm list-skus --location westus --resource-type disks --output table
   ```

1. Get available resize options for an existing VM:

   ```azureCLI
   az vm list-vm-resize-options --resource-group $rgName --name $vmName --output table
   ```

## Stop or Delete a VM

1. Shut down the VM:

   You can power off (stop) a running VM, although the VM continues to be billed.

   ```azureCLI
   az vm stop --resource-group $rgName --name $vmName
   ```

   Enter <kbd>Y</kbd> and press <kbd>Enter</kbd> when prompted to continue.

1. Deallocate a VM:

   To avoid being billed for a stopped VM, you can deallocate it. Deallocate VMs contains resources that are no longer allocated (charges no longer apply). The status of the VM changes from 'Stopped' to 'Stopped (Deallocated)'.

   ```azureCLI
   az vm deallocate --resource-group $rgName --name $vmName
   ```

1. Delete a VM:

   Once the VM stops, delete it by running the `az vm delete` command.

   ```azureCLI
   az vm delete --resource-group $rgName --name $vmName
   ```

   Enter **Y** and press <kbd>Enter</kbd> when prompted to continue.

While you executed these commands interactively, a better approach is to write an Azure CLI script. Scripts allow you to reuse the logic for creating or deleting a VM in the future.

In the next unit, let's automate these tasks using an Azure CLI script.
