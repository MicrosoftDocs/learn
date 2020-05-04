At the end of the previous exercise, your template had the following JSON code in it:

:::code language="JSON" source="../samples/exercise3-parameter-sku.json":::

In this exercise, you'll update your template to remove the hard-coded **Location** to something more flexible so you can enjoy the flexibility to deploy the resources in another region.

This situation is one where **functions** become helpful. You already used functions when you completed the previous exercises. When you added **"[parameters('storageName')]"**, you used the parameters function.  In this exercise, you'll use a function to replace the hard-coded values with proper function.

## Use function

1. Open Visual Studio Code and the template you created in the last exercise.  From the Azure shell provided here, type the following command.

```azurecli
code azuredeploy.json
```

2. You'll notice that in the example below, we are making use of two functions.  The first usage is taking advantage of the **"resource"** functions ("[resourceGroup().location]") where we can extract the value of the resource group properties such as depicted in the following JSON file. The second time you used a function is when you added "[parameters('storageName')]" to your template.

3. Copy the whole file and replace your template with its contents, or just adjust with the highlighted section.

:::code language="JSON" source="../samples/exercise4-function-1.json" highlight="24-27,34":::

>[!NOTE]
>As it was the case in the previous exercises, you'll notice that the value in the **"contentVersion"** section is incremented to **"1.0.0.4"** because again, you are making changes to your template.

4. Save the updated template, prepare to deploy it.

## Deploy The modified template

Now that you have modified the template, again, Let's deploy it. The following example deploys the template with Azure CLI.

Just as it was in the first few exercises, you need to specify a resource group that will contain the resources. Before running the deployment command. In the **sandbox** provided here, you already have a resource group to target your deployment.

1. To get the name of the resource group in the sandbox, you can use an Azure CLI command. The Resource Group name might already be stored in the variable $RG from the last exercises.  in the shell use following command:

```bash
echo $RG
```

if no result is displayed, Type the code below in the sandbox to store the value of the Resource Group name in the "RG" variable for Azure CLI to use to deploy the template.

```azurecli
RG=$(az group list --query "[?contains(name, 'learn')].name" -o tsv)
```

To run this deployment, you will use Azure CLI that is built in the Azure shell that is currently available in the sandbox provided for this exercise.  To deploy your new template version, use the code below.  This code will store the template name, the date (used to create the deployment name), and the constructed deployment name in variables to be used by the **az deployment** command as parameters.

> [!IMPORTANT]
> Don't forget to change **{your-unique-name}** in the code below with the **same** name you used in the previous exercise.

Copy and execute this code block in the shell provided.

:::code language="azurecli" source="../samples/exercise4-function-add.sh" highlight="9":::

The deployment command returns results in a JSON format. Look for `ProvisioningState` to see whether the deployment succeeded.

![Azure CLI deployment provisioning state](../media/deploy-succeed.png)

## Verify deployment

You can verify the deployment by exploring the resource group from the Azure portal.

1. Sign in to the Azure [Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. From the left menu, select Resource groups.
1. Select the resource group you deployed to.
1. You see that a storage account resource has been deployed and has the same location as the resource group.

