## Deploy Azure Key Vault

> [!NOTE]
> Due to limitations with the sandbox, here you create a key vault in Azure Key Vault from the Azure portal. Normally, you would use the `New-AzKeyVault` cmdlet to create a key vault from Azure PowerShell.

Create a key vault and allow deploy time access. To do so:

1. Create a PowerShell variable that holds the key vault name:

   ```powershell
   $KVNAME="tailwind-secrets" + (Get-Random -Count 1 -Maximum 9999999)
   ```

1. Run `$KVNAME` to print its value:

    ```powershell
    $KVNAME
    ```

    Your output resembles this (the number you see will be different):

    ```output
    tailwind-secrets5978564
    ```

    Copy the value somewhere convenient for the next step.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) by using the same account you activated the sandbox with.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**.

1. In the search box, enter _Key Vault_.

1. Select **Key Vault** from the list, and select **Create** to start configuring the key vault.

1. In the creation pane, specify these values:

    1. **Resource group**: <rgn>resource group name</rgn>.
    1. **Key vault name**: Your value of `$KVNAME`, for example, *tailwind-secrets5978564*.

1. Select **Review + create**.

1. Select **Create**. This should take a minute or so. When the resource has been created, select **Go to resource**.

1. Select **Access Policies**. Enable the option **Azure Resource Manager for template deployment**, and select **Save**.

1. From your PowerShell session, run the `ConvertTo-SecureString` cmdlet and assign the result to the `secretSecureString` variable:

   ```powershell
   $secretSecureString = ConvertTo-SecureString 'insecurepassword123!' -AsPlainText -Force
   ```

1. Run the following `Set-AzKeyVaultSecret` command to create a secret in the key vault. The secret is named `vmPassword`, with the value `insecurepassword123!`:

   ```powershell
   $secret = Set-AzKeyVaultSecret -VaultName $KVNAME -Name vmPassword -SecretValue $secretSecureString
   ```

## Create the parameter file

Here, you create a parameter file that contains the VM's name, the administrator username, and a reference to the VM password in the key vault.

You can pass parameters to templates from the command line. Recall that a parameter file is an alternative way to pass parameters to your ARM template during deployment. A parameter file enables you to access key vault secrets from your template.

1. Run the following `Get-AzKeyVault` command to print your key vault ID:

    ```powershell
    Get-AzKeyVault -VaultName $KVNAME | Select-Object -ExpandProperty ResourceId
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

1. Run the following command `New-AzResourceGroupDeployment`:

   ```powershell
   New-AzResourceGroupDeployment `
     -TemplateFile "./azuredeploy.json" `
     -TemplateParameterFile "./azuredeploy.parameters.json" `
     -dnsLabelPrefix ("vm2-" + (Get-Random -Count 1 -Maximum 9999999))
   ```

   In the previous exercise, you provided each key-value pair directly from the command line. Here, you specify `"./azuredeploy.parameters.json"` to provide your parameters file.

   The `dnsLabelPrefix` is set to `vm2-` followed by a random number. This is required to ensure that the DNS name differs from the DNS name you used in the previous exercise.

## Verify deployment

Verify that the VM is provisioned and is connectable over SSH. To do so:

1. Run the `Invoke-Expression` command to connect to the VM via SSH:

   ```powershell
   Invoke-Expression (Get-AzResourceGroupDeployment -Name azuredeploy -ResourceGroupName <rgn>your resource group</rgn>).outputs.sshCommand.value
   ```

   When prompted, enter `yes` to continue connecting. Then enter the administrator password, `insecurepassword123!`.

    > [!IMPORTANT]
    > In practice, keep passwords safe. You can also use public key authentication, which is typically more secure than using passwords.

1. From your SSH connection to the VM, run `hostname` to print the VM's hostname:

    ```bash
    hostname
    ```

    You see the VM's internal hostname, `vm1`:

    ```output
    vm2
    ```

1. Run `exit` to leave your SSH session.

    ```bash
    exit
    ```

Nice work! You've extended your deployment to include a parameters file that reads secret information from Key Vault.
