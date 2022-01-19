Azure DevTest Labs uses various objects to configure each lab to your requirements. 

In the e-commerce scenario, you want to know how to use objects, such as artifacts and policies, to manage environments and govern their usage.

In this unit, you'll learn what these objects are and how they govern the behavior of your lab. Using these objects provides a flexible and secure environment for training, testing, and development.

## Objects in DevTest Labs

When you create test environments or development machines, you can use objects to ensure that users can do necessary tasks. These objects also enable you to prevent unauthorized actions. The objects include:

- Environments
- Artifacts
- Formulas and custom images
- Policies
- VMs

:::image type="content" source="../media/3-devtest-labs-overview.png" alt-text="Diagram illustrating the relationship between logical DevTest Labs objects.":::

The following sections describe these objects in more detail.

## Environments

Azure DevTest Labs has a public repository of Azure Resource Manager templates (ARM templates) you can use to create environments. This setup is similar to the artifacts repository available in the Azure portal for each lab. The environment repository gets you started quickly in a preconfigured environment that has few input parameters. For example, you can use PaaS resources such as Azure Service Fabric or the Web Apps feature of Azure App Service.

When you create environments or templates, you can either store them in the environment repository to share with others, or you can set up your own Git repository.

## Artifacts

Use artifacts to deploy and configure an application after you set up a VM. An artifact consists of a JSON definition file and other script files, which are stored in a folder within a specified Git repository. These files contain expressions that you use to specify what's required on the VM. For example, you might define a command to run and parameters that are available when that command is run.

The following code shows an example JSON artifact:

```JSON
{
  "$schema": "https://raw.githubusercontent.com/Azure/azure-devtestlab/master/schemas/2016-11-28/dtlArtifacts.json",
  "title": "",
  "description": "",
  "iconUri": "",
  "targetOsType": "",
  "parameters": {
    "<parameterName>": {
      "type": "",
      "displayName": "",
      "description": ""
    }
  },
  "runCommand": {
    "commandToExecute": ""
  }
}
```

Suppose that, for the e-commerce developer who's onboarding labs, the Windows package manager *Chocolatey* is required on all development machines. You can set up an artifact to install the required package through a PowerShell script:

```JSON
runCommand": {
    "commandToExecute": "[concat('powershell.exe -ExecutionPolicy bypass \"& ./installChocolatey.ps1'
, ' -RawPackagesList ', parameters('packages')
, ' -Username ', parameters('installUsername')
, ' -Password ', parameters('installPassword'))]"
}
```

The following table details each section of the JSON artifact schema and how it's used:

| Element name | Required? | Description |
| ------------ | --------- | ----------- |
| $schema | No | The location of the JSON schema file. This value ensures validation checking of your custom artifact. |
| title | Yes | The name of the JSON file. |
| description | Yes | The description of the JSON file. |
| iconUri | No | The URI of the icon that's displayed in the lab. |
| targetOsType | Yes | The operating system of the VM: Windows or Linux. |
| parameters | No | The values that are provided when the artifact install command is run on a machine. |
| runCommand | Yes | The command that's run on the VM. |
| | |

## Formulas and custom images

You can use both custom images and formulas as a basis for creating new VMs. A custom image is based on a virtual hard drive (a VHD file). A formula is an image that's based on a virtual hard drive with preconfigured settings, such as VM size and artifacts. The system sets these preconfigured settings with default values, which you can override when you create the VM.

To manage formulas:

1. From the left pane of the **DevTest Labs** page, under **Settings**, select **Configuration and policies**.

1. From the left pane of the **Configuration and policies** page, under **Virtual machine bases**, select **Formulas (reusable bases)**.

   :::image type="content" source="../media/3-lab-settings-formulas.png" alt-text="Screenshot of the left pane with the Formulas command highlighted.":::

1. Select **Add**, and then select a base for your formula.

   :::image type="content" source="../media/3-base-list.png" alt-text="Screenshot of the Azure portal that shows options for DevTest virtual machine bases.":::

1. In the **Basic settings** tab of the **Create formula (reusable base)** window, configure the following settings:

   - A **Formula name** for your formula.
   - A **User name** and **Password** for the default user account.
   - A **Virtual machine size**.
   - The **Artifacts** to install.

1. Select **Create formula**.

## Policies

In Azure DevTest Labs, you use policies to manage costs and minimize waste in each lab environment. You can set things such as the number of VMs or the sizes that each person uses. You can also set autoshutdown rules. Doing so is important, because costs are incurred only when a VM is running.

Policies cover the following areas:

- Allowed VM sizes
- Maximum number of VMs per user
- Total number of VMs allowed
- Autoshutdown policy
