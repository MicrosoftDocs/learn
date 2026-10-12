> [!NOTE]
> We start with a greenfield deployment where the HGS forest hasn't yet been deployed. The `Install-HgsServer` steps in this section create it. 

Deploy HGS in a dedicated forest. In this example, the forest's DNS name is `security.contoso.com`, and the HGS service name is `hgs`, so the full service name is `hgs.security.contoso.com`. Deploy three HGS nodes across separate failure domains, and size the deployment to continue attesting Hyper-V hosts and releasing VM keys if one node becomes unavailable.

Best practice is a dedicated HGS forest. The default deployment creates a new forest. A separate single-domain forest is a straightforward design, but not a strict requirement. If you use an existing bastion forest, install HGS in its root domain as HGS doesn't support deployment in a non-root domain. 

In a dedicated HGS forest, HGS nodes are domain controllers. You need one HGS node for a test deployment. For production, use a high-availability cluster, typically three nodes. A guarded fabric can start with one Hyper-V host, but you need at least two to test live migration. Microsoft supports running HGS on physical servers or virtual machines, but recommends physical servers. A three-node physical HGS cluster requires three physical servers. If you virtualize HGS, keep its startup independent of the HGS service and the guarded Hyper-V hosts it protects to avoid a circular dependency. 

An existing bastion forest is an alternative only if it's already a highly privileged, isolated security environment. You need to deploy HGS in the forest's root domain, not a child domain. Account for domain controllers, service identities, delegated permissions, and recovery. A general production or fabric forest isn't an equivalent isolation boundary.

DNS must resolve the service's distributed network name and the required domain records. Plan conditional forwarding where needed, reliable time, domain connectivity, cluster communications, and secured administration. HTTPS access to `/Attestation` and `/KeyProtection` is necessary in this design, but opening TCP 443 alone doesn't satisfy all deployment dependencies.

## Assign certificate purposes correctly

HGS uses separate **signing** and **encryption** key certificates. A separate **Transport Layer Security (TLS) certificate** authenticates the HTTPS endpoint. Template-signing and owner certificates serve other authorities. Similar subject names don't make these certificates interchangeable.

A Personal Information Exchange (PFX) file can package a certificate with its private key. Protect both the file and its password. Nonexportable or hardware security module (HSM) keys reduce some key-export exposure but add provider, access, availability, and recovery dependencies. They don't remove the need for recoverable private-key authority.

The documented HGS signing/encryption certificate profile requires a **Key Storage Provider (KSP)** rather than a legacy Cryptographic Service Provider (CSP), RSA keys of at least 2048 bits, Digital Signature and Data Encipherment key usages, and Server Authentication extended key usage. SHA256 is recommended. Apply this profile to HGS key certificates. Also meet the TLS certificate's own service-name and trust-chain requirements.

HGS treats its signing/encryption certificates as key containers. Certificate expiry or public key infrastructure revocation doesn't, by itself, withdraw those keys from HGS use. TLS expiry, name mismatch, or chain failure can still break HTTPS transport. Plan service-key retirement explicitly.

Renewing a certificate with the same key is different from introducing a new key pair. A new certificate with the same subject name but a new key can't replace the old key's cryptographic access.

### Prepare requests for a standalone CA

HGS can use, but doesn't require an enterprise CA. The procedure outlined in this module uses a standalone CA, which doesn't use certificate templates. Include the requested certificate properties in each request, and have the CA administrator review the requests and the issued certificates. Standalone CA requests are held for administrator approval by default. These examples use exportable, software-backed keys and create private keys in the local computer certificate store. Use your HSM vendor's request and key-provisioning procedure for HSM-backed keys.

The signing and encryption certificates need separate RSA keys of at least 2048 bits, a KSP, Digital Signature and Data Encipherment key usages, and Server Authentication enhanced key usage. SHA-256 is recommended. Renew these HGS certificates with the same keys. The TLS certificate is needed only if you configure HTTPS. It must support Server Authentication and identify the HGS distributed network name. If a SAN is present, include the distributed network name there and every other DNS name clients use.

Save the following as `HgsSigning.inf`. After you create the HGS forest, place this file in `C:\Certificates` on the first HGS node.

```ini
[Version]
Signature="$Windows NT$"

[NewRequest]
Subject = "CN=HGS Signing Certificate"
KeySpec = 0
KeyLength = 2048
Exportable = TRUE
MachineKeySet = TRUE
ProviderName = "Microsoft Software Key Storage Provider"
RequestType = PKCS10
HashAlgorithm = sha256
KeyUsage = 0x90

[Extensions]
2.5.29.37 = "{text}"
_continue_ = "1.3.6.1.5.5.7.3.1"
```

Save the following as `C:\Certificates\HgsEncryption.inf`:

