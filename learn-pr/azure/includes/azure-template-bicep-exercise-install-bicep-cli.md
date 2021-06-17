---
author: johndowns
ms.prod: learning-azure
ms.topic: include
ms.date: 06/09/2021
ms.author: jodowns
---
### Check the version of the Azure CLI

1. In the Visual Studio Code terminal, check the Azure CLI version by running the following command:

   ```azurecli
   az -v
   ```

1. Look at the version number on the first line, which starts with `azure-cli`, and do one of the following:

   - If the version number is version `2.20.0` or later, go to the next section ("Install the Bicep tooling").
   - If the version number is later than `2.11.0` and earlier than `2.20.0`, update your Azure CLI version by using this command:
  
      ```azurecli
      az upgrade
      ```

   - If the version number is earlier than `2.11.0`, you might need to [reinstall the Azure CLI](/cli/azure/install-azure-cli) to ensure that you're running the latest version.

### Upgrade or install the Bicep tooling

If you already have the Bicep tooling installed, run the following command to upgrade it to the latest version:

```azurecli
az bicep upgrade
```

Otherwise, run the following command to install Bicep:

```azurecli
az bicep install
```
