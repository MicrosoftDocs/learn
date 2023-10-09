Your company is a clothing manufacturer, so it needs applications and databases to handle its products. The company also needs compute resources to run its workloads. Your company wants you to provision compute on Azure and put in place automated scaling for your compute resources.

Creating and managing compute resources manually requires much administration time and becomes a repetitive task. When administrators have to do the same task regularly, mistakes can happen. You want to identify a way to automate the provisioning and management of compute resources. You need to research some of the tools that you can use to provision compute on Azure.

## Why automate compute provisioning?

It takes a long time to implement an architecture with many servers manually. You need to configure the operating system, install software, configure that software, and apply updates. You also need to do these tasks for each virtual machine. The tasks can become complex. When you have to carry out complex tasks many times, it's easy to make mistakes.

You might also need to redeploy your architecture, for example, to recover from an attack or disaster. Your architecture might need to support software testing, so you need to be able to redeploy it for every testing cycle. If your manual deployment takes several hours, it isn't ideal.

You need some way to automate the deployment of virtual machines to deal with these issues and difficulties. For each virtual machine, such a solution must be able to:

- **Configure the virtual machine.** For example, in Azure you need to specify an image from Azure Marketplace, a tier, a size, IP addresses, and other values.
- **Configure the operating system for the virtual machine.** For example, if the operating system includes a firewall, you must be able to set firewall rules that filter traffic.
- **Install software.** For example, you might need to install a web server or a database server.
- **Apply updates.** For example, you might need to apply service packs or hotfixes to the operating system and the installed software.

To reduce the complexity of a deployment configuration, create a complete architecture in the form of a script or a configuration file. Then deploy it in a single operation. This way, you can automate your configuration to reduce mistakes and accelerate deployment, helping your organization become more productive and cost effective.

## Custom scripts

The custom script extension downloads and runs scripts on Azure virtual machines. This tool is useful for post-deployment configuration, software installation, or any other configuration or management task.

You can have a PowerShell script that's on your local file server, GitHub, Azure Storage, or other locations that are accessible to your virtual machine. The extension looks for the script that should be run on the virtual machine. The script is downloaded and then executed on the target virtual machine to apply the changes introduced by the script. You add a custom script extension to a virtual machine through Azure Resource Manager templates, PowerShell, or the Azure CLI.

> [!NOTE]
> Take care if your configuration or management task requires a restart. A custom script extension won't continue after a restart.

The following custom script extension configuration can be added to an Azure Resource Manager template for a virtual machine. Use the `fileUris` property to point to your script file.

```json
{
    "apiVersion": "2019-06-01",
    "type": "Microsoft.Compute/virtualMachines/extensions",
    "name": "[concat(variables('virtual machineName'),'/', 'InstallWebServer')]",
    "location": "[parameters('location')]",
    "dependsOn": [
        "[concat('Microsoft.Compute/virtualMachines/',variables('virtual machineName'))]"
    ],
    "properties": {
        "publisher": "Microsoft.Compute",
        "type": "CustomScriptExtension",
        "typeHandlerVersion": "1.7",
        "autoUpgradeMinorVersion":true,
        "settings": {
            "fileUris": [
                "https://your-potential-file-location.com/your-script-file.ps1"
            ],
            "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File your-script-file.ps1"
       		 }
    	}
	}
}
```

## Desired State Configuration extensions

Desired State Configuration (DSC) extensions make it possible for you to deal with the configurations on your infrastructure that might need more complex installation procedures, such as reboots. DSC helps you define a state for your machines instead of writing detailed manual instructions on how to achieve that state for each machine. State configurations are relatively easy to read and implement.

By using a DSC extension handler, which you can define for a virtual machine, you can enforce your states. The configurations for your states can be located in various places, such as Azure Blob storage or your internal file storage. The DSC extension handler grabs the configuration and implements the state on the target virtual machine. If reboots are necessary for a configuration, DSC continues to execute the state configuration after the reboots are completed.

The following example defines a DSC extension handler for a virtual machine in an Azure Resource Manager template. The `script` property points to a configuration script in blob storage.

