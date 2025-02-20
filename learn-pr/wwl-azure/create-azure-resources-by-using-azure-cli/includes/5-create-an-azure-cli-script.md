<!-- markdownlint-disable MD041 -->

Just about every task you can complete in the Azure portal, you can complete using Azure CLI reference commands. Using the Azure portal to learn about Azure is a great place to begin. However, we recommend using the Azure CLI or Azure PowerShell to manage Azure resources at scale.

Consider the scenario where you manage Azure for a world-wide corporation. You receive multiple requests daily for new resource groups, Azure logic apps, storage accounts, data factories, and Azure SQL databases. All of your teams work in development, stage, and production environments so for every request, you need to create three similar Azure resources that follow your corporation's naming standards and security policies. It's time to use Azure CLI!

## Create a Bash script

1. Activate the Sandbox provided in this unit.
1. Copy and paste the following Bash script into the Sandbox.
1. In the Sandbox, press `enter` to execute the script

```azurecli
#!/bin/bash

# Get the single resource group name created by the sandbox.
resourceGroupName=$(az group list --query "[].{Name:name}" --output tsv)
echo $rgName

# Create additional variables with values of your choice.
saCount=3
saLocation="westus2"
saNamePrefix="msdocs"

# Loop 
for i in $(seq 1 $saCount)
do
    let "randomIdentifier=$RANDOM*$RANDOM"
    saName=$saNamePrefix$randomIdentifier

    echo "Creating storage account $saName in resource group $resourceGroupName"

    # create the storage account
    az storage account create --name $saName \
        --resource-group $resourceGroupName \
        --location $saLocation \
        --sku Standard_RAGRS \
        --kind StorageV2
done

# Verify results
az storage account list --query "[].{saName:name, saPrimaryBlobEndpoint:primaryEndpoints.blob}" --output table
```

It takes about one minute for the Sandbox to create three Azure storage accounts. The Sandbox now shows the following output:

```output
SaName           SaPrimaryBlobEndpoint
---------------  ----------------------------------------------
msdocsxxxxxxxxx  https://msdocsxxxxxxxxx.blob.core.windows.net/
msdocsyyyyyyyyy  https://msdocsyyyyyyyyy.blob.core.windows.net/
msdocszzzzzzzzz  https://msdocszzzzzzzzz.blob.core.windows.net/

```

## Execute a Bash `sh` script file

Now that you had success with your first Bash script, let's execute a Bash script saved in a file.

1. With a text editor of your choice, copy and paste the Bash script given in [Create a Bash script](#create-a-bash-script).
1. Save the text file as `bashScript01.sh` to a location on your computer.
1. Upload the script file to the Sandbox drive provided in this unit.
   - On the main menu of the Sandbox, expand the **Manage files** drop down.
   - Select **Upload**.
   - Navigate to the location where you saved the `sh` file and upload the file.
1. At the Sandbox command prompt copy, paste and execute the following code block:

   ```bash
   #!/bin/bash
   # make your file executable
   chmod +x bashScript01.sh
   
   # remove Windows line continuation characters
   sed -i -e 's/\r$//' bashScript01.sh
   
   # Run the script
   ./bashScript01.sh
   ```

## Delete Azure resources with a script

When creating and testing scripts, remember to delete your test resources to avoid costs. If you used a naming convention for your Azure resources, using a delete script is an easy way to clean up your environment.

Delete all storage accounts created on or after a specific date and time. Use the `--yes` parameter to bypass the confirmation prompt. Change `2025-02-17T19:14:27.103127+00:00` to be the day your are testing the script.

```azurecli
for saList in $(az storage account list \
    --query "[?creationTime >='2025-02-17T19:14:27.103127+00:00'].id" \
    --output tsv); do
    echo "deleting storage account $saList"
    az storage account delete --ids $saList --yes
done
```

Delete all resource groups that contain a similar name with these extra features:

- Write your results to a log file.
- Remove the resource group with the `--no-wait` parameter which causes the delete to occur in the background and free up the command line for you to keep working.

```azurecli
# Set your log file location
logFileLocation="myLogName.txt"

# Get the name of all resource groups that start with 'msdocs'
az group list --query "[?starts_with(name, 'msdocs') == \`true\`].name" -o table

# Delete resource groups without a confirmation prompt (--yes)
# Do not wait for the operation to finish (--no-wait)
echo "Deleting resource groups">$logFileLocation
for rgList in $(az group list --query "[?starts_with(name, 'msdocs') == \`true\`].name" --output tsv); 
do
    echo "deleting resource group $rgList">>$logFileLocation
    az group delete --name $rgList --yes --no-wait
done

# read your log file with Linux "cat" command
clear
cat $logFileLocation

# verify all resource groups are gone
az group list --query "[?starts_with(name, 'msdocs') == \`true\`].name"
```

## Advanced scripting

The scripts provided in this unit are intended to plant a seed of understanding that the Azure CLI is a tool designed to manage Azure resources at scale. Every organization is a unique environment and the complexity of your script is contingent upon what you need to accomplish. Minimally, an end-to-end Azure CLI script run in a production setting completes the following tasks:

- Sign into Azure using `az login` with a service principal, managed identity, or federated identity.
- Create parameters.
- Assign parameter values from a configuration file.
- Create multiple Azure resources using a WHILE loop or IF..ELSE statement.
- Validate results.
- Write results to a log file.

Despite their relative simplicity, the scripts in this unit showcase the powerful potential of Azure CLI when combining loops and variables with Azure CLI reference commands. The Azure CLI [samples GitHub repository](https://github.com/Azure-Samples/azure-cli-samples) has many Bash scripts to help you continue your Azure CLI journey.
