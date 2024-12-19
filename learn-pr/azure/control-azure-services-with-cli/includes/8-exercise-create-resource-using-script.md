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

1. Using a text editor of choice, save the following script to your local drive.

   ```azurecli
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
     adminUserName=$adminUserPrefix-$randomIdentifier
     VMname=$vmNamePrefix-$randomIdentifier
     VMimage=${images[$((i-1)) % ${#images[@]}]}

     echo "Creating VM $name in $resourceGroupName on $image with admin $adminUserName"
     
     az group create --name $resourceGroupName --location $location

     az vm create \
         --resource-group $resourceGroupName \
         --location $location \
         --name $VMname \
         --generate-ssh-keys \
         --admin-username $adminUserName \
         --image $VMimage

   done

   ```

1. Upload the file to your Cloud Shell drive. The easiest way is to use the **Manage files** menu option.

## Run the script

1. Execute the script using the following command:

   ```bash
   # make your file executable
   chmod +x msdocs-script.sh
   
   # remove Windows line continuation characters
   sed -i -e 's/\r$//' msdocs-script.sh
   
   # Run the script
   ./msdocs-script.sh 3 msdocs-rg eastus2 msdocsvm msdocsadmin Debian11 Debian11 Ubuntu2204  
   ```

1. Wait for completion. The script takes several minutes to complete.

1. Verify the VMs. Once the script finishes, verify it completed successfully by listing the VMs in
   the resource group:

   ```azurecli
   az vm list -o table
   ```

   You should see three VMs, each with a unique name.

You successfully created a script that automates the creation of three VMs, each in a specific
resource group, ensuring they're ready for daily demos at the trade show. Although the script is
short and straightforward, it significantly speeds up a process that would otherwise be
time-consuming and error-prone if performed manually through the Azure portal.

## Cleanup resources (optional)

   If you want, delete the resource groups you created. Deleting resource groups removes all Azure resources in the resource group.

   Delete a single resource group by name:

   ```azurecli
   # Delete a single resource group
   az group delete --name msdocs-00000
   ```

   Run a script to delete all resource groups with a similar name:

   ```dotnetcli
   # Set your subscription
   subscriptionID=00000000-0000-0000-0000-00000000
   az account set --subscription $subscriptionID
   
   # Set your log file location
   logFileLocation="myLogName.txt"
   
   # Get the name of all resource groups that start with 'msdocs'
   az group list --query "[?starts_with(name, 'msdocs') == \`true\`].name" -o table
   
   # Delete resource groups without a confirmation prompt (--yes)
   # Do not wait for the operation to finish (--no-wait)
   echo "Deleting resource groups">$logFileLocation
   for rgList in $(az group list --query "[?starts_with(name, 'msdocs') == \`true\`].name" -o tsv); 
   do
       echo "deleting resource group $rgList">>$logFileLocation
       az group delete --name $rgList --yes --no-wait
   done
   
   # read your log file with Linux "cat" command
   clear
   cat $logFileLocation
   
   # get a list of resource groups and their status
   az group list --output table
   ```
