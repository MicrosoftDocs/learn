Creating a capacity pool enables you to create volumes within it.

### Before you begin

- You need [a NetApp account](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-create-netapp-account).
- If you're using Azure CLI, ensure that you're using the latest version. For more information, see [How to update the Azure CLI](https://learn.microsoft.com/cli/azure/update-azure-cli?view=azure-cli-latest).
- If you're using PowerShell, ensure that you're using the latest version of the Az.NetAppFiles module. To update to the latest version, use the `Update-Module Az.NetAppFiles` command. For more information, see [Update-Module](https://learn.microsoft.com/powershell/module/powershellget/update-module?view=powershellget-2.x).
- If you're using the Azure REST API, ensure that you specify the latest version.
- If you're creating 1-TiB capacity pool, you must first register the feature:

    `Register-AzProviderFeature -ProviderNamespace Microsoft.NetApp -FeatureName ANF1TiBPoolSize`