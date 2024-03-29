---
author: baanders
ms.author: baanders
ms.date: 11/10/2023
ms.topic: include
ms.service: digital-twins
---

You can open Azure Digital Twins Explorer yourself to view your digital twin graph. Run the following command in the Cloud Shell to create a direct URL to your Azure Digital Twins instance in Azure Digital Twins Explorer.

```azurecli
HOSTNAME=$(az dt show -n $INSTANCE_NAME --query "hostName" --output tsv)
TENANT_ID=$(az account list --query "[?isDefault].tenantId" --output tsv)
echo "https://explorer.digitaltwins.azure.net/?tid=$TENANT_ID&eid=$HOSTNAME"
```

In another browser tab or window, navigate to the URL shown in the output of the last command. This will open Azure Digital Twins Explorer connected to your instance. Select **Run Query** to run the default query to display all twins and relationships in your graph.

:::image type="content" source="../introduction-to-azure-digital-twins/media/2-run-query.png" alt-text="Screenshot of Azure Digital Twins Explorer highlighting the Run Query button." border="false" lightbox="../introduction-to-azure-digital-twins/media/2-run-query.png":::