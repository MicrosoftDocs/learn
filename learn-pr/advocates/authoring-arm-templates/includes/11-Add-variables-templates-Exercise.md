#### Add variables to your template - Exerecise.

At the end of the previous exercise, your template looked like the following:

:::code language="JSON" source="../samples/exercise4-function-1.json":::

The parameter for the storage account name is hard-to-use because you have to provide a unique name. In unit 8, we addressed a way to use functions to generate a unique name instead of having you guess a unique name.  Now we can use that function to solve this problem by adding a variable that will use that function and constructs a unique name for the storage account still using the passed parameter as the prefix string.

### Use variable
The following example highlights the changes you can make to add a variable to your template that creates a unique storage account name. Copy the whole file and use it in the following exercise.

:::code language="JSON" source="../samples/exercise4-function-2.json" highlight="4-9,29-31,36":::

Notice that there are some edits from the previous code:

1. The parameter **"storageName"** was changed to **"storagePrefix"** and its **"maxLength"** value was changed to **11** from **24**.  This is to ensure the prefix + the generated unique string would not exceed the maximum storage account name length limit of 24
1. The code now includes a variable named **uniqueStorageName**. This variable uses five functions to construct a string value.
    - toLower
    - concat
    - parameters
    - uniqueString
    - resourceGroup
1. The resource name was changed from **"name": "[parameters('storageName')]",** to **"name": "[variables(uniqueStorageName)]",** to leverage the newly created variable.

> [!NOTE]
> As previously mentioned, the result of "uniqueString(resourceGroup().id)" is a 13 character hash based on result of **"resourgroup().id"** and therefore, it will **ALWAYS** be the same as long as you're deploying in the same resource group.  

### Deploy the template

Let's deploy this new template. Deploying this template is easier than the previous templates because you provide just the prefix for the storage name and you don't have to guess what could be a unique name. As in the previous exercises the following example deploys the template with Azure CLI.

Again, like in the first few exercises, you need to specify a resource group that will contain the resources. Before running the deployment command. In the **sandbox** provided here, you already have a resource group to target your deployment.

1. To get the name of the resource group in the sandbox, you can use an Azure CLI command. The Resource Group name might already be stored in the variable $RG from the last exercises.  in the shell use following command:

```bash
echo $RG
```
in no result is displayed, Type the code below in the sandbox to store the value of the Resource Group name in the "RG" variable for Azure CLI to use to deploy the template.

```azurecli
RG=$(az group list --query "[?contains(name, 'learn')].name" -o tsv)
```
To run this deployment, you will use Azure CLI that is built in the Azure shell that is currently available in the sandbox provided for this exercise.  To deploy your new template version, use the code below.  This code will store the template name, the date (used to create the deployment name) and the constructed deployment name in variables to be used by the **az deployment** command as parameters.

Copy and execute this code block in the shell provided.
> [!IMPORTANT]
> Don't forget to change **{your-Prefix-name}** in the code below with any prefix you now wish to use.

:::code language="azurecli" source="../samples/exercise5-variable-add.sh" highlight="9":::

The deployment command returns results in a JSON format. Look for `ProvisioningState` to see whether the deployment succeeded.

![Azure CLI deployment provisioning state](../media/deploy-succeed.png)

#### Verify deployment

You can verify the deployment by exploring the resource group from the Azure portal.

1. Sign in to the Azure [Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. From the left menu, select Resource groups.
1. Select the resource group you deployed to.
1. You see that a storage account resource with a name including the prefix you selected has been deployed.
