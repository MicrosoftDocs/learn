The virtual machine (VM) that hosts your app has been deployed in Azure. You now need to enable a managed identity in the company's Azure subscription. The idea is to allow your stock-tracking app to access the Azure resources that it needs.

In this unit, you'll create a system-assigned managed identity for your VM. You'll see how to access Azure resources from inside the identity.

## Set up the environment

1. Use the following code to create an instance of Azure Key Vault to store your company's private data. Every Azure Key Vault name needs to be globally unique.

    ```azurecli
    export VMNAME=prodserver
    export KVNAME=furniture-secrets$RANDOM

    az keyvault create --name $KVNAME \
        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
        --default-action Allow \
        --location $(az resource list --output tsv --query [0].location) \
        --sku standard
    ```

1. Create a VM to host your company's app. Store the public IP address in an environment variable.

    ```azurecli
    export publicIP=$(az vm create \
        --name $VMNAME \
        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
        --image Ubuntu2204 \
        --generate-ssh-keys \
        --output tsv \
        --query "publicIpAddress")
    ```

    > [!NOTE]
    > Creating the VM can take a few minutes.

## Configure a system-assigned managed identity for an Azure VM

1. Assign a system-assigned managed identity to the VM.

    ```azurecli
    az vm identity assign \
      --name $VMNAME \
      --resource-group "<rgn>[sandbox resource group name]</rgn>"
    ```

    This command should return a response that shows the managed identity. Here's an example  response:

    ```json
    {
        "systemAssignedIdentity": "a78ddd60-183b-4e27-9f0d-c11a11c417d8",
        "userAssignedIdentities": {}
    }
    ```

## Use your key vault to store a secret

1. Add your connection string to the key vault.

    ```azurecli
    az keyvault secret set \
      --vault-name $KVNAME \
      --name DBCredentials \
      --value "Server=tcp:prodserverSQL.database.windows.net,1433;Database=myDataBase;User ID=mylogin@myserver;Password=examplePassword;Trusted_Connection=False;Encrypt=True;"
    ```

1. Make a note of your key vault name.

    ```bash
    echo $KVNAME
    ```

## Set up the VM for your company's stock-tracking app

1. Use SSH to access your VM.

    ```bash
    ssh $publicIP
    ```

    At the prompt, type *yes*.

1. For the next exercise, download and install the .NET Core version on the VM that the module's sample app will use.

    ```bash
    sudo snap install dotnet-sdk --classic --channel=3.1
    ```

    > [!NOTE]
    > Installing the .NET SDK can take a few minutes to complete.

1. Download the source code for this module's sample app.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-authenticate-apps-with-managed-identities identity
    ```

1. End the SSH session.

    ```bash
    exit
    ```
