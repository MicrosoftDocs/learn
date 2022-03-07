## Deploy Azure Key Vault

In Azure Key Vault, create a key vault and add the VM password as a secure secret. To do so:

1. Create a Bash variable that holds the key vault name.

    ```bash
    KVNAME=tailwind-secrets$RANDOM
    ```

    Key vault names must be unique. The `$RANDOM` part ensures that the key vault name ends in a random series of numbers.

1. Run the following `az keyvault create` command to create the key vault:

    ```azurecli
    az keyvault create \
      --name $KVNAME \
      --enabled-for-template-deployment true
    ```

    The `--enabled-for-template-deployment` argument permits the Azure Resource Manager (ARM) template to retrieve secrets from the key vault.

1. Run the following `az keyvault secret set` command to create a secret in the key vault. The secret is named `vmPassword`, with the value `insecurepassword123!`:

   ```azurecli
   az keyvault secret set \
     --vault-name $KVNAME \
     --name vmPassword \
     --value 'insecurepassword123!'
   ```

## Create the parameter file

Here, you create a parameter file that contains the VM's name, the administrator username, and a reference to the VM password in the key vault.

You can pass parameters to templates from the command line. Recall that a parameter file is an alternative way to pass parameters to your ARM template during deployment. A parameter file enables you to access key vault secrets from your template.

1. Run the following `az keyvault show` command to print your key vault ID:

    ```azurecli
    az keyvault show \
      --name $KVNAME \
      --query id \
      --output tsv
    ```

    The output resembles this:

    ```output
    /subscriptions/7c7df858-93a0-4f38-8990-304c836a4e8d/resourceGroups/<rgn>[resource group name]</rgn>/providers/Microsoft.KeyVault/vaults/tailwind-secrets3020
    ```

    Note the output for the next step.

1. In Visual Studio Code, create a file named *azuredeploy.parameters.json* in the same directory that contains *azuredeploy.json*.
1. Add these contents to *azuredeploy.parameters.json*:

    ```json
    {
      "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
        "adminUsername": {
          "value": "azureuser"
        },
        "vmName": {
          "value": "vm2"
        },
        "adminPasswordOrKey": {
          "reference": {
             "keyVault": {
             "id": ""
             },
             "secretName": "vmPassword"
          }
        }
      }
    }
    ```

1. Replace the value of `id` (the empty string) with the value you copied in the previous step. Then save the file.

## Deploy a Linux VM

Here, you deploy the same ARM template that you deployed in the previous exercise. This time, you provide the parameter file that references the VM password in the key vault.

Run the following `az deployment group create` command to deploy the template:

```azurecli
az deployment group create \
  --template-file azuredeploy.json \
  --parameters @azuredeploy.parameters.json dnsLabelPrefix="vm2-$RANDOM"
```

In the previous exercise, you provided each key-value pair in the `--parameters` argument. Here, you specify `@azuredeploy.parameters.json` to provide your parameters file.

The `dnsLabelPrefix` is set to `vm2-` followed by a random number. This is required to ensure that the DNS name differs from the DNS name you used in the previous exercise.

## Verify the deployment

As you did in the previous exercise, verify that the VM is provisioned and is connectable over SSH. For brevity, this time you'll skip some of the intermediary steps.

1. Run the following to connect to your VM over SSH:

    ```azurecli
    $(az deployment group show \
      --name azuredeploy \
      --query properties.outputs.sshCommand.value \
      --output tsv)
    ```

    When prompted, enter `yes` to continue connecting. Then enter the administrator password, `insecurepassword123!`.

1. From your SSH connection to the VM, run `hostname` to print the VM's hostname:

    ```bash
    hostname
    ```

    You see the VM's internal hostname, `vm2`:

    ```output
    vm2
    ```

1. Run `exit` to leave your SSH session.

    ```bash
    exit
    ```

Nice work! You've extended your deployment to include a parameters file that reads secret information from Key Vault.
