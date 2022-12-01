[!INCLUDE [BYO subscription explanation](../../../includes/azure-exercise-subscription-prerequisite.md)]

Your toy company has acquired a competitor that created a popular toy truck. The toys connect to a virtual machine hosted in Azure to receive firmware updates. All the resources for the virtual machine were created manually by using the Azure portal. In this unit, you'll begin the process of migrating the resources to a Bicep file.

During the process, you'll do the following tasks:

> [!div class="checklist"]
>
> - Deploy a new virtual machine by using the Azure portal.
> - Export the virtual machine resources to a JSON template.
> - Decompile the JSON template to Bicep.
> - Create a new Bicep file and migrate the resources from the decompiled template.

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

## Create a virtual machine by using the Azure portal

To simulate the situation in the example scenario, you'll first deploy a virtual machine by using the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure home page, under **Azure services**, select **Create a resource**.

   :::image type="content" source="../media/3-create-resource.png" alt-text="Screenshot of the Azure portal, with the Create a resource option highlighted.":::

   Azure Marketplace appears in the **Create a resource** pane.

1. Under **Ubuntu Server 20.04 LTS**, select **Create**.

   :::image type="content" source="../media/3-create-ubuntu.png" alt-text="Screenshot that shows Azure Marketplace, with the Create link highlighted under the words Ubuntu Server 20.04 LTS.":::

   > [!IMPORTANT]
   > If you don't see the **Ubuntu Server 20.04 LTS** item, go directly to [Ubuntu Server 20.04 LTS](https://portal.azure.com/#create/canonical.0001-com-ubuntu-server-focal20_04-lts-ARM) in Azure Marketplace.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value  |
    | ------ | ------- |
    | **Project Details**  |
    | Resource group | Select **Create new** and enter **ToyTruck**. |
    | **Instance Details** |
    | Virtual machine name  | ToyTruckServer |
    | Region | (US) West US 3 |
    | Availability options  | No infrastructure redundancy required |
    | Image | Ubuntu Server 20.04 LTS - Gen2 |
    | Size | Standard_D2s_v3 |
    | **Administrator account** |
    | Authentication type | Password |
    | Username | toytruckadmin |
    | Password | Enter a password |
    | **Inbound port rules** |
    | Public inbound ports | None |

1. On the **Management** tab, ensure that **Enable auto-shutdown** isn't selected.

1. Select **Review + Create**. Azure validates your settings. You might need to enter or select more information depending on the image requirements.

1. Select **Create** to deploy and create the VM.

   The Azure portal shows the deployment while it's in progress.

1. When the deployment is finished, select the resource group name to open the resource group.

   :::image type="content" source="../media/3-deployment-completed.png" alt-text="Screenshot of the Azure portal that shows the deployment, with the resource group name highlighted.":::

   The resource group now contains the virtual machine and its dependencies:

   :::image type="content" source="../media/3-resource-group.png" alt-text="Screenshot of the Azure portal that shows the resource group.":::

## Export the resource group contents to a JSON template

1. In the left menu, under **Automation** select **Export template**.

   :::image type="content" source="../media/3-export-template-menu.png" alt-text="Screenshot of the Azure portal that shows the Export template menu item in the resource group pane.":::

   A JSON template is generated. It might take a minute or two for the process to finish.

1. Select the **Download** button.

   :::image type="content" source="../media/3-export-template.png" alt-text="Screenshot of the Azure portal that shows the exported resource group JSON template, with the Download button highlighted.":::

   The JSON template and parameters file are downloaded to your computer as a _.zip_ file.

1. Unzip the file to a folder that you can access easily, like your desktop.

1. Open Visual Studio Code.

## Prepare your local environment

::: zone pivot="cli"

[!INCLUDE [Open VS Code terminal (CLI)](../../includes/azure-template-exercise-terminal-cli.md)]

[!INCLUDE [Install Bicep (CLI)](../../includes/azure-template-bicep-exercise-install-bicep-cli.md)]

::: zone-end

::: zone pivot="powershell"

[!INCLUDE [Open VS Code terminal (PowerShell)](../../includes/azure-template-exercise-terminal-powershell.md)]

[!INCLUDE [Install Bicep (PowerShell)](../../includes/azure-template-bicep-exercise-install-bicep-powershell.md)]

::: zone-end

## Decompile the JSON template to Bicep

::: zone pivot="cli"

