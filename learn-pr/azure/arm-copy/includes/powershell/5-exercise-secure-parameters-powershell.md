## Exercise overview

Here's an overview of the steps you are about to carry out:

> [!NOTE]
> If you already have a working Sandbox where you've done steps 1-3, then there's no need to repeat them.

1. **Sign in to Azure**. You will be able to sign in using Visual Studio Code and using the integrated terminal.

1. **Set the active subscription**. This task can be accomplished by invoking a PowerShell cmdlet.

1. **Set default resource group**. Also this task can be carried out by invoking a PowerShell cmdlet. The reason for setting these default values on subscription and resource group is to ensure the resources are created in the correct place.

1. **Carry out the deployment**. This step involves using the cmdlet **New-AzResourceGroupDeployment** with a URL to a template as an argument.

## Deploy a Key Vault

You need to both deploy the Key Vault and once created you will need to add a secret.

1. Run the command `New-AzKeyVault`:

    ```powershell
    $rg = <rgn>name of resource group</rgn>
    $vaultName = Read-Host -Prompt "Enter a vault name"
    $location = Read-Host -Prompt "Enter a location"

    New-AzKeyVault `
      -VaultName $vaultName `
      -resourceGroupName $rg `
      -Location $location `
      -EnabledForTemplateDeployment
    ```

    The above command will create a Key Vault. The usage of the flag `-EnabledForTemplateDeployment` ensures it the Key Vault can be read from, from an ARM template.

1. Run the command `Set-AzKeyVaultSecret`

   ```powershell
   $secretPlainText = 'insecurepassword123!'
   $secretName = vmPassword

   $secretSecureString = ConvertTo-SecureString $secretPlainText -AsPlainText -Force
   $secret = Set-AzKeyVaultSecret -VaultName ExampleVault -Name $vmPassword -SecretValue $secretSecureString
   ```

   The above command ensures the plain text password is converted to a secure string.

   > [!NOTE]
   >  You should avoid using plain text in script or the command line, as this can show up in event logs and command history logs. The secure string construct helps address this situation by constructing a type that's encrypted and not possible to print (it would only print its type rather than its value). It's even deleted from memory after it's been used.

   Thereafter the name of the secret and the now encoded secret value  is being added to the Key Vault you've just created.

   Everything should be set up at this point so you can deploy the VM next.  

1. Run the command `Get-AzKeyVaultSecret`:

   ```powershell
   (Get-AzKeyVaultSecret -vaultName $vaultName  -name $secretName).SecretValueText
   ```

   Ensure the returned value corresponds to the value of parameter `$secretSecureString`.

## Deploy a VM and set password based on a Key Vault secret

1. Run `wget` to fetch the following ARM template:

   `wget https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-windows/azuredeploy.json` 

   and store it locally as a file `vmdeploy.json`.

1. Run the command `Get-AzKeyVault`:

   ```powershell
   Get-AzKeyVault -VaultName $vaultName
   ```

   Make a note of the value from the field `Resource ID`. You will need this value to modify the file `vmdeploy.json`.

1. Run `wget` to save save down the following parameter file:

   `wget https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-windows/azuredeploy.parameters.json`

   and name it `vmdeploy.parameters.json`

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

1. Run the command `New-AzResourceGroupDeployment`:

   ```powershell
   New-AzResourceGroupDeployment `
    -ResourceGroupName $rg `
    -TemplateFile "./vmdeploy.json" `
    -TemplateParameterFile "./vmdeploy.parameters.json"
   ```

   The above command will deploy the VM while reading parameter values from the parameter file.

### Verify deployment

1. Go to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. Select **Resource groups** > **\<rgn>your resource group\</rgn>** > **simple-vm**.
1. Select **Connect** at the top.

1. Select **Download RDP File**, and then follow the instructions to sign in to the virtual machine by using the password that's stored in the Key Vault.

Congratulations, you've managed to deploy an Azure Key Vault. Additionally you've managed to create a VM while reading from the Azure Key Vault.
