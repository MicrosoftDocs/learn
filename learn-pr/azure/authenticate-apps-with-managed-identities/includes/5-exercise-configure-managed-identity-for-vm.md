The VM you use to host your app has been deployed in Azure. You now need to enable a managed identity in the company's Azure subscription, with the view to allowing your stock-tracking app access to the Azure resources it needs.

In the unit, you'll configure a managed identity on your virtual machine. You'll create a system-assigned managed identity for the VM, and see how to access Azure resources from inside the VM.

## Set up the enivironment

1. Create a VM to host your companies app, and store the public IP address in an environment variable.

    ```azurecli
    export vmname=prodserver

    export publicIP=$(az vm create \
        --name $vmname \
        --resource-group <rgn>[Sandbox resource group]</rgn> \
        --image UbuntuLTS \
        --generate-ssh-keys \
        --output tsv \
        --query "publicIpAddress")
    ```

    > [!NOTE]
    > This process can take a couple of minutes to complete

1. Create an Azure Key Vault to store your companies private data.

    ```azurecli
    az keyvault create --name furniture-secrets \
        --resource-group <rgn>[Sandbox resource group]</rgn> \
        --default-action Allow \
        --location $(az resource list --o tsv --query [0].location) \
        --sku standard
    ```

## Configure a system-assigned managed identity for an Azure VM

1. Assign a system-managed identity to the VM.

    ```azurecli
    az vm identity assign \
      --name $vmname \
      --resource-group <rgn>[Sandbox resource group]</rgn>
    ```

    This command should return a response similar showing the managed identity:

    ```json
    {
        "systemAssignedIdentity": "a78ddd60-183b-4e27-9f0d-c11a11c417d8",
        "userAssignedIdentities": {}
    }
    ```

## Check the system-managed identity for the VM has access to the key vault

1. SSH into your VM.

    ```bash
    ssh $publicIP
    ```

1. Request an access token from the created key vault.

    ```bash
    curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net' -H Metadata:true
    ```

    Azure Key Vault should return an access token.

    ```json
    {
        "access_token":"eyJ0eXAiOiJKV1QiLC...",
        "refresh_token":"",
        "expires_in":"4198",
        "expires_on":"1559742260",
        "not_before":"1559738062",
        "resource":"https://vault.azure.net",
        "token_type":"Bearer"
    }
    ```

1. In the VM, for the next exercise install the .NET Core.

    ```bash
    sudo snap install dotnet-sdk --classic
    ```

1. Run the following command to download the source code for the sample app for this module.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-authenticate-apps-with-managed-identities identity
    ```

1. Lastly, you need to exit the SSH session:
    ```bash
    exit
    ```