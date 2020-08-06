## Azure Management tools

You can configure and manage Azure using a broad range of tools and platforms. There are tools available for the command line, language-specific Software Development Kits (SDKs), developer tools, tools for migration, and many others.

## Azure portal

![Azure icon.](../media/icon-portal.png)

The [Azure portal](https://azure.microsoft.com/features/azure-portal/) is a public website that you can access with any web browser. After you sign in with your Azure account, you can create, manage, and monitor any available Azure services. You can identify a service you're looking for, get links for help on a topic, and deploy, manage, and delete resources. It also guides you through complex administrative tasks using wizards and tooltips.

The dashboard view provides high-level details about your Azure environment. You can customize the portal view as you need by moving and resizing tiles, displaying particular services of interest, accessing links for help and support, and providing feedback.

The portal does not provide any way to automate repetitive tasks. For example, to set up multiple Virtual Machines, you would need to create them one at a time by completing the wizard for each Virtual Machine. Completing a wizard can be time-consuming and error-prone for complex tasks. 

## Azure PowerShell

![PowerShell icon.](../media/icon-3.png)

Azure PowerShell is a module that you add to Windows PowerShell or PowerShell Core that enables you to connect to your Azure subscription and manage resources. Azure PowerShell requires Windows PowerShell to function. PowerShell provides services such as the shell window and command parsing. Azure PowerShell then adds the Azure-specific commands.

For example, Azure PowerShell provides the **New-AzVM** command that creates a virtual machine for you inside your Azure subscription. To use it, you would launch PowerShell, sign in to your Azure account using the command `Connect-AzureRMAccount`, and then issue a command such as:


```powershell
New-AzVm `
    -ResourceGroupName "TesResourceGroup" `
    -Name "Testvm" `
    -Image "UbuntuLTS"
    ...
```

> [!NOTE]
> PowerShell Core is a cross-platform version of PowerShell that runs on Windows, Linux or macOS.

## Azure Command Line Interface (CLI)

![CLI icon.](../media/icon-2.png)

Azure CLI is a cross-platform command-line program that connects to Azure and executes administrative commands on Azure resources. *Cross platform* means that it can be run on Windows, Linux, or macOS. For example, to create a Virtual Machine, you would open a command prompt window, sign in to Azure using the command `az login`, create a resource group, then use a command such as:

```azurecli
az vm create \
  --resource-group Testrg1 \
  --name Testvm \
  --image UbuntuLTS
  --generate-ssh-keys
  ...
```


## Azure Cloud Shell

![Cloud Shell icon.](../media/icon-shell.png)

[Azure Cloud Shell](https://azure.microsoft.com/features/cloud-shell/) is a browser-based scripting environment in your portal. It provides the flexibility of choosing the shell experience that best suits the way you work. Linux users can opt for a Bash experience, while Windows users can opt for PowerShell.

A storage account is required to use the Cloud Shell and you will be prompted to create one when accessing the Azure Cloud Shell.

> [!NOTE]
> You can access Azure Cloud Shell through the portal. 

## Azure Mobile App

![Mobile app icon.](../media/icon-mobile-app.png)

The [Microsoft Azure mobile app](https://azure.microsoft.com/features/azure-portal/mobile-app/) allows you to access, manage, and monitor all your Azure accounts and resources from your iOS or Android phone or tablet. Once installed, you can:

+	Check the status and important metrics of your services
+	Stay informed with notifications and alerts about important health issues
+	Quickly diagnose and fix issues anytime, anywhere
+	Review the latest Azure alerts
+	Start, stop, and restart virtual machines or web apps
+	Connect to your virtual machines
+	Manage permissions with role-based access control (RBAC)
+	Use the Azure Cloud Shell to run saved scripts or perform unplanned administrative tasks

## Azure REST API

![REST API icon.](../media/icon-1.png)

Representational State Transfer (REST) APIs are service endpoints that support sets of HTTP operations (methods), which provide create, retrieve, update, or delete access to the service's resources. A REST API defines a set of functions which developers can perform requests and receive responses via HTTP protocol such as GET and POST.


