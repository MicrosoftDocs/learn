The Azure Az PowerShell module is a rollup module. Installing it downloads the available Az PowerShell modules and makes their cmdlets available for use. The Azure Az PowerShell module works with PowerShell 7.x and newer versions on all platforms. Azure PowerShell has no additional requirements when you run it on PowerShell 7.x and newer versions.

To check your PowerShell version, run the following command from within a PowerShell session:

```powershell
$PSVersionTable.PSVersion
```

Before installing the Azure Az PowerShell module, you should set your PowerShell script execution policy to **RemoteSigned**. You can do this by running the following command:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## Methods to install the Az PowerShell module

You can install the Azure Az PowerShell module by using one of the following methods:

- The **Install-Module** cmdlet
- Azure PowerShell MSI
- Az PowerShell Docker container

> [!NOTE]
> The Azure Az PowerShell module is preinstalled in Azure Cloud Shell. You can use it directly from the browser, without installing anything locally on your machine. You'll learn more about Azure Cloud Shell in the next lesson.

### The Install-Module cmdlet

Using the **Install-Module** cmdlet is the preferred installation method for the Azure Az PowerShell module. You should install this module for the current user only. This is the recommended installation scope. This method works the same on Windows, macOS, and Linux platforms. To install the Az module, run the following command from a local PowerShell session:

```powershell
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
```

Although PowerShell 7.x is the recommended version of PowerShell, and **Install-Module** is the recommended installation option, you can also install the Az module within PowerShell 5.1 environment on Windows. If you're on Windows 10 version 1607 or higher, you already have PowerShell 5.1 installed. You should also make sure that you have .NET Framework 4.7.2 or newer installed and the latest version of PowerShellGet. To install the latest version of the PowerShellGet module within PowerShell 5.1, run the following command:

```powershell
Install-Module -Name PowerShellGet -Force
```

You can then install the Az module by using the same command you use in PowerShell 7.1.

### Azure PowerShell MSI

In some environments, it isn't possible to connect to the PowerShell Gallery. In such situations, you can install the Az PowerShell module offline, by downloading the Azure PowerShell MSI package. Keep in mind that the MSI installer only works for PowerShell 5.1 on Windows.

To update any PowerShell module, you should use the same method used to install the module. For example, if you originally used **Install-Module**, then you should use **Update-Module** to get the latest version. If you originally used the MSI package, then you should download and install the new MSI package.

### Az PowerShell Docker container

It's also possible to run Azure PowerShell inside a Docker image. Microsoft provides Docker images with Azure PowerShell preinstalled. The released images require Docker 17.05 or newer. The latest container image contains the latest version of PowerShell and the latest Azure PowerShell modules supported with the Az module.

To download the image and start an interactive PowerShell session, you should run the following commands:

```powershell
docker pull mcr.microsoft.com/azure-powershell
docker run -it mcr.microsoft.com/azure-powershell pwsh
```

## Starting to work with Azure PowerShell

To start working in the Azure PowerShell environment, you should first sign in with your Azure credentials. This step is different from working in pure PowerShell. Your Azure credentials are the same credentials you use to sign in to the Azure portal or other Azure-based resources.

To sign in to Azure from Azure PowerShell, run the following command:

```powershell
Connect-AzAccount
```

After running this command, you'll be prompted to sign in with your Azure credentials. After you successfully authenticate to Azure, you can start using commands from the Az module to manage your Azure resources.
