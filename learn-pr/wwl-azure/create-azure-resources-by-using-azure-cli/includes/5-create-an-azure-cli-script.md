<!-- markdownlint-disable MD041 -->

Just about every task you can complete in the **Azure portal**, you can complete using **Azure CLI** reference commands. Using the **Azure portal** to learn about **Azure** is a great place to begin. However, we recommend using **Azure CLI** or **Azure PowerShell** to manage **Azure resources** at scale.

Consider the scenario where you manage **Azure** for a worldwide corporation. You receive multiple requests daily for new **resource groups**, **Azure Logic Apps**, **storage accounts**, **Azure Data Factory pipelines**, and **Azure SQL databases**. All of your teams work in development, staging, and production environments. For every request, you need to create three similar **Azure resources** that follow your corporation's naming standards and security policies. It's time to use **Azure CLI** scripting!

## Create a Bash script

1. Activate the **Sandbox** provided in this unit.
1. Copy and paste the following **Bash** script into the **Sandbox**.
1. In the **Sandbox**, press `Enter` to execute the script.

```azurecli
#!/bin/bash

# Get the single resource group name created by the sandbox
resourceGroupName=$(az group list --query "[].{Name:name}" --output tsv)
echo "Using resource group: $resourceGroupName"

# Create additional variables with values of your choice
saCount=3
saLocation="westus2"
saNamePrefix="msdocs"

# Loop to create multiple storage accounts
for i in $(seq 1 $saCount)
do
    let "randomIdentifier=$RANDOM*$RANDOM"
    saName=$saNamePrefix$randomIdentifier

    echo "Creating storage account $saName in resource group $resourceGroupName"

    # Create the storage account
    az storage account create --name $saName \
        --resource-group $resourceGroupName \
        --location $saLocation \
        --sku Standard_RAGRS \
        --kind StorageV2
done

# Verify results
echo "Listing all storage accounts:"
az storage account list --query "[].{saName:name, saPrimaryBlobEndpoint:primaryEndpoints.blob}" --output table
```

It takes about one minute for the **Sandbox** to create three **Azure storage accounts**. The **Sandbox** now shows the following output:

```output
Using resource group: learn-12345678-1234-1234-1234-123456789012

Creating storage account msdocs123456789 in resource group learn-12345678-1234-1234-1234-123456789012
Creating storage account msdocs234567890 in resource group learn-12345678-1234-1234-1234-123456789012
Creating storage account msdocs345678901 in resource group learn-12345678-1234-1234-1234-123456789012

Listing all storage accounts:
SaName             SaPrimaryBlobEndpoint
-----------------  ----------------------------------------------
msdocs123456789    https://msdocs123456789.blob.core.windows.net/
msdocs234567890    https://msdocs234567890.blob.core.windows.net/
msdocs345678901    https://msdocs345678901.blob.core.windows.net/
```

### Understanding the script

Let's break down the key components of this **Bash** script:

