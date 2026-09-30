An Active Directory Domain Services (AD DS) certificate template is a forest-wide set of rules and settings that tells an Active Directory Certificate Services (AD CS) enterprise certification authority how to process certificate requests and tells clients how to create and submit them. It defines identity, cryptography, certificate purpose, validity, enrollment permissions, and issuance requirements for a specific workload.

Only an **enterprise CA** can issue a certificate based on an AD DS certificate template. Enterprise CAs must be domain joined. A standalone CA can apply its local policy to PKCS #10 or CMC requests, but it doesn't retrieve and enforce enterprise template objects, even when members of an Active Directory domain. Don't describe a standalone request that contains a template name as template-based issuance.

> [!NOTE]
> In a two-tier hierarchy, the offline standalone root CA issues only subordinate-CA certificates and revocation information. It remains offline and never publishes end-entity templates. Enterprise issuing CAs perform all template-based issuance.

Templates are objects beneath the Public Key Services container in the **Configuration naming context**, so one forest owns one template catalog that replicates to every domain controller, not merely within the domain where an administrator edited it. Every enterprise CA in that forest can discover a replicated template, but a CA can issue from it only after the template is explicitly published on that CA.

A saved change doesn't reach every CA, client, or administrative console when the administrator selects **OK**. Its arrival depends on AD DS site topology, replication health, policy caches, and service refresh. Because a malformed or over-permissive change therefore has forest-wide potential, delegate template administration more narrowly than ordinary enrollment. Before publication, verify Configuration partition convergence from the sites that host issuing CAs and pilot recipients; when rollback is required, keep the previous template published during a controlled overlap.

The **template name** is the programmatic identifier assigned when a template is created and used by CAs, request attributes, scripts, and supersedence references. Treat it as immutable. The **display name** is the operator-facing label and can be edited, but changing it can still confuse runbooks and inventories. When a material profile change needs a new name, duplicate the template, assign a versioned template name, publish the replacement on each intended CA, and update supersedence deliberately.

## Template schema

Template schema version describes the attributes and behaviors stored on the object. The **Compatibility** tab constrains which settings the console exposes and which CA and recipient versions may consume them. A later Windows Server release doesn't imply a new template schema version. The following table compares the four enterprise template schema versions and the design constraints that each introduces.

| Template schema | Directory/OS origin and practical gate | Principal capabilities | Design consequence |
|---|---|---|---|
| Version 1 | Windows 2000 forest schema; Windows 2000-era enterprise CA and recipient compatibility | Fixed built-in behavior; security ACL is the main editable control; legacy computer enrollment behavior | Retain only for an evidenced legacy dependency. Duplicate rather than trying to modernize the built-in. |
| Version 2 | Windows Server 2003 forest schema extension; Windows Server 2003 CA and Windows XP/Windows Server 2003 recipient floor when those compatibility values are selected | Fully configurable properties, autoenrollment, supersedence, issuance requirements, key archival | Baseline for many RSA/CSP profiles, but it can't express later CNG and attestation controls. |
| Version 3 | Windows Server 2008 forest schema extension; Windows Server 2008 CA and Windows Vista/Windows Server 2008 recipient floor | CNG/KSP providers, modern algorithm selection, ECC/Suite B-era capabilities | Selecting KSP/ECC excludes clients, services, HSM middleware, or tooling that only understands legacy CSP keys. |
| Version 4 | Windows Server 2012 forest schema extension; Windows Server 2012 CA and Windows 8/Windows Server 2012 recipient floor; some features require later compatibility | Additional renewal and private-key protection controls; foundation for later TPM attestation settings | Validate feature-specific requirements. TPM key attestation requires supported client/TPM/KSP and, for the documented deployment, Windows Server 2012 R2 CA and Windows 8.1/Windows Server 2012 R2 recipient compatibility or later. |

Schema extension is required before a newer template object can be represented. Forest functional level isn't a substitute for schema readiness and shouldn't be used as the sole gate. Record the forest schema version, the lowest issuing-CA OS, the lowest recipient OS, enrollment client API, provider/HSM version, and management-console version before selecting compatibility.

> [!NOTE]
> There hasn't been a new template version since the release of Windows Server 2012.

Use the following table to assess how a compatibility or cryptography change can affect enrollment clients and relying applications, and to select a rollback method that doesn't require editing the replacement profile in place.

| Change | Client/provider/tool effect | Rollback and migration control |
|---|---|---|
| Raise CA compatibility | Enables settings older CAs might not parse or enforce | Don't publish to an older CA. Preserve the old template object and CA publication until all issuers are validated. |
| Raise recipient compatibility | Hides the template from or causes enrollment failure on older recipients | Inventory actual recipients, including appliances and service hosts; pilot policy discovery before broad ACLs. |
| CSP to KSP | Existing CSP-bound applications or HSM middleware may not locate/use the new key | Issue a parallel profile; test service binding, backup, and renewal. A same-key renewal can't move a key between provider families. |
| RSA to ECC or another algorithm | Relying parties, TLS stacks, middleware, or inspection devices may reject the certificate or chain | Use an overlap profile and live relying-party tests. Roll back by selecting the old certificate, not by editing the new certificate. |
| Optional to required TPM attestation | Unsupported TPMs, absent endorsement certificates, or wrong providers fail enrollment | Never choose **Required, if client is capable** when attestation is an assurance requirement. Keep a separately authorized non-attested profile only for approved exceptions. |
| New template schema/feature | Older `certtmpl.msc`, enrollment APIs, scripts, and policy caches may omit or misrepresent settings | Administer with supported RSAT, export the approved design record, allow replication, and reverse publication instead of changing settings in place if the pilot fails. |

## Procedure: Install tools and inspect the forest catalog

> [!NOTE]
> The following placeholders are used throughout the module: `<CAName>`, `<TemplateName>`, `<SerialNumber>`, `<RequestId>`, `<CertificateFile>`, and `<RecoveryBlobFile>`. `<RecoveryBlobFile>` is the exact generated `.rec` filename or full path, not a literal filename or a wildcard. Commands are intentionally minimal.

Run the following command on the management host to install the AD CS administration tools, including the Certificate Templates console. It assumes that an enterprise issuing CA is already present in your AD DS environment:

```powershell
Install-WindowsFeature RSAT-ADCS
```

On Windows Server with Desktop Experience, perform the following steps:

1. Run `certtmpl.msc`. Confirm that the list is forest-wide.
1. Open a suitable built-in template read-only, then select **Duplicate Template** without saving.
1. Walk the **Compatibility**, **General**, **Request Handling**, **Cryptography**, **Subject Name**, **Extensions**, **Security**, and **Issuance Requirements** tabs.
1. On `<CAName>`, open **Certification Authority** > **Certificate Templates**. This shorter list is the CA's publication set.

You can also use the following command to distinguish the templates published by this CA from the larger forest-wide catalog shown in `certtmpl.msc`.

```powershell
certutil.exe -catemplates
```
