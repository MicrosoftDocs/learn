The following table compares the three built-in domain controller certificate profiles. Use it to choose a supported starting point and to understand why publishing overlapping profiles can produce multiple valid certificates and ambiguous service selection.

| Profile | Subject/SAN behavior | EKUs and dependencies | Enrollment/compatibility decision |
|---|---|---|---|
| **Domain Controller** | Legacy v1 construction; lacks the modern domain-DNS SAN behavior expected by newer Kerberos designs | Server Authentication and Client Authentication; no explicit KDC Authentication EKU | Retain only for proven legacy dependencies. V1 settings aren't a modern design surface and configurable autoenrollment is limited. |
| **Domain Controller Authentication** | V2 AD-built DC identity with DNS SAN support | Server Authentication, Client Authentication, and Smart Card Logon; supports LDAP/TLS and smart-card logon scenarios but lacks explicit KDC Authentication | Better than the legacy template where older compatibility is required; duplicate and validate rather than editing. |
| **Kerberos Authentication** | AD-built DC identity; includes the DC DNS identity and the domain DNS identity required for KDC service validation on supported systems | Adds KDC Authentication (`1.3.6.1.5.2.3.5`) to Server Authentication, Client Authentication, and Smart Card Logon | Preferred starting point for a modern DC profile when all DCs and relying components support it. Use autoenrollment with a DC security group and controlled overlap. |

> [!WARNING]
> Don't publish all three indefinitely. Multiple valid DC certificates cause service-selection ambiguity. Inventory LDAPS, Kerberos Public Key Cryptography for Initial Authentication (**PKINIT**) and smart-card sign-in, replication, monitoring, and third-party LDAP consumers; pilot one DC per site; verify live service selection before unpublishing the predecessor.

## Server TLS reference behavior

A server TLS certificate is accepted because the connecting client can build a valid chain, the certificate is time-valid and not revoked, Server Authentication is present, the requested DNS name matches SAN, and the TLS stack supports the key/signature algorithms. Enrollment success proves none of those relying-party conditions.

For automatic Windows server enrollment, build the DNS SAN (Subject Alternate Name) from AD DS unless a controlled service inventory must assert aliases. A computer can have service aliases that are absent from its computer object, but globally enabling requester-supplied SANs would let a broad population assert names that AD DS doesn't authorize. Handle approved aliases through a separate profile with explicit requester authorization and name validation.

Keep server private keys nonexportable and validate that the application service account can use the key without receiving broad file-system or local-administrator rights. In a server farm, prefer per-node keys and load-balancer termination where possible. If an application genuinely requires a shared key, document protected distribution, access auditing, coordinated renewal, and removal of old copies.

## NPS and 802.1X profiles

NPS server authentication and 802.1X client authentication are separate profiles because the server proves the network's identity to the supplicant, while the user or computer proves its identity to NPS. **EAP-TLS** is the Extensible Authentication Protocol method that uses TLS certificates for this mutual authentication. The following table distinguishes the certificate identity and validation requirements on each side of that exchange.

| Component | Required identity/use | Important constraints |
|---|---|---|
| NPS server certificate | Nonempty Subject, Server Authentication EKU, and normally server DNS SAN; chain trusted by supplicants | NPS doesn't offer certificates lacking Server Authentication or a Subject. Configure clients to validate the server name and approved root; otherwise a trusted but unintended server can solicit credentials. |
| Computer EAP-TLS certificate | Client Authentication EKU and computer FQDN in DNS SAN; maps to the intended computer account | Private key must be accessible before user sign-in and usable without a password prompt. Scope NPS policy by certificate OID when assurance must be constrained. |
| User EAP-TLS certificate | Client Authentication EKU and user UPN in SAN; maps to the intended user | Don't combine recoverable encryption or broad smart-card purposes unless required. Test renewal in the user's context and roaming/profile behavior. |

Relying-party trust is two-way: supplicants validate the NPS server certificate, while NPS validates the client chain, EKU, identity mapping, revocation status, and network-policy conditions.

## Procedure: Validate a TLS/NPS candidate

**Objective**: Prove that an issued candidate contains the intended identity and purposes and is accepted by the actual relying service.  

To validate a TLS/NPS certificate, you need Local Administrator privileges on the server to inspect Local Computer keys and configure service binding; NPS administrator for NPS policy; no template privilege required for read-only inspection. To perform this task:

1. Run `mmc.exe`; add **Certificates** for **Computer account** > **Local computer**.
1. Inspect **Personal** > **Certificates**. Open the candidate and verify **Certification Path**, Subject, SAN, EKU, Key Usage, policy OIDs, validity, and "You have a private key that corresponds to this certificate."
1. For NPS, open the intended network policy's EAP settings and select the candidate server certificate after verifying its identity and certificate details. Other eligible certificates can also appear, including during renewal overlap. Configure supplicant policy to validate the approved NPS server DNS names and trusted root CA.

You can use the first command to validate the candidate's chain and revocation status from a certificate file, and the second to inspect machine personal-store certificates and their private-key associations.

```powershell
certutil.exe -verify -urlfetch "<CertificateFile>"
certutil.exe -store my
```