```ini
[Version]
Signature="$Windows NT$"

[NewRequest]
Subject = "CN=HGS Encryption Certificate"
KeySpec = 0
KeyLength = 2048
Exportable = TRUE
MachineKeySet = TRUE
ProviderName = "Microsoft Software Key Storage Provider"
RequestType = PKCS10
HashAlgorithm = sha256
KeyUsage = 0x90

[Extensions]
2.5.29.37 = "{text}"
_continue_ = "1.3.6.1.5.5.7.3.1"
```

If you configure HTTPS, save this example as `C:\Certificates\HgsTls.inf`. Replace or add SAN DNS entries if clients use additional names:

```ini
[Version]
Signature="$Windows NT$"

[NewRequest]
Subject = "CN=hgs.security.contoso.com"
KeySpec = 0
KeyLength = 2048
Exportable = TRUE
MachineKeySet = TRUE
ProviderName = "Microsoft Software Key Storage Provider"
RequestType = PKCS10
HashAlgorithm = sha256
KeyUsage = 0xa0

[Extensions]
2.5.29.17 = "{text}"
_continue_ = "DNS=hgs.security.contoso.com"
2.5.29.37 = "{text}"
_continue_ = "1.3.6.1.5.5.7.3.1"
```

These files describe requested properties. The CA can apply its configured policy. Inspect each issued certificate's subject, SAN, public key, key usages, enhanced key usage, and chain before using it. Approval or a successful enrollment command alone doesn't prove that an issued certificate meets the HGS profile.

## Deploy the first node

The HGS deployment process starts on a dedicated, initially non-domain-joined Windows Server 2025 computer that will function as the first HGS node and as first domain controller in a new forest. First install the HGS role. `Install-WindowsFeature` doesn't install AD DS, create a forest, or promote the server to a domain controller. The subsequent `Install-HgsServer` command creates and configures the HGS forest and promotes the node as its domain controller. Ensure that you already have the server name configured appropriately. Installation requires elevated local administration, approved network configuration, and authority to create the new forest. These commands install roles, configure the forest, and restart the server. Use separate sessions across reboot boundaries.

```powershell
Install-WindowsFeature -Name HostGuardianServiceRole `
    -IncludeManagementTools -Restart
```

After the role installation and restart, establish the dedicated forest.

```powershell
$dsrmPassword = Read-Host -AsSecureString -Prompt 'DSRM password'

Install-HgsServer -HgsDomainName 'security.contoso.com' `
    -SafeModeAdministratorPassword $dsrmPassword -Restart
```

The password is for Directory Services Restore Mode (DSRM). It isn't a replacement interactive sign-in password. Preserve it through the approved recovery process.

### Trust the standalone CA in the HGS forest

Before enrolling or importing CA-issued certificates, distribute the standalone CA's public certificate chain to the HGS forest. Obtain the root and any intermediate CA certificates from the CA administrator through an authenticated channel. Verify their thumbprints independently. Never distribute or import a CA private key.

Create a dedicated Group Policy Object (GPO) in the new HGS forest and link it to the HGS domain:

1. In Group Policy Management, create and link a GPO for HGS certificate trust.
1. Edit the GPO and open **Computer Configuration > Policies > Windows Settings > Security Settings > Public Key Policies**.
1. Import the root CA certificate into **Trusted Root Certification Authorities**. Import each intermediate CA certificate into **Intermediate Certification Authorities**. Don't place an intermediate CA certificate in the root store.
1. Apply the policy on each HGS node and verify that the certificates appear in the corresponding local computer stores.

```powershell
gpupdate /target:computer /force

$rootThumbprint = '<verified-root-ca-thumbprint>'
Get-ChildItem Cert:\LocalMachine\Root |
    Where-Object Thumbprint -eq $rootThumbprint
```

This GPO establishes CA-chain trust for HGS computers in this forest. It doesn't automatically establish trust on guarded Hyper-V hosts in a separate fabric domain or on VM-owner systems. Distribute the same verified public CA chain through the fabric's certificate policy to Hyper-V hosts that validate the TLS endpoint. VM owners must also establish the appropriate CA trust before relying on CA-issued HGS guardian certificates.

Ensure that the CA's certificate revocation list (CRL) and authority information access (AIA) locations are reachable wherever clients validate the issued certificates.

### Enroll the HGS certificates

Run the following commands in an elevated session on the first HGS node after the forest is created. Replace the CA configuration with the standalone CA's exact `ComputerName\CAName` value. These commands don't use `-attrib CertificateTemplate` because standalone CAs don't use certificate templates.

```powershell
$caConfig = 'CA01.security.contoso.com\Contoso Standalone CA'
$certificatePath = 'C:\Certificates'
New-Item -ItemType Directory -Path $certificatePath -Force | Out-Null

certreq -new "$certificatePath\HgsSigning.inf" `
    "$certificatePath\HgsSigning.req"
