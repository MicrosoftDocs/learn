Here you will deploy a KeyVault, add a secret and then deploy a VM reading a secret from the KeyVault.

## Prerequisites

Before installing the required PowerShell module, make sure you have PowerShell Core (6.x or 7.x)

- **Upgrade to/Install latest PowerShell**. If you have Windows PowerShell 5.x or earlier or PowerShell Core 6.2.3 or earlier, [install the latest version of PowerShell](https://docs.microsoft.com/powershell/azure/install-az-ps?view=azps-4.4.0&azure-portal=true) You can't install the required module on Windows PowerShell 5.x or earlier.

- **Install the Az Module**. To use *what-if* in PowerShell, you must have version **4.2 or later of the Az module**.

## Verify installation

Run `$PSVersionTable.PSVersion` to verify the PowerShell version:

```powershell
$PSVersionTable.PSVersion
```

You should see a similar output:

```powershell
Major  Minor  Build  Revision PSSemVerPreReleaseLabel    PSSemVerBuildLabel
7      1      0      -1       preview.5

>
```

## Install or update module

There are potentially two different paths here:

> [!NOTE]
> In order to avoid using PowerShell in an *elevated mode* you can use the argument `-Scope CurrentUser` to install or update modules on your user.

- **You DON'T have the module installed previously**. Install this module use the following command:

   ```powershell
   Install-Module -Name Az -Force -Scope CurrentUser
   ```

- **You need to update a pre-existing module**. If you have an older version of the **Az Module**, and need to update it, use the following command:

   ```powershell
   Update-Module -Name Az -Scope CurrentUser
   ```

## Exercise overview

Here's an overview of the steps you are about to carry out:

- **Sign in to Azure**. You will be able to sign in using Visual Studio Code and using the integrated terminal.
- **Set the active subscription**. This task can be accomplished by invoking a PowerShell cmdlet.
- **Set default resource group**. Also this task can be carried out by invoking a PowerShell cmdlet. The reason for setting these default values on subscription and resource group is to ensure the resources are created in the correct place.
- **Carry out the deployment**. This step involves using the cmdlet **New-AzResourceGroupDeployment** with a URL to a template as an argument.

## Sign in to Azure

You can sign into your Azure account from the terminal. If you are on Windows, the terminal will default to PowerShell. On other OSs, you can use the command line executable `pwsh` to launch a PowerShell shell from the terminal.

1. Open the integrated terminal in Visual Studio Code. Be sure you are signing in to the same account that activated the sandbox.

   > [!IMPORTANT]
   > If you have a non-Windows OS, type `pwsh` to ensure the PowerShell shell is running.

1. Run `Connect-AzAccount` to sign in to your account.

    ```powershell
    Connect-AzAccount
    ```

    (it will open a browser that allows you to sign in to your account)

   Once you are logged in, you see a list, in JSON format. The list contains subscriptions associated with this account in the terminal, if you activated the sandbox.

## Set the active subscription

The command you are about to run will list your subscriptions and their IDs. The subscription ID is the second column.

1. Run `Get-AzSubscription` to get a hold of the subscription ID for the Concierge Subscription.

    ```powershell
    Get-AzSubscription
    ```

    Look for Concierge Subscription and copy the second column. It will look something like *cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0*.

1. Run `Set-AzContext` to change your active subscription to the Concierge Subscription.

   > [!NOTE]
   > Be sure to substitute *{Your subscription ID}* with the ID of the Concierge Subscription you just got in the last command.

    ```powershell
    $subscription = Get-AzSubscription -SubscriptionId {Your subscription ID}
    Set-AzContext $subscription
    ```

### Set default resource group

You need to set the resource group created for you in the sandbox as the default resource group. You will accomplish this task in two steps:

   1. Run `Get-AzResourceGroup` to get the resource group name.

      ```powershell
      Get-AzResourceGroup
      ```

   1. Run `Set-AzDefault` to set the default Resource Group.

      ```powershell
      Set-AzDefault -ResourceGroupName <rgn>resource group name</rgn>
      ```

       Use the name of the resource name provided by the last command in this command. (It will look like something like **learn-a73131a1-b618-48b8-af70-21af7ca420c4**).

      > [!NOTE]
      > Normally, when you use a PowerShell or an Azure CLI command to deploy a template you need to specify the target **resource group** name.  In the exercise in this module we are bypassing this requirement by setting the context of our deployment by specifying our sandbox resource group name in the step below by using the **[Set-AzDefault](https://docs.microsoft.com/powershell/module/az.accounts/set-azdefault?view=azps-4.5.0)** PowerShell command.

## Deploy a KeyVault

You need to both deploy the KeyVault and once created you will need to add a secret.

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

    The above command will create a KeyVault. The usage of the flag `-EnabledForTemplateDeployment` ensures it the KeyVault can be read from, from an ARM template.

1. Run the command `Set-AzKeyVaultSecret`

   ```powershell
   $secretPlainText = abc123!
   $secretName = vmPassword

   $secretSecureString = ConvertTo-SecureString $secretPlainText -AsPlainText -Force
   $secret = Set-AzKeyVaultSecret -VaultName ExampleVault -Name $vmPassword -SecretValue $secretSecureString
   ```

   The above command ensures the plain text password is converted to a so called secure string. Thereafter the name of the secret and the now encoded secret value  is being added to the KeyVault you've just created.

   Everything should be set up at this point so you can deploy the VM next.  

1. Run the command `Get-AzKeyVaultSecret`:

   ```powershell
   (Get-AzKeyVaultSecret -vaultName $vaultName  -name $secretName).SecretValueText
   ```

   Ensure the returned value corresponds to the value of parameter `$secretSecureString`.

## Deploy a VM and set password based on a KeyVault secret

1. Fetch the following ARM template from the URL `https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-windows/azuredeploy.json` and store it locally as a file `vmdeploy.json`.

1. Run the command `Get-AzKeyVault`:

   ```powershell
   Get-AzKeyVault -VaultName $vaultName
   ```

   Make a note of the value from the field `Resource ID`. You will need this value to modify the file `vmdeploy.json`.

1. Save down the following file `https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-windows/azuredeploy.parameters.json` and name it `vmdeploy.parameters.json`

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

   The `id` parameter's value needs to be replaced with the `Resource ID` of the KeyVault you were asked to note down.

1. Run the command `New-AzResourceGroupDeployment`:

   ```powershell
   New-AzResourceGroupDeployment `
    -ResourceGroupName $rg `
    -TemplateFile "./vmdeploy.json" `
    -TemplateParameterFile "./vmdeploy.parameters.json"
   ```

### Verify deployment

1. Navigate to portal.azure.com
1. Select Resource groups > **\<rgn>your resource group\</rgn>** > simple-vm.
1. Select connect at the top.

1. Select Download RDP File, and then follow the instructions to sign in to the virtual machine by using the password that's stored in the key vault.

Congrats, you've managed to deploy an Azure KeyVault. Additionally you've managed to create a VM while reading from the Azure KeyVault.