```json
{
	"type": "Microsoft.Compute/virtualMachines/extensions",
	"name": "Microsoft.Powershell.DSC",
	"apiVersion": "2018-06-30",
	"location": "your-region",
	"dependsOn": [
		"[concat('Microsoft.Compute/virtualMachines/', parameters('virtual machineName'))]"
	],
	"properties": {
		"publisher": "Microsoft.Powershell",
		"type": "DSC",
		"typeHandlerVersion": "2.77",
		"autoUpgradeMinorVersion": true,
		"settings": {
			"configuration": {
				"url": "https://demo.blob.core.windows.net/iisinstall.zip",
				"script": "IisInstall.ps1",
				"function": "IISInstall"
			}
		},
		"protectedSettings": {
			"configurationUrlSasToken": "odLPL/U1p9lvcnp..."
		}
	}
}
```

## Chef

A Chef server can handle 10,000 nodes (machines) at a time. Chef makes it possible for you to automate the deployment of your infrastructure and fit it into your workflow, whether on-premises or in the cloud.

A Chef server is typically hosted for you and runs as a service. Chef works by using the Chef server to manage your recipes. Recipes are commands to run to achieve a configuration. Use Chef's knife tool to deploy virtual machines and simultaneously apply recipes to them. You install the knife tool on your admin workstation, which is the machine where you create policies and execute commands. Then run your knife commands from your admin workstation.

The following example shows how a knife command can be used to create a virtual machine on Azure. The command simultaneously applies a recipe that installs a web server on the machine.

```cmd
knife azurerm server create `
    --azure-resource-group-name rg-chefdeployment `
    --azure-storage-account store `
    --azure-vm-name chefvm `
    --azure-vm-size 'Standard_DS2_v2' `
    --azure-service-location 'eastus' `
    --azure-image-reference-offer 'WindowsServer' `
    --azure-image-reference-publisher 'MicrosoftWindowsServer' `
    --azure-image-reference-sku '2016-Datacenter' `
    --azure-image-reference-version 'latest' `
    -x myuser `
    -P yourPassword `
    --tcp-endpoints '80,3389' `
    --chef-daemon-interval 1 `
    -r "recipe[webserver]"
```

You can also use the Chef extension to apply recipes to the target machines.
The following example defines a Chef extension for a virtual machine in an Azure Resource Manager template. It points to a Chef server by using the `chef_server_url` property. It points to a recipe to run on the virtual machine to put it in the desired state.

```json
{
  "type": "Microsoft.Compute/virtualMachines/extensions",
  "name": "[concat(variables('virtual machineName'),'/', variables('virtual machineExtensionName'))]",
  "apiVersion": "2015-05-01-preview",
  "location": "[parameters('location')]",
  "dependsOn": [
    "[concat('Microsoft.Compute/virtualMachines/', variables('virtual machineName'))]"
  ],
  "properties": {
    "publisher": "Chef.Bootstrap.WindowsAzure",
    "type": "LinuxChefClient",
    "typeHandlerVersion": "1210.12",
    "settings": {
      "bootstrap_options": {
        "chef_node_name": "chef_node_name",
        "chef_server_url": "chef_server_url",
        "validation_client_name": "validation_client_name"
      },
      "runlist": "recipe[your-recipe]",
      "validation_key_format": "validation_key_format",
      "chef_service_interval": "chef_service_interval",
      "bootstrap_version": "bootstrap_version",
      "bootstrap_channel": "bootstrap_channel",
      "daemon": "service"
    },
    "protectedSettings": {
      "validation_key": "validation_key",
      "secret": "secret"
    }
  }
}
```

A recipe might look like the one that follows. The recipe installs an IIS web server.

```powershell
#install IIS on the node.
powershell_script 'Install IIS' do
     action :run
     code 'add-windowsfeature Web-Server'
end

service 'w3svc' do
     action [ :enable, :start ]
end
```

## Terraform

Terraform is an open-source infrastructure-as-code software tool. You can create infrastructures by using a language created by Hashicorp, called Hashicorp Configuration Language (HCL). You can also use JSON. Terraform lets you create relatively easy-to-read script templates that define what type of resources to create, regardless of the cloud service provider. You can build your environments by using different cloud service providers, such as Microsoft Azure and Amazon Web Services (AWS). This way you can ensure that your environments are identical across cloud providers. The process requires you to install Terraform, either locally or on Azure. You can then use Terraform to execute a Terraform script.

The following Terraform script example provisions a virtual machine on Azure:

```hcl
# Configure the Microsoft Azure as a provider
provider "azurerm" {
    subscription_id = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
    client_id       = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
    client_secret   = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
    tenant_id       = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}

# Create a resource group
resource "azurerm_resource_group" "myterraformgroup" {
    name     = "myResourceGroup"
    location = "eastus"

    tags = {
        environment = "Terraform Demo"
    }
}
# Create the virtual machine
resource "azurerm_virtual_machine" "myterraformvirtual machine" {
    name                  = "myvirtual machine"
    location              = "eastus"
    resource_group_name   = "${azurerm_resource_group.myterraformgroup.name}"
    network_interface_ids = ["${azurerm_network_interface.myterraformnic.id}"]
    virtual machine_size               = "Standard_DS1_v2"

    storage_os_disk {
        name              = "myOsDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "myvirtual machine"
        admin_username = "azureuser"
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path     = "/home/azureuser/.ssh/authorized_keys"
            key_data = "ssh-rsa AAAAB3Nz{snip}hwhaa6h"
        }
    }

    boot_diagnostics {
        enabled     = "true"
        storage_uri = "${azurerm_storage_account.mystorageaccount.primary_blob_endpoint}"
    }

    tags = {
        environment = "Terraform Demo"
    }
}
```

To use this script, run the following command by using Terraform:

```cmd
terraform apply
```

## Azure Automation state configuration

Azure Automation state configuration is the service you use to make sure that your DSC configurations are managed properly and deployed across your nodes (virtual machines). Azure Automation state configuration works with both Azure virtual machines and machines on-premises. It also works with machines on other cloud providers. Through an intuitive Azure portal process, you can apply configurations to all of your nodes.

![Screenshot of the State configuration panel in the Azure portal.](../media/2-automation-state-config.png)

Azure Automation state configuration makes it possible for you to ensure that all target machines are assigned the correct configurations automatically. It also ensures that each machine reports back on what its current state is and shows whether it has achieved the desired state. You can send this information for reporting and for further decision making. You can interact with Azure Automation state configuration through the Azure portal or through Azure PowerShell.

## Azure Resource Manager templates

Azure Resource Manager templates are JSON files that you can use to define the Azure resources you want to provision in Azure through object notation. You can define an entire infrastructure this way. They're relatively easy to read and work with, based on your exposure to JSON.

With Azure Resource Manager templates, you can make sure that your deployments are consistent. You can ensure, for example, that all virtual machines you create have the same properties. You can also embed extensions into virtual machines in a template to make sure that their configuration is the same. You deploy any Azure Resource Manager template through Azure PowerShell, the Azure CLI, or the Azure portal. Test Azure Resource Manager templates before they're deployed. When you test your deployment, you ensure that your template is something Azure can deploy before you attempt a real deployment.

The following example shows how a virtual machine is defined in an Azure Resource Manager template. You can see the virtual machine type, the operating system, and its storage details among other things.

```json
{
  "type": "Microsoft.Compute/virtualMachines",
  "apiVersion": "2018-10-01",
  "name": "[variables('virtual machineName')]",
  "location": "[parameters('location')]",
  "dependsOn": [
    "[resourceId('Microsoft.Storage/storageAccounts/', variables('storageAccountName'))]",
    "[resourceId('Microsoft.Network/networkInterfaces/', variables('nicName'))]"
  ],
  "properties": {
    "hardwareProfile": {
      "virtual machinesize": "Standard_A2"
    },
    "osProfile": {
      "computerName": "[variables('virtual machineName')]",
      "adminUsername": "[parameters('adminUsername')]",
      "adminPassword": "[parameters('adminPassword')]"
    },
    "storageProfile": {
      "imageReference": {
        "publisher": "MicrosoftWindowsServer",
        "offer": "WindowsServer",
        "sku": "[parameters('windowsOSVersion')]",
        "version": "latest"
      },
      "osDisk": {
        "createOption": "FromImage"
      },
      "dataDisks": [
        {
          "diskSizeGB": 1023,
          "lun": 0,
          "createOption": "Empty"
        }
      ]
    },
    "networkProfile": {
      "networkInterfaces": [
        {
          "id": "[resourceId('Microsoft.Network/networkInterfaces',variables('nicName'))]"
        }
      ]
    },
    "diagnosticsProfile": {
      "bootDiagnostics": {
        "enabled": true,
        "storageUri": "[reference(resourceId('Microsoft.Storage/storageAccounts/', variables('storageAccountName'))).primaryEndpoints.blob]"
      }
    }
  }
}
```
