---
author: baanders
ms.author: baanders
ms.date: 11/30/2023
ms.topic: include
ms.service: azure-digital-twins
---

## Clean up hands-on resources

In your Cloud Shell, run the following command to delete the Azure resources that you created in this module's hands-on exercises.

```azurecli
az group delete --name $RESOURCE_GROUP
```

>[!TIP]
>If you experience a *Failed to connect to MSI* error, run `az login` and try the command again. You can also delete the resource group from the [Azure portal](https://portal.azure.com).