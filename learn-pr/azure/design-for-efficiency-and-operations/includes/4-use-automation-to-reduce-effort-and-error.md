Managing the infrastructure supporting a workload involves many configuration tasks. This statement is true for both on-premises workloads and workloads running in Azure. One of the strategies to reduce the amount of these tasks is to go for PaaS or even SaaS based solutions. With an IaaS based solution it's your responsibility to deploy, operate, and maintain the network, virtual machines, storage, and other related resources. In a PaaS deployment, many of those tasks are handled by Microsoft for you. However even with PaaS you might need to do deployment or configuration tasks to support your workload. Luckily Azure offers various components and services that can help you automate these configuration or maintenance tasks.

## Azure Resource Manager templates

When deploying a workload, there are various ways to do so: PowerShell, CLI, Azure portal, Resource Manager templates,... The Azure portal is easy to deploy resources but leaves many choices open to the person interacting with the portal. How do you make sure standards are followed? How do you make sure a second deployment is identical to the first one? [Azure Policy](https://docs.microsoft.com/en-us/azure/azure-policy/azure-policy-introduction) might enforce some of the governance decisions that were made by your organization. But Azure policy is more there to audit and enforce than correct. By automating your deployments, you can make sure they are correct right from the beginning.

Various options are available when automating tasks against Azure. Either a scripting approach using PowerShell or CLI, or an approach using Azure Resource Manager templates. Scripting and templates are two different approaches. Using PowerShell/CLI scripting is also called an imperative way of working. That means that every step along the process is explicitly described and covered in the script. Scripts are typically complex due to error handling or logic for scenario's where some of the resources already exist.

Resource Manager templates are one of the benefits of the Azure Resource Manager management layer that is consistently used across all Azure services. The [Resource Manager management layer](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-overview) is organized around resources, resource groups, and resource providers. Resource Manager templates are built around that layer and allow you to do a declarative deployment of your resources. A declarative deployment allows you to describe how the end situation should look like. You no longer have to explain how the steps look to get there. The complexity of the steps is handled by the Azure Resource Manager for you.

Below is an example Resource Manager template that will deploy a virtual machine. The file is structure in three blocks: parameters, variables, and resources. The resources section holds the definition of the resources to be deployed. The template will assume you want to leave the resources in place when they already exist. Resources that don't exist will be created. This behavior is the default operations mode for templates and is called incremental mode.

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "adminUsername": { "type": "string" },
    "adminPassword": { "type": "securestring" }
  },
  "variables": {
    "vnetID": "[resourceId('Microsoft.Network/virtualNetworks','myVNet')]", 
    "subnetRef": "[concat(variables('vnetID'),'/subnets/mySubnet')]" 
  },
  "resources": [
    {
      "apiVersion": "2016-03-30",
      "type": "Microsoft.Network/publicIPAddresses",
      "name": "myPublicIPAddress",
      "location": "[resourceGroup().location]",
      "properties": {
        "publicIPAllocationMethod": "Dynamic",
        "dnsSettings": {
          "domainNameLabel": "myresourcegroupdns1"
        }
      }
    },
    {
      "apiVersion": "2016-03-30",
      "type": "Microsoft.Network/virtualNetworks",
      "name": "myVNet",
      "location": "[resourceGroup().location]",
      "properties": {
        "addressSpace": { "addressPrefixes": [ "10.0.0.0/16" ] },
        "subnets": [
          {
            "name": "mySubnet",
            "properties": { "addressPrefix": "10.0.0.0/24" }
          }
        ]
      }
    },
    {
      "apiVersion": "2016-03-30",
      "type": "Microsoft.Network/networkInterfaces",
      "name": "myNic",
      "location": "[resourceGroup().location]",
      "dependsOn": [
        "[resourceId('Microsoft.Network/publicIPAddresses/', 'myPublicIPAddress')]",
        "[resourceId('Microsoft.Network/virtualNetworks/', 'myVNet')]"
      ],
      "properties": {
        "ipConfigurations": [
          {
            "name": "ipconfig1",
            "properties": {
              "privateIPAllocationMethod": "Dynamic",
              "publicIPAddress": { "id": "[resourceId('Microsoft.Network/publicIPAddresses','myPublicIPAddress')]" },
              "subnet": { "id": "[variables('subnetRef')]" }
            }
          }
        ]
      }
    },
    {
      "apiVersion": "2016-04-30-preview",
      "type": "Microsoft.Compute/virtualMachines",
      "name": "myVM",
      "location": "[resourceGroup().location]",
      "dependsOn": [
        "[resourceId('Microsoft.Network/networkInterfaces/', 'myNic')]"
      ],
      "properties": {
        "hardwareProfile": { "vmSize": "Standard_DS1" },
        "osProfile": {
          "computerName": "myVM",
          "adminUsername": "[parameters('adminUsername')]",
          "adminPassword": "[parameters('adminPassword')]"
        },
        "storageProfile": {
          "imageReference": {
            "publisher": "MicrosoftWindowsServer",
            "offer": "WindowsServer",
            "sku": "2012-R2-Datacenter",
            "version": "latest"
          },
          "osDisk": {
            "name": "myManagedOSDisk",
            "caching": "ReadWrite",
            "createOption": "FromImage"
          }
        },
        "networkProfile": {
          "networkInterfaces": [
            {
              "id": "[resourceId('Microsoft.Network/networkInterfaces','myNic')]"
            }
          ]
        }
      }
    }
  ]
}
```

```[to be removed]: or use this one instead of the above as its a lighter json example:```

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "storageAccountType": {
      "type": "string",
      "defaultValue": "Standard_LRS",
      "allowedValues": [
        "Standard_LRS",
        "Standard_GRS",
        "Standard_ZRS",
        "Premium_LRS"
      ],
      "metadata": {
        "description": "Storage Account type"
      }
    },
    "location": {
      "type": "string",
      "defaultValue": "[resourceGroup().location]",
      "metadata": {
        "description": "Location for all resources."
      }
    }
  },
  "variables": {
    "storageAccountName": "[concat(uniquestring(resourceGroup().id), 'standardsa')]"
  },
  "resources": [
    {
      "type": "Microsoft.Storage/storageAccounts",
      "name": "[variables('storageAccountName')]",
      "apiVersion": "2018-02-01",
      "location": "[parameters('location')]",
      "sku": {
        "name": "[parameters('storageAccountType')]"
      },
      "kind": "Storage",
      "properties": {}
    }
  ],
  "outputs": {
    "storageAccountName": {
      "type": "string",
      "value": "[variables('storageAccountName')]"
    }
  }
}
```

