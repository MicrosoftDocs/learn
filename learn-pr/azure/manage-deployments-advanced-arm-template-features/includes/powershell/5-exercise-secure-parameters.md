## Deploy a Key Vault

> [!NOTE]
> Due to limitations with the sandbox, here you create an Azure Key Vault from the Azure portal. Normally, you would use the `New-AzKeyVault` cmdlet to create a Key Vault from Azure PowerShell.

Create a Key Vault and allow deploy time access. To do so:

1. Create a PowerShell variable that holds the Key Vault name:

   ```powershell
   $KVNAME="tailwind-secrets" + (Get-Random -Count 1 -Maximum 9999999)
   ```

1. Run `$KVNAME` in the terminal and copy the value, you will use it when you create a Key Vault in the Azure Portal next.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**.

1. In the search box, enter _Key Vault_.

1. Select **Key Vault** from the list.

1. Select the **Create** button to start configuring the Key Vault.

1. In the creation pane, paste the value of `$KVNAME`, for the Key Vault name.

1. Select **Review and Create**.

1. Select **Create**. This should take a minute or so. Once the resource has been created, go to the resource blade.

1. To allow access to Key Vault during deployment, ensure you are in the detail page for the resource, then select **Access Policies** from the left menu. Check the option **Azure Resource Manager for template deployment** and select **Save**.

1. Run `pwsh` to start a PowerShell shell in a terminal.

1. Run the `ConvertTo-SecureString` command and assign it to the `secretSecureString` PowerShell variable:

   ```powershell
   $secretSecureString = ConvertTo-SecureString 'insecurepassword123!' -AsPlainText -Force
   ```

1. Run the following `Set-AzKeyVaultSecret` command to create a secret in the key vault named *vmPassword* with the value "insecurepassword123!":

   ```powershell
   $secret = Set-AzKeyVaultSecret -VaultName $KVNAME -Name vmPassword -SecretValue $secretSecureString
   ```

## Create the parameter file

Here, you create a parameter file that contains the VM's name, the administrator username, and a reference to the VM password in the key vault.

Recall that a parameter file is an alternative way to pass parameters to your ARM template during deployment.

1. Run the following `Get-AzKeyVault` command to print your key vault ID:

    ```powershell
    Get-AzKeyVault -VaultName $KVNAME | Select-Object -ExpandProperty ResourceId
    ```

    The output resembles this:

    ```output
    Id
    --
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
     -TemplateParameterFile "./azuredeploy.parameters.json"
     -dnsLabelPrefix ("vm2-" + (Get-Random -Count 1 -Maximum 9999999))
   ```

   In the previous exercise, you provided each key-value pair in the `-TemplateParameterFile` argument. Here, you specify `"./azuredeploy.parameters.json"` to provide your parameters file.

   The `dnsLabelPrefix` is set to "vm2-" followed by a random number. This is required to ensure that the DNS name differs from the DNS name you used in the previous exercise.

## Verify deployment

Verify that the VM is provisioned and is connectable over SSH. To do so:

1. Run the `Invoke-Expression` command to connect to the VM via SSH::

   ```powershell
   Invoke-Expression (Get-AzResourceGroupDeployment -Name azuredeploy -ResourceGroupName <rgn>your resource group</rgn>).outputs.sshCommand.value
   ```

   When prompted, enter *yes* to continue connecting. Then enter the administrator password, *insecurepassword123!*.

    > [!IMPORTANT]
    > In practice, keep passwords safe. Or use public key authentication, which is typically more secure than using passwords.

1. From your SSH connection to the VM, run `hostname` to print the VM's hostname:

    ```bash
    hostname
    ```

    You see the VM's internal hostname, *vm1*:

    ```output
    vm2
    ```

1. Run `exit` to leave your SSH session.

    ```bash
    exit
    ```

Congratulations, you've successfully deployed a Linux VM by using an ARM template. A VM is a common resource type that includes dependent resources.
