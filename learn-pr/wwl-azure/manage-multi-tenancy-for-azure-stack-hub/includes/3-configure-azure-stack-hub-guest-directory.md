Once the Azure Stack Hub operator has enabled the Fabrikam directory to be used with Azure Stack Hub, you must register Azure Stack Hub with Fabrikam's directory tenant.

### Register Azure Stack Hub with the guest directory

You are the directory admin for Fabrikam, run the following commands in the guest directory `fabrikam.onmicrosoft.com`:

```powershell
## The following Azure Resource Manager endpoint is for the ASDK. If you're in a multinode environment, contact your operator or service provider to get the endpoint.
$tenantARMEndpoint = "https://management.local.azurestack.external"
   
## Replace the value below with the guest tenant directory.
$guestDirectoryTenantName = "fabrikam.onmicrosoft.com"

Register-AzSWithMyDirectoryTenant `
-TenantResourceManagerEndpoint $tenantARMEndpoint `
-DirectoryTenantName $guestDirectoryTenantName `
-Verbose
```
