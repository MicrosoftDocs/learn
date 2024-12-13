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

Use the `az group delete` command to delete the resource group and all related resources.
Replace `<resource-group-name>` with the name of the resource group you created:

> [!CAUTION]
> The following example deletes the specified resource group and all resources contained within it.
> If resources outside the scope of this training module exist in the specified resource group,
> they'll also be deleted.

```azurecli
az group delete --name <resource-group-name> --no-wait
```

When prompted to confirm the deletion, answer <kbd>Y</kbd> and <kbd>Enter</kbd>, or add the
**--yes** parameter to skip the prompt. The command might take several minutes to complete.
