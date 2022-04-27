When creating a certificate credential, the following requirements must be met:

 -  For production, the certificate must be issued from either an internal Certificate Authority or a Public Certificate Authority. When using a public authority, include the authority in the base operating system image as part of the Microsoft Trusted Root Authority Program.
 -  The cryptographic provider must be specified as a Microsoft legacy Cryptographic Service Provider (CSP) key provider.
 -  The certificate format must be in PFX file, as both the public and private keys are required. Windows servers use .pfx files that contain the public key file (TLS/SSL certificate file) and the associated private key file.
 -  Your Azure Stack Hub infrastructure must have network access to the certificate authority's Certificate Revocation List (CRL) location published in the certificate. This CRL must be an HTTP endpoint.

Once you have a certificate, use the PowerShell script below to register your app and create a service principal. You also use the service principal to sign in to Azure. Substitute your own values for the following placeholders:

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
    `<YourCertificateLocation>`
  :::column-end:::
  :::column:::
    The location of your X509 certificate in the local certificate store.
  :::column-end:::
  :::column:::
    `Cert:\CurrentUser\My\AB5A8A3533CC7AA2025BF05120117E06DE407B34`
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


1.  Open an elevated Windows PowerShell session, and run the following script.

```
# Sign in to PowerShell interactively, using credentials that have access to the virtual machine running the Privileged Endpoint (typically <domain>\cloudadmin)
$Creds = Get-Credential

# Create a PSSession to the Privileged Endpoint virtual machine
$Session = New-PSSession -ComputerName "<PepVm>" -ConfigurationName PrivilegedEndpoint -Credential $Creds

# Use the Get-Item cmdlet to retrieve your certificate.
# If you don't want to use a managed certificate, you can produce a self-signed cert for testing purposes:
# $Cert = New-SelfSignedCertificate -CertStoreLocation "cert:\CurrentUser\My" -Subject "CN=<YourAppName>" -KeySpec KeyExchange
$Cert = Get-Item "<YourCertificateLocation>"

# Use the privileged endpoint to create the new app registration (and service principal object)
$SpObject = Invoke-Command -Session $Session -ScriptBlock {New-GraphApplication -Name "<YourAppName>" -ClientCertificates $using:cert}
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
$SpSignin = Connect-AzAccount -Environment "AzureStackUser" `
-ServicePrincipal `
-CertificateThumbprint $SpObject.Thumbprint `
-ApplicationId $SpObject.ClientId `
-TenantId $TenantID

# Output the service principal details
$SpObject

```

2.  After the script finishes, it displays the app registration info, including the service principal's credentials. The `ClientID` and `Thumbprint` are authenticated, and later authorized for access to resources managed by Azure Resource Manager.

```
ApplicationIdentifier : S-1-5-21-1512385356-3796245103-1243299919-1356
ClientId              : 3c87e710-9f91-420b-b009-31fa9e430145
Thumbprint            : 30202C11BE6864437B64CE36C8D988442082A0F1
ApplicationName      : Azurestack-MyApp-c30febe7-1311-4fd8-9077-3d869db28342
ClientSecret          :
PSComputerName        : azs-ercs01
RunspaceId            : a78c76bb-8cae-4db4-a45a-c1420613e01b

```
