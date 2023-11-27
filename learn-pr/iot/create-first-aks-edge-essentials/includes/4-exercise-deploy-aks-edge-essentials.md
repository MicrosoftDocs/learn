In this exercise we will deploy AKS Edge Essentials in a single machine K3S cluster with a Linux and Windows node. We will use the Azure Cloud Shell to create an Azure virtual machine (VM) with Windows 11 Enterprise and run a PowerShell script for easy deployment of AKS Edge Essentials.

## Create an Azure VM with Windows 11 Enterprise

Let's create the Azure VM with Windows 11 Enterprise using Azure Cloud Shell.

1. Start by **activating the Azure sandbox above**.

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

## Deploy AKS Edge Essentials

Now that the VM is created, let's prepare the machine for AKS Edge Essentials and run the `AksEdgeQuickStartForLearn.ps1` script by using [Managed Run Commands](/azure/virtual-machines/windows/run-command-managed) in the Azure Cloud Shell. Alternatively you could connect from your local machine via Remote Desktop Connection (RDP), download and run the PowerShell script there.

<!-- TODO: Publish Script to main! I may need the RunAsPassword and RunAsUser -->
<!-- RunAsUser = $username -->
<!-- RunAsPassword = $adminpassword -->

<!-- When deploying it over Azure cloudshell I need to run this in the VM to be able to use kubectl: Get-AksEdgeKubeConfig -->

 <!--TODO if 2 params $parameters = @(@{Name='name';Value='Sergio'},@{Name='lastname';Value='Azevedooo'}) -->

1. Run the PowerShell [Set-AzVMRunCommand](/powershell/module/az.compute/set-azvmruncommand) cmdlet to deliver the PowerShell script to the VM and execute it.

    ```powershell
    $setazvmrparamsScript = @{
        ResourceGroupName = $resourcegroup
        VMName = $vmname
        Location = $location
        RunCommandName = "deployAKSEE"
        SourceScriptUri = "https://raw.githubusercontent.com/asergaz/AKS-Edge/learnmodule/tools/scripts/AksEdgeQuickStart/AksEdgeQuickStartForLearn.ps1"
        Parameter = @(@{Name='WindowsNode';Value=$true})
        NoWait = $true
    }
    Set-AzVMRunCommand @setazvmrparamsScript
    ```

    > [!NOTE]
    > The installation process takes around 30 minutes to complete.

    This script automates the following steps:

    - In the VM working folder `C:\akseeLearn`, the script downloads the GitHub archive of [Azure/AKS-Edge](https://github.com/Azure/AKS-Edge) and unzips to a folder **AKS-Edge-main**.
    - Invokes the `Start-AideWorkflow` function that performs the following tasks:
      - Downloads and installs the AKS Edge Essentials MSI.
      - Downloads Windows node files.
      - Installs required host OS features (`Install-AksEdgeHostFeatures`).
      - Deploys a single machine K3S cluster with a Linux and Windows node.

1. Run the PowerShell [Get-AzVMRunCommand](/powershell/module/az.compute/get-azvmruncommand) cmdlet to retrieve the output of the PowerShell script you executed in the VM:

    ```powershell
    $getazvmparamsScript = @{
        ResourceGroupName = $resourcegroup
        VMName = $vmname
        RunCommandName = "deployAKSEE"
        Expand = "InstanceView"
    }
    while($true) {
        (Get-AzVMRunCommand @getazvmparamsScript).InstanceView
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

Now that AKS Edge Essentials is deployed we will log in to the VM via RDP to further configure our single machine K3S cluster.

1. Run the Powershell [Get-AzRemoteDesktopFile](/powershell/module/az.compute/get-azremotedesktopfile) cmdlet to get the RDP file to connect to the VM:

    ```powershell
    $getazrdpfileparams = @{
        ResourceGroupName = $resourcegroup
        Name = $vmname
        LocalPath = "./myvm.rdp"
    }
    Get-AzRemoteDesktopFile @getazrdpfileparams
    ```

1. In Azure Cloud Shell, select **Upload/Download Files** to download the RDP file to your local machine.

1. Open the RDP file and connect to the VM using *azureuser* as the **user**, and the `Admin Password` you took a note earlier, as the **password**.

The following commands are executed in the PowerShell command line of the VM.

> [!TIP]
> When logging in for the first time to the Windows 11 Enterprise Azure VM, you can accept all options by clicking **Next**.

1. Open the PowerShell command line by clicking on the **Start** menu and typing **PowerShell**.

1. Run the PowerShell [Get-AksEdgeKubeConfig](/azure/aks/hybrid/reference/aks-edge-ps/get-aksedgekubeconfig) cmdlet to pull the KubeConfig file from the Kubernetes Linux node so that kubectl on the host can access the AKS Edge Essentials cluster, and then press <kbd>Enter</kbd> to confirm:

    ```powershell
    Get-AksEdgeKubeConfig
    ```

1. Confirm that the deployment was successful by running the following command:

    ```powershell
    kubectl get nodes -o wide
    kubectl get pods -A -o wide
    ```

    The following example output shows the Linux and Windows nodes are ready and the pods are running:

    ```output
    PS C:\Users\azureuser> kubectl get nodes -o wide
    NAME         STATUS   ROLES                       AGE   VERSION        INTERNAL-IP   EXTERNAL-IP   OS-IMAGE                         KERNEL-VERSION     CONTAINER-RUNTIME
    myvm-ledge   Ready    control-plane,etcd,master   46m   v1.26.6+k3s-   192.168.0.2   <none>        CBL-Mariner/Linux                5.15.133.1-1.cm2   containerd://1.7.1-k3s1
    myvm-wedge   Ready    <none>                      33m   v1.26.6+k3s-   192.168.0.3   <none>        Windows Server 2022 Datacenter   10.0.20348.2031    containerd://1.7.1-k3s1
    
    PS C:\Users\azureuser> kubectl get pods -A -o wide
    NAMESPACE     NAME                               READY   STATUS    RESTARTS      AGE   IP            NODE         NOMINATED NODE   READINESS GATES
    kube-system   coredns-866448bdfb-8s26b           1/1     Running   0             47m   10.42.0.3     myvm-ledge   <none>           <none>
    kube-system   kube-vip-cloud-provider-ds-n8l6t   1/1     Running   0             46m   10.42.0.2     myvm-ledge   <none>           <none>
    kube-system   kube-vip-ds-rjl8v                  1/1     Running   2 (43m ago)   46m   192.168.0.2   myvm-ledge   <none>           <none>
    ``````

    :::image type="content" source="../media/2-aks-ee-deploysuccess-inline.png" alt-text="Screenshot of Windows VM with powershell commands output demonstrating a successful deployment of AKS Edge Essentials." lightbox="../media/2-aks-ee-deploysuccess-expanded.png":::