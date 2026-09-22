Before installing the certificate services role on hosts that you're configuring as issuing CAs:

- Use Windows Server 2025 Desktop Experience for the procedures in this walkthrough.
- Set final computer name, static network settings, DNS, time, and production domain membership **before** configuring AD CS.
- Use a dedicated server; don't install unrelated roles or applications.
- Confirm connectivity to required DCs, DNS, management, backup, monitoring, and future publication staging. The CA doesn't need direct web-server write unless explicitly designed.
- Confirm `C:\Windows\CAPolicy.inf`, provider/HSM, database/log paths, service account assumptions, and protected administration.

## Server Manager UI deployment

This procedure installs the issuing-CA role and creates a subordinate request before the host possesses a signed CA certificate. Role installation requires elevated local administrator privilege. Enterprise CA configuration additionally requires Enterprise Admin or appropriately delegated forest-configuration privilege, plus local administrator and HSM authorization. Success means `IssuingCA.req` is created and its subject, key, provider, requested extensions, and hash match the approved implementation record; `CertSvc` can't issue certificates until `IssuingCA.cer` is installed. If the root signs the wrong request, it creates a long-lived unauthorized issuing identity even before any end-entity certificate is issued.

1. Open **Server Manager > Manage > Add Roles and Features > Active Directory Certificate Services**.
1. Add **Certification Authority** and management tools.
1. Start the **AD CS Configuration wizard**.
1. Select **Enterprise CA** and **Subordinate CA**.
1. Select **Create a new private key**.
1. Select the approved KSP/CSP/HSM, algorithm, key length/curve, and hash.
1. Enter `<IssuingCAName>` and the approved DN suffix.
1. Select **Save a certificate request to file** and write `IssuingCA.req` to protected local staging.
1. Select approved database and log paths. Configure and record the result.

The subordinate validity shown or requested here doesn't force the offline root to grant it. Root policy and remaining root lifetime govern the signed certificate.

## PowerShell deployment

The following command installs the issuing host's CA role service and management tools:

```powershell
Install-WindowsFeature ADCS-Cert-Authority -IncludeManagementTools
```

`Install-AdcsCertificationAuthority` configures the CA using the supplied parameters and defaults for omitted settings. Its confirmation prompt isn't a configuration wizard. Review the approved CA type, provider, key length, hash, CA name, storage, and request-output settings before running the parameterized example below. Use the Server Manager AD CS Configuration wizard if you need an interactive configuration experience. Don't run a bare configuration command as a preliminary step.

`-AllowAdministratorInteraction` concerns private-key/provider prompts, not collection of the CA design. Don't rerun installation against an already configured CA to repair accidentally accepted defaults.

The following repeatable software-KSP example creates the request and stores it in protected local staging; use only after validating all parameter values on the target build:

```powershell
Install-AdcsCertificationAuthority `
    -CAType EnterpriseSubordinateCA `
    -CACommonName '<IssuingCAName>' `
    -CryptoProviderName 'RSA#Microsoft Software Key Storage Provider' `
    -KeyLength 4096 `
    -HashAlgorithmName SHA256 `
    -OutputCertRequestFile 'C:\CAConfig\IssuingCA.req' `
    -DatabaseDirectory 'D:\CertDB' `
    -LogDirectory 'E:\CertLog'
```

Use the HSM vendor's supported provider and options where applicable.

## Inspect and hash the request

The following read-only commands display the request's subject, public key, signature, and requested extensions and calculate the hash used for custody verification:

> [!NOTE]
> **Required privilege:** read access to the request.  

```powershell
certutil.exe -dump C:\CAConfig\IssuingCA.req
Get-FileHash -Algorithm SHA256 C:\CAConfig\IssuingCA.req
```

> [!NOTE]
> **Expected success:** subject contains the approved `<IssuingCAName>` and DN; key algorithm/size and signature request match the profile; hash is recorded independently.

Before signing a request, review the following:

- Subject and requested CA identity.
- Public-key algorithm and size/curve.
- Basic Constraints request appropriate to a CA.
- Signature and provider evidence.
- Any policy or extension requests.
- Request hash and custody record.

Don't sign a request based only on its filename or source host.
