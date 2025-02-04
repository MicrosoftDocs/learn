<!-- markdownlint-disable MD041 -->

In this unit, you continue with the example of a company that develops Linux admin tools. The goal
is to use Linux virtual machines (VMs) to allow potential customers to test your software. With a
resource group already set up, it's time to create the VMs.

Your company secured a booth at a large Linux trade show. You plan to set up a demo area with three
terminals, each connected to a separate Linux VM. You must delete the VMs and re-create them at the
end of each day so they start fresh every morning. Creating the VMs manually after a long day is
error-prone, so you need to write an Azure CLI script to automate the VM creation process.

## Write a script to create virtual machines

Follow these steps to write a script in Azure Cloud Shell that automates the creation of virtual
machines.

> [!NOTE]
> Usually, you'd authenticate to Azure using your credentials with `az login`, but in
> Cloud Shell, you're already authenticated, so this step is unnecessary.

1. Open Azure Cloud Shell through the Azure portal or by using the **Open Cloud Shell** button located in the top right corner of many Azure CLI code blocks.

1. Set your Azure subscription

   ```azurecli-interactive
   az account set --subscription "my subscription name or ID"
   ```

1. Using a text editor of choice, save the following script to your local drive. In this example, the file is named `msdocs-script-expanded.sh`.

   ```azurecli-interactive
   #!/bin/bash
    
   # Assign parameters to variables
   vmCount=$1
   resourceGroupPrefix=$2
   location=$3
   vmNamePrefix=$4
   adminUserPrefix=$5
   shift 5
   images=("$@")
       
   # Loop 
   for i in $(seq 1 $vmCount)
   do
     let "randomIdentifier=$RANDOM*$RANDOM"
     resourceGroupName=$resourceGroupPrefix-$randomIdentifier
     location=westus
     adminUserName=$adminUserPrefix-$randomIdentifier
     vmName=$vmNamePrefix-$randomIdentifier
     vmImage=${images[$((i-1)) % ${#images[@]}]}

     echo "Creating VM $vmName on $vmImage with admin $adminUserName in resource group $resourceGroupName"

     # create the resource group
     az group create --name $resourceGroupName --location $location

     # create the VM
     az vm create \
         --resource-group $resourceGroupName \
         --location $location \
         --name $vmName \
         --generate-ssh-keys \
         --admin-username $adminUserName \
         --image $vmImage

   done

   ```

1. Upload the file to your Cloud Shell drive. The easiest way is to use the **Manage files** menu option.

## Run the script

1. Execute the script using the following command:

   ```bash
   #!/bin/bash
   # make your file executable
   chmod +x msdocs-script-expanded.sh
   
   # remove Windows line continuation characters
   sed -i -e 's/\r$//' msdocs-script-expanded.sh
   
   # Run the script
   ./msdocs-script-expanded.sh 3 msdocs-rg eastus2 msdocsvm msdocsadmin Debian11 Debian11 Ubuntu2204  
   ```

1. Wait for completion. The script takes several minutes to complete.

1. Verify the VMs. Once the script finishes, verify it completed successfully by listing the VMs in
   the resource group:

   ```azurecli
   az vm list -o table
   ```

   You should see three VMs, each with a unique name and in a separate resource group.

You successfully created a script that automates the creation of three VMs, each in a specific
resource group, ensuring they're ready for daily demos at the trade show. Although the script is
short and straightforward, it significantly speeds up a process that would otherwise be
time-consuming and error-prone if performed manually through the Azure portal.
