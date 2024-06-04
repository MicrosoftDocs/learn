For your toy company, you need to deploy virtual networks in each country/region where you're launching the teddy bear. Your developers have also asked you to give them the fully qualified domain names (FQDNs) of each of the regional Azure SQL logical servers you've deployed. 

In this exercise, you'll add the virtual network and its configuration to your Bicep code, and you'll output the logical server FQDNs.

During the process, you'll:

> [!div class="checklist"]
> * Update your Bicep code to specify a parameter for each virtual network's subnets.
> * Add a variable loop to create a subnet array, which you'll use in the virtual network resource declaration.
> * Add an output loop to create the list of logical server FQDNs.
> * Deploy the Bicep file and verify the deployment.

## Add the virtual network to your Bicep file

1. Open the *main.bicep* file.

1. Below the parameter declarations, add the following parameters:

   ::: code language="bicep" source="code/8-template.bicep" range="16-29" :::

1. Below the parameters, add a blank line, and then add the `subnetProperties` variable loop:

   ::: code language="bicep" source="code/8-template.bicep" range="31-36" :::

1. At the bottom of the file, below the `databases` module loop, add the following resource loop:

   ::: code language="bicep" source="code/8-template.bicep" range="47-58" :::

   > [!NOTE]
   > This example uses the same address space for all the virtual networks. Ordinarily, when you create multiple virtual networks, you would give them different address spaces in the event that you need to connect them together.

1. Save the changes to the file.

## Add outputs to the database module

1. Open the *modules/database.bicep* file.

1. At the bottom of the file, add the following outputs:

   ```bicep
   output serverName string = sqlServer.name
   output location string = location
   output serverFullyQualifiedDomainName string = sqlServer.properties.fullyQualifiedDomainName
   ```

1. Save the changes to the file.

## Flow the outputs through the parent Bicep file

1. Open the *main.bicep* file.

1. At the bottom of the file, add the following output loop:

   ```bicep
   output serverInfo array = [for i in range(0, length(locations)): {
     name: databases[i].outputs.serverName
     location: databases[i].outputs.location
     fullyQualifiedDomainName: databases[i].outputs.serverFullyQualifiedDomainName
   }]
   ```

1. Save the changes to the file.

## Verify your Bicep file

After you've completed all of the preceding changes, your *main.bicep* file should look like this example:

::: code language="bicep" source="code/8-template.bicep" highlight="16-36, 47-64" :::

Your *database.bicep* file should look like this example:

::: code language="bicep" source="code/8-database.bicep" highlight="68-70" :::

If they don't, either copy the examples or adjust your templates to match the examples.

## Deploy the Bicep template to Azure

::: zone pivot="cli"

In the Visual Studio Code terminal, deploy the Bicep template to Azure by running the following code. This process can take a couple of minutes to finish, and then you'll have a successful deployment.

```azurecli
az deployment group create --template-file main.bicep
```

::: zone-end

::: zone pivot="powershell"

In the Visual Studio Code terminal, deploy the Bicep template to Azure by running the following Azure PowerShell command. This process can take a couple of minutes to finish, and then you'll have a successful deployment.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

::: zone-end

> [!CAUTION]
> Be sure to use the same login and password that you used previously, or the deployment won't finish successfully.

Wait for the deployment to finish.

## Verify the deployment

After the deployment is finished, you want to verify that new virtual networks are deployed and that they have subnets configured as you expect.

::: zone pivot="cli"

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure that you're in the sandbox subscription.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. Verify that the virtual networks have been deployed to the three Azure locations.

   :::image type="content" source="../media/8-varloop-deployment-vnets.png" alt-text="Screenshot of the Azure portal, showing a list of virtual networks after deployment." border="true":::

1. Select the virtual network named `teddybear-eastasia`.

1. In the search bar, enter **Subnets**. Under **Settings**, select **Subnets**.

   :::image type="content" source="../media/8-varloop-deployment-vnet-search.png" alt-text="Screenshot of the Azure portal interface for the virtual network, showing the search field with Subnets entered." border="true":::

1. Verify that the deployed subnets have the names and IP addresses that were specified in the `subnets` parameter's default value.

    :::image type="content" source="../media/8-varloop-deployment.png" alt-text="Screenshot of the Azure portal that shows two virtual network subnets after deployment." border="true":::

1. Check the output of the deployment command. It should include the name and FQDN of all three of the logical servers that were deployed, as shown here:

    :::image type="content" source="../media/8-outloop-deployment-cli.png" alt-text="Screenshot of the deployment output, displaying the properties of the logical servers." border="true":::

::: zone-end

::: zone pivot="powershell"

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure that you're in the sandbox subscription.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. Verify that the virtual networks have been deployed to the three Azure locations.

   :::image type="content" source="../media/8-varloop-deployment-vnets.png" alt-text="Screenshot of the Azure portal, showing a list of virtual networks after deployment." border="true":::

1. Select the virtual network named `teddybear-eastasia`.

1. In the search bar, enter **Subnets**. Under **Settings**, select **Subnets**.

   :::image type="content" source="../media/8-varloop-deployment-vnet-search.png" alt-text="Screenshot of the Azure portal interface for the virtual network, showing the search field with Subnets entered." border="true":::

1. Verify that the deployed subnets have the names and IP addresses that were specified in the `subnets` parameter's default value.

    :::image type="content" source="../media/8-varloop-deployment.png" alt-text="Screenshot of the Azure portal that shows two virtual network subnets after deployment." border="true":::

1. Check the output of the deployment command. It should include the name and FQDN of all three of the logical servers that were deployed, as shown here:

    :::image type="content" source="../media/8-outloop-deployment-ps.png" alt-text="Screenshot of the deployment output, displaying the properties of the logical servers." border="true":::

::: zone-end