Resource Manager templates are great to automate deployments while keeping every deployment consistent. Combining these templates with definition files for the different configuration allows you to manage your Infrastructure as Code (IaC). Describing your infrastructure in templates and definition files has several advantages. The deployment speed can be improved and the likelihood for errors or violations against security and/or governance rules is reduced.

Resource Manager templates can create and configure the VM on the Azure platform but that doesn't mean the job is done. In the next section, we'll cover some strategies for configuring what goes on inside the virtual machines.

## Images or post-deployment configuration

Azure allows you to work with a variety of images, for both Windows and Linux operating systems, right from the Azure portal. These images are convenient and also ensure each new virtual machine starts with the latest updates already installed. However, for most deployments the job isn't done when the machine is running. Additional disks might need formatting, the machine might need to be joined to a domain, maybe an agent for a management software needs to be installed, and most likely the actual workload requires installation and configuration as well.

There are two common strategies applied for the configuration work considered to be part of as a baseline applied to "all" virtual machines:

* Custom images
* Post-deployment scripting

Both of them have their advantages and their disadvantages. Eventually what you chose might come down to personal preference. Custom images are generated by deploying a virtual machine and then configure or install software on that running instance. When everything is configured correctly, the machine can be shut down and an image is converted. This image can then be used as a base for other new virtual machines. Working with custom images might speed up the overall time of your deployment as once the virtual machine is deployed and running it should be ready. So if deployment speed is an important factor, custom images are definitely worth exploring.

