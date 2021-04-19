Azure DevTest Labs uses various objects to configure each lab to your requirements. 

In the e-commerce scenario, you want to know how to use objects such as artifacts and policies to manage environments and govern their usage. 

In this unit, you'll learn what these objects are and how they govern the behavior of your lab to provide a flexible and secure environment for training, testing, development, and other purposes.

## Objects in DevTest Labs

When you create test environments or development machines, you can use objects to ensure that users can perform necessary tasks. These objects also enable you to prevent unauthorized actions. The objects include:

- Environments
- Artifacts
- Formulas and images
- Policies
- Virtual machines

:::image type="content" source="../media/3-devtest-labs-overview.png" alt-text="Diagram illustrating the relationship between logical DevTest Labs objects.":::

Let's examine these objects in more detail.

## Environments

Azure DevTest Labs has a public repository of Azure Resource Manager templates (ARM templates) that you can use to create environments. This setup is similar to the artifacts repository that's available in the Azure portal for each lab. The environment repository gets you started quickly in a preconfigured environment that has few input parameters. For example, you could use PaaS resources such as Azure Service Fabric or the Web Apps feature of Azure App Service.

When you create environments or templates, you can store them in the environment repository to share with others, or you can set up your own Git repository.

## Artifacts

Use artifacts to deploy and configure an application after you set up a virtual machine. An artifact consists of a JavaScript Object Notation (JSON) definition file and other script files that are stored in a folder within a specified Git repository. These files contain expressions that can be used to specify what's required on the virtual machine. For example, you might define a command to run and parameters that are available when that command is run. 

This code is an example JSON artifact:

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

Suppose that, for the e-commerce developer who's onboarding labs, the Windows package manager *Chocolatey* is required on all development machines. You could set up an artifact to install the required package through a PowerShell script.

```JSON
runCommand": {
    "commandToExecute": "[concat('powershell.exe -ExecutionPolicy bypass \"& ./installChocolatey.ps1'
, ' -RawPackagesList ', parameters('packages')
, ' -Username ', parameters('installUsername')
, ' -Password ', parameters('installPassword'))]"
}
```
<br>

The following table details each section of the JSON artifact schema and how it's used:

| Element name | Required? | Description |
| ------------ | --------- | ----------- |
| $schema	| No | The location of the JSON schema file. This value ensures validation checking of your custom artifact. |
| title | Yes |	The name of the JSON file. |
| description | Yes | The description of the JSON file. |
| iconUri | No | The URI of the icon that's displayed in the lab. |
| targetOsType | Yes | The operating system of the virtual machine: Windows or Linux. |
| parameters | No | The values that are provided when the artifact install command is run on a machine. |
| runCommand | Yes | The command that's run on the virtual machine. |
| | |

## Formulas and custom images

You can use both custom images and formulas as a base for creating new virtual machines, although they're different. A custom image is based on a virtual hard drive (a VHD file). A formula is an image that's based on a virtual hard drive with preconfigured settings, such as virtual machine size, virtual network, subnet, and artifacts. These preconfigured settings are set up with default values that can be overridden when the virtual machine is created.

You manage formulas within the following Azure submenu:

:::image type="content" source="../media/3-lab-settings-formulas.png" alt-text="Screenshot of the left pane in the Azure portal with the Formulas command highlighted.":::

Start by selecting a base for your formula:

:::image type="content" source="../media/3-base-list.png" alt-text="Screenshot of the Azure portal illustrating options for DevTest virtual machine bases.":::

Then use **basic settings** to configure:

- A name for your formula.
- A username and password for the default user account.
- A virtual machine size.
- Artifacts to install.

## Policies

In Azure DevTest Labs, you use policies to manage costs and minimize waste in each lab environment. You can set things such as the number of virtual machines or the sizes that each person can use. You can also set auto-shutdown rules, because costs are incurred only when a virtual machine is running. 

Policies cover the following areas:

- Allowed virtual machine sizes
- The maximum number of virtual machines per user
- The total number of virtual machines allowed
- The auto-shutdown policy
