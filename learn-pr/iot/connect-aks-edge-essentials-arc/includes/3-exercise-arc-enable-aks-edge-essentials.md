In this exercise, we deploy AKS Edge Essentials in a single machine K3S cluster with a Linux node and Arc-enable it. We use the Azure Cloud Shell to create an Azure virtual machine (VM) with Windows 11 Enterprise and run a PowerShell script for easy deployment of AKS Edge Essentials and then connect it to Azure Arc.

## Create necessary resources in your Azure subscription

This unit provides Azure CLI commands that you can run with an Azure subscription. If you don't have an Azure subscription already, [create one for free now](https://azure.microsoft.com/free).

> [!IMPORTANT]
> You need an Azure subscription with either the **Owner** role or a combination of **Contributor** and **User Access Administrator** roles. You can check your access level by navigating to your subscription on the Azure portal, selecting **Access control (IAM)** on the left-hand side of the Azure portal, and then selecting **View my access**. For more information see how to [manage Azure resource groups by using the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

1. In another browser tab, navigate to the [Azure Cloud Shell](https://ms.portal.azure.com/#cloudshell/).

1. Run the following commands in the Cloud Shell to set up your session and create a resource group to use for this unit. Replace the value of `<your-Azure-subscription-ID>` with your Azure subscription ID value.

    ```azurecli
    resourcegroup="aksedge-training"
    az account set --subscription "<your-Azure-subscription-ID>"
    az group create --name $resourcegroup --location westus3
    ```
<!-- TODO: Try with: az ad sp create-for-rbac --name $serviceprincipalname --role "Microsoft.Kubernetes connected cluster role" --scopes /subscriptions/$(az account show --query id -o tsv)/resourceGroups/$resourcegroup -->
1. Create a new Service Principal with the built-in **Owner** role and restricted to the resource group scope. This service principal is used to connect to Azure Arc. Use the [az ad sp create-for-rbac](/cli/azure/ad/sp#az-ad-sp-create-for-rbac) command:

    ```azurecli
    resourcegroup="aksedge-training"
    serviceprincipalname="aksedge-sp"
    az ad sp create-for-rbac --name $serviceprincipalname --role "Owner" --scopes /subscriptions/$(az account show --query id -o tsv)/resourceGroups/$resourcegroup
    ```

    > [!NOTE]
    > Take a note of the `Service Principal ID` and `Service Principal Password`. You will need it later.

1. Enable all required resource providers in the Azure subscription using the [az provider register](/cli/azure/provider#az-provider-register) command:

    ```azurecli
    az provider register --namespace Microsoft.HybridCompute
    az provider register --namespace Microsoft.GuestConfiguration
    az provider register --namespace Microsoft.HybridConnectivity
    az provider register --namespace Microsoft.Kubernetes
    az provider register --namespace Microsoft.KubernetesConfiguration
    az provider register --namespace Microsoft.ExtendedLocation
    ```

## Create an Azure VM with Windows 11 Enterprise

Let's create the Azure VM with Windows 11 Enterprise using Azure Cloud Shell.

1. Execute the following command in the Cloud Shell to set the variables for creating the Azure VM:

    ```azurecli
    resourcegroup="aksedge-training"
    location="westus3"
    vmname="myVM"
    username="azureuser"
    let "randomIdentifier=$RANDOM*$RANDOM"
    adminpassword="Admin-$randomIdentifier-Password!"

    echo Admin Password: $adminpassword
    echo Subscription Name: $(az account show --query name -o tsv)
    echo Subscription ID: $(az account show --query id -o tsv)
    echo Tenant ID: $(az account show --query tenantId -o tsv)
    echo Resource Group Name: $resourcegroup
    ```

    > [!NOTE]
    > Take a note of the `Admin Password`, `Subscription Name`, `Subscription ID`, `Tenant ID` and `Resource Group Name`. You will need it later.

1. Create the Azure VM with Windows 11 Enterprise using the [az vm create](/cli/azure/vm#az-vm-create) command:

    ```azurecli
    az vm create \
        --resource-group $resourcegroup \
        --name $vmname \
        --image MicrosoftVisualStudio:windowsplustools:base-win11-gen2:latest \
        --public-ip-sku Standard \
        --admin-username $username \
        --admin-password $adminpassword \
        --size Standard_D2s_v5 \
        --security-type TrustedLaunch
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

1. Run the PowerShell [Get-AzRemoteDesktopFile](/powershell/module/az.compute/get-azremotedesktopfile) cmdlet to get the RDP file to connect to the VM:

    ```azurecli
    publicIp=$(az vm show -d -g $resourcegroup -n $vmname --query publicIps -o tsv)
    echo full address:s:$publicIp > ./myvm.rdp
    echo username:s:$username >> ./myvm.rdp
    ```

1. Download the RDP file to your local machine.

    ```azurecli
    download myvm.rdp
    ```

1. Open the RDP file and connect to the VM using *azureuser* as the **user**, and the `Admin Password` you took a note earlier, as the **password**.

> [!TIP]
> When logging in for the first time to the Windows 11 Enterprise Azure VM, you can accept all options by clicking **Next** and **Accept**.

## Deploy and Arc-enable AKS Edge Essentials

Now that the VM is created, let's run the `AksEdgeQuickStart-v2.ps1` PowerShell script for easy deployment of AKS Edge Essentials and connect it to Azure Arc.

> [!NOTE]
> The following commands are executed in the PowerShell command line of the VM.

1. Open the PowerShell command line by clicking on the **Start** menu and typing **PowerShell**. Then run the following command to change the working directory to `C:\aksedgeLearn`.

    ```powershell
    if (!(Test-Path -Path "C:\aksedgeLearn")) {
        New-Item -ItemType Directory -Path "C:\aksedgeLearn" | Out-Null
    }
    Push-Location "C:\aksedgeLearn"
    ```

1. Download Aks Edge Essentials K3s installer.

    ```azurecli
    curl -L -o AksEdge-Learn.msi "https://aka.ms/aks-edge/k3s-msi"
    ```

1. Set the parameters to create a single machine K3S cluster with a Linux node. The `aideuser-config.json` and `aksedge-config.json` files are used to run the `AksEdgeQuickStart-v2.ps1` PowerShell script. Replace the values of `[SUBSCRIPTION_NAME]`, `[SUBSCRIPTION_ID]` , `[TENANT_ID]`, `[RESOURCE_GROUP_NAME]`, `[SERVICE_PRINCIPAL_ID]` and `[SERVICE_PRINCIPAL_PASSWORD]` with the values you took a note earlier.

    ```powershell
    $aideuserConfig = @"
    {
        "SchemaVersion": "1.1",
        "Version": "1.0",
        "AksEdgeProduct": "AKS Edge Essentials - K3s",
        "AksEdgeProductUrl": "C:\\aksedgeLearn\\AksEdge-Learn.msi",
        "Azure": {
            "SubscriptionName": "[SUBSCRIPTION_NAME]",
            "SubscriptionId": "[SUBSCRIPTION_ID]",
            "TenantId": "[TENANT_ID]",
            "ResourceGroupName": "[RESOURCE_GROUP_NAME]",
            "ServicePrincipalName": "aksedge-sp",
            "Location": "westus3",
            "CustomLocationOID":"",
            "Auth":{
                "ServicePrincipalId":"[SERVICE_PRINCIPAL_ID]",
                "Password":"[SERVICE_PRINCIPAL_PASSWORD]"
            }
        },
        "AksEdgeConfigFile": "aksedge-config.json"
    }
    "@

    echo $aideuserConfig | Out-File -FilePath "aideuser-config.json"

    $aksedgeConfig = @"
    {
        "SchemaVersion": "1.9",
        "Version": "1.0",
        "DeploymentType": "SingleMachineCluster",
        "Init": {
            "ServiceIPRangeSize": 10
        },
        "Network": {
            "NetworkPlugin": "flannel",
            "InternetDisabled": false
        },
        "User": {
            "AcceptEula": true,
            "AcceptOptionalTelemetry": true
        },
        "Machines": [
            {
                "LinuxNode": {
                    "CpuCount": 2,
                    "MemoryInMB": 4096,
                    "DataSizeInGB": 20
                }
            }
        ]
    }
    "@

    echo $aksedgeConfig | Out-File -FilePath "aksedge-config.json"
    ```

1. Download and run the `AksEdgeQuickStart-v2.ps1` PowerShell script.

    ```powershell
    $url = "https://raw.githubusercontent.com/Azure/AKS-Edge/main/tools/scripts/AksEdgeQuickStart/AksEdgeQuickStart-v2.ps1"
    Invoke-WebRequest -Uri $url -OutFile .\AksEdgeQuickStart-v2.ps1
    Unblock-File .\AksEdgeQuickStart-v2.ps1
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

    .\AksEdgeQuickStart-v2.ps1 -AideUserConfigFilePath .\aideuser-config.json -AksEdgeConfigFilePath .\aksedge-config.json
    ```
    <!-- TODO: How many minutes it takes? -->
    > [!NOTE]
    > The installation process takes around 30 minutes to complete.

    This script automates the following steps:

    - In the VM working folder `C:\aksedgeLearn`, the script downloads the GitHub archive of [Azure/AKS-Edge](https://github.com/Azure/AKS-Edge) and unzips to a folder **AKS-Edge-main**.
    - Invokes the `Start-AideWorkflow` function that performs the following tasks:
      - Installs the AKS Edge Essentials MSI.
      - Installs required host OS features (`Install-AksEdgeHostFeatures`).
      - Deploys a single machine K3S cluster with a Linux node.
    - Invokes the `Connect-AideArc` function that performs the following tasks:
      - Installs the Azure Connected Machine Agent and connects the host machine to Arc for Servers.
      - Connects the deployed cluster to Arc for connected Kubernetes.

    The following example with the last lines of the output, shows the download and installation of AKS Edge Essentials K3s distribution was successful. You can also access the log file at `C:\aksedgeLearn\aksedgedlog-yymmdd-hhmm.txt`
    <!-- TODO: CHeck the output. With Arc Enable it may be different -->
    ```powersell
    ...
    [01/04/2024 15:29:34]
    Waiting for Windows node IP address...
    
    [01/04/2024 15:29:34]
    Testing Windows node control channel...
    
    [01/04/2024 15:29:37]
    ...successfully connected to the Windows node
    
    [01/04/2024 15:31:39]
    Waiting for Windows node to transition to ready state (796 seconds remaining)
    - Waiting for Kubernetes node (myvm-wedge) to reach condition Ready, time remaining = 796 seconds
    - Kubernetes node (myvm-wedge) reached condition Ready
    
    [01/04/2024 15:31:57]
    AksEdge - copying Kubeconfig into the host.
    
    [01/04/2024 15:32:02]
    AksEdge - new deployment successfully created.

    * AksEdge VM deployment successfull.
    Deployment Successful.
    Step 4: Connect to Arc
    >> skipping step 4
    Duration: 0 hrs 23 mins 13 seconds
    ```

<!-- TODO: Add new screenshot here -->

<!-- TODO: Will we wait and check ARC or continue? -->
> [!TIP]
> Since the installation process takes around 30 minutes to complete, you can continue to the next learning unit, we will get back to this later.

1. Confirm that the deployment was successful by running the following command:

    ```powershell
    kubectl get nodes -o wide
    kubectl get pods -A -o wide
    ```

    The following example screenshot shows the Linux node is ready and the pods are running:

    <!-- TODO: Add new screenshot here -->

## View your cluster in Azure Portal

1. You can view your cluster in the Azure portal if you navigate to `aksedge-training` resource group and then select the `myVM-k3s` **Kubernetes - Azure Arc** resource.

1. On the left panel, select the **Namespaces** option, under **Kubernetes resources (preview)**:

    :::image type="content" source="../media/3-aks-edge-kubernetes-azure-arc-resource-inline.png" alt-text="Screenshot of AKS Edge Essentials Kubernetes Azure Arc resource in Azure Portal." lightbox="../media/3-aks-edge-kubernetes-azure-arc-resource-expanded.png":::

1. You will need to sign in using a bearer token to view the Kubernetes resources. To get the token, run the following command in the PowerShell command line of the VM:

    ```powershell
    Get-AksEdgeManagedServiceToken
    ```

1. Now you can view resources on your cluster. The **Workloads** shows the pods running on your cluster.

    :::image type="content" source="../media/3-aks-edge-kubernetes-azure-arc-workloads-inline.png" alt-text="Screenshot of AKS Edge Essentials Kubernetes Azure Arc workloads in Azure Portal." lightbox="../media/3-aks-edge-kubernetes-azure-arc-workloads-expanded.png":::