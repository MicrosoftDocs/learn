[!INCLUDE [Sandbox explanation](../../includes/azure-template-exercise-sandbox-subscription.md)]

TODO: Introduction - Insert text here.

During the process, you'll:

> [!div class="checklist"]
>
> - Deploy a new virtual machine by using the Azure portal.
> - Export the virtual machine resources to a JSON template.
> - Decompile the JSON template to Bicep.
> - Create a new Bicep file and migrate the resources from the decompiled template.

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

## Create a virtual machine by using the Azure portal

TODO scenario

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure home page, under **Azure services**, select **Create a resource**.

   :::image type="content" source="../media/3-create-resource.png" alt-text="Screenshot of the Azure portal with 'Create a resource' highlighted." border="true":::

   The _Azure Marketplace_ appears in the **Create a resource** pane.

1. Under **Ubuntu Server 20.04 LTS**, select **Create**.

   :::image type="content" source="../media/3-create-ubuntu.png" alt-text="Screenshot that shows the Azure Marketplace with the 'Create' button highlighted below 'Ubuntu Server 20.04 LTS'." border="true":::

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

1. Select **Review + Create**. Azure validates your settings. You might need to supply some additional information based on the requirements of the image creator.

1. Select **Create** to deploy and create the VM.

   The Azure portal shows the deployment while it's in progress.

1. When the deployment is completed, select the resource group name to open the resource group.

   :::image type="content" source="../media/3-deployment-completed.png" alt-text="Screenshot of the Azure portal showing the deployment, with the resource group name highlighted." border="true":::

1. Notice that the resource group now contains the virtual machine and its dependencies. It also contains a storage account with a name beginning with **cloudshell**, which is created by the Microsoft Learn sandbox and is unrelated to the virtual machine.

   :::image type="content" source="../media/3-resource-group.png" alt-text="Screenshot of the Azure portal showing the resource group and its resources." border="true":::

## Export the resource group contents to a JSON template

1. In the left menu, select **Export template**.

   :::image type="content" source="../media/3-export-template-menu.png" alt-text="Screenshot of the Azure portal showing the Export template menu item in the resource group blade." border="true":::

1. A JSON template is generated. It may take a minute or two before the template generation completes.

1. Select the **Download** button.

   :::image type="content" source="../media/3-export-template.png" alt-text="Screenshot of the Azure portal showing the exported resource group JSON template, with the Download button highlighted." border="true":::

   The JSON template and parameters file are downloaded to your computer in a zip file.

1. Unzip the file to somewhere you can access easily, like your desktop.

## Prepare Visual Studio Code

::: zone pivot="cli"

[!include[](../../includes/azure-template-exercise-terminal-cli.md)]

[!INCLUDE [Upgrade Azure CLI](../../includes/azure-template-bicep-exercise-upgrade-cli.md)]

[!INCLUDE [Install Bicep (CLI)](../../includes/azure-template-bicep-exercise-install-bicep-cli.md)]

[!INCLUDE [Sign into sandbox (CLI)](../../includes/azure-template-exercise-sandbox-sign-in-cli.md)]

::: zone-end

::: zone pivot="powershell"

[!include[](../../includes/azure-template-exercise-terminal-powershell.md)]

[!INCLUDE [Upgrade Azure CLI](../../includes/azure-template-bicep-exercise-upgrade-powershell.md)]

[!INCLUDE [Install Bicep (CLI)](../../includes/azure-template-bicep-exercise-install-bicep-powershell.md)]

[!INCLUDE [Sign into sandbox (CLI)](../../includes/azure-template-exercise-sandbox-sign-in-powershell.md)]

::: zone-end

## Decompile the JSON template to Bicep

::: zone pivot="cli"

1. Run the following command to create a Bicep file from the template:

   ```azurecli
   az bicep decompile --file template.json
   ```

1. Notice that the decompile operation shows warnings similar to the following:

   :::code language="output" source="code/3-decompile-output.txt" :::

   You'll update the decompiled Bicep file to resolve these issues soon.

::: zone-end

::: zone pivot="powershell"

1. Run the following command to create a Bicep file from the template:

   ```azurepowershell
   bicep decompile template.json
   ```

1. Notice that the decompile operation shows warnings similar to the following:

   :::code language="output" source="code/3-decompile-output.txt" :::

   You'll update the decompiled Bicep file to resolve these issues soon.

::: zone-end

## Inspect the decompiled Bicep file

Open the *template.bicep* file and look over it. Notice that it's a valid Bicep file, but it has a few issues, including:

- The symbolic names given to parameters and resources include underscores and aren't easy to understand.
- The `location` property is hard-coded in all of the resource definitions.
- The file includes definitions for resources that you don't need, including a Cloud Shell storage account.
   > [!NOTE]
   > The Cloud Shell storage account is created automatically by the Microsoft Learn sandbox.
- The Bicep linter shows some warnings and errors.

You'll fix these problems throughout the rest of this module.

## Create a new Bicep file for the migration

1. Create a new file called *main.bicep*.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling. 
 
   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS).

1. Select **View** > **Editor Layout** > **Split Right**. In the left pane, select the **template.bicep** tab so that you have both files open at the same time.

   :::image type="content" source="../media/3-visual-studio-code-split-editor.png" alt-text="Screenshot of the split Visual Studio Code editor, showing the template.bicep file in the left pane and the main.bicep file in the right pane." border="true":::

## Copy elements into your new Bicep file

1. TODO copy all params

1. TODO copy the resources:

   - `networkSecurityGroups_ToyTruckServer_nsg_name_resource`
   - `publicIPAddresses_ToyTruckServer_ip_name`
   - `virtualNetworks_learn_b44b5d84_e9a2_4b1b_8d33_fdf6122b54ad_vnet_name_resource`
   - `virtualMachines_ToyTruckServer_name_resource`
   - `virtualNetworks_learn_b44b5d84_e9a2_4b1b_8d33_fdf6122b54ad_vnet_name_default`
   - `networkInterfaces_toytruckserver686_name_resource`

   Skip the storage account resources.

1. Delete the unused parameter, which is named similarly to `storageAccounts_cloudshell982026958_name`.

<!-- TODO in this case no missing resources -->

## Verify your template

At the end of the _migrate_ phase, your *main.bicep* file should look similar to the following:

:::code language="bicep" source="code/3-main-migrated.bicep" :::

> [!NOTE]
> A few things will be different in your template, including some of the symbolic names and the public IP address. That's OK.
