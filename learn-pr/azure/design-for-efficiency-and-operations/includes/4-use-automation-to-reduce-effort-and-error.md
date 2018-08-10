Managing the infrastructure of any type of workload involves configuration tasks. This configuration can be done manually, but manual steps can be labor-intensive, error prone and inefficient. What if you were assigned to lead a project that required the deployment of hundreds of systems on Azure? How would you build and configure these resources? How long would this take? Could you ensure that each system was configured properly, with no variance between them? By using automation in your architecture design, you can work past these challenges. Let's take a look at some of the ways you can automate on Azure.

## Infrastructure as code

When automating the deployment of services and infrastructure, there are two different approaches you can take: imperative and declarative. In an imperative approach, you explicitly state the commands that are executed to produce the outcome you are looking for. With a declarative approach, you specify what you want the outcome to be instead of specifying how you want it done. Both approaches are valuable, so there's no wrong choice. What do these different approaches look like on Azure and how do you use them?

### Imperative automation

Let's start with imperative automation. With this approach, we're specifying _how_ things are to be done. This is typically done programmatically through a scripting language or SDK. For Azure resources, we could use the Azure CLI or Azure PowerShell to do this. Let's take a look at an example that uses PowerShell to create a storage account.

```powershell
$resourceGroup = "storage-resource-group"
$location = "westus"
New-AzureRmResourceGroup -Name $resourceGroup -Location $location
New-AzureRmStorageAccount -ResourceGroupName $resourceGroup `
  -Name "mystorageaccount" `
  -Location $location `
  -SkuName Standard_LRS `
  -Kind StorageV2 
```

In this example we're specifying how to create these resources. Execute a command to create a resource group, execute another command to create a storage account. We're explicitly telling Azure what commands to run to produce the output we need.

With this approach, we're able to fully automate our infrastructure. We can provide areas for input, output, and can ensure that the same commands are executed every time. By automating our resources, we've taken the manual steps out of the process, making resource administration operationally more efficient. There are some downsides to this approach though. Scripts to create resources can quickly become complex as the architecture becomes more complex. Error handling and input validation may need to be added to ensure full execution. Commands may change, requiring ongoing maintenance of the scripts. 

### Declarative automation

With declarative automation, we're specifying _what_ we want our end result to be, leaving the details of how it's done to the system we're using. On Azure, this is done through the use of Resource Manager templates.

