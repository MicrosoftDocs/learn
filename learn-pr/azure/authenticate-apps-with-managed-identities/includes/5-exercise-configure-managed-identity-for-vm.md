The VM you use to host your app has been deployed in Azure. You now need to enable a managed identity in the company's Azure subscription. The idea is to allow your stock-tracking app access to the Azure resources it needs.

In this unit, you'll create a system-assigned managed identity for your virtual machine, and see how to access Azure resources from inside it.

### Set up the environment

1. Create an Azure Key Vault to store your company's private data. Every Azure Key Vault name needs to be globally unique.

    ```azurecli
    export VMNAME=prodserver
    export KVNAME=furniture-secrets$RANDOM

    az keyvault create --name $KVNAME \
        --resource-group <rgn>[Sandbox resource group]</rgn> \
        --default-action Allow \
        --location $(az resource list --o tsv --query [0].location) \
        --sku standard
    ```

1. Create a VM to host your company's app, and store the public IP address in an environment variable.

    ```azurecli
    export publicIP=$(az vm create \
        --name $VMNAME \
        --resource-group <rgn>[Sandbox resource group]</rgn> \
        --image UbuntuLTS \
        --generate-ssh-keys \
        --output tsv \
        --query "publicIpAddress")
    ```

    > [!NOTE]
    > Creating the VM can take a couple of minutes to complete.

### Configure a system-assigned managed identity for an Azure VM

1. Assign a system-managed identity to the VM.

    ```azurecli
    az vm identity assign \
      --name $VMNAME \
      --resource-group <rgn>[Sandbox resource group]</rgn>
    ```

    This command should return a similar response showing the managed identity:

    ```json
    {
        "systemAssignedIdentity": "a78ddd60-183b-4e27-9f0d-c11a11c417d8",
        "userAssignedIdentities": {}
    }
    ```

### Use your Key Vault to store a secret

1. Add your connection string to the key vault:

    ```azurecli
    az keyvault secret set \
      --vault-name $KVNAME \
      --name DBCredentials \
      --value "Server=tcp:prodserverSQL.database.windows.net,1433;Database=myDataBase;User ID=mylogin@myserver;Password=examplePassword;Trusted_Connection=False;Encrypt=True;"
    ```

1. Make a note of your key vault name:

    ```bash
    echo $KVNAME
    ```

### Set up the VM for your company's stock-tracking app

1. SSH into your VM.

    ```bash
    ssh $publicIP
    ```

    At the prompt, type **yes**.

1. Install .NET Core on the VM, for the next exercise.

    ```bash
    wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    sudo add-apt-repository universe
    sudo apt-get update
    sudo apt-get install apt-transport-https
    sudo apt-get update
    sudo apt-get install dotnet-sdk-3.1

    ```

1. Run the following command to download the source code for the sample app for this module:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-authenticate-apps-with-managed-identities identity
    ```

1. Finally, you need to exit the SSH session:
    ```bash
    exit
    ```
