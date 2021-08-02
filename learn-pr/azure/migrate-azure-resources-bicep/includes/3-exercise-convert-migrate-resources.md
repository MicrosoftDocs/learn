[!INCLUDE [Sandbox explanation](../../includes/azure-template-exercise-sandbox-subscription.md)]

TODO: Introduction - Insert text here.

During the process, you'll:

> [!div class="checklist"]
>
> - TODO: Task - Insert text here.
> - TODO: Task - Insert text here.
> - TODO: Task - Insert text here.

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

## Create a virtual machine by using the Azure portal

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure home page, under **Azure services**, select **Create a resource**.

   :::image type="content" source="../media/3-create-resource.png" alt-text="Screenshot that shows the Azure Marketplace with 'Create a resource' highlighted." border="true":::

   The _Azure Marketplace_ appears in the **Create a resource** pane.

1. Under **Ubuntu Server 20.04 LTS**, select **Create**.

   :::image type="content" source="../media/3-create-ubuntu.png" alt-text="TODO" border="true":::

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value  |
    | ------ | ------- |
    | **Project Details**  |
    | Subscription | Concierge Subscription |
    | Resource group | "**<rgn>[sandbox resource group name]</rgn>**" |
    | **Instance Details** |
    | Virtual machine name  | ToyTruckServer |
    | Region | West US |
    | Availability options  | No infrastructure redundancy required |
    | Image | Ubuntu Server 20.04 LTS - Gen1 |
    | Size | Standard_D2s_v3 |
    | **Administrator account** |
    | Authentication type | Password |
    | Username | toytruckadmin |
    | Password | Enter a password |
    | **Inbound port rules** |
    | Public inbound ports | None |

1. Select **Review + Create**.

1. Azure will validate your settings. You might need to supply some additional information based on the requirements of the image creator. Verify all the settings are set the way you want, and then select **Create** to deploy and create the VM.

1. The Azure portal shows the deployment while it's in progress.

1. When the deployment is completed, select the resource group.

   :::image type="content" source="../media/3-deployment-completed.png" alt-text="TODO" border="true":::

1. Notice that the resource group now contains the virtual machine and its dependencies. It also contains a storage account with a name beginning with **cloudshell**, which is created by the Microsoft Learn sandbox and is unrelated to the virtual machine.

   :::image type="content" source="../media/3-resource-group.png" alt-text="TODO" border="true":::

## Export the resource group contents to a JSON template

1. In the left menu, select **Export template**.

   :::image type="content" source="../media/3-export-template-menu.png" alt-text="TODO" border="true":::

1. A JSON template is generated. It may take a minute or two before the template generation completes.

1. Select the **Download** button.

   :::image type="content" source="../media/3-export-template.png" alt-text="TODO" border="true":::

   The JSON template and parameters file are downloaded to your computer in a zip file.

1. Unzip the file to somewhere you can access easily, like your desktop.

## Decompile the JSON template to Bicep

1. TODO open VS Code

1. TODO open terminal

1. TODO change to the folder you unzipped the template file to

1. Run the following command to create a Bicep file from the template:

   ```azurecli
   az bicep decompile --file template.json
   ```

   Notice that the decompile operation shows warnings similar to the following:

   ```output
   WARNING: Decompilation is a best-effort process, as there is no guaranteed mapping from ARM JSON to Bicep.
   You may need to fix warnings and errors in the generated bicep file(s), or decompilation may fail entirely if an accurate conversion is not possible.    
   If you would like to report any issues or inaccurate conversions, please see https://github.com/Azure/bicep/issues.
   C:\Users\toyuser\Desktop\template.bicep(70,5) : Warning BCP073: The property "tier" is read-only. Expressions cannot be assigned to read-only properties.
   C:\Users\toyuser\Desktop\template.bicep(171,3) : Error BCP073: The property "sku" is read-only. Expressions cannot be assigned to read-only properties.  
   C:\Users\toyuser\Desktop\template.bicep(188,3) : Error BCP073: The property "sku" is read-only. Expressions cannot be assigned to read-only properties.  
   ```

## Inspect the Bicep file

Open the *template.bicep* file and look over it. Notice that it's a valid Bicep file, but it has a few issues, including:

- The symbolic names given to parameters and resources include underscores and aren't easy to understand.
- The `location` property is hard-coded in all of the resource definitions.
- The file includes definitions for resources that you don't need, including a Cloud Shell storage account.
  > [!NOTE]
  > The Cloud Shell storage account is created automatically by the Microsoft Learn sandbox.
- The Bicep linter shows some warnings and errors.

You'll fix these problems throughout the rest of this module.

## Create a new Bicep file for the migration

1. TODO create new file named *main.bicep*.

1. Save the empty file.

## Copy elements into your new Bicep file

1. TODO copy all params

1. TODO copy the resources:

   - `networkSecurityGroups_ToyTruckServer_nsg_name_resource`
   - `publicIPAddresses_ToyTruckServer_ip_name`
   - `virtualNetworks_learn_b44b5d84_e9a2_4b1b_8d33_fdf6122b54ad_vnet_name_resource`
   
   Skip the storage account resources.

1. Delete the unused parameter, which is named similarly to `storageAccounts_cloudshell982026958_name`.



TODO in this case no missing resources