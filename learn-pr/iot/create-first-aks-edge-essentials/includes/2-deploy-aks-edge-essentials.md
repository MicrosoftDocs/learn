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

1. Create the Azure VM with Windows 11 Enterprise using the [az vm create](/cli/azure/vm#az-vm-create) command.

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

Now that the VM is created, let's prepare the machine for AKS Edge Essentials and run a PowerShell script by using [Run Command](/azure/virtual-machines/run-command-overview) and Azure CLI. Alternatively you could connect from your local machine via Remote Desktop Connection (RDP), download and run the PowerShell script there.

1. Execute the following command in the Azure Cloud Shell to create a `aksee` folder and navigate to it:

    ```azurecli
    mkdir ~/aksee
    cd ~/aksee
    ```

<!-- TODO: Publish Script to main! -->
1. Execute the following command in the Cloud Shell to download `AksEdgeQuickStartForLearn.ps1` in your `aksee` folder:

    ```azurecli
    wget https://raw.githubusercontent.com/asergaz/AKS-Edge/learnmodule/tools/scripts/AksEdgeQuickStart/AksEdgeQuickStartForLearn.ps1
    ```

1. Run the Azure CLI [az vm run-command create](/cli/azure/vm/run-command#az-vm-run-command-create) command to deliver the Powershell script to the VM and execute it:

    ```azurecli
    az vm run-command create --no-wait --name "deployAKSEE" --vm-name myVM --resource-group <rgn>[sandbox resource group name]</rgn> --script @AksEdgeQuickStartForLearn.ps1
    ```

    > [!NOTE]
    > The installation process takes a few minutes to complete.

    This script automates the following steps:

    - In the VM working folder `C:\akseeLearn`, the script downloads the GitHub archive of [Azure/AKS-Edge](https://github.com/Azure/AKS-Edge) and unzips to a folder **AKS-Edge-main**.
    - Invokes the `Start-AideWorkflow` function that performs the following tasks:
      - Downloads and installs the AKS Edge Essentials MSI.
      - Installs required host OS features (`Install-AksEdgeHostFeatures`).
      - Deploys a single machine K3S cluster with a Linux and Windows node.

1. Run the Azure CLI [az vm run-command show](/cli/azure/vm/run-command#az-vm-run-command-show) command to retrieve the output of the PowerShell script you executed in the VM:

    ```azurecli
    az vm run-command show --name "deployAKSEE" --vm-name "myVM" --resource-group <rgn>[sandbox resource group name]</rgn> --instance-view | jq .instanceView.output | sed 's/\\n/\n/g'
    ```

    The following example output shows the download and installation of AKS Edge Essentials K3s distribution was successful:
    <!-- TODO: Add output example -->
    ```output
    NEED OUTPUT
    ```

    > [!NOTE]
    > If the output shows **null** or looks incomplete, run the command again.