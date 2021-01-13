You can run the Azure File Sync evaluation PowerShell cmdlets on any Windows Server computer that you'd like to use file sync on. The cmdlets check the OS, file system, file name, and folder name compatibility.

Before you install and set up Azure File Sync on your company's CAD file server, you're going to assess the server to ensure it's compatible. You'll run the evaluation cmdlets to produce a report.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

The following video shows how to do the assessment on your on-premises server. Follow the steps in this exercise to complete the assessment on a virtual machine that you create in your Azure subscription.

> [!VIDEO https://channel9.msdn.com/Shows/Learn-Azure/Azure-File-Sync-Unit4/player?format=ny]

## Create a Windows file server

You'd normally install Azure File Sync on your on-premises server. For this exercise, you'll create an Azure virtual machine (VM) to act as your Windows file server.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. From the menu bar on the top right-hand side, open **Cloud Shell**.
1. Run the following command to create a resource group. Replace `EastUS` with the value of a location near you.

    ```powershell
    $resourceGroup = 'learn-file-sync-rg'
    $location = 'EastUS'
    New-AzResourceGroup -Name $resourceGroup -Location $location
    ```

   This list shows some location values you can use:

   [!include[](../../../includes/azure-sandbox-regions-note.md)]

1. In PowerShell, run the following command to create a subnet and virtual network in the same location as the resource group:

    ```powershell
    $subnetConfig = New-AzVirtualNetworkSubnetConfig `
    -Name Syncpublicnet `
    -AddressPrefix 10.0.0.0/24

    $virtualNetwork = New-AzVirtualNetwork `
    -Name Syncvnet `
    -AddressPrefix 10.0.0.0/16 `
    -Location $location `
    -ResourceGroupName $resourceGroup `
    -Subnet $subnetConfig

    ```

1.  Run the following command to set the user name and password for the administrator account on the VM. Enter the user name `learnadmin` and a password. The password needs to be at least eight characters long and include a digit, an uppercase letter, a lowercase letter, and a special character. Write down the password because you'll need it later.

    ```powershell
    $cred = Get-Credential

    ```

1. Create the Windows Server machine:

   ```powershell
    New-Azvm `
    -Name FileServerLocal `
    -Credential $cred `
    -ResourceGroupName $resourceGroup `
    -Size Standard_DS1_v2 `
    -VirtualNetworkName Syncvnet `
    -SubnetName Syncpublicnet `
    -Image "MicrosoftWindowsServer:WindowsServer:2019-Datacenter-with-Containers:latest" 


    ```

   Creating the VM takes a couple of minutes.

## Set up Windows Server for assessment

Connect to the new server by using Remote Desktop client. You'll download a sample CAD file and install the Azure PowerShell module that you'll use later.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true). 
1. In the portal, in the left pane, select **Virtual machines**.
1. Select the **FileServerLocal** VM.
1. In the top menu, select **Connect**.
1. Select **Download RDP File**.
1. Open the RDP file from your browser and select **Connect**.
1. In the **Windows Security** window, select **More choices**, and then select **Use a different account**.
1. Enter the user name **learnadmin** and the password you used earlier, and then select **OK**.
1. If you're asked to connect despite certificate errors, select **Yes**.
1. After you've logged in, select **Start**, type **cmd**, and then select **Command Prompt**.
1. At the command prompt, enter **D:** and then select **Enter**.
1. Download this sample CAD file by using cURL:

    ```cmd
    curl https://github.com/MicrosoftDocs/mslearn-extend-share-capacity-with-azure-file-sync/blob/master/resources/CADFolder.zip?raw=true -L -o CADFolder.zip
    ```

1. Expand the zip file:

    ```cmd
    CADFolder.zip
    ```

1. In File Explorer, select **Compressed Folder Tools**, and then select **Extract all** and **Extract**.

## Install the Azure PowerShell modules

1. Right-click **Start**, and then select **Windows PowerShell (Admin)**.
1. In the console, download the latest Azure PowerShell modules:

    ```powershell
    Install-Module -Name Az
    ```

1. When prompted, enter **Y** to accept the untrusted repository. Do the same thing for any of the modules.

   The modules take a minute or two to install.


## Complete an assessment

With the evaluation cmdlets installed, check whether your file server and folders are compatible with Azure File Sync.

1. Do a system and data file check:

    ```powershell
    Invoke-AzStorageSyncCompatibilityCheck -Path D:\CADFolder
    ```

1. The output should look like this output:

    ```
    Environment validation results:
    
    Computer name: localhost
    OS version check: Passed.
    File system check: Passed.
    
    Namespace validation results:
    
    Path: C:\CADFolder
    Number of files scanned: 4
    Number of directories scanned: 6
    
    There were no compatibility issues found with your files.
    ```
    
1. Test the files only:

    ```powershell
    Invoke-AzStorageSyncCompatibilityCheck -Path D:\CADFolder -SkipSystemChecks
    ```

1. Test system requirements only:

    ```powershell
    Invoke-AzStorageSyncCompatibilityCheck -ComputerName localhost
    ```

1. Save the results in a CSV file:

    ```powershell
    $results=Invoke-AzStorageSyncCompatibilityCheck -Path D:\CADFolder
    $results | Select-Object -Property Type, Path, Level, Description | Export-Csv -Path D:\assessment-results.csv
    ```

1. Leave the Remote Desktop connection open for a later exercise.
