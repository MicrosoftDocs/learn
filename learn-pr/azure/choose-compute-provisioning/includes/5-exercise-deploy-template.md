Your organization grows, and demand rises in Europe and Asia. Your organization is based in the USA. Most of your infrastructure is cloud-based. Your European users are reporting a slow website. To provide better service to the customers in Europe, your company has asked you to create a new and improved web server for Europe. The machine must be configured as an IIS web server when it's provisioned.

You have been asked to choose appropriate provisioning tools. Your tools should also be easy to use and easily customizable.

In this exercise, you'll provision a web server to meet the requirements.

### Provision a web server

You'll use a couple of tools together. Azure Resource Manager templates will enable you to create a template outlining the environment for your web server. Your Azure Resource Manager template can also help you define a state that you apply to your web server at the point of provisioning. You can apply your desired state by putting a DSC extension handler inside of your Azure Resource Manager template. The DSC handler helps you enforce a state that you define in a DSC configuration.

In the following exercise, you'll use an Azure Resource Manager template to provision a virtual machine. The DSC extension handler that will be included in the template will enforce your state on the virtual machine. You'll use an Azure storage account to host your DSC configuration file.

### Create your state configuration file

1. First, create your state configuration. You'll configure an IIS web server on your machine. Copy the following code to an empty file.

    ```powershell
        Configuration Webserver
        {
          param ($MachineName)

          Node $MachineName
          {
            #Install the IIS Role
            WindowsFeature IIS
            {
              Ensure = "Present"
              Name = "Web-Server"
            }

            #Install ASP.NET 4.5
            WindowsFeature ASP
            {
              Ensure = "Present"
              Name = "Web-Asp-Net45"
            }

             WindowsFeature WebServerManagementConsole
            {
                Name = "Web-Mgmt-Console"
                Ensure = "Present"
            }
          }
        }
    ```

1. Save the file as Webserver.ps1

1. Compress your Webserver.ps1 file into a *.zip* folder named Webserver in a folder of your choice, on your computer.

### Create a storage account

1. Sign into the [Azure portal](<https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true>).

1. Select **All Services**, search for *Storage Accounts*, then select **Storage Accounts** in the list of results.

   ![Search for Storage Accounts](../media/5-search-storage-account-portal.png)

1. Select **Add** at the top of the **Storage Accounts** pane.

1. The **Create storage account** form appears.

   ![Create Storage Account](../media/5-create-storage-account.png)

1. Give your storage account a name using the **Storage account name** field. For resource group, use <rgn>[sandbox resource group name]</rgn>. Leave the rest of the form fields at their default values.

1. Select **Review + create**.

1. Select **Create**.

### Upload your configuration file

1. Navigate to your storage account.  Select **Resource groups**, select your resource group, then select your storage account.

1. Select **Containers** under **Blob service** on the left hand side, then select **+ Container**.

1. Give your container a unique name.

1. From the Public access level dropdown, select **Container (anonymous read access for containers and blobs)**.

1. Select **OK**.

    ![Add a container](../media/5-create-container.png)

1. Select your container, select **Upload**, browse for your *Webserver.zip* file, then select **Upload** at the bottom of the form.

    ![Upload the zip file](../media/5-upload-file-to-storage-account.png)

1. Select the file, then copy the file's URL and paste it somewhere safe.

    ![Copy the URL](../media/5-copy-file-url.png)

### Create a template

1. To create the template you'll use the Azure Cloud Shell. Open your Azure Cloud Shell and use this command to open the Code editor. 

    ```bash
    code .
    ```
    
    ![Save template](../media/5-save-template-file.png)
    
1. Now you'll need to create an Azure Resource Manager template.  Below is a skeleton template, which you'll use as a baseline. Copy the code, and use <kbd>Ctrl</kbd>+<kbd>S</kbd> to save it.  When prompted, enter the filename *template.json*.

    ```json
    {
        "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
        "contentVersion": "1.0.0.0",
        "parameters": {  },
        "variables": {  },
        "resources": [  ]
    }
    ```

