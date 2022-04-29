The Azure Stack Hub Readiness Checker tool described in this unit is available from the PowerShell Gallery. Use the tool to validate that generated public key infrastructure (PKI) certificates are suitable for pre-deployment. Validate certificates by leaving enough time to test and reissue certificates if necessary.

The Readiness Checker tool performs the following certificate validations:

 -  **Parse PFX** ‎Checks for valid PFX file, correct password, and whether the public information is protected by the password.
 -  **Expiry Date** ‎Checks for minimum validity of seven days.
 -  **Signature algorithm** ‎Checks that the signature algorithm isn't SHA1.
 -  **Private Key** ‎Checks that the private key is present and is exported with the local machine attribute.
 -  **Cert chain** ‎Checks certificate chain is intact including a check for self-signed certificates.
 -  **DNS names** ‎Checks the SAN contains relevant DNS names for each endpoint or if a supporting wildcard is present.
 -  **Key usage** ‎Checks if the key usage contains a digital signature and key encipherment and checks if enhanced key usage contains server authentication and client authentication.
 -  **Key size** ‎Checks if the key size is 2048 or larger.
 -  **Chain order** ‎Checks the order of the other certificates validating that the order is correct.
 -  **Other certificate**s ‎Ensure no other certificates have been packaged in PFX other than the relevant leaf certificate and its chain.

Your system should meet the following prerequisites before validating PKI certificates for an Azure Stack Hub deployment:

 -  Microsoft Azure Stack Hub Readiness Checker.
 -  SSL Certificate(s) exported following the [preparation instructions](/azure-stack/operator/azure-stack-prepare-pki-certs?view=azs-1910).
 -  'DeploymentData.json'.
 -  Windows 10 or Windows Server 2016.

## Perform core services certificate validation

Use these steps to validate the Azure Stack Hub PKI certificates for deployment and secret rotation:

1.  Install AzsReadinessChecker from a PowerShell prompt (5.1 or above) by running the following cmdlet:
    
    ```
    Install-Module Microsoft.AzureStack.ReadinessChecker -Force -AllowPrerelease
    
    ```

2.  Create the certificate directory structure. In the example below, you can change &lt;C:\\Certificates\\Deployment&gt; to a new directory path of your choice.
    
    ```
    New-Item C:\Certificates\Deployment -ItemType Directory
    
    $directories = 'ACSBlob', 'ACSQueue', 'ACSTable', 'Admin Extension Host', 'Admin Portal', 'ARM Admin', 'ARM Public', 'KeyVault', 'KeyVaultInternal', 'Public Extension Host', 'Public Portal'
    
    $destination = 'C:\Certificates\Deployment'
    
    $directories | % { New-Item -Path (Join-Path $destination $PSITEM) -ItemType Directory -Force}
    
    
    ```

3.  In the PowerShell window, change the values of RegionName, FQDN, and IdentitySystem appropriate to the Azure Stack Hub environment and run the following cmdlet:
    
    ```
    $pfxPassword = Read-Host -Prompt "Enter PFX Password" -AsSecureString
    Invoke-AzsHubDeploymentCertificateValidation -CertificatePath C:\Certificates\Deployment -pfxPassword $pfxPassword -RegionName east -FQDN azurestack.contoso.com -IdentitySystem AAD
    
    
    ```

4.  Check the output and ensure that all certificates pass all tests. For example:
    
    ```
    Testing: KeyVaultInternal\KeyVaultInternal.pfx
    Thumbprint: E86699****************************4617D6
        PFX Encryption: OK
        Expiry Date: OK
        Signature Algorithm: OK
        DNS Names: OK
        Key Usage: OK
        Key Length: OK
        Parse PFX: OK
        Private Key: OK
        Cert Chain: OK
        Chain Order: OK
        Other Certificates: OK
    Testing: ARM Public\ARMPublic.pfx
    Thumbprint: 8DC4D9****************************69DBAA
        PFX Encryption: OK
        Expiry Date: OK
        Signature Algorithm: OK
        DNS Names: OK
        Key Usage: OK
        Key Length: OK
        Parse PFX: OK
        Private Key: OK
        Cert Chain: OK
        Chain Order: OK
        Other Certificates: OK
    Testing: Admin Portal\AdminPortal.pfx
    Thumbprint: 6F9055****************************4AC0EA
        PFX Encryption: OK
        Expiry Date: OK
        Signature Algorithm: OK
        DNS Names: OK
        Key Usage: OK
        Key Length: OK
        Parse PFX: OK
        Private Key: OK
        Cert Chain: OK
        Chain Order: OK
        Other Certificates: OK
    Testing: Public Portal\PublicPortal.pfx
    
    Log location (contains PII): C:\Users\[*redacted*]\AppData\Local\Temp\AzsReadinessChecker\AzsReadinessChecker.log
    Report location (contains PII): C:\Users\[*redacted*]\AppData\Local\Temp\AzsReadinessChecker\AzsReadinessCheckerReport.json
    Invoke-AzsHubDeploymentCertificateValidation Completed
    
    
    ```

To validate certificates for other Azure Stack Hub services, change the value for `-CertificateType`. For example:

```
# App Services
Invoke-AzsHubAppServicesCertificateValidation -CertificatePath C:\Certificates\AppServices -pfxPassword $pfxPassword -RegionName east -FQDN azurestack.contoso.com

# DBAdapter
Invoke-AzsHubDBAdapterCertificateValidation -CertificatePath C:\Certificates\DBAdapter -pfxPassword $pfxPassword -RegionName east -FQDN azurestack.contoso.com

# EventHubs
Invoke-AzsHubEventHubsCertificateValidation -CertificatePath C:\Certificates\EventHubs -pfxPassword $pfxPassword -RegionName east -FQDN azurestack.contoso.com

# IoTHub
Invoke-AzsHubIoTHubCertificateValidation -CertificatePath C:\Certificates\IoTHub -pfxPassword $pfxPassword -RegionName east -FQDN azurestack.contoso.com


```
