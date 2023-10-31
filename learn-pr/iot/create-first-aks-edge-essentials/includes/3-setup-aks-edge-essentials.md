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
    > Take a note of the `Admin Password` you will need it later.

1. Create the Azure VM with Windows 11 Enterprise using the following command.

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
    "id": "/subscriptions/6d9888d2-c623-46a2-9848-0e443ef7f578/resourceGroups/learn-a5efd3c2-cc89-4cf0-98b8-6335c0364d82/providers/Microsoft.Compute/virtualMachines/myVM",
    "location": "westus",
    "macAddress": "00-0D-3A-37-C7-E2",
    "powerState": "VM running",
    "privateIpAddress": "10.0.0.4",
    "publicIpAddress": "104.40.70.15",
    "resourceGroup": "learn-a5efd3c2-cc89-4cf0-98b8-6335c0364d82",
    "zones": ""
}
```

> [!NOTE]
> Take a note your own `publicIpAddress`` in the output when you create your VM. This IP address is used to access the VM later in this article.

Now that the VM is created, we will prepare the machine for AKS Edge Essentials. We will run Powershell scripts within the Azure Windows VM you just created. Alternatively you could connect from your local machine via Remote Desktop Connection (RDP) and run the Powershell commands there.

1. Execute the following command in the Azure Cloud Shell to create a `aks-ee` folder and navigate to it:

    ```azurecli
    mkdir ~/aksee
    cd ~/aksee
    ```

1. Create a new powershell script to download and install AKS Edge Essentials K3s distribution:

    ```azurecli
    code ./install-aks-ee.ps1
    ```

    Then add the following code to the script:

    ```powershell
    Set-ExecutionPolicy RemoteSigned -Scope Process -Force

    # Create a directory to store the k3s MSI installer and logs
    if (!(Test-Path -Path "C:\aksee")) {
        New-Item -ItemType Directory -Path "C:\aksee" | Out-Null
    }

    Start-Transcript -Path "C:\aksee\log.txt" -Append

    # Download the k3s MSI installer
    Write-Host "Step 1 : AKS-Edge download k3s.msi"
    if (!(Test-Path -Path "C:\aksee\k3s.msi")) {
        try {
            Start-BitsTransfer -Source "https://aka.ms/aks-edge/k3s-msi" -Destination "C:\aksee\k3s.msi"
        } catch {
            Write-Host "Error: Downloading k3s.msi failed" -ForegroundColor Red
            Stop-Transcript | Out-Null
            Pop-Location
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
            Pop-Location
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
            Pop-Location
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
        Pop-Location
        exit -1
    }
    
    Write-Host "Step 4 : AKS-Edge test modules"
    #Once installation is complete, make sure it was successful by running the following command
    Import-Module AksEdge
    Get-Command -Module AKSEdge | Format-Table Name, Version
    Stop-Transcript | Out-Null
    Pop-Location
    exit 0
    ```
    
    Hit `Ctrl+S` to save the file and `Ctrl+Q` to exit the editor.


1. Run the powershell script to download and install AKS Edge Essentials K3s distrubution:

    ```azurecli
    az vm run-command create --no-wait --name "installAKSEE" --vm-name myVM --resource-group <rgn>[sandbox resource group name]</rgn> --script @install-aks-ee.ps1
    ```

    > [!NOTE]
    > The installation process takes a few minutes to complete.

1. Check the output of the powershell script you ran in the VM:

    ```azurecli
    az vm run-command show --name "installAKSEE" --vm-name "myVM" --resource-group <rgn>[sandbox resource group name]</rgn> --instance-view | jq .instanceView.output | sed 's/\\n/\n/g'
    ```

The following example output shows the download and installation of AKS Edge Essentials K3s distribution was successful, and the output of AKS Edge Essentials modules:

```output
Transcript started, output file is C:\\aksee\\log.txt
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
```

> [!NOTE]
> If the output looks incomplete, run the command again.