Azure DevTest Labs uses various objects to configure each lab to your requirements. 

In the e-commerce scenario, you want to know how to use objects, such as artifacts and policies, to manage environments and govern their usage.

In this unit, you'll learn what these objects are and how they govern the behavior of your lab. Using these objects provides a flexible and secure environment for training, testing, and development.

## Objects in DevTest Labs

When you create test environments or development machines, you can use objects to ensure that users can do all necessary tasks. These objects also enable you to prevent unauthorized actions. The objects include:

- Environments
- Artifacts
- Formulas and custom images
- Policies
- VMs

:::image type="content" source="../media/3-devtest-labs-overview.png" alt-text="Diagram illustrating the relationship between logical DevTest Labs objects.":::

The following sections describe these objects in more detail.

## Environments

An environment refers to a collection of Azure resources in a lab. Azure DevTest Labs has a public repository of Azure Resource Manager templates (ARM templates) you can use to create environments. The environment repository gets you started quickly in a preconfigured environment that has few input parameters. For example, you can use PaaS resources such as Azure Service Fabric or the Web Apps feature of Azure App Service. This setup is similar to the artifacts repository available in the Azure portal for each lab.

When you create environments or templates, you can either store them in the environment repository to share with others, or you can set up your own Git repository.

## Artifacts

Use artifacts to deploy and configure an application after you set up a VM. DevTest Labs artifacts can either come from the public DevTest Labs artifact repository, or you can create your own artifacts and store them in a private GitHub repository.

An artifact consists of a JSON definition file and other script files, which are stored in a folder within a specified Git repository. These files contain expressions that you use to specify what's required on the VM. For example, you might define a command to run and parameters that are available when that command is run.

Suppose that, for the e-commerce developer who's onboarding labs, the Windows package manager *Chocolatey* is required on all development machines. You can set up an artifact to install the required package through a PowerShell script:

```JSON
{
  "$schema": "https://raw.githubusercontent.com/Azure/azure-devtestlab/master/schemas/2016-11-28/dtlArtifacts.json",
  "title": "",
  "description": "",
  "iconUri": "",
  "targetOsType": "",
  "parameters": {
    "installUsername": {
    "type": "string",
    "displayName": "User name",
    "description": "Installation user name"
    },
    "installPassword": {
    "type": "securestring",
    "displayName": "Password",
    "description": "Installation password"
    }
  },
  "runCommand": {
    "commandToExecute": "[concat('powershell.exe -ExecutionPolicy bypass \"& ./installChocolatey.ps1', ' -RawPackagesList ', parameters('packages'), ' -Username ',parameters('installUsername'), ' -Password ', (ConvertTo-SecureString ''', parameters('installPassword'), ''' -AsPlainText -Force), '\"')]"
  }
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

You can use both custom images and formulas as a basis for creating new VMs. A custom image is based on a virtual hard drive (VHD) file. A formula is a base image and a list of preconfigured settings, such as VM size and artifacts.

When you create a VM from a formula, the system uses these preconfigured settings as default values to accelerate the provisioning process. Optionally, you can override the default values.

## Policies

In Azure DevTest Labs, you use policies to manage costs and minimize waste in each lab environment. You can specify settings such as the number or size of VMs that each person is allowed to use. You can also set autoshutdown rules. Doing so is important because costs are incurred only when a VM is running.

Policies cover the following areas:

- Allowed VM sizes
- Maximum number of VMs per user
- Total number of VMs allowed
- Autoshutdown policy