1. Now you'll need to flesh out the skeleton.  To start, you will need to update the parameters section. The parameters section defines which values should be provided every time your template is deployed. Replace the parameters section with the code below.  In this code fragment there are comments to help explain the purpose of some of the settings. Use <kbd>Ctrl</kbd>+<kbd>F</kbd> to search for "/*" and remove any comments, otherwise the template is not valid.

    When copying and pasting, be careful not to remove the comma (,) at the end of the line: "parameters": {  }**,** in your *template.json* skeleton.

    ```json
    "parameters": {  
                "diskType": {
                "type": "string",
                "defaultValue": "Standard_LRS",
                "allowedValues": [
                    "Standard_LRS",
                    "Premium_LRS"
                ],
                "metadata": {
                    "description": "Type of Storage for disks"
                }
            },
            "vmName": {
                "type": "string",
                "metadata": {
                    "description": "Name of the VM"
                }
            },
            "vmSize": {
                "type": "string",
                "defaultValue": "Standard_A2",
                "metadata": {
                    "description": "Size of the VM"
                }
            },
            "imageSKU": {
                "type": "string",
                "defaultValue": "2012-R2-Datacenter",
                "allowedValues": [
                    "2008-R2-SP1",
                    "2012-Datacenter",
                    "2012-R2-Datacenter"
                ],
                "metadata": {
                    "description": "Image SKU"
                }
            },
            "adminUsername": {
                "type": "string",
                "metadata": {
                    "description": "Admin username"
                }
            },
            "adminPassword": {
                "type": "securestring",
                "metadata": {
                    "description": "Admin password"
                }
            },
    /* Location of your DSC configuration */
            "modulesUrl": {
                "type": "string",
                "metadata": {
                    "description": "URL for the DSC configuration module."
                }
            },
    /* The function to run in your DSC configuration */
            "configurationFunction": {
                "type": "string",
                "defaultValue": "Webserver.ps1\\Webserver",
                "metadata": {
                    "description": "DSC configuration function to call"
                }
            },
            "location": {
                "type": "string",
                "defaultValue": "[resourceGroup().location]",
                "metadata": {
                    "description": "Location for all resources."
                }
            }
    }
    ```

1. The variables section allows you to define variables you can reuse in your template. Replace the variable section in your template with the code below.

    ```json
    "variables": {
        "virtualNetworkName": "dscVNET",
        "vnetID": "[resourceId('Microsoft.Network/virtualNetworks', variables('virtualNetworkName'))]",
        "vnetAddressPrefix": "10.0.0.0/16",
        "subnet1Name": "dscSubnet-1",
        "subnet1Prefix": "10.0.0.0/24",
        "subnet1Ref": "[concat(variables('vnetID'),'/subnets/', variables('subnet1Name'))]",
        "publicIPAddressType": "Dynamic",
        "publicIPAddressName": "dscPubIP",
        "nicName": "dscNIC",
        "imagePublisher": "MicrosoftWindowsServer",
        "imageOffer": "WindowsServer",
        "vmExtensionName": "dscExtension"
    }
    ```

1. The resources section holds all of the resources you want to provision. Because you will be provisioning a virtual machine, you will have to include a virtual network, a public IP address, a network interface, along with the DSC extension handler for your desired state configuration. You use individual resources to add all of those components. Replace the resources section with the code below. 
You can use <kbd>Ctrl</kbd>+<kbd>F</kbd> to search for "/*" and remove any comments.
   
    ```json
    "resources": [
        {   /* Your IP address resource*/
            "apiVersion": "2015-05-01-preview",
            "type": "Microsoft.Network/publicIPAddresses",
            "name": "[variables('publicIPAddressName')]",
            "location": "[parameters('location')]",
            "properties": {
                "publicIPAllocationMethod": "[variables('publicIPAddressType')]"
            }
        },
        {    /* Your virtual network resource */
            "apiVersion": "2015-05-01-preview",
            "type": "Microsoft.Network/virtualNetworks",
            "name": "[variables('virtualNetworkName')]",
            "location": "[parameters('location')]",
            "properties": {
                "addressSpace": {
                    "addressPrefixes": [
                        "[variables('vnetAddressPrefix')]"
                    ]
                },
                "subnets": [
                    {
                        "name": "[variables('subnet1Name')]",
                        "properties": {
                            "addressPrefix": "[variables('subnet1Prefix')]"
                        }
                    }
                ]
            }
        },
        {    /* Your network interface resource */
            "apiVersion": "2015-05-01-preview",
            "type": "Microsoft.Network/networkInterfaces",
            "name": "[variables('nicName')]",
            "location": "[parameters('location')]",
            "dependsOn": [
                "[concat('Microsoft.Network/publicIPAddresses/', variables('publicIPAddressName'))]",
                "[concat('Microsoft.Network/virtualNetworks/', variables('virtualNetworkName'))]"
            ],
            "properties": {
                "ipConfigurations": [
                    {
                        "name": "ipconfig1",
                        "properties": {
                            "privateIPAllocationMethod": "Dynamic",
                            "publicIPAddress": {
                                "id": "[resourceId('Microsoft.Network/publicIPAddresses', variables('publicIPAddressName'))]"
                            },
                            "subnet": {
                                "id": "[variables('subnet1Ref')]"
                            }
                        }
                    }
                ]
            }
        },
        {    /* Your virtual machine resource*/
            "apiVersion": "2017-03-30",
            "type": "Microsoft.Compute/virtualMachines",
            "name": "[parameters('vmName')]",
            "location": "[parameters('location')]",
            "dependsOn": [
                "[concat('Microsoft.Network/networkInterfaces/', variables('nicName'))]"
            ],
            "properties": {
                "hardwareProfile": {
                    "vmSize": "[parameters('vmSize')]"
                },
                "osProfile": {
                    "computerName": "[parameters('vmName')]",
                    "adminUsername": "[parameters('adminUsername')]",
                    "adminPassword": "[parameters('adminPassword')]"
                },
                "storageProfile": {
                    "imageReference": {
                        "publisher": "[variables('imagePublisher')]",
                        "offer": "[variables('imageOffer')]",
                        "sku": "[parameters('imageSKU')]",
                        "version": "latest"
                    },
                    "osDisk": {
                        "name": "[concat(parameters('vmName'), '_OSDisk')]",
                        "caching": "ReadWrite",
                        "createOption": "FromImage",
                        "managedDisk": {
                            "storageAccountType": "[parameters('diskType')]"
                        }
                    }
                },
                "networkProfile": {
                    "networkInterfaces": [
                        {
                            "id": "[resourceId('Microsoft.Network/networkInterfaces', variables('nicName'))]"
                        }
                    ]
                }
            }
        },
        { /* Your DSC extension */
            "type": "Microsoft.Compute/virtualMachines/extensions",
            "name": "[concat(parameters('vmName'),'/', variables('vmExtensionName'))]",
            "apiVersion": "2015-05-01-preview",
            "location": "[parameters('location')]",
            "dependsOn": [
                "[concat('Microsoft.Compute/virtualMachines/', parameters('vmName'))]"
            ],
            "properties": {
                "publisher": "Microsoft.Powershell",
                "type": "DSC",
                "typeHandlerVersion": "2.19",
                "autoUpgradeMinorVersion": true,
                "settings": {
                    /*Location of your state configuration. Points to a parameter which you can set when you deploy your template.*/
                    "ModulesUrl": "[parameters('modulesUrl')]",
                    /*The function to call in your configuration.*/
                    "ConfigurationFunction": "[parameters('configurationFunction')]",
                    "Properties": {
                        "MachineName": "[parameters('vmName')]"
                    }
                },
                "protectedSettings": null
            }
        }
    ]
    ```

