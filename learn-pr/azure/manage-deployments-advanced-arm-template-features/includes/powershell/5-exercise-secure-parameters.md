## Deploy a Key Vault

Create a Key Vault and add the VM password as a secure secret. To do so:

1. Start a PowerShell session by typing `pwsh` in a terminal.

1. Create a PowerShell variable that holds the Key Vault name:

   ```powershell
   $KVNAME=tailwind-secrets + (Get-Random -Count 1)
   ```

   Key Vault names must be unique. The call to `Get-Random` part ensures that the Key Vault name ends in a random series of numbers.

1. Run the command `New-AzKeyVault`:

    ```powershell
    New-AzKeyVault `
      -VaultName $KVNAME `
      -EnabledForTemplateDeployment
    ```

    The `-EnabledForTemplateDeployment` argument permits the ARM template to retrieve secrets from the key vault.

1 Run the `ConvertTo-SecureString` command and assign it to the `secretSecureString` PowerShell variable:

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
    Get-AzKeyVault -VaultName $KVNAME | Select-Object Id
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
    -dnsLabelPrefix=("vm2-" + (Get-Random -Count 1))
   ```

   In the previous exercise, you provided each key-value pair in the `-TemplateParameterFile` argument. Here, you specify `"./azuredeploy.parameters.json"` to provide your parameters file.

   The `dnsLabelPrefix` is set to "vm2-" followed by a random number. This is required to ensure that the DNS name differs from the DNS name you used in the previous exercise.

## Verify deployment

Verify that the VM is provisioned and is connectable over SSH. To do so:

1. Run the following command PowerShell query:

   ```powershell
   invoke-expression (Get-AzResourceGroupDeployment -Name azuredeploy -ResourceGroupName <rgn>your resource group</rgn>).outputs.sshCommand.value
   ```

   Your output is similar to:

   ```output
   ssh azureuser@simplelinuxvm-a33zb3sc332ue.westus.cloudapp.azure.com
   ```
  
1. Run the SSH command from the previous step:

   ```bash
   ssh azureuser@simplelinuxvm-a33zb3sc332ue.westus.cloudapp.azure.com
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
