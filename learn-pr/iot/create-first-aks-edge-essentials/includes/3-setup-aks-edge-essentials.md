Let's create the Azure virtual machine (VM) with Windows 11 Enterprise.

1. Execute the following command in the Azure Cloud Shell to set the variables for creating the Azure VM:

    ```azurecli
    resourcegroup=<rgn>[sandbox resource group name]</rgn>
    location="westus3"
    vmname="myVM"
    username="azureuser"
    let "randomIdentifier=$RANDOM*$RANDOM"
    adminpassword="Admin-$randomIdentifier-Password!"
    echo Admin Password: $adminpassword
    ```

    > [!NOTE]
    > Take a note of the `Admin Password`. You will need it later.

1. Create the Azure VM with Windows 11 Enterprise using the [az vm create](/cli/azure/vm?view=azure-cli-latest#az-vm-create) command.

    ```azurecli
    az vm create \
        --resource-group $resourcegroup \
        --name $vmname \
        --image MicrosoftVisualStudio:windowsplustools:base-win11-gen2:latest \
        --public-ip-sku Standard \
        --admin-username $username \
        --admin-password $adminpassword \
        --size Standard_D2s_v3
    ```

    It takes a few minutes to create the VM and supporting resources. The following example output shows the VM create operation was successful.

    ```output
    {
        "fqdns": "",
        "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/learn-rg-0000/providers/Microsoft.Compute/virtualMachines/myVM",
        "location": "westus",
        "macAddress": "00-00-00-00-00-00",
        "powerState": "VM running",
        "privateIpAddress": "10.0.0.4",
        "publicIpAddress": "104.40.70.15",
        "resourceGroup": "learn-rg-0000",
        "zones": ""
    }
    ```

Now that the VM is created, let's prepare the machine for AKS Edge Essentials and run some PowerShell scripts by using [Run Command](/azure/virtual-machines/run-command-overview) and Azure CLI. Alternatively you could connect from your local machine via Remote Desktop Connection (RDP) and run the PowerShell commands there.

1. Execute the following command in the Azure Cloud Shell to create a `aksee` folder and navigate to it:

    ```azurecli
    mkdir ~/aksee
    cd ~/aksee
    ```

1. Create a new PowerShell script to download and install AKS Edge Essentials K3s distribution:

    ```azurecli
    code ./install-aks-ee.ps1
    ```

    Add the following code to the script:

    ```powershell
    # If you RDP to the machine, you may need to run the following command to allow the commands to run
    # Set-ExecutionPolicy RemoteSigned -Scope Process -Force

    # Create a directory to store the k3s MSI installer and logs
    if (!(Test-Path -Path "C:\aksee")) {
        New-Item -ItemType Directory -Path "C:\aksee" | Out-Null
    }

    Start-Transcript -Path "C:\aksee\log.txt" -Append | Out-Null

    # Download the k3s MSI installer
    Write-Host "Step 1 : AKS-Edge download k3s.msi"
    if (!(Test-Path -Path "C:\aksee\k3s.msi")) {
        try {
            Start-BitsTransfer -Source "https://aka.ms/aks-edge/k3s-msi" -Destination "C:\aksee\k3s.msi"
        } catch {
            Write-Host "Error: Downloading k3s.msi failed" -ForegroundColor Red
            Stop-Transcript | Out-Null
            exit -1
        }
    }
    Write-Host "Downloading k3s.msi succeeded" -ForegroundColor Green

    # Download and unzip the Windows node files
    Write-Host "Step 2 : AKS-Edge download windows-node.zip"
    if (!(Test-Path -Path "C:\aksee\windows-node.zip")) {
        try {
            Start-BitsTransfer -Source "https://aka.ms/aks-edge/windows-node-zip" -Destination "C:\aksee\windows-node.zip"
        } catch {
            Write-Host "Error: Downloading windows-node.zip failed" -ForegroundColor Red
            Stop-Transcript | Out-Null
            exit -1
        }
    }
    Write-Host "Downloading windows-node.zip succeeded" -ForegroundColor Green
    
    #Extract Zip file
    if (!(Test-Path -Path "C:\aksee\AksEdgeWindows-v1.exe")) {
        try {
            $Shell = New-Object -ComObject "Shell.Application"
            $zipContents = $Shell.Namespace((Convert-Path "C:\aksee\windows-node.zip")).items()
            $DestinationFolder = $Shell.Namespace((Convert-Path "C:\aksee"))
            $DestinationFolder.CopyHere($zipContents)
        } catch {
            Write-Host "Error: Extracting windows-node.zip failed" -ForegroundColor Red
            Stop-Transcript | Out-Null
            exit -1
        }
    }

    
    Write-Host "Step 3 : AKS-Edge install k3s.msi"
    # Install k3s using the MSI installer - i = install, li = log install, qn = quiet, no UI 
    $process = Start-Process -FilePath "msiexec.exe" -ArgumentList "/i C:\aksee\k3s.msi ADDLOCAL=CoreFeature,WindowsNodeFeature /li C:\aksee\k3s-install.log /qn" -PassThru
    $process.WaitForExit()
    $exitCode = $process.ExitCode
    if ($exitCode -eq 0) {
        Write-Host "Installing k3s.msi succeeded." -ForegroundColor Green
    } else {
        Write-Host "Installation failed with exit code $exitCode." -ForegroundColor Red
        Stop-Transcript | Out-Null
        exit -1
    }
    
    Write-Host "Step 4 : AKS-Edge test modules"
    #Once installation is complete, make sure it was successful by running the following command
    Import-Module AksEdge
    Get-Command -Module AKSEdge | Select-Object Name, Version
    
    Write-Host "Step 5 : AKS-Edge check device settings"
    # Run the Install-AksEdgeHostFeatures command to validate the Hyper-V, SSH and Power settings on the machine.
    Install-AksEdgeHostFeatures -Force
    
    Stop-Transcript | Out-Null
    exit 0
    ```
    
    Hit <kbd>Ctrl</kbd>+<kbd>S</kbd> to save the file and <kbd>Ctrl</kbd>+<kbd>Q</kbd> to exit the editor.


1. Run the Azure CLI [az vm run-command create](/cli/azure/vm/run-command#az-vm-run-command-create) command to deliver the Powershell script to the VM and execute it:

    ```azurecli
    az vm run-command create --no-wait --name "installAKSEE" --vm-name myVM --resource-group <rgn>[sandbox resource group name]</rgn> --script @install-aks-ee.ps1
    ```

    > [!NOTE]
    > The installation process takes a few minutes to complete.

1. Run the Azure CLI [az vm run-command show](/cli/azure/vm/run-command#az-vm-run-command-show) command to retrieve the output of the PowerShell script you executed in the VM:

    ```azurecli
    az vm run-command show --name "installAKSEE" --vm-name "myVM" --resource-group <rgn>[sandbox resource group name]</rgn> --instance-view | jq .instanceView.output | sed 's/\\n/\n/g'
    ```

    The following example output shows the download and installation of AKS Edge Essentials K3s distribution was successful, the output of AKS Edge Essentials modules, and that the Hyper-V, SSH and Power settings on the machine are configured correctly:

    ```output
    Step 1 : AKS-Edge download k3s.msi
    Downloading k3s.msi succeeded
    Step 2 : AKS-Edge download windows-node.zip
    Downloading windows-node.zip succeeded
    Step 3 : AKS-Edge install k3s.msi
    Installing k3s.msi succeeded.
    Step 4 : AKS-Edge test modules
    
    Name                            Version  
    ----                            -------  
    Add-AksEdgeNode                 1.4.109.0
    Connect-AksEdgeArc              1.4.109.0
    Copy-AksEdgeNodeFile            1.4.109.0
    Disconnect-AksEdgeArc           1.4.109.0
    Get-AksEdgeDeploymentInfo       1.4.109.0
    Get-AksEdgeEventLog             1.4.109.0
    Get-AksEdgeKubeConfig           1.4.109.0
    Get-AksEdgeLogs                 1.4.109.0
    Get-AksEdgeManagedServiceToken  1.4.109.0
    Get-AksEdgeNodeAddr             1.4.109.0
    Get-AksEdgeNodeConnectivityMode 1.4.109.0
    Get-AksEdgeNodeName             1.4.109.0
    Get-AksEdgeUpgrade              1.4.109.0
    Install-AksEdgeHostFeatures     1.4.109.0
    Invoke-AksEdgeNodeCommand       1.4.109.0
    New-AksEdgeConfig               1.4.109.0
    New-AksEdgeDeployment           1.4.109.0
    New-AksEdgeScaleConfig          1.4.109.0
    Remove-AksEdgeDeployment        1.4.109.0
    Remove-AksEdgeNode              1.4.109.0
    Set-AksEdgeNodeConnectivityMode 1.4.109.0
    Set-AksEdgeNodeToDrain          1.4.109.0
    Set-AksEdgeUpgrade              1.4.109.0
    Start-AksEdgeControlPlaneUpdate 1.4.109.0
    Start-AksEdgeNode               1.4.109.0
    Start-AksEdgeUpdate             1.4.109.0
    Start-AksEdgeWorkerNodeUpdate   1.4.109.0
    Stop-AksEdgeNode                1.4.109.0
    Test-AksEdgeArcConnection       1.4.109.0
    Test-AksEdgeDeployment          1.4.109.0
    Test-AksEdgeNetworkParameters   1.4.109.0
    Test-AksEdgeNode                1.4.109.0

    Step 5 : AKS-Edge check device settings
     - Checking host for required features
     - Checking the status of 'Microsoft-Hyper-V'
     - Checking the status of 'Microsoft-Hyper-V-Management-PowerShell'
     - Checking the status of 'Microsoft-Hyper-V-Hypervisor'
     - Checking the status of 'OpenSSH.Client*'
     - Checking power management settings of the Host
     - Checking HNS version of the Host
     - Checking OpenSSH version of the Host
     - Checking Nested Virtualization of the Host
    True
    ```

    > [!NOTE]
    > If the output shows **null** or looks incomplete, run the command again.