If you prefer the flexibility of a script, that is executed after the virtual machine is deployed, you can use the Azure VM script extension to kick of these scripts automatically. The script extension can be integrated with a Resource Manager template as well, which allows for a fully automated approach. Scripts are flexible as it's more convenient to add in changes as opposed to an image, which involves more steps to update.

Running scripts across several servers does bring some complexity though, as there might be subtile changes requiring your script to break or stall in those different situations. So rather than trying to create super flexible / fault tolerant scripts it might be easier to use Desired State Configuration (DSC). Just like Resource Manager templates, DSC is a way to describe how something should be configured as opposed to describing all the steps required to configure it. On Windows virtual machines, DSC is available as part of the PowerShell platform and can be used through the Azure Desired State Configuration VM extension.

One of the advantages of DSC is that it has an extensible model where you can pull in DSC resources to be used in your DSC scripts from the community. Using these resources you can heavily reduce the time required to write the logic to configure your system. Here are some common examples of resources that can be configured through DSC: Active Directory, Microsoft SQL, Fail over clustering, IIS, ... For example, if you have the need to deploy SQL servers on a regular base, take a look at DSC. Using DSC will allow you to speed up the deployment time, avoid configuration errors and free up some of your time.

## Automating Azure tasks

Templates, images, and scripting are great if you want to improve the consistency of your deployments and lower the amount of time you're busy deploying solutions. But once your solutions are up and running there are still many things that might require you to make your hands dirty from time to time.

An example frequently seen is the need to shut down machines to save on Azure spend. Initially you might consider telling everyone to shut down their machines when they're not using them. Shutting down machines manually might work for a while but eventually people might start forgetting about it. Eventually you'll probably end up stopping the machines at a given time in the evening. But what if different machines have different needs? How do we keep track of those needs? What if the developers arrive in the morning and have to manually power on their machines every time and waste time waiting for them to boot? All of these challenges can be easily solved using Azure Automation. For this specific example: start/stop virtual machines during off-hours there's even an [out of the box solution](https://docs.microsoft.com/en-us/azure/automation/automation-solution-vm-management) in Azure Automation.

## Automating lab environments

Developers and testers are looking to solve the delays in creating and managing their environments by going to the cloud. Azure solves the problem of environment delays and allows self-service within a new cost efficient structure. However, developers and testers still need to spend considerable time configuring their self-served environments. Part of this challenge can be solved with Resource Manager templates as covered earlier in this article but the Resource Manager deployment model lacks certain controls. For example, Azure role-based access control does allow you to delegate access to a resource group so that people can create their own virtual machines. But what if you want each developer to have access to a limited number of (running) machines so that costs don't go out of control? What if you want to whitelist or offer certain images that can be used during VM creation. What if some of these machines need to have third-party browsers installed for testing purposes or maybe certain developer / debug tools? Maybe machines should only run during a specific window of the day.

These additional tasks can all be realized using capabilities we covered before, but [Azure Dev/Test Labs](https://docs.microsoft.com/en-us/azure/lab-services/devtest-lab-overview) allows you to configure these options in an easy to use experience. Some of the common tasks that fall somewhere between teams can be easily orchestrated using Azure DevTest Labs. DevTest Labs allows you to specify policies, for when machines should be running or powered off, how many virtual machines every developer can have, and several other items. Should a VM be auto-deleted after a certain date. Should a VM come readily installed with Chrome or Visual Studio? Maybe the VM should be joined to an Active Directory domain. This and many more examples are readily available in Azure DevTest Labs and ensure you can offer the flexibility of Azure while both facilitating the developers so that they can do their job but at the same time stay in control.

## Managed applications

Resource Manager templates are a great way to describe how a deployment should look like. Templates can easily be integrated into your CI/CD pipelines. In some cases, you want your templates to be made available to other teams within the company as part of a service catalog offering. The Azure portal allows you to expose your cloud solutions through the Azure Marketplace as [Azure managed applications](https://docs.microsoft.com/en-us/azure/managed-applications/overview). These managed applications are easy for the consumer to deploy. Through the managed application deployment model, an application owner still owns and manages the actual resources behind the solution while the consumer owns the managed application.
