[Motivation] 
Describe a scenario from the healthcare organization where a manual step introduced error and how it impacted the business.  
 
[Knowledge Needed] 
Use template deployments to deploy infrastructure, make deployments reusable and repeatable 
[G4-1] graphic that depicts template deployments 
Include some example JSON 
Image management vs post-deployment configuration 
Use Azure Automation to handle manual activities (such as stopping/starting VMs off hours) and reduce operational burden 
Use DSC to automate software deployment and VM configuration 
Use DevTest Labs to provide automated lab environments to developers 
Use Azure Managed Applications (Service Catalog) to provide approved solutions to your internal teams 

https://docs.microsoft.com/en-us/azure/automation/automation-intro 

# Use automation to reduce effort and error

Managing the infrastructure supporting a workload does involve a lot of configuration tasks. This is true for on-premises workloads as well as workloads running in Azure. One of the strategies to reduce the amount of these tasks is to go for PaaS or even SaaS based solution. When going for an IaaS based solution it's your responsibility to deploy, operate and maintain the network, virtual machines, ... whereas in a PaaS deployment those tasks are handled by Microsoft for you. However even with PaaS you might need to do various deployment or configuration tasks to support your workload. Luckily Azure does offer various components and services that can help you automate these configuration or maintenance tasks.

## Azure Resource Manager Templates

When deploying a workload there are various approaches to do so: PowerShell, CLI, Azure Portal, ARM templates,... The Azure Portal is really approachable but leaves a lot of choices open to the person configuring the resources. How do you ensure following standards are used? How do you ensure that a second deployment is identical to the first one? E.g. to deploy a new testing environment next to an existing one? There are certain controls like Azure Policy that might enforce/guide you through some of the governance decisions that were made by your organization, but Azure policy is more there to audit and enforce than correct. By automating your deployments you can ensure that they are correct right from the beginning.

When automating there are various options available. Either a scripting approach using PowerShell or CLI or an approach leveraging Azure Resource Manager(ARM) templates. Both are very different. The approach using PowerShell/CLI is also called an imperative way of working. That means that every step along the process is explicitly described and covered in a script. There's potentially also a lot of error handling or logic for scenario's where some of the resources potentially already exist. ARM templates is one of the benefits of the Azure Resource Manager management layer that is consistently used across all Azure services. This [resource management layer](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-overview) is organized around resources, resource groups and resource providers. ARM templates are build around those and allow you to do a declarative deployment of your resources. The difference between imperative (scripting) and declarative (ARM templates) is that with the ARM templates you described how the end situation should look like without required to explain ("script") how the steps look to get there. The complexity of the steps is handled by the Azure Resource Manager for you.

Here's an example ARM template that will deploy a virtual machine. The file is structure in 3 blocks: parameters, variables and resources. The resources section contains the definition of the desired resources. If they already exist the template will assume you want to leave them in place. If they don't exist they will be created. This is the default operations mode for templates and is called incremental mode.

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

<to be removed: or a lighter jsone example:>

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

ARM templates are great to automate deployments to ensure every one of those is consistent. Combining these templates with definition files for the different configuration allows you to manage your Infrastructure as Code (IaC). Describing your infrastructure in templates and definition files can ensure you improve the deployment speed as well as reduce the chance for error or violations against security and/or governance rules.

When looking at the deployment of solutions that involve one or more virtual machines we often see that ARM templates cater for the configuration of the VM on the Azure platform but that doesn't mean the job is done. In the next section we'll cover some strategies for configuring what goes on inside the virtual machines.

## Images or post-deployment configuration?

Azure allows you to work with a variety of images for both Windows as Linux operating systems right from the Azure portal. This is really convenient and also ensure each new deployment starts with the latest updates already installed. For most deployments however the job isn't done when the machine is running. Additional disks might need formatting, the machine might need to be joined to a domain, maybe an agent for a management software needs to be installed and most likely the actually workload requires installation and configuration as well.

There are two common strategies applied for the configuration work that's considered as a baseline or that needs to be applied to "all" virtual machines:

* Custom images
* Post-deployment scripting

Both of them have their advantages as well as their disadvantages and eventually what you chose might come down to personal preference. Working with custom images might speed up the overall time of your deployment as once the virtual machine is deployed and running it should be good to go. So if deployment speed is an important factor customer images are definitely worth exploring.

If you prefer the flexibility of a script or set of scripts that are executing after the virtual machine is deployed you can leverage the Azure VM script extension to kick of these scripts automatically. The script extension can be integrated with ARM templates as well which allows for a fully automated approach. The reason scripts are being pointed out as flexible as it's more convenient to add in changes as opposed to an image that you have to modify, sysprep and recreate.

Running scripts across a variety of servers does bring some complexity though as there might be subtile changes requiring your script to break or stall in those different situations. So rather than trying to create super flexible / fault tolerant scripts it might be easier to leverage Desired State Configuration (DSC). Similar to ARM templates DSC is a way to describe how something should be configured as opposed to describing all the steps required to configure it. On Windows virtual machines DSC is available as part of the PowerShell platform and can be leveraged through the Azure Desired State Configuration VM extension.

The cool thing about DSC is that it has an extensible model where you can pull in DSC resources to be used in your DSC scripts from the community heavily reducing the time required to write the logic to configure your system. Here are some common example of resources that can be configured through DSC: Active Directory, Microsoft SQL, Failover Clustering, IIS, ... If you have the need to deploy SQL servers on a regular base than it's really recommended to look at DSC to speed up the deployment time, avoid configuration errors and free up some of your time.

## Azure Automation

All of the above are nice if you want to improve the consistency of your deployments and lower the amount of time you're busy deploying solutions. But once your solutions are up and running there are still a lot of things that might require you to make your hands dirty from time to time.

An example frequently encountered is the need to shutdown machines to save on Azure spend. Initially you might considering telling everyone to shut down their machines when they're not using them. That might work for a while but eventually people might start forgetting about it. Eventually you'll probably end up stopping the machines at a given time in the evening. But what if different machines have different needs? How do we keep track of those needs? What if your developers arrive in the morning and have to manually power on their machines every time and waste time waiting for them to boot? All of these challenges can be easily solved leveraging Azure Automation. For this specific example: start/stop virtual machines during off-hours there's even an [out of the box solution](https://docs.microsoft.com/en-us/azure/automation/automation-solution-vm-management) in Azure Automation.






DevTest labs for dev Infra

Azure Managed Applications