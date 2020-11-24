Here you will deploy a Key Vault, add a secret and then deploy a VM that reads a secret from said Key Vault.

## Exercise overview

Here's an overview of the steps you are about to carry out:

> [!NOTE]
> If you already have a working Sandbox where you've done steps 1-3, then there's no need to repeat them.

1. **Sign in to Azure**. You will be able to sign in using Visual Studio Code and using the integrated terminal.

2. **Set the active subscription**. This can be accomplished by invoking a Azure CLI command.

3. **Set default resource group**. This can be accomplished by invoking a Azure CLI command. The reason for setting these default values on subscription and resource group is to ensure the resources are created in the correct place.

4. **Carry out the deployment**. This step involves using the command **az deployment group create** with a URL to a template as an argument.

## Deploy Key Vault

You need to both deploy the Key Vault and once created you will need to add a secret.

1. Run the command `az keyvault create`:

    ```azurecli
    KVNAME=tailwind-secrets$RANDOM

    az keyvault create \
      --name $KVNAME \
      --enabled-for-template-deployment true
    ```

    The above command will create a Key Vault. The usage of the flag `-EnabledForTemplateDeployment` ensures it the Key Vault can be read from, from an ARM template.

1. Run the command `az keyvault secret set`:

   ```azurecli
   export secretPlainText=abc123!
   export secretName=vmPassword

   az keyvault secret set --vault-name $vaultName --name $secretName --value $secretPlainText
   ```

   The above command ensures the plain text password is converted to a secure string. Thereafter the name of the secret and the now encoded secret value  is being added to the Key Vault you've just created.

   Everything should be set up at this point so you can deploy the VM next.  

## Deploy a VM and set password based on a Key Vault secret

1. Run `wget` to fetch the following ARM template:

   ```bash
   wget https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-windows/azuredeploy.json
   ```

   and store it locally as a file `vmdeploy.json`.

1. Run the command `az keyvault show`:

   ```azurecli
   az keyvault show --name $vaultName
   ```

   Make a note of the value from the field `Resource ID`. You will need this value to modify the file `vmdeploy.json`.

1. Run `wget` to store the following parameters file:

   `wget https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-windows/azuredeploy.parameters.json`

   name it `vmdeploy.parameters.json`

1. Locate the parameters section in `vmdeploy.parameters.json` and the `adminPassword` parameter. Replace it's content with the following text:

   ```json
   "adminPassword": {
     "reference": {
        "keyVault": {
        "id": "/subscriptions/<SubscriptionID>/resourceGroups/mykeyvaultdeploymentrg/providers/Microsoft.KeyVault/vaults/<KeyVaultName>"
        },
        "secretName": "vmPassword"
     }
   }
   ```

   The `id` parameter's value needs to be replaced with the `Resource ID` of the Key Vault you were asked to note down.

1. Run the command `az deployment group create`:

   ```azurecli
   az deployment group create \
      --resource-group <rgn>resource group name</rgn> \
      --template-file "./vmdeploy.json" \
      --parameters "./vmdeploy.parameters.json"
   ```

### Verify deployment

1. Go to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. Select **Resource groups** > **\<rgn>your resource group\</rgn>** > **simple-vm**.
1. Select **Connect** at the top.

1. Select **Download RDP File**, and then follow the instructions to sign in to the virtual machine by using the password that's stored in the key vault.

Congratulations, you've managed to deploy an Azure Key Vault. Additionally you've managed to create a VM while reading from the Azure Key Vault.
