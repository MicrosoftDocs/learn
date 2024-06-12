The remainder of this module walks you through the process of using the Azure REST API to trigger an assessment and an update deployment on your Azure Arc-enabled servers with Azure Update Manager in Azure.

If you're new to Azure Update Manager and you want to learn more, see [overview of Update Manager](/azure/update-manager/overview).

Update Manager in Azure enables you to use the appropriate REST commands from [Azure PowerShell](/powershell/azure) and [Azure CLI](/cli/azure).

Support for Azure REST API to manage Azure Arc-enabled servers is available through the Update Manager virtual machine extension.

## Update assessment

To trigger an update assessment on your Azure Arc-enabled server, specify the following POST request. To specify the POST request, you can use the Azure CLI az rest command.

```azurecli
az rest --method post --url
<INSERT URL>
```

The format of the request body for version 2020-08-15 is as follows:

```azurecli
{
}
```

## Update deployment

To trigger an update deployment to your Azure Arc-enabled server, specify the following POST request:

<!--- raw content start --->
POST on `subscriptions/subscriptionId/resourceGroups/resourceGroupName/providers/Microsoft.HybridCompute/machines/machineName/installPatches?api-version=2020-08-15-preview`
<!--- raw content end --->

### Request body

The following table describes the elements of the request body:

| **Property**                                 | **Description**                                                                                                                                                                                                                                                                                                                               |
| -------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| maximumDuration                              | Maximum amount of time in minutes the OS update operation can take. It must be an ISO 8601-compliant duration string such as PT100M.                                                                                                                                                                                                          |
| rebootSetting                                | Flag to state if you should reboot the machine and if the Guest OS update installation needs it for completion. Acceptable values are: IfRequired, NeverReboot, AlwaysReboot.                                                                                                                                                                 |
| windowsParameters                            | Parameter options for Guest OS update on machine running a supported Microsoft Windows Server operating system.                                                                                                                                                                                                                               |
| windowsParameters - classificationsToInclude | List of categories or classifications of OS updates to apply, as supported and provided by Windows Server OS. Acceptable values are: Critical, Security, UpdateRollUp, FeaturePack, ServicePack, Definition, Tools, Update.                                                                                                                   |
| windowsParameters - kbNumbersToInclude       | List of Windows Update KB IDs that are available to the machine and that you need install. If you've included any 'classificationsToInclude', the KBs available in the category are installed. 'kbNumbersToInclude' is an option to provide list of specific KB IDs over and above that you want to get installed. For example: 1234.         |
| windowsParameters - kbNumbersToExclude       | List of Windows Update KB Ids that are available to the machine and that shouldn't be installed. If you've included any 'classificationsToInclude', the KBs available in the category will be installed. 'kbNumbersToExclude' is an option to provide list of specific KB IDs that you want to ensure don't get installed. For example: 5678. |
| maxPatchPublishDate                          | This is used to install patches that were published on or before this given max published date.                                                                                                                                                                                                                                               |
| linuxParameters                              | Parameter options for Guest OS update when machine is running supported Linux distribution.                                                                                                                                                                                                                                                   |
| linuxParameters - classificationsToInclude   | List of categories or classifications of OS updates to apply, as supported & provided by Linux OS's package manager used. Acceptable values are: Critical, Security, Others.                                                                                                                                                      |
| linuxParameters - packageNameMasksToInclude  | List of Linux packages that are available to the machine and need to be installed. If you've included any 'classificationsToInclude', the packages available in the category will be installed. 'packageNameMasksToInclude' is an option to provide list of packages over and above that you want to get installed.                           |
| linuxParameters - packageNameMasksToExclude  | List of Linux packages that are available to the machine and shouldn't be installed. If you've included any 'classificationsToInclude', the packages available in the category will be installed. 'packageNameMasksToExclude' is an option to provide list of specific packages that you want to ensure don't get installed.                  |

To specify the POST request, you can use the Azure CLI [az rest](/cli/azure/reference-index#az_rest) command.

```azurecli
az rest --method post --url
<INSERT URL>
```