Resource Manager templates are JSON structured files that specify what we want created. In the example below we're telling Azure to create a storage account with the names and properties that we specify. The actual steps that are executed to create this storage account are left to Azure. Templates have four sections: parameters, variables, resources, and outputs. Parameters handle input to be used within the template. Variables provide a way to store values for use throughout the template. Resources are the things that are being created, and outputs are a way to provide details to the user of what was created.

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "name": {
            "type": "string"
        },
        "location": {
            "type": "string"
        },
        "accountType": {
            "type": "string"
        },
        "kind": {
            "type": "string"
        },
        "accessTier": {
            "type": "string"
        },
        "httpsTrafficOnlyEnabled": {
            "type": "bool"
        }
    },
    "variables": {
    },
    "resources": [
        {
            "apiVersion": "2018-02-01",
            "name": "[parameters('name')]",
            "location": "[parameters('location')]",
            "type": "Microsoft.Storage/storageAccounts",
            "sku": {
                "name": "[parameters('accountType')]"
            },
            "kind": "[parameters('kind')]",
            "properties": {
                "supportsHttpsTrafficOnly": "[parameters('httpsTrafficOnlyEnabled')]",
                "accessTier": "[parameters('accessTier')]",
                "encryption": {
                    "services": {
                        "blob": {
                            "enabled": true
                        },
                        "file": {
                            "enabled": true
                        }
                    },
                    "keySource": "Microsoft.Storage"
                }
            },
            "dependsOn": []
        }
    ],
    "outputs": {
        "storageAccountName": {
            "type": "string",
            "value": "[parameters('name')]"
        }
    }
}
```

Templates can be used to create and manipulate every service on Azure. They can be stored in code repositories and source controlled, and shared across environments to ensure that the infrastructure being developed against matches what's actually in production. They are a great way to automate deployments and help ensure consistency, eliminate deployment misconfigurations, and can increase operational speed.

Automating your infrastructure deployment is a great first step, but when deploying virtual machines there's still more work to do. Let's take a look at a couple of approaches to automating configuration post-deployment.

## VM customization: images vs post-deployment configuration

For many virtual machine deployments, the job isn't done when the machine is running. It's likely there's additional configuration that's needed before the VM can actually serve it's intended purpose. Additional disks might need formatting, the VM might need to be joined to a domain, maybe an agent for a management software needs to be installed, and most likely the actual workload requires installation and configuration as well.

There are two common strategies applied for the configuration work considered to be part the configuration of the VM itself, both of which have advantages and disadvantages:

* Custom images
* Post-deployment scripting

Custom images are generated by deploying a virtual machine and then configuring or installing software on that running instance. When everything is configured correctly, the machine can be shut down and an image is created from this VM. This image can then be used as a base for other new virtual machines. Working with custom images can speed up the overall time of your deployment as once the virtual machine is deployed and running, no additional configuration would be needed. If deployment speed is an important factor, custom images are definitely worth exploring.

Post-deployment scripting typically leverages a basic base image, then relies on scripting or a configuration management platform to do configuration after the VM is deployed. This could be done by executing a script on the VM through the Azure Script Extension, or by leveraging a more robust solution such as Azure Automation DSC.

Each approach has some considerations to keep in mind. When using images, you'll need to ensure there's a process to handle image updates, security patches, and inventory management of the images themselves. With post-deployment scripting, build times can be extended since the VM can't be added to live workloads until the build is complete. This may not be a significant issue for standalone systems, but when using services that autoscale (such as virtual machine scale sets) this extended build time can impact how quickly you can scale. With both approaches, you'll want to ensure you address configuration drift; as new configuration is rolled out you'll need to ensure that existing systems are updated accordingly.

That said, automating resource deployment can be a massive benefit to your environment. The amount of time saved and error reduced can move your operational capabilities to another level.

## Automating Azure tasks

Templates, images, and scripting are great if you want to improve the consistency of your deployments and lower the effort and error when deploying solutions. But once your solutions are up and running there are still ongoing operational activities you'll need to do. Automating these tasks can ease the strain on operations teams, and can even enable you to take automated actions on alerts.

Azure Automation plays this role on Azure. With Automation, you can fully automate those operational tasks that you used to perform manually. For things like performing security updates on VMs, creating an inventory of your resources and installed software, to shutting down virtual machines in off hours to save costs, Automation can provide a wide array of automation capabilities.

## Automating lab environments

Developers and testers are looking to solve the delays in creating and managing their environments by going to the cloud. Azure solves the problem of environment delays and allows self-service within a new cost efficient structure. However, developers and testers still need to spend considerable time configuring their self-served environments. You could certainly use Resource Manager templates to address this, but that deployment model lacks certain controls and may not have the ease of use to make developers productive. What if you want each developer to have access to a limited number of (running) machines so that costs don't go out of control? What if you want to whitelist or offer certain images that can be used during VM creation. What if some of these machines need to have third-party browsers installed for testing purposes or maybe certain developer or debug tools? Maybe machines should only run during a specific window of the day.

[Azure Dev/Test Labs](https://docs.microsoft.com/en-us/azure/lab-services/devtest-lab-overview) allows you to configure these options in an easy to use experience. Some of the common tasks that fall somewhere between teams can be easily orchestrated using Azure DevTest Labs. DevTest Labs allows you to specify policies for when machines should be running or powered off, how many virtual machines every developer can have, among a wide array of capabilities.

Ensuring developers have what they need, when they need it, and can be as productive as possible is the ultimate goal when it comes to lab environments. With an automated lab solution you can ensure developer productivity and satisfaction remains high, while limiting the operational requirements to make it happen.

## Automation at Lamna Healthcare

Let's take a look at how Lamna Healthcare is using automation in their environment. When they started their journey, infrastructure deployment and server builds were entirely manual. Engineers were deploying everything through the portal. This was introducing a lot of variance and error across their environment, and the differences between the test environments and production environments was hindering their ability to detect problems before code hit production.

They now deploy all their infrastructure through Resource Manager templates. These templates are checked into a GitHub repository, and a code review happens before they are released for deployment. They're also able to build the same infrastructure between dev, test, and production, ensuring they have validated their configuration across all environments. 

For most services using virtual machines, they have a standard base image, and use DSC to configure the systems post deployment. For web farms where they need the scalability of virtual machine scale sets, they have a fully automated process to check in code and build a new image with all required configuration built in before making it available in their scale sets.

They have an Automation job to shut down identified virtual machines in off hours to reduce costs, and have automated their VM patching as well. 

Developers now have a self-service environment in DevTest Labs where they can develop against the latest images and configuration, ensuring that what they develop against matches the configuration in production.

All of this took some up front effort, but the benefits have paid off in the long run. They've dramatically reduced error and the effort required by their operations teams to maintain their environments. Developers love that they can easily go provision resources to develop against, eliminating the back-and-forth to get environments created.

## Summary

We've take a look at a number of ways to bring automation capabilities into your architecture. From deploying infrastructure as code, to improving developer productivity with lab environments, there's a ton of benefit from taking time to automate your environment. Reducing error, reducing variance, and saving operational costs can be a significant benefit to your organization and help take your cloud environment to the next level.
