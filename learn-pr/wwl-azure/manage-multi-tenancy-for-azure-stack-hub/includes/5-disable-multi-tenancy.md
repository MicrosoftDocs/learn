If you no longer want multiple tenants in Azure Stack Hub, you can disable multi-tenancy by doing the following steps in order:

1.  As the administrator of the guest directory, run *Unregister-AzsWithMyDirectoryTenant*. The cmdlet uninstalls all the Azure Stack Hub apps from the new directory.

```
## The following Azure Resource Manager endpoint is for the ASDK. If you're in a multinode environment, contact your operator or service provider to get the endpoint.
$tenantARMEndpoint = "https://management.local.azurestack.external"

## Replace the value below with the guest tenant directory.
$guestDirectoryTenantName = "fabrikam.onmicrosoft.com"

Unregister-AzsWithMyDirectoryTenant `
-TenantResourceManagerEndpoint $tenantARMEndpoint `
-DirectoryTenantName $guestDirectoryTenantName `
-Verbose

```

2.  As the service administrator of Azure Stack Hub (you in this scenario), run *Unregister-AzSGuestDirectoryTenant*.

```
## The following Azure Resource Manager endpoint is for the ASDK. If you're in a multinode environment, contact your operator or service provider to get the endpoint.
$adminARMEndpoint = "https://adminmanagement.local.azurestack.external"

## Replace the value below with the Azure Stack Hub directory
$azureStackDirectoryTenant = "contoso.onmicrosoft.com"

## Replace the value below with the guest tenant directory.
$guestDirectoryTenantToBeDecommissioned = "fabrikam.onmicrosoft.com"

## Replace the value below with the name of the resource group in which the directory tenant registration resource should be created (resource group must already exist).
$ResourceGroupName = "system.local"

Unregister-AzSGuestDirectoryTenant -AdminResourceManagerEndpoint $adminARMEndpoint `
-DirectoryTenantName $azureStackDirectoryTenant `
-GuestDirectoryTenantName $guestDirectoryTenantToBeDecommissioned `
-ResourceGroupName $ResourceGroupName


```
