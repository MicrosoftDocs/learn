The procedures in this unit only apply to Azure App Service on Azure Stack Hub. Rotation of Azure App Service on Azure Stack Hub secrets is not included in the centralized secret rotation procedure for Azure Stack Hub.

Operators can monitor the validity of secrets within the system, the date on which they were last updated, and the time remaining until the secrets expire.

Operators won't receive alerts for secret expiration on the Azure Stack Hub dashboard as Azure App Service on Azure Stack Hub is not integrated with the Azure Stack Hub alerting service. Operators must regularly monitor their secrets using the Azure App Service on Azure Stack Hub administration experience in the Azure Stack Hub administrator portal.

This unit contains the procedure for rotating the following secrets:

 -  Encryption keys used within Azure App Service on Azure Stack Hub.
 -  Database connection credentials used by Azure App Service on Azure Stack Hub to interact with the hosting and metering databases.
 -  Certificates used by Azure App Service on Azure Stack Hub to secure endpoints and rotation of identity application certificates in Microsoft Entra ID or Active Directory Federation Services (AD FS).
 -  System credentials for Azure App Service on Azure Stack Hub infrastructure roles.

## Rotate encryption keys

To rotate the encryption keys used within Azure App Service on Azure Stack Hub, take the following steps:

1.  Go to the App Service administration experience in the Azure Stack Hub administrator portal.
2.  Go to the **Secrets** menu option.
3.  Select the **Rotate** button in the Encryption Keys section.
4.  Select **OK** to start the rotation procedure.
5.  The encryption keys are rotated and all role instances are updated. Operators can check the status of the procedure using the **Status** button.

## Rotate connection strings

To update the credentials for the database connection string for the App Service hosting and metering databases, take the following steps:

1.  Go to the App Service administration experience in the Azure Stack Hub administrator portal.
2.  Go to the **Secrets** menu option.
3.  Select the **Rotate** button in the Connection Strings section.
4.  Provide the **SQL SA Username** and **Password** and select **OK** to start the rotation procedure.
5.  The credentials are rotated throughout the Azure App Service role instances. Operators can check the status of the procedure using the **Status** button.

## Rotate certificates

To rotate the certificates used within Azure App Service on Azure Stack Hub, take the following steps:

1.  Go to the App Service administration experience in the Azure Stack Hub administrator portal.
2.  Go to the **Secrets** menu option.
3.  Select the **Rotate** button in the Certificates section.
4.  Provide the **certificate file** and associated **password** for the certificates you wish to rotate and select **OK**.
5.  The certificates are rotated as required throughout the Azure App Service on Azure Stack Hub role instances. Operators can check the status of the procedure using the **Status** button.

When the identity application certificate is rotated, the corresponding app in Microsoft Entra ID or AD FS must also be updated with the new certificate.

Failure to update the identity application with the new certificate after rotation will break the user portal experience for Azure Functions, prevent users from being able to use the KUDU developer tools, and prevent admins from managing worker tier scale sets from the App Service administration experience.

<a name='rotate-credential-for-the-azure-ad-identity-application'></a>

### Rotate credential for the Microsoft Entra identity application.

The identity application is created by the operator before deployment of Azure App Service on Azure Stack Hub. If the application ID is unknown, follow these steps to discover it:

1.  Go to the **Azure Stack Hub administrator portal**.
2.  Go to **Subscriptions** and select **Default Provider Subscription**.
3.  Select **Access Control (IAM)** and select the **App Service** application.
4.  Take a note of the **APP ID**, this value is the application ID of the identity application that must be updated in Microsoft Entra ID.

To rotate the certificate for the application in Microsoft Entra ID, follow these steps:

1.  Go to the **Azure portal** and sign in using the Global Admin used to deploy Azure Stack Hub.
2.  Go to **Microsoft Entra ID** and browse to **App Registrations**.
3.  Search for the **Application ID**, then specify the identity Application ID.
4.  Select the application and then go to **Certificates &amp; Secrets**.
5.  Select **Upload certificate** and upload the new certificate for the identity application with one of the following file types: .cer, .pem, .crt.
6.  Confirm the **thumbprint** matches that listed in the App Service administration experience in the Azure Stack Hub administrator portal.
7.  Delete the old certificate.

### Rotate certificate for AD FS identity application.

The identity application is created by the operator before deployment of Azure App Service on Azure Stack Hub. If the application's object ID is unknown, follow these steps to discover it:

1.  Go to the **Azure Stack Hub administrator portal**.
2.  Go to **Subscriptions** and select **Default Provider Subscription**.
3.  Select **Access Control (IAM)** and select the **AzureStack-AppService-** application.
4.  Take a note of the **Object ID**, this value is the ID of the Service Principal that must be updated in AD FS.

To rotate the certificate for the application in AD FS, you need to have access to the privileged endpoint (PEP). Then you update the certificate credential using PowerShell, replacing your own values for the following placeholders:

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
    `PepVM`
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
    `CertificateFileLocation`
  :::column-end:::
  :::column:::
    The location of your X509 certificate on disk.
  :::column-end:::
  :::column:::
    `d:\certs\sso.cer`
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `ApplicationObjectId`
  :::column-end:::
  :::column:::
    The identifier assigned to the identity application.
  :::column-end:::
  :::column:::
    `S-1-5-21-401916501-2345862468-1451220656-1451`
  :::column-end:::
:::row-end:::


1.  Open an elevated Windows PowerShell session and run the following script:

```PowerShell
# Sign in to PowerShell interactively, using credentials that have access to the virtual machine running the Privileged Endpoint
$Creds = Get-Credential

# Create a new Certificate object from the identity application certificate exported as .cer file
$Cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2("<CertificateFileLocation>")

# Create a new PSSession to the PrivelegedEndpoint virtual machine
$Session = New-PSSession -ComputerName "<PepVm>" -ConfigurationName PrivilegedEndpoint -Credential $Creds

# Use the privileged endpoint to update the certificate thumbprint, used by the service principal associated with the App Service identity application
$SpObject = Invoke-Command -Session $Session -ScriptBlock {Set-GraphApplication -ApplicationIdentifier "<ApplicationObjectId>" -ClientCertificates $using:Cert}
$Session | Remove-PSSession

# Output the updated service principal details
$SpObject

```

2.  After the script finishes, it displays the updated app registration info, including the thumbprint value for the certificate.

```shell
ApplicationIdentifier : S-1-5-21-401916501-2345862468-1451220656-1451
ClientId :
Thumbprint : FDAA679BF9EDDD0CBB581F978457A37BFD73CA3B
ApplicationName : Azurestack-AppService-d93601c2-1ec0-4cac-8d1c-8ccde63ef308
ClientSecret :
PSComputerName : AzS-ERCS01
RunspaceId : cb471c79-a0d3-40ec-90ba-89087d104510

```

## Rotate system credentials

To rotate the system credentials used within Azure App Service on Azure Stack Hub, take the following steps:

1.  Go to the App Service administration experience in the Azure Stack Hub administrator portal.
2.  Go to the **Secrets** menu option.
3.  Select the **Rotate** button in the System Credentials section.
4.  Select the **Scope** of the System Credential you're rotating. Operators can choose to rotate the system credentials for all roles or individual roles.
5.  Specify a **new Local Admin User Name** and a new **Password**. Then confirm the **Password** and select **OK**.
6.  The credential(s) are rotated as required throughout the corresponding Azure App Service on Azure Stack Hub role instance. Operators can check the status of the procedure using the **Status** button.
