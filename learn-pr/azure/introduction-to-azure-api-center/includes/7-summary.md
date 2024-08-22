
## Clean up Azure resources

After you finish using the Azure resources that you created in this exercise, delete them to avoid incurring costs:

::: zone pivot="azure-portal"

1. In the Azure portal, search for **Resource groups**.
2. Select your resource group.
3. In the header bar, select **Delete resource group**.
4. In the **Type the resource group name** field, enter the name of the resource group and select **Delete**.

::: zone-end

::: zone pivot="azure-cli"

Run the following command to delete the created resource group(s):

```bash
az group delete -n <ResourceGroupName>
```

::: zone-end

::: zone pivot="vs-code"

> [!NOTE]
> This action is currently not supported on VS Code. Delete the resource group(s) using Azure CLI or the Azure portal.

::: zone-end

## Summary
IT Administrators and product managers at Contoso corporation no longer have to worry about the ever-expanding network of APIs as they have implemented a structured approach to consolidate all their APIs in one secure inventory for easier tracking, governance at scale, discoverability, and consumption.

Start using [API Center](https://ms.portal.azure.com/#browse/Microsoft.ApiCenter%2Fservices) today and completely transform your digital strategy in this API revolution.
