Let's create the Azure virtual machine (VM) with Windows 11 Enterprise.

1. Execute the following command in the Azure Cloud Shell to set the variables for creating the Azure VM:

    ```powershell
    $resourcegroup = <rgn>[sandbox resource group name]</rgn>
    $location = "westus3"
    $vmname = "myVM"
    $username = "azureuser"
    $randomIdentifier = Get-Random
    $adminpassword = "Admin-$randomIdentifier-Password!"
    $securedadminpassword = ConvertTo-SecureString $adminpassword -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($username, $securedadminpassword)
    Write-Output "Admin Password: $adminpassword"
    ```

    > [!NOTE]
    > Take a note of the `Admin Password`. You will need it later.

1. Create the Azure VM with Windows 11 Enterprise using the [New-AzVm](/powershell/module/az.compute/new-azvm) command.

    ```powershell
    $params = @{
        ResourceGroupName = $resourcegroup
        Location = $location
        Name = $vmname
        Image = "MicrosoftVisualStudio:windowsplustools:base-win11-gen2:latest"
        VirtualNetworkName = 'myVnet'
        SubnetName = 'mySubnet'
        SecurityGroupName = 'myNetworkSecurityGroup'
        PublicIpAddressName = 'myPublicIpAddress'
        Credential = $credential
        Size = 'Standard_D2s_v3'
    }
    New-AzVm @params
    ```

    It takes a few minutes to create the VM and supporting resources. The following example output shows the VM create operation was successful.

    ```output
    ResourceGroupName        : learn-rg-0000                              
    Id                       : /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/learn-rg-0000/providers/Microsoft.Compute/virtualMachines/myVM            
    VmId                     : 00000000-0000-0000-0000-000000000000                                    
    Name                     : myVM                                                                    
    Type                     : Microsoft.Compute/virtualMachines                                       
    Location                 : westus3                                                                  
    Tags                     : {}                                                                      
    HardwareProfile          : {VmSize}                                                                
    NetworkProfile           : {NetworkInterfaces}                                                     
    OSProfile                : {ComputerName, AdminUsername, WindowsConfiguration, Secrets, AllowExtensionOperations RequireGuestProvisionSignal}                                             
    ProvisioningState        : Succeeded                                                               
    StorageProfile           : {ImageReference, OsDisk, DataDisks, DiskControllerType}                 
    FullyQualifiedDomainName : myvm-000000.westus.cloudapp.azure.com                                   
    TimeCreated              : 13/15/2023 2:33:56 PM    
    ```

Now that the VM is created, let's prepare the machine for AKS Edge Essentials and run a PowerShell script by using [Managed Run Commands](/azure/virtual-machines/windows/run-command-managed) in the Azure Cloud Shell. Alternatively you could connect from your local machine via Remote Desktop Connection (RDP), download and run the PowerShell script there.

1. Execute the following command in the Azure Cloud Shell to create a `aksee` folder and navigate to it:

    ```powershell
    New-Item -ItemType Directory -Path "$HOME\aksee"
    Set-Location -Path "$HOME\aksee"
    ```

<!-- TODO: Publish Script to main! -->
1. Execute the following command in the Cloud Shell to download `AksEdgeQuickStartForLearn.ps1` in your `aksee` folder:

    ```powershell
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/asergaz/AKS-Edge/learnmodule/tools/scripts/AksEdgeQuickStart/AksEdgeQuickStartForLearn.ps1" -OutFile "AksEdgeQuickStartForLearn.ps1"
    ```

1. Run the PowerShell [Set-AzVMRunCommand](/powershell/module/az.compute/set-azvmruncommand) command to deliver the PowerShell script to the VM and execute it:

    ```powershell
    $resourcegroup = <rgn>[sandbox resource group name]</rgn>
    $location = "westus3"
    $vmname = "myVM"
    $scriptPath = "$HOME/aksee/AksEdgeQuickStartForLearn.ps1"
    $parameters = @{
        "WindowsNode" = $true
    }

    Set-AzVMRunCommand -ResourceGroupName $resourcegroup -VMName $vmname -Location $location -RunCommandName "deployAKSEE" -ScriptLocalPath $scriptPath -Parameter $parameters -NoWait
    ```

    > [!NOTE]
    > The installation process takes a few minutes to complete.

    This script automates the following steps:

    - In the VM working folder `C:\akseeLearn`, the script downloads the GitHub archive of [Azure/AKS-Edge](https://github.com/Azure/AKS-Edge) and unzips to a folder **AKS-Edge-main**.
    - Invokes the `Start-AideWorkflow` function that performs the following tasks:
      - Downloads and installs the AKS Edge Essentials MSI.
      - Installs required host OS features (`Install-AksEdgeHostFeatures`).
      - Deploys a single machine K3S cluster with a Linux and Windows node.

1. Run the PowerShell [Get-AzVMRunCommand](/powershell/module/az.compute/get-azvmruncommand) command to retrieve the output of the PowerShell script you executed in the VM:

    ```powershell
    $resourcegroup = <rgn>[sandbox resource group name]</rgn>
    $vmname = "myVM"
    $x = Get-AzVMRunCommand -ResourceGroupName $resourcegroup -VMName $vmname -RunCommandName "deployAKSEE" -Expand InstanceView

    $x.InstanceView
    ```

    The following example output shows the download and installation of AKS Edge Essentials K3s distribution was successful:
    <!-- TODO: Add output example -->
    ```output
    NEED OUTPUT
    ```

    > [!NOTE]
    > If the output shows **null** or looks incomplete, run the command again.