certreq -new "$certificatePath\HgsEncryption.inf" `
    "$certificatePath\HgsEncryption.req"

# Run this command only if you configure HTTPS.
certreq -new "$certificatePath\HgsTls.inf" `
    "$certificatePath\HgsTls.req"

certreq -submit -config $caConfig `
    "$certificatePath\HgsSigning.req" "$certificatePath\HgsSigning.cer"
certreq -submit -config $caConfig `
    "$certificatePath\HgsEncryption.req" "$certificatePath\HgsEncryption.cer"

# Run this command only if you configure HTTPS.
certreq -submit -config $caConfig `
    "$certificatePath\HgsTls.req" "$certificatePath\HgsTls.cer"
```

Submit the TLS request only if you configure HTTPS. A standalone CA holds requests for approval by default, and standalone requests aren't authenticated through AD DS. Restrict approval to authorized CA administrators and verify each requester's identity and request contents through an approved channel. Record each request ID that `certreq -submit` returns, have the CA administrator issue the approved requests, then retrieve any certificate that wasn't issued immediately.

```powershell
certreq -retrieve -config $caConfig '<signing-request-id>' `
    "$certificatePath\HgsSigning.cer"
certreq -retrieve -config $caConfig '<encryption-request-id>' `
    "$certificatePath\HgsEncryption.cer"

# Run this command only if a TLS request was submitted and left pending.
certreq -retrieve -config $caConfig '<tls-request-id>' `
    "$certificatePath\HgsTls.cer"
```

Run only the retrieval commands for requests left pending. After issuance, inspect each certificate and accept it on the HGS node that created its private key:

```powershell
certutil -dump "$certificatePath\HgsSigning.cer"
certutil -dump "$certificatePath\HgsEncryption.cer"
certutil -verify "$certificatePath\HgsSigning.cer"
certutil -verify "$certificatePath\HgsEncryption.cer"
certreq -accept "$certificatePath\HgsSigning.cer"
certreq -accept "$certificatePath\HgsEncryption.cer"
```

If you requested TLS, inspect and accept `HgsTls.cer` as well:

```powershell
certutil -dump "$certificatePath\HgsTls.cer"
certutil -verify "$certificatePath\HgsTls.cer"
certreq -accept "$certificatePath\HgsTls.cer"
```

Confirm the required public key, usages, enhanced key usage, subject/SAN, and chain before proceeding. If a certificate fails these checks, stop and correct the CA issuance policy. Don't initialize HGS with it.

For exportable software-backed keys, export the accepted signing and encryption certificates with their private keys to password-protected PFX files. Keep each password out of scripts and protect the files as private-key material:

```powershell
$signingPassword = Read-Host -AsSecureString -Prompt 'Signing PFX password'
$encryptionPassword = Read-Host -AsSecureString -Prompt 'Encryption PFX password'
$signingCert = Get-Item 'Cert:\LocalMachine\My\<signing-certificate-thumbprint>'
$encryptionCert = Get-Item 'Cert:\LocalMachine\My\<encryption-certificate-thumbprint>'

Export-PfxCertificate -Cert $signingCert `
    -FilePath "$certificatePath\HgsSigning.pfx" `
    -Password $signingPassword
Export-PfxCertificate -Cert $encryptionCert `
    -FilePath "$certificatePath\HgsEncryption.pfx" `
    -Password $encryptionPassword
```

If you configure HTTPS, accept and export the TLS certificate as a protected PFX too:

```powershell
$tlsPassword = Read-Host -AsSecureString -Prompt 'TLS PFX password'
$tlsCert = Get-Item 'Cert:\LocalMachine\My\<tls-certificate-thumbprint>'

Export-PfxCertificate -Cert $tlsCert `
    -FilePath "$certificatePath\HgsTls.pfx" `
    -Password $tlsPassword
```

For HSM-backed or nonexportable keys, don't export PFX files. Provision and authorize the provider-backed keys on every HGS node and initialize HGS by using the installed certificate thumbprints.

After the forest is available, sign in with the required HGS forest authority. The following initialization uses distinct approved signing and encryption PFX files. Their private keys and passwords must be protected before and after import.

```powershell
$signingPassword = Read-Host -AsSecureString -Prompt 'Signing PFX password'
$encryptionPassword = Read-Host -AsSecureString -Prompt 'Encryption PFX password'

$initialization = @{
    HgsServiceName                = 'hgs'
    SigningCertificatePath        = 'C:\Certificates\HgsSigning.pfx'
    SigningCertificatePassword    = $signingPassword
    EncryptionCertificatePath     = 'C:\Certificates\HgsEncryption.pfx'
    EncryptionCertificatePassword = $encryptionPassword
    TrustTpm                      = $true
}