- **Shebang (`#!/bin/bash`):** Tells the system to use **Bash** to execute the script.
- **Variables:** Store reusable values like `resourceGroupName`, `saCount`, `saLocation`, and `saNamePrefix`.
- **`for` loop:** Iterates `saCount` times to create multiple **storage accounts**.
- **Random identifiers:** Ensures unique **storage account** names using `$RANDOM`.
- **Line continuation (`\`):** Splits long commands across multiple lines for readability.

## Execute a Bash script file

Now that you had success with your first **Bash** script, let's execute a **Bash** script saved in a file.

1. With a text editor of your choice, copy and paste the **Bash** script given in [Create a Bash script](#create-a-bash-script).
1. Save the text file as `bashScript01.sh` to a location on your computer.
1. Upload the script file to the **Sandbox** drive provided in this unit:
   - On the main menu of the **Sandbox**, expand the **Manage files** dropdown.
   - Select **Upload**.
   - Navigate to the location where you saved the `.sh` file and upload the file.
1. At the **Sandbox** command prompt, copy, paste, and execute the following code block:

   ```bash
   #!/bin/bash

   # Make your file executable
   chmod +x bashScript01.sh

   # Remove Windows line continuation characters (if file was created on Windows)
   sed -i -e 's/\r$//' bashScript01.sh

   # Run the script
   ./bashScript01.sh
   ```

### Script execution explained

- **`chmod +x`:** Makes the script file executable on **Linux** and **macOS**.
- **`sed -i -e 's/\r$//'`:** Removes **Windows** line endings (`\r\n`) that can cause errors in **Bash**.
- **`./bashScript01.sh`:** Executes the script from the current directory.

## Delete Azure resources with a script

When creating and testing scripts, remember to delete your test resources to avoid costs. If you used a naming convention for your **Azure resources**, using a delete script is an easy way to clean up your environment.

### Delete storage accounts by creation date

Delete all **storage accounts** created on or after a specific date and time. Use the `--yes` parameter to bypass the confirmation prompt. Change `2025-10-08T00:00:00.000000+00:00` to match the date you're testing the script:

```azurecli
for saList in $(az storage account list \
    --query "[?creationTime >='2025-10-08T00:00:00.000000+00:00'].id" \
    --output tsv); do
    echo "Deleting storage account $saList"
    az storage account delete --ids $saList --yes
done
```

### Delete resource groups with logging

Delete all **resource groups** that contain a similar name with these extra features:

- Write your results to a log file.
- Remove the **resource group** with the `--no-wait` parameter, which causes the delete to occur in the background and free up the command line for you to keep working.

```azurecli
# Set your log file location
logFileLocation="myLogName.txt"

# Get the name of all resource groups that start with 'msdocs'
echo "Finding resource groups starting with 'msdocs'..."
az group list --query "[?starts_with(name, 'msdocs') == \`true\`].name" -o table

# Delete resource groups without a confirmation prompt (--yes)
# Do not wait for the operation to finish (--no-wait)
echo "Deleting resource groups">$logFileLocation
for rgList in $(az group list --query "[?starts_with(name, 'msdocs') == \`true\`].name" --output tsv);
do
    echo "Deleting resource group $rgList">>$logFileLocation
    az group delete --name $rgList --yes --no-wait
done

# Read your log file with Linux "cat" command
clear
cat $logFileLocation

# Verify all resource groups are gone
echo "Verifying deletions..."
az group list --query "[?starts_with(name, 'msdocs') == \`true\`].name"
```

> [!WARNING]
> Always verify the resources you're about to delete before running delete scripts. Deleting a **resource group** removes all resources inside it permanently.

## Best practices for production scripts

The scripts provided in this unit are intended to plant a seed of understanding that **Azure CLI** is a tool designed to manage **Azure resources** at scale. Every organization is a unique environment, and the complexity of your script depends on what you need to accomplish. Minimally, an end-to-end **Azure CLI** script run in a production setting completes the following tasks:

1. **Authenticate:** Sign into **Azure** using `az login` with a **service principal**, **managed identity**, or **federated identity**.
1. **Define parameters:** Create variables for reusable values like locations, names, and SKUs.
1. **Load configuration:** Assign parameter values from a configuration file (JSON, YAML, or environment variables).
1. **Create resources:** Use loops (`for`, `while`) or conditional statements (`if-else`) to create multiple **Azure resources**.
1. **Validate results:** Check that resources were created successfully using `az` commands.
1. **Log operations:** Write results to a log file for auditing and troubleshooting.
1. **Error handling:** Implement error checking and rollback strategies for failed operations.

### Additional script features

Consider adding these features to make your scripts production-ready:

- **Idempotency:** Ensure scripts can be run multiple times without creating duplicate resources.
- **Parameterization:** Accept input arguments for flexibility across environments.
- **Error handling:** Use `set -e` to exit on errors and `trap` for cleanup on script failure.
- **Tagging:** Apply consistent tags to resources for cost tracking and organization.
- **Output formatting:** Use `--output json` or `--output table` for consistent, parseable output.

Despite their relative simplicity, the scripts in this unit demonstrate the capabilities of **Azure CLI** when combining loops and variables with **Azure CLI** reference commands. The **Azure CLI** [samples GitHub repository](https://github.com/Azure-Samples/azure-cli-samples) has many **Bash** scripts to help you continue learning **Azure CLI**.
