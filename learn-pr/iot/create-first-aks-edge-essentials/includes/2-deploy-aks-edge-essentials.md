Let's create the Azure virtual machine (VM) with Windows 11 Enterprise.

1. Execute the following command in the Azure Cloud Shell to set the variables for creating the Azure VM:

    ```powershell
    $resourcegroup = "<rgn>[sandbox resource group name]</rgn>"
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

1. Create the Azure VM with Windows 11 Enterprise using the [New-AzVm](/powershell/module/az.compute/new-azvm) cmdlet.

    ```powershell
    $newazvmparams = @{
        ResourceGroupName = $resourcegroup
        Location = $location
        Name = $vmname
        Image = "MicrosoftVisualStudio:windowsplustools:base-win11-gen2:latest"
        VirtualNetworkName = "myVnet"
        SubnetName = "mySubnet"
        SecurityGroupName = "myNetworkSecurityGroup"
        PublicIpAddressName = "myPublicIpAddress"
        Credential = $credential
        Size = "Standard_D2s_v3"
    }
    New-AzVm @newazvmparams
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

Now that the VM is created, let's prepare the machine for AKS Edge Essentials and run the `AksEdgeQuickStartForLearn.ps1` script by using [Managed Run Commands](/azure/virtual-machines/windows/run-command-managed) in the Azure Cloud Shell. Alternatively you could connect from your local machine via Remote Desktop Connection (RDP), download and run the PowerShell script there.

<!-- TODO: Publish Script to main! I may not need the RunAsPassword and RunAsUser -->
<!-- RunAsUser = $username -->
<!-- RunAsPassword = $adminpassword -->

 <!--TODO if 2 params $parameters = @(@{Name='name';Value='Sergio'},@{Name='lastname';Value='Azevedooo'}) -->

1. Run the PowerShell [Set-AzVMRunCommand](/powershell/module/az.compute/set-azvmruncommand) cmdlet to deliver the PowerShell script to the VM and execute it.

    ```powershell
    $setazvmrparams = @{
        ResourceGroupName = $resourcegroup
        VMName = $vmname
        Location = $location
        RunCommandName = "deployAKSEE"
        SourceScriptUri = "https://raw.githubusercontent.com/asergaz/AKS-Edge/learnmodule/tools/scripts/AksEdgeQuickStart/AksEdgeQuickStartForLearn.ps1"
        Parameter = @(@{Name='WindowsNode';Value=$true})
        NoWait = $true
    }
    Set-AzVMRunCommand @setazvmrparams
    ```

    > [!NOTE]
    > The installation process takes around 30 minutes to complete.

    This script automates the following steps:

    - In the VM working folder `C:\akseeLearn`, the script downloads the GitHub archive of [Azure/AKS-Edge](https://github.com/Azure/AKS-Edge) and unzips to a folder **AKS-Edge-main**.
    - Invokes the `Start-AideWorkflow` function that performs the following tasks:
      - Downloads and installs the AKS Edge Essentials MSI.
      - Installs required host OS features (`Install-AksEdgeHostFeatures`).
      - Deploys a single machine K3S cluster with a Linux and Windows node.

1. Run the PowerShell [Get-AzVMRunCommand](/powershell/module/az.compute/get-azvmruncommand) cmdlet to retrieve the output of the PowerShell script you executed in the VM:

    ```powershell
    $getazvmparams = @{
        ResourceGroupName = $resourcegroup
        VMName = $vmname
        RunCommandName = "deployAKSEE"
        Expand = "InstanceView"
    }
    while($true) {
        (Get-AzVMRunCommand @getazvmparams).InstanceView
        Start-Sleep -Seconds 10
    }
    ```

    The following example with the last lines of the output, shows the download and installation of AKS Edge Essentials K3s distribution was successful:

    ```output
    ExecutionState   : Succeeded
    ExecutionMessage : RunCommand script execution completed
    ExitCode         : 0
    Output           : ...                      
                       [11/16/2023 13:30:10] Initializing kubernetes runtime in Linux node.
                       
                        - Waiting for Kubernetes node (myvm-ledge) to reach condition Ready, time remaining = 300 seconds
                        - Kubernetes node (myvm-ledge) reached condition Ready
                       
                       [11/16/2023 13:32:09] Querying IP and MAC addresses from virtual machine (myvm-ledge)
                       
                        - Virtual machine MAC: 00:15:5d:0b:cd:35
                        - Virtual machine IP : 192.168.0.2 retrieved directly from virtual machine
                       
                       [11/16/2023 13:32:12] Retrieving local Linux node's k3s cluster join data.
                       [11/16/2023 13:32:18] Extracting Windows Vhdx
                       [11/16/2023 13:37:32] Deploying Windows Worker Node
                       
                        - Verifying expected Windows VM image
                        - Creating storage vhd (file: AksEdgeWindowsImage)
                        - Creating the storage vhdx... 9 retries remaining
                        - Creating the storage vhdx... 8 retries remaining
                       
                       [11/16/2023 13:43:41] Removing Intermediate Windows Vhdx
                       
                        - Creating vnic (name: eth0)
                       
                       [11/16/2023 13:44:40] Done
                       [11/16/2023 13:44:40] Waiting for Windows node IP address...
                       [11/16/2023 13:44:40] Testing Windows node control channel...
                       [11/16/2023 13:45:21] ...successfully connected to the Windows node
                       [11/16/2023 13:47:09] Waiting for Windows node to transition to ready state (796 seconds remaining)
                       
                        - Waiting for Kubernetes node (myvm-wedge) to reach condition Ready, time remaining = 796 seconds
                        - Kubernetes node (myvm-wedge) reached condition Ready
                       
                       [11/16/2023 13:47:34] AksEdge - copying Kubeconfig into the host.
                       [11/16/2023 13:47:39] AksEdge - new deployment successfully created.
                       
                       * AksEdge VM deployment successfull.
                       Deployment Successful. 
                       Step 4: Connect to Arc
                       >> skipping step 4
                       Duration: 0 hrs 31 mins 26 seconds
    Error            : 
    StartTime        : 11/16/2023 1:16:10 PM
    EndTime          : 11/16/2023 1:47:44 PM
    Statuses         : 
    ```

    > [!NOTE]
    > This will create an infinite loop. When the output looks similar to the example above you can stop it by pressing <kbd>Ctrl</kbd>+<kbd>C</kbd>. Since this takes around 30 minutes to complete, you can stop it now and continue to the next learning unit, we will get back to this later.



<!-- TODO : This does not work with Powershell. Need to use SSH -->
1. Confirm that the deployment was successful by running the PowerShell [Invoke-AzVMRunCommand](/powershell/module/az.compute/invoke-azvmruncommand) cmdlet to retrieve the output of kubectl:

    ```powershell
    $invokeazvmparams = @{
        ResourceGroupName = $resourcegroup
        Name = $vmname
        CommandId = "RunPowerShellScript"
        ScriptString = "kubectl get nodes -o wide; kubectl get pods -A -o wide"
    }
    Invoke-AzVMRunCommand @invokeazvmparams
    ```