Initialize-HgsServer @initialization
Get-HgsServer
Get-HgsKeyProtectionCertificate
```

Confirm the intended service identity, endpoints, active TPM mode, and signing/encryption keys. Initialization isn't proof that a client can attest or that every cluster node can release keys.

Forest creation isn't a reversible configuration toggle. Correct failed deployment through the supported installation or recovery procedure rather than deleting domain or cluster objects experimentally.

## Add nodes and establish private-key access

For each additional HGS node in a dedicated forest, start with a stand alone Windows Server computer that isn't yet joined to a domain. Configure the server to use DNS that can resolve records for the AD DS DNS partition for the existing HGS forest, then install the HGS role. An HGS administrator runs `Install-HgsServer` with credentials authorized to join the existing forest. This joins the node and promotes it as a domain controller. After the restart, initialize it into the existing HGS cluster. The server is standalone only before this setup. It becomes a domain controller in the dedicated HGS forest.

```powershell
$credential = Get-Credential
$dsrmPassword = Read-Host -AsSecureString -Prompt 'DSRM password'

Install-HgsServer -HgsDomainName 'security.contoso.com' `
    -HgsDomainCredential $credential `
    -SafeModeAdministratorPassword $dsrmPassword -Restart
```

After restart, initialize the node against an existing HGS node's actual IP address with the following command:

```powershell
$firstNodeAddress = Read-Host -Prompt 'First HGS node IP address'
Initialize-HgsServer -HgsServerIPAddress $firstNodeAddress
Get-HgsServer
```

PFX-provided HGS key material is replicated within the HGS cluster. With thumbprint-based, nonexportable, or HSM keys, don't assume private-key replication. Install the required key access on every node and authorize the HGS group managed service account (gMSA) to use it.

The computer account of each HGS node must be allowed to retrieve the gMSA's managed password from AD DS; the gMSA separately needs access to the certificate private keys. Certificate presence, service-account identity, and private-key usability are three different checks. An HSM connection or key access failure on one node can produce intermittent failures behind an otherwise healthy service name.

Protect HGS system disks and backups against unauthorized access and modification, with independently recoverable keys. For an HSM, follow the provider's supported Windows Server deployment and recovery instructions alongside the HGS certificate requirements. This module doesn't prescribe vendor-specific installation.

## Add HTTPS without breaking the supported binding

In this deployment, HTTPS is the TLS-protected transport for Hyper-V host requests to the HGS Attestation and Key Protection endpoints. It encrypts and authenticates the network connection between clients and each HGS node, in addition to HGS's message-level protection for sensitive key material. HTTPS doesn't perform host attestation or authorize a VM's key protector. Those checks remain HGS functions.

An HGS administrator configures each node using an approved TLS certificate that covers the service name. The example imports a protected PFX. HTTPS certificates aren't automatically replicated like PFX-provided HGS service keys.

```powershell
$tlsPassword = Read-Host -AsSecureString -Prompt 'HTTPS PFX password'

Set-HgsServer -Http -Https `
    -HttpsCertificatePath 'C:\Certificates\HgsTls.pfx' `
    -HttpsCertificatePassword $tlsPassword
```

An installed certificate can instead be selected with `-HttpsCertificateThumbprint`. Each node may use a different TLS certificate if the certificate names and chains are correct.

Keep the HTTP binding in Internet Information Services (IIS). Removing the binding isn't supported. Where the security design requires restricting HTTP access, use appropriate firewall controls without deleting that binding. HGS protects sensitive key messages at the message level. HTTPS adds transport protection. Neither layer replaces attestation or KP authorization.

Verify DNS and TLS from a Hyper-V host, then independently exercise attestation and key release through each HGS node. Finally test loss of one HGS node. A successful request to the clustered URL doesn't establish that all nodes have usable private keys.

## Delegate inspection through JEA

**Just Enough Administration (JEA)** limits the commands a delegated operator can run. HGS administrator roles can change trust. Reviewer roles provide read-only inspection. In a dedicated forest, the role groups use the HGS service name. Verify the actual group membership and endpoint permissions rather than granting general forest administration.

From a trusted Windows Server management system, an authorized delegated reviewer connects to the HGS JEA endpoint. This example uses the configured authenticated remoting environment. Add `-UseSSL` only when a WinRM HTTPS listener and its certificate are explicitly configured.

```powershell
$reviewer = Get-Credential

Enter-PSSession -ComputerName 'HGS01.security.contoso.com' `
    -Credential $reviewer `
    -ConfigurationName 'microsoft.windows.hgs'

Get-HgsAttestationPolicy
Exit-PSSession
```