Use the `decompile` command to create a Bicep file from the template.

```azurecli
az bicep decompile --file template.json
```

The decompile operation shows warnings similar to the following example:

:::code language="output" source="code/3-decompile-output.txt" :::

::: zone-end

::: zone pivot="powershell"

Use the `decompile` command to create a Bicep file from the template.

```powershell
bicep decompile template.json
```

The decompile operation shows warnings similar to the following example:

:::code language="output" source="code/3-decompile-output.txt" :::

::: zone-end

## Inspect the decompiled Bicep file

Open the _template.bicep_ file and read through it. Notice that it's a valid Bicep file, but it has a few issues, including:

- The symbolic names that are given to parameters and resources include underscores and aren't easy to understand.
- The `location` property is hard-coded in all the resource definitions.
- The template includes hard-coded values that should either be parameters or be set automatically by Azure.

You'll fix these problems throughout the rest of this module.

## Create a new Bicep file

1. Create a new file called _main.bicep_.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling.

   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS).

1. Split the editor so that you can see both files at the same time. The _template.bicep_ file in the left pane and the _main.bicep_ file in the right pane.

   1. Select the **main.bicep** tab.
   1. Select **View** > **Editor Layout** > **Split Right** to open the **main.bicep** tab in the right pane.
   1. Close the **main.bicep** tab in the left pane.

   :::image type="content" source="../media/3-visual-studio-code-split-editor.png" alt-text="Screenshot of the split Visual Studio Code editor that shows the template dot bicep file in the left pane and the main dot bicep file in the right pane.":::

## Copy each element into your new Bicep file

1. Copy the resource named `networkSecurityGroups_ToyTruckServer_nsg_name_resource` from the _template.bicep_ file to the _main.bicep_ file.

   As you copy it, note that the `securityRules` property is empty. Later in this module, you'll refactor the file to remove redundant properties.

1. Visual Studio Code indicates an error because the `networkSecurityGroups_ToyTruckServer_nsg_name` parameter is missing:

   :::image type="content" source="../media/3-visual-studio-code-missing-parameter.png" alt-text="Screenshot of the Visual Studio Code editor that shows the migrated resource, with a tooltip displaying an error because of the missing parameter.":::

   Copy the parameter to the _main.bicep_ file.

1. Repeat the process with the following resources and their associated parameters:

   - `publicIPAddresses_ToyTruckServer_ip_name_resource`
   - `virtualMachines_ToyTruckServer_name_resource`
   - `virtualNetworks_ToyTruck_vnet_name_resource`
   - `virtualNetworks_ToyTruck_vnet_name_default`
   - `networkInterfaces_toytruckserver890_name_resource`

   > [!NOTE]
   > The names of the resources in your deployment might be different from the resources listed here. Find the resources that have names that are close to these names.

   As you copy each resource, inspect its properties. Later in this module, you'll update each resource's properties and configuration to conform to Bicep best practices.

   > [!TIP]
   > When you convert or export your own templates, you can update the resources to follow best practices as you copy them cross. In this module, we do this separately to make it easier to understand each phase of the migration process.

## Check for missing resources

1. In the Azure portal, open the **ToyTruck** resource group.

1. Review the list of resources and compare it against the list of resources in your Bicep file. Notice that the resource group contains a **Disk** resource that isn't defined as a `resource` in your Bicep file.

   :::image type="content" source="../media/3-resource-group-missing-disk.png" alt-text="Screenshot of the Azure portal that shows the resource group, with the disk resource highlighted.":::

   When you work with virtual machines in Bicep, you don't need to explicitly define the managed disk resource. Instead, you define the properties of the virtual machine and Azure creates the managed disk for you automatically. In this example, you don't need to be concerned that the disk resource isn't defined in the Bicep file.

## Verify your template

At the end of the migrate phase, your _main.bicep_ file should look similar to this example:

   :::code language="bicep" source="code/3-main-migrated.bicep" :::

   > [!NOTE]
   > A few things might be different in your template, including some of the symbolic names, API versions, and the IP addresses. That's OK. Some of this will be resolved later in the module.

You've created an initial Bicep file to represent your resources. The Bicep file isn't well structured and it doesn't follow best practices. In the next unit, you'll learn how to improve the quality of the migrated template.

> [!TIP]
> If you use a version control system like Git, this would be a good time to commit your work.

After you've verified your _main.bicep_ file close the _template.bicep_ file.
