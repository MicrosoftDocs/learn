There are several solutions available to provision compute on Azure. VM extensions provide post-deployment configuration, automation, software installation, or any other configuration or management task. There are few tools available to help you systemize and automate VM deployment. 

In this unit, you'll explore some of the solutions that are available.

## Custom scripts

The Custom Script Extension downloads and runs scripts on Azure VMs. This is useful for post deployment configuration, software installation, or any other configuration or management tasks.

You can have a PowerShell script that is located anywhere, from your local file server to GitHub, Azure Storage, and so on.  The extension looks for the script that should be run on the VM. The script is downloaded and then executed on the target VM to apply the changes introduced by the script. A Custom Script Extension can be added to a VM through Azure Resource Manager Templates, PowerShell or Azure CLI.  Note that if your configuration or management task requires a restart, the extension will not continue after a restart.

Below is a Custom Script Extension configuration which can be added to an  Azure Resource Manager Template for a VM:

```JSON
{
    "apiVersion": "2019-06-01",
    "type": "Microsoft.Compute/virtualMachines/extensions",
    "name": "[concat(variables('vmName'),'/', 'InstallWebServer')]",
    "location": "[parameters('location')]",
    "dependsOn": [
        "[concat('Microsoft.Compute/virtualMachines/',variables('vmName'))]"
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

## DSC extensions

Desired State Configuration Extensions make it possible for you to easily deal with the configurations on your infrastructure that may require more complex installation procedures, for example reboots. The extension uploads and applies a PowerShell DSC Configuration on an Azure VM.

Through the use of a DSC extension handler which you can define for a VM, you can execute configurations.  These configurations for your machines can be located anywhere from Azure blob storage, to your local file storage.  The DSC extension handler then grabs the configuration and executes the configuration on the target VM.   If reboots are necessary for this configuration, DSC continues to executes the configuration after the reboots are completed.

Below is an example defining a DSC extension handler for a VM in an Azure Resource Manager template pointing to a configuration in blob storage:

```powershell
{
	"type": "Microsoft.Compute/virtualMachines/extensions",
	"name": "Microsoft.Powershell.DSC",
	"apiVersion": "2018-06-30",
	"location": "your-region",
	"dependsOn": [
		"[concat('Microsoft.Compute/virtualMachines/', parameters('VMName'))]"
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

Chef is high scale, and makes it possible for you to automate the deployment of your infrastructure and fit it into your workflow. Whether on-premises or in the cloud.

The Chef VM Extension enables Chef on VMs.  Chef works by  using a Chef server to manage your recipes, which are essentially commands to run to achieve a configuration.  The Chef Extension then can be used to apply those recipes to the target machine(s).

Below is an example defining a Chef Extension for a VM in an Azure Resource Manager template, which points to a chef server, and points to a recipe to run on the VM to put it in the desired state.  

```json
{
  "type": "Microsoft.Compute/virtualMachines/extensions",
  "name": "[concat(variables('vmName'),'/', variables('vmExtensionName'))]",
  "apiVersion": "2015-05-01-preview",
  "location": "[parameters('location')]",
  "dependsOn": [
    "[concat('Microsoft.Compute/virtualMachines/', variables('vmName'))]"
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

A recipe might look like this:

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

## **Terraform**

Terraform is an open source infrastructure as code software tool that is particularly useful for when you have infrastructures across different cloud providers. Terraform makes it possible for you to create infrastructures using Hashicorp Configuration Language (HCL). This is created by Hashicorp. Alternately you can also use JSON (JavaScript Object Notation).  Terraform makes it possible to create easy to read script templates that define what type of resources to create, regardless of the provider.  You can build environments on entirely different providers. This way you can ensure your environments are virtually identical across cloud providers.   You install Terraform, either locally or on Azure, and then use it to execute your Terraform script.

Below is an example of a Terraform script that can be used by Terraform to provision a VM  on Azure:

```HCL
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
# Create the VM
resource "azurerm_virtual_machine" "myterraformvm" {
    name                  = "myVM"
    location              = "eastus"
    resource_group_name   = "${azurerm_resource_group.myterraformgroup.name}"
    network_interface_ids = ["${azurerm_network_interface.myterraformnic.id}"]
    vm_size               = "Standard_DS1_v2"

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
        computer_name  = "myvm"
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

Terraform simply needs to you run a command like the one below to execute this script and create the VM.

```
terraform apply
```

## Azure automation state configuration

Azure Automation State Configuration is the service you would use to make sure your DSC configurations are managed properly and deployed across your nodes (machines). Azure Automation State Configuration works with both Azure based virtual machines and machines on-premises network, or other cloud providers. Through an intuitive Azure Portal process, you can apply configurations to all of your nodes.

Azure Automation State Configuration makes it possible for you to ensure that all target machines are assigned the correct configurations automatically, and on top of this also ensures that each machine reports back on what its current state is and show whether it has achieved the desired state. This information can then be sent for reporting and used for further decision making.  Azure Automation State Configuration can be interacted with through the Azure Portal or through Azure PowerShell.

## Azure resource manager templates

Azure Resource Manager templates are JSON files that allow you to define the Azure resources you want to provision in Azure through object notation. You can define an entire infrastructure this way.  They are fairly easy to read and work with.

 Azure Resource Manager templates allow you to make sure your deployments are consistent. Ensuring for example, that all VMs you create have the same properties. And as we have seen above, you can even embed extensions into VMs in a template to make sure they are configured exactly the same. You can deploy any Azure Resource Manager template through Azure PowerShell, Azure CLI, or Azure Portal.  Azure Resource Manager templates can be tested before they are deployed. This way you can ensure your template is something Azure can deploy before attempting an actual deployment.

Below is an example of how a virtual machine would be defined inside of an Azure Resource Manager template:

```json
{
  "type": "Microsoft.Compute/virtualMachines",
  "apiVersion": "2018-10-01",
  "name": "[variables('vmName')]",
  "location": "[parameters('location')]",
  "dependsOn": [
    "[resourceId('Microsoft.Storage/storageAccounts/', variables('storageAccountName'))]",
    "[resourceId('Microsoft.Network/networkInterfaces/', variables('nicName'))]"
  ],
  "properties": {
    "hardwareProfile": {
      "vmSize": "Standard_A2"
    },
    "osProfile": {
      "computerName": "[variables('vmName')]",
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
