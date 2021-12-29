Now you create another app registration, but this time specifies a client secret credential. Unlike a certificate credential, the directory has the ability to generate a client secret credential. Instead of specifying the client secret, you use the `-GenerateClientSecret` switch to request it generated. Substitute your own values for the following placeholders:

:::row:::
  :::column:::
    **Placeholder**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
  :::column:::
    **Example**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `<PepVM>`
  :::column-end:::
  :::column:::
    The name of the privileged endpoint virtual machine on your Azure Stack Hub instance.
  :::column-end:::
  :::column:::
    `AzS-ERCS01`
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `<YourAppName>`
  :::column-end:::
  :::column:::
    A descriptive name for the new app registration.
  :::column-end:::
  :::column:::
    `My management tool`
  :::column-end:::
:::row-end:::


1.  Open an elevated Windows PowerShell session, and run the following cmdlets:

```
# Sign in to PowerShell interactively, using credentials that have access to the virtual machine running the Privileged Endpoint (typically <domain>\cloudadmin)
$Creds = Get-Credential

# Create a PSSession to the Privileged Endpoint virtual machine
$Session = New-PSSession -ComputerName "<PepVM>" -ConfigurationName PrivilegedEndpoint -Credential $Creds

# Use the privileged endpoint to create the new app registration (and service principal object)
$SpObject = Invoke-Command -Session $Session -ScriptBlock {New-GraphApplication -Name "<YourAppName>" -GenerateClientSecret}
$AzureStackInfo = Invoke-Command -Session $Session -ScriptBlock {Get-AzureStackStampInformation}
$Session | Remove-PSSession

# Using the stamp info for your Azure Stack Hub instance, populate the following variables:
# - Az endpoint used for Azure Resource Manager operations 
# - Audience for acquiring an OAuth token used to access Graph API. 
# - GUID of the directory tenant
$ArmEndpoint = $AzureStackInfo.TenantExternalEndpoints.TenantResourceManager
$GraphAudience = "https://graph." + $AzureStackInfo.ExternalDomainFQDN + "/"
$TenantID = $AzureStackInfo.AADTenantID

# Register and set an Az environment that targets your Azure Stack Hub instance.
Add-AzEnvironment -Name "AzureStackUser" -ArmEndpoint $ArmEndpoint

# Sign in using the new service principal
$securePassword = $SpObject.ClientSecret | ConvertTo-SecureString -AsPlainText -Force
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $SpObject.ClientId, $securePassword
$SpSignin = Connect-AzAccount -Environment "AzureStackUser" -ServicePrincipal -Credential $credential -TenantId $TenantID

# Output the service principal details
$SpObject

```

2.  After the script finishes, it displays the app registration info, including the service principal's credentials. The `ClientID` and `ClientSecret` are authenticated, and later authorized for access to resources managed by Azure Resource Manager.

```
ApplicationIdentifier : S-1-5-21-1634563105-1224503876-2692824315-2623
ClientId              : 8e0ffd12-26c8-4178-a74b-f26bd28db601
Thumbprint            : 
ApplicationName       : Azurestack-YourApp-6967581b-497e-4f5a-87b5-0c8d01a9f146
ClientSecret          : 6RUWLRoBw3EebBLgaWGiowCkoko5_j_ujIPjA8dS
PSComputerName        : azs-ercs01
RunspaceId            : 286daaa1-c9a6-4176-a1a8-03f543f90998

```
