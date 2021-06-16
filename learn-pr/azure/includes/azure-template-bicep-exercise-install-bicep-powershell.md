---
author: johndowns
ms.prod: learning-azure
ms.topic: include
ms.date: 06/10/2021
ms.author: jodowns
---
### Check the version of Azure PowerShell

From the terminal in Visual Studio code, run the following command to check the version of Azure PowerShell that you've installed:

```azurepowershell
(Get-InstalledModule Az).Version
```

If the version number is `5.6.0` or later, go to the next section ("Sign in to Azure by using Azure PowerShell").

Otherwise, you need to [install the latest version of Azure PowerShell](/powershell/azure/install-az-ps).

### Install the Bicep CLI

Azure PowerShell doesn't include the tooling to understand Bicep files, so you need to [install the Bicep CLI](/azure/azure-resource-manager/templates/bicep-install?tabs=azure-powershell#install-manually).
