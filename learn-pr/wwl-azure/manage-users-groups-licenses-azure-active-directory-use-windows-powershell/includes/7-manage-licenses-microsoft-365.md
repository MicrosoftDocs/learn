After you create user accounts, you need to assign a license to the user account. The license determines which Microsoft 365 services the user has access to. The licenses in the tenant vary depending on which licenses you've purchased.

Some of the common enterprise licenses are:

- Microsoft Office 365 E3
- Office 365 E5
- Microsoft 365 E3
- Microsoft 365 E5

Each license includes multiple services that can be enabled or disabled. For example, an Office 365 E3 license includes access to Exchange Online, Microsoft Teams, SharePoint Online, and others. All services in a license are enabled by default.

When you configure licensing by using Windows PowerShell, you need to refer to the license and service plans by either a string ID or a globally unique identifier (GUID). For example, the Microsoft 365 E3 license has a string ID of SPE_E3 and a GUID of 05e9a617-0261-4cee-bb44-138d3ef5d965. The AzureAD cmdlets for licensing use the GUID, and the Msol cmdlets use the string ID.

> **Additional reading:** It's possible to query the string ID or GUID from your tenant, but you can also find a list of licenses and service plans on [Product names and service plan identifiers for licensing](https://aka.ms/product-names-and-service-plan-identifiers-for-licensing).

> [!NOTE]
> Some organizations use group-based licensing, which assigns licenses to user accounts automatically, based on group membership. If a license has been assigned by group-based licensing, you can't modify that license assignment by using PowerShell.

## Reviewing licenses by using Microsoft Entra PowerShell

You can use the **Get-EntraSubscribedSku** cmdlet to review the licenses available in your Microsoft 365 tenant. The following example retrieves licenses and displays information about them. The **SkuId** property is the GUID for the license:

```powershell
Get-EntraSubscribedSku | Select-Object -Property Sku*,ConsumedUnits -ExpandProperty PrepaidUnits
```

The service plans for a license are stored in the **ServicePlans** property. The following example places all licenses in a variable and then displays the service plans for the first item in the array. The provisioning status for the service plan indicates whether it's enabled or disabled:

```powershell
$sku = Get-EntraSubscribedSku
$sku[0].ServicePlans
```

## Managing licenses by using Microsoft Entra PowerShell

You can use the **Set-EntraUserLicense** cmdlet to assign a license to a user. Licenses to be added are specified as a hashtable with the **SkuId** property. The following example assigns a Microsoft 365 E3 license to a user:

```powershell
$addLicense = @{SkuId = "05e9a617-0261-4cee-bb44-138d3ef5d965"}
Set-EntraUserLicense -UserId AbbieP@adatum.com -AddLicenses $addLicense -RemoveLicenses @()
```

If you want to disable service plans for a user, include the GUIDs of those service plans in the **DisabledPlans** property of the license hashtable:

```powershell
$addLicense = @{
    SkuId = "05e9a617-0261-4cee-bb44-138d3ef5d965"
    DisabledPlans = @("7547a3fe-08ee-4ccb-b430-5077c5041653","a23b959c-7ce8-4e57-9140-b90eb88a9e97")
}
Set-EntraUserLicense -UserId AbbieP@adatum.com -AddLicenses $addLicense -RemoveLicenses @()
```

To remove a license, include the SkuId in the **RemoveLicenses** array. The following example removes a Microsoft 365 E3 license from a user account:

```powershell
$removeLicense = "05e9a617-0261-4cee-bb44-138d3ef5d965"
Set-EntraUserLicense -UserId AbbieP@adatum.com -AddLicenses @() -RemoveLicenses $removeLicense
```

You can't add multiple licenses to a user that has conflicting components. However, you can create a single **Set-EntraUserLicense** call that removes the old license and adds the new one at the same time by populating both the **AddLicenses** and **RemoveLicenses** parameters.