1. Save your template file using <kbd>Ctrl</kbd>+<kbd>S</kbd>. If prompted, enter the name **template.json** and select **Save**.  

1. You can close the editor using <kbd>Ctrl</kbd>+<kbd>Q</kbd>.

### Validate your template

1. Validate and test your deployment before you attempt a real deployment. Run this command to test whether your deployment would be successful.

    ```bash
    az group deployment validate  --resource-group <rgn>[sandbox resource group name]</rgn>  --template-file template.json
    ```

1. You'll be prompted to enter a **vmName**.  This is the name of the virtual machine you want to create.  Enter a memorable name here.

1. Use a strong username and password combination when you are asked for **adminUsername** and **adminPassword**. Use a username that has at least 1 uppercase letter, a symbol, and a number. Remember that the password you use must be between 8-123 characters long and must satisfy at least 3 of these password needs:

    1. Contains an uppercase character
    1. Contains a lowercase character
    1. Contains a numeric digit
    1. Contains a special character
    1. Control characters are not allowed

1. When you're prompted for a **modulesUrl**, use the URL of your configuration *.zip* file you copied down earlier.

1. Press <kbd> ENTER</kbd>, Azure will try and validate your template.

1. If your deployment is validated, you'll see information about your deployment. Pay special attention to the error property, which can be found by scrolling back through the output text. It should be null.

    ![No error](../media/5-error-null.png)

1. If there are no errors, your template has been validated and can be deployed.

### Deploy your template

1. Run the below command to deploy the template.

    ```bash
    az group deployment create --resource-group <rgn>[sandbox resource group name]</rgn> --template-file template.json
    ```

1. Follow the prompts to complete your deployment. If you are running on a sandbox this will take around ten minutes.  As long as you see the response "Running.." the deployment is still busy.

1. Once everything has been set up, your virtual machine will be created and configured as an IIS webserver. List all of the resources in the resource group to confirm everything has been set up. Run the below command.

    ```bash
    az resource list --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

1. You'll see all of your resources listed, which means your deployment was successful.

1. Test if your IIS server is running. Run the following command in the shell.

    ```bash
    az vm show -d -g <rgn>[sandbox resource group name]</rgn> -n <your-vm-name> --query publicIps -o tsv
    ```

1. Copy the IP address that is returned, and paste it into a new tab or window. You should see your IIS server running.

    ![IIS server](../media/5-iis-server-runs.png)

You've provisioned a web server using Azure Resource Manager templates and enforced a desired state configuration on your machine through a DSC extension handler.
