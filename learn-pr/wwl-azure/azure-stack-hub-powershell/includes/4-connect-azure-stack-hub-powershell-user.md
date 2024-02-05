You can connect to Azure Stack Hub with PowerShell to manage Azure Stack Hub resources. For example, you can use PowerShell to subscribe to offers, create virtual machines (virtual machines), and deploy Azure Resource Manager templates.

To get setup:

 -  Make sure you have the requirements.
 -  Connect with Microsoft Entra or Active Directory Federation Services (AD FS).
 -  Register resource providers.
 -  Test your connectivity.

Make sure you replace the script variables with values listed below for your Azure Stack Hub configuration:

 -  **Microsoft Entra tenant name**: The name of your Microsoft Entra tenant used to manage Azure Stack Hub. For example, yourdirectory.onmicrosoft.com.
 -  **Azure Resource Manager endpoint**: For Azure Stack Development kit, this value is set to `https://management.local.azurestack.external`. To get this value for Azure Stack Hub integrated systems, contact your service provider.

<a name='connect-to-azure-stack-hub-with-azure-ad'></a>

### Connect to Azure Stack Hub with Microsoft Entra ID.

```powershell
Add-AzEnvironment -Name "AzureStackUser" -ArmEndpoint "https://management.local.azurestack.external"
# Set your tenant name
$AuthEndpoint = (Get-AzEnvironment -Name "AzureStackUser").ActiveDirectoryAuthority.TrimEnd('/')
$AADTenantName = "<myDirectoryTenantName>.onmicrosoft.com"
$TenantId = (invoke-restmethod "$($AuthEndpoint)/$($AADTenantName)/.well-known/openid-configuration").issuer.TrimEnd('/').Split('/')[-1]
# After signing in to your environment, Azure Stack Hub cmdlets
# can be easily targeted at your Azure Stack Hub instance.
Connect-AzAccount -EnvironmentName "AzureStackUser" -TenantId $TenantId

```

### AzureRM modules

```powershell
Add-AzureRMEnvironment -Name "AzureStackUser" -ArmEndpoint "https://management.local.azurestack.external"
# Set your tenant name
$AuthEndpoint = (Get-AzureRMEnvironment -Name "AzureStackUser").ActiveDirectoryAuthority.TrimEnd('/')
$AADTenantName = "<myDirectoryTenantName>.onmicrosoft.com"
$TenantId = (invoke-restmethod "$($AuthEndpoint)/$($AADTenantName)/.well-known/openid-configuration").issuer.TrimEnd('/').Split('/')[-1]
# After signing in to your environment, Azure Stack Hub cmdlets
# can be easily targeted at your Azure Stack Hub instance.
Add-AzureRMAccount -EnvironmentName "AzureStackUser" -TenantId $TenantId

```

## Test the connection

When you've got everything setup, test connectivity by using PowerShell to create resources in Azure Stack Hub. As a test, create a resource group for an application and add a virtual machine. Run the following command to create a resource group named "MyResourceGroup":

### AZ Modules

```powershell
New-AzResourceGroup -Name "MyResourceGroup" -Location "Local"
```

### AzureRM modules

```powershell
New-AzureRMResourceGroup -Name "MyResourceGroup" -Location "Local"
```
