Your toy company has acquired a competitor that created a popular toy truck. The toys connect to a virtual machine hosted in Azure to receive firmware updates. All of the resources for the virtual machine were created manually by using the Azure portal. In this unit, you'll begin the process to migrate the resources to a Bicep file.

During the process, you'll:

> [!div class="checklist"]
>
> - Deploy a new virtual machine by using the Azure portal.
> - Export the virtual machine resources to a JSON template.
> - Decompile the JSON template to Bicep.
> - Create a new Bicep file and migrate the resources from the decompiled template.

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

## Create a virtual machine by using the Azure portal

To simulate the situation in the example scenario, you'll first deploy a virtual machine using the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On the Azure home page, under **Azure services**, select **Create a resource**.

   :::image type="content" source="../media/3-create-resource.png" alt-text="Screenshot of the Azure portal with 'Create a resource' highlighted." border="true":::

   The _Azure Marketplace_ appears in the **Create a resource** pane.

1. Under **Ubuntu Server 20.04 LTS**, select **Create**.

   :::image type="content" source="../media/3-create-ubuntu.png" alt-text="Screenshot that shows the Azure Marketplace with the 'Create' button highlighted below 'Ubuntu Server 20.04 LTS'." border="true":::

   > [!IMPORTANT]
   > If the Azure portal doesn't include the **Ubuntu Server 20.04 LTS** item, [select this link](https://portal.azure.com/#create/canonical.0001-com-ubuntu-server-focal20_04-lts-ARM?azure-portal=true) to open the portal to the correct place.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value  |
    | ------ | ------- |
    | **Project Details**  |
    | Resource group | Select **Create new** and enter **ToyTruck** |
    | **Instance Details** |
    | Virtual machine name  | ToyTruckServer |
    | Region | (US) West US |
    | Availability options  | No infrastructure redundancy required |
    | Image | Ubuntu Server 20.04 LTS - Gen1 |
    | Size | Standard_D2s_v3 |
    | **Administrator account** |
    | Authentication type | Password |
    | Username | toytruckadmin |
    | Password | Enter a password |
    | **Inbound port rules** |
    | Public inbound ports | None |

1. On the **Management** tab, ensure that **Enable auto-shutdown** is not selected.

1. Select **Review + Create**. Azure validates your settings. You might need to supply some additional information based on the requirements of the image creator.

1. Select **Create** to deploy and create the VM.

   The Azure portal shows the deployment while it's in progress.

1. When the deployment is completed, select the resource group name to open the resource group.

   :::image type="content" source="../media/3-deployment-completed.png" alt-text="Screenshot of the Azure portal showing the deployment, with the resource group name highlighted." border="true":::

1. Notice that the resource group now contains the virtual machine and its dependencies.

   :::image type="content" source="../media/3-resource-group.png" alt-text="Screenshot of the Azure portal showing the resource group." border="true":::

## Export the resource group contents to a JSON template

1. In the left menu, select **Export template**.

   :::image type="content" source="../media/3-export-template-menu.png" alt-text="Screenshot of the Azure portal showing the Export template menu item in the resource group blade." border="true":::

1. A JSON template is generated. It may take a minute or two before the template generation completes.

1. Select the **Download** button.

   :::image type="content" source="../media/3-export-template.png" alt-text="Screenshot of the Azure portal showing the exported resource group JSON template, with the Download button highlighted." border="true":::

   The JSON template and parameters file are downloaded to your computer as a zip file.

1. Unzip the file to a folder that you can access easily, like your desktop.

1. Open Visual Studio Code.

## Prepare your local environment

::: zone pivot="cli"

[!INCLUDE [Open VS Code terminal (CLI)](../../includes/azure-template-exercise-terminal-cli.md)]

[!INCLUDE [Upgrade Azure CLI](../../includes/azure-template-bicep-exercise-upgrade-cli.md)]

[!INCLUDE [Install Bicep (CLI)](../../includes/azure-template-bicep-exercise-install-bicep-cli.md)]

::: zone-end

::: zone pivot="powershell"

[!INCLUDE [Open VS Code terminal (PowerShell)](../../includes/azure-template-exercise-terminal-powershell.md)]

[!INCLUDE [Upgrade Azure PowerShell](../../includes/azure-template-bicep-exercise-upgrade-powershell.md)]

[!INCLUDE [Install Bicep (PowerShell)](../../includes/azure-template-bicep-exercise-install-bicep-powershell.md)]

::: zone-end

## Decompile the JSON template to Bicep

::: zone pivot="cli"

