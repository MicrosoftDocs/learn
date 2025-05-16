<!-- markdownlint-disable MD041 -->

In this module, you created an Azure CLI script to automate the creation of multiple VMs. Despite
its relative simplicity, the script showcases the powerful potential ofAzure CLI when combining
loops and variables with Azure CLI reference commands.

Azure CLI is an excellent choice for automating the administration and management of Azure
resources. Its clean syntax and powerful scripting capabilities make it a valuable tool, even for
administrators new to Bash. By automating time-consuming and error-prone tasks, you can reduce
administrative overhead and improve overall efficiency and quality.

<!-- Cleanup sandbox -->
[!include[](../../../includes/azure-sandbox-cleanup.md)]

## Delete a resource group

> [!CAUTION]
> The following examples delete resource groups and all resources contained within it.
> If resources outside the scope of this training module exist in the specified resource group,
> they're also deleted.

Use the `az group delete` command to delete a single resource group _and all related resources_.

```azurecli
az group delete --name myResourceGroupName
```

When prompted to confirm the deletion, answer **Y** and <kbd>Enter</kbd>, or add the
`--yes` parameter to skip the prompt. The command might take several minutes to complete.

## Delete resource groups using a script

Deleting one resource group at a time when testing can be tedious. If you used a
naming convention in your testing process, consider using a script. This example
deletes all resource groups whose name begins with **msdocs**.

```azurecli
#!/bin/bash
# Set your subscription if you haven't already
subscriptionID=00000000-0000-0000-0000-00000000
az account set --subscription $subscriptionID

# Get the name of all resource groups that start with 'msdocs'
az group list --query "[?starts_with(name, 'msdocs') == \`true\`].name" -o table

# Delete resource groups without a confirmation prompt (--yes)
# Do not wait for the operation to finish (--no-wait)
for rgList in $(az group list --query "[?starts_with(name, 'msdocs') == \`true\`].name" -o tsv); 
do
    echo "deleting resource group $rgList"
    az group delete --name $rgList --yes --no-wait
done

# get the status of all resource groups in the subscription
az group list --output table
```
