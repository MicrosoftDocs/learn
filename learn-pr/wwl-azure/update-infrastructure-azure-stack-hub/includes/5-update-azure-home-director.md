After installing updates or hotfixes to Azure Stack, new features may be introduced which require new permissions to be granted to one or more identity applications. Granting these permissions requires administrative access to the home directory, so it cannot be done automatically.

## Download Azure Stack tools

The Azure Stack tools GitHub repository contains PowerShell modules that support Azure Stack functionality, including updating permissions on Microsoft Entra ID. During the registration process, you must import and use the **AzureStack.Connect** and **AzureStack.Identity** PowerShell modules, found in the Azure Stack tools repository, to update the permissions on Microsoft Entra ID for the Azure Stack Hub stamp.

To ensure that you are using the latest version, delete any existing versions of the Azure Stack tools, then [download the latest version from GitHub](/azure-stack/operator/azure-stack-powershell-download) before proceeding.

<a name='updating-azure-ad-tenant-permissions'></a>

## Updating Microsoft Entra tenant permissions

You should now be able to update the permissions, which should clear the alert. Run the following commands from the **Azurestack-tools-master/identity** folder:

```
Import-Module ..\Connect\AzureStack.Connect.psm1
Import-Module ..\Identity\AzureStack.Identity.psm1

$adminResourceManagerEndpoint = "https://adminmanagement.<region>.<domain>"

# This is the primary tenant Azure Stack is registered to:
$homeDirectoryTenantName = "<homeDirectoryTenant>.onmicrosoft.com"

Update-AzsHomeDirectoryTenant -AdminResourceManagerEndpoint $adminResourceManagerEndpoint `
  -DirectoryTenantName $homeDirectoryTenantName -Verbose

```

The script prompts you for administrative credentials on the Microsoft Entra tenant, and takes several minutes to run. The alert should clear after you have run the cmdlet.
