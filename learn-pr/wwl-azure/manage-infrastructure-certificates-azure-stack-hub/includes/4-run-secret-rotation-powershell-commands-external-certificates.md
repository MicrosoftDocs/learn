This unit provides guidance for performing secret rotation, to help maintain secure communication with Azure Stack Hub infrastructure resources and services.

Azure Stack Hub uses secrets to maintain secure communication with infrastructure resources and services. To maintain the integrity of the Azure Stack Hub infrastructure, operators need the ability to rotate secrets at frequencies that are consistent with their organization's security requirements.

When secrets are within 30 days of expiration, the following alerts are generated in the administrator portal. Completing secret rotation will resolve these alerts:

 -  Pending service account password expiration
 -  Pending internal certificate expiration
 -  Pending external certificate expiration

## Rotate external secrets

This unit covers rotation of certificates used to secure external-facing services. These certificates are provided by the Azure Stack Hub Operator, for the following services:

 -  Administrator portal
 -  Public portal
 -  Administrator Azure Resource Manager
 -  Global Azure Resource Manager
 -  Administrator Key Vault
 -  Key Vault
 -  Admin Extension Host
 -  ACS (including blob, table, and queue storage)
 -  ADFS
 -  Graph

## Rotation

Use the following PowerShell script to rotate the secrets. The script requires access to a Privileged EndPoint (PEP) session. The PEP is accessed through a remote PowerShell session on the virtual machine that hosts the PEP.

If you're using an integrated system, there are three instances of the PEP, each running inside a virtual machine (Prefix-ERCS01, Prefix-ERCS02, or Prefix-ERCS03) on different hosts.

If you're using the ASDK, this virtual machine is named AzS-ERCS01. Update the values before running:

```
# Create a PEP Session
winrm s winrm/config/client '@{TrustedHosts= "<IP_address_of_ERCS>"}'
$PEPCreds = Get-Credential
$PEPSession = New-PSSession -ComputerName <IP_address_of_ERCS_Machine> -Credential $PEPCreds -ConfigurationName "PrivilegedEndpoint"

# Run Secret Rotation
$CertPassword = ConvertTo-SecureString "<Cert_Password>" -AsPlainText -Force
$CertShareCreds = Get-Credential
$CertSharePath = "<Network_Path_Of_CertShare>"
Invoke-Command -Session $PEPSession -ScriptBlock {
    Start-SecretRotation -PfxFilesPath $using:CertSharePath -PathAccessCredential $using:CertShareCreds -CertificatePassword $using:CertPassword
}
Remove-PSSession -Session $PEPSession

```

The script performs the following steps:

 -  Creates a PowerShell Session with the Privileged endpoint using the **CloudAdmin** account, and stores the session as a variable. This variable is used as a parameter in the next step.
 -  Runs *Invoke-Command*, passing the PEP session variable as the *-Session* parameter.
 -  Runs *Start-SecretRotation* in the PEP session, using the following parameters:
    
     -  *PfxFilesPath*: The network path to your Certificates directory created earlier.
     -  *PathAccessCredential*: The PSCredential object for credentials to the share.
     -  *CertificatePassword*: A secure string of the password used for all of the pfx certificate files created.

External secret rotation takes approximately one hour. After successful completion, your console will display a *ActionPlanInstanceID ... CurrentStatus: Completed* message, followed by *DONE*. Remove your certificates from the share created in the Preparation section and store them in their secure backup location.

## Preparation

Prior to rotation of external secrets:

1.  Run the Test-AzureStack PowerShell cmdlet using the `-group SecretRotationReadiness` parameter, to confirm all test outputs are healthy before rotating secrets.
2.  Prepare a new set of replacement external certificates:
    
     -  The new set must match the certificate specifications.
     -  Generate a certificate signing request (CSR) to submit to your Certificate Authority (CA).
     -  Be sure to validate the certificates you prepare.
     -  Make sure there are no special characters in the password, like \* or).
     -  Make sure the PFX encryption is **TripleDES-SHA1**.

3.  Store a backup to the certificates used for rotation in a secure backup location. If your rotation runs and then fails, replace the certificates in the file share with the backup copies before you rerun the rotation. Keep backup copies in the secure backup location.
4.  Create a fileshare you can access from the ERCS virtual machines. The file share must be readable and writable for the **CloudAdmin** identity.
5.  Open a PowerShell ISE console from a computer where you have access to the fileshare. Navigate to your fileshare, where you create directories to place your external certificates.
6.  Download CertDirectoryMaker.ps1 to your network fileshare, and run the script. The script will create a folder structure that adheres to **.\\Certificates\\AAD** or **.\\Certificates\\ADFS**, depending on your identity provider. Your folder structure must begin with a **\\Certificates** folder, followed by ONLY an **\\AAD** or **\\ADFS** folder. All remaining subdirectories are contained within the preceding structure. For example:
    
     -  File share =**\\ &lt;ShareName&gt;** 
     -  Certificate root folder for Microsoft Entra provider = **\\Certificates\\AAD**
     -  Full path = **\\ &lt;ShareName&gt;\\Certificates\\AAD** 

7.  Copy the new set of replacement external certificates created in *Step 2*, to the **\\Certificates&lt;IdentityProvider&gt;** directory created in *Step 6*. Be sure to follow the `cert.<regionName>.<externalFQDN>` format for `<CertName>`.

The image below is an example of a folder structure for the Microsoft Entra identity Provider:

:::image type="content" source="../media/secrets-rotation-b04b4f04.png" alt-text="Prepare to run secret rotation PowerShell cmdlet for external certificates.":::