1. Run the following command to create a Bicep file from the template:

   ```azurecli
   az bicep decompile --file template.json
   ```

1. Notice that the decompile operation shows warnings similar to the following:

   :::code language="output" source="code/3-decompile-output.txt" :::

::: zone-end

::: zone pivot="powershell"

1. Run the following command to create a Bicep file from the template:

   ```powershell
   bicep decompile template.json
   ```

1. Notice that the decompile operation shows warnings similar to the following:

   :::code language="output" source="code/3-decompile-output.txt" :::

::: zone-end

## Inspect the decompiled Bicep file

Open the *template.bicep* file and look over it. Notice that it's a valid Bicep file, but it has a few issues, including:

- The symbolic names given to parameters and resources include underscores and aren't easy to understand.
- The `location` property is hard-coded in all of the resource definitions.
- The template includes hard-coded values that either should be parameters or should be set automatically by Azure.

You'll fix these problems throughout the rest of this module.

## Create a new Bicep file

1. Create a new file called *main.bicep*.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling. 
 
   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS).

1. Split the editor so that you can see both files at the same time.

   You can drag the tab titled **main.bicep** to the right side of the window to split. Alternatively, select **View** > **Editor Layout** > **Split Right**. In the left pane, select the **template.bicep** tab.

   :::image type="content" source="../media/3-visual-studio-code-split-editor.png" alt-text="Screenshot of the split Visual Studio Code editor, showing the template.bicep file in the left pane and the main.bicep file in the right pane." border="true":::

## Copy each element into your new Bicep file

1. Copy the resource named `networkSecurityGroups_ToyTruckServer_nsg_name_resource` from the *template.bicep* file to the *main.bicep* file.

   As you copy it, note that the `securityRules` property is empty. Later in this module, you'll refactor the file to remove redundant properties.

1. Notice that Visual Studio Code indicates an error because the `networkSecurityGroups_ToyTruckServer_nsg_name` parameter is missing:

   :::image type="content" source="../media/3-visual-studio-code-missing-parameter.png" alt-text="Screenshot of the Visual Studio Code editor showing the migrated resource, with a tooltip displaying an error because of the missing parameter." border="true":::

   Copy the parameter to the *main.bicep* file.

1. Repeat the process with the following resources and their associated parameters:

   - `publicIPAddresses_ToyTruckServer_ip_name_resource`
   - `virtualNetworks_ToyTruck_vnet_name_resource`
   - `virtualMachines_ToyTruckServer_name_resource`
   - `virtualNetworks_ToyTruck_vnet_name_default`
   - `networkInterfaces_toytruckserver890_name_resource`

   > [!NOTE]
   > The names of the resources in your deployment might be different to the ones above. Find the resources that have names that are close to the names listed here.

   As you copy each resource, inspect its properties. Later in this module, you'll update each resource's properties and configuration to conform to Bicep best practices.

   > [!TIP]
   > When you convert or export your own templates, you could update the resources to follow best practices as you copy them across. In this module, we will do this separately to make it easier to understand each phase of the migration process.

## Check for missing resources

1. In the Azure portal, open the **ToyTruck** resource group.

1. Review the list of resources, and compare it against the list of resources in your Bicep file. Notice that the resource group contains a **Disk** resource that isn't defined in your Bicep file:

   :::image type="content" source="../media/3-resource-group-missing-disk.png" alt-text="Screenshot of the Azure portal showing the resource group, with the disk resource highlighted." border="true":::

   When you work with virtual machines in Bicep, you don't need to explicitly define the managed disk resource. Instead, you define properties of the virtual machine, and Azure creates the managed disk for you automatically. This means that, in this case, you don't need to worry about the missing resource.

## Verify your template

1. At the end of the _migrate_ phase, your *main.bicep* file should look similar to the following:

   :::code language="bicep" source="code/3-main-migrated.bicep" :::

   > [!NOTE]
   > A few things might be different in your template, including some of the symbolic names and the IP addresses. That's OK. Some of this will be resolved later in the module.

1. Close the *template.bicep* file.

1. Select **View** > **Problems** to show the problems pane.

   No problems are indicated.

   :::image type="content" source="../media/3-visual-studio-code-problems.png" alt-text="Screenshot of the Visual Studio Code editor showing the problems pane, with no problems listed." border="true":::

You've now created an initial Bicep file to represent your resources. The Bicep file isn't well-structured and it doesn't follow best practices. In the next unit, you'll learn how to improve the quality of the migrated template.

> [!TIP]
> If you use a version control system like Git, this would be a good time to commit your work.