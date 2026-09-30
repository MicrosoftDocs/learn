A certificate profile starts with an identity and relying-party requirement. Cryptography, names, usages, lifetime, enrollment authority, and retirement must all support that same requirement. Don't start with a broad built-in such as **User** and remove settings until enrollment succeeds. 

> [!NOTE]
> The module uses standard X.509 and Windows cryptography terminology. The **Subject** names the certificate holder, while the **Subject Alternative Name (SAN)** carries typed identities such as DNS names or user principal names. **Key Usage** limits cryptographic operations, and **Extended Key Usage (EKU)** or application policy limits intended applications such as server or client authentication. An **object identifier (OID)** is the numeric identifier for a purpose or policy; a **certification practice statement (CPS)** explains the practices behind a policy claim. In Windows, a legacy **cryptographic service provider (CSP)** and a Cryptography Next Generation **key storage provider (KSP)** create and use keys. A **hardware security module (HSM)** or **Trusted Platform Module (TPM)** can protect keys in hardware, but only an attestation-capable design lets the CA verify TPM residence.

The following table turns the major template tabs and properties into one design review, so a safe setting in one row isn't evaluated in isolation from the others.

| Property/tab | Required design decision | Security consequence and validation |
|---|---|---|
| Template name / display name | Use an immutable machine name such as `Corp-TLS-Server-v2` and a descriptive display name with owner and version | Renaming breaks CA publication and supersedence references. Keep the object name in the profile register. |
| Compatibility | Lowest CA and recipient levels that support required features | Raising it can silently remove the template from older clients; lowering it can remove KSP, attestation, or renewal controls. |
| Validity / renewal | Set a lifetime supported by outage tolerance and automation; renewal period must allow repeated attempts before expiry | CA certificate remaining lifetime and CA policy can shorten issuance. Very long validity expands exposure; a tiny renewal window creates outages. |
| Request Handling | Select signature, encryption, or both only as the workload requires; choose user interaction, key reuse, exportability, and archival deliberately | Exportable authentication keys increase credential theft impact. "Renew with same key" extends key exposure and can't satisfy provider/algorithm/key-size migration. |
| Cryptography | Provider category (CSP/KSP), permitted providers, algorithm, minimum key size, and hash | Prefer supported modern providers and SHA-2. A minimum isn't a target if the provider can create an unsupported larger or different key; test actual output and workload support. |
| Subject Name | Prefer **Build from this Active Directory information** for managed users/computers; include only required DNS/UPN values | **Supply in the request** delegates identity assertion to the effective requester and must be paired with a trusted request path and issuance validation. |
| Key Usage | Digital signature, key encipherment, or key agreement only as technically required | Extra bits let software select the certificate for unintended operations even when EKU is constrained. |
| EKUs / Application Policies | One narrowly related purpose set | Client Authentication, Smart Card Logon, KDC Authentication, Server Authentication, and Enrollment Agent are credential-bearing purposes. Combining unrelated purposes increases theft impact and selection ambiguity. |
| Issuance policies / certificate policies | Use owned OIDs to express a defined assurance level; publish a maintained CPS URL if a relying party needs policy detail | An OID has no protective effect unless issuance enforces it and relying parties evaluate it. Policy mappings can broaden cross-domain trust; use only under formal policy governance. |
| Private-key export | Default **not exportable** for authentication and signing; allow only for documented mobility/cluster import where no non-export alternative exists | Export permits cloning. Compensate with protected PFX handling, scoped operators, audit, rotation, and deletion of transient copies. |
| Key archival | Enable only for encryption keys where loss would make business data unrecoverable | Archiving authentication or signing keys enables impersonation or repudiation disputes and normally has no recovery justification. |
| Superseded templates | Add only templates whose intended population and purpose are truly replaced | Supersedence guides enrollment selection; it doesn't revoke, delete, unbind, or remove old certificates. |
| Issuance requirements | Decide manager approval, authorized signatures, number/type of signatures, and reenrollment rules | Approval adds a human gate but isn't identity proof by itself. Authorized signatures transfer enrollment power to the signing agent. |
| Security | Grant Read, Enroll, and Autoenroll to groups; tightly restrict Write and Full Control | A principal with template Write can turn a safe profile into an authentication escalation path. Deny entries can be hard to reason about; prefer clean allow groups. |

## Minimal EKUs and multipurpose risk

An absent EKU extension can be interpreted by some consumers as unrestricted purpose. A broad **Any Purpose** EKU is similarly unsafe. Include the exact EKU set required by each relying party and test that it rejects a certificate outside that set.

Avoid a single certificate that combines server TLS, client authentication, smart-card sign-in, encryption, or enrollment-agent use. Theft of one exportable or service-accessible key would compromise every accepted purpose, and Windows or an application might select a different matching certificate than the operator expects. Several identity forms can also make AD account mapping ambiguous, while a relying party may honor Client Authentication even though the profile owner assessed only Server Authentication. The lifecycle requirements conflict as well: recoverable encryption and nonrecoverable authentication shouldn't share a key because archival, renewal, and access controls can't satisfy both assurance models safely.

Related purposes can coexist only with explicit reliance evidence. For example, a domain controller profile may require Server Authentication, Client Authentication, Smart Card Logon, and KDC Authentication because DC services consume them as one controlled identity. This isn't a precedent for general multipurpose templates.

## Policy OIDs, CPS pointers, and mappings

Application policies/EKUs constrain what a key may be used for; issuance-policy OIDs assert how strongly the issuer validated or controlled issuance. The X.509 Certificate Policies extension can carry those policy OIDs plus CPS or user-notice qualifiers. These controls aren't interchangeable.

Create an OID only after defining its issuer, assurance claim, approval authority, issuance controls, audit evidence, and retirement rule. A CPS pointer should resolve through a resilient HTTPS location and describe the actual process. Policy mappings between certification domains are trust decisions: they can cause one policy to be treated as equivalent to another during path processing. Require legal/security ownership, explicit relying-party tests, and path-validation behavior before use. If a relying application merely displays or ignores the OID, the OID doesn't enforce assurance; configure the application/NPS rule to require it or remove the unsupported claim.

Test at least:

- A conforming certificate is accepted by each intended relying party.
- The same identity with a missing/wrong EKU is rejected.
- The same identity with a missing/wrong policy OID is rejected when policy is intended to be mandatory.
- Chain engines and non-Windows applications process policy constraints and mappings as designed.
- Renewal preserves or intentionally changes the policy extension.

## Procedure: Duplicate and configure a TLS template

To duplicate and configure a TLS certificate, sign on to an enterprise issuing CA with Domain Admin or delegated template administrator privileges and perform the following steps:

1. In `certtmpl.msc`, open the shortcut menu for **Web Server**, then select **Duplicate Template**.
1. **Compatibility**: Choose the lowest validated CA and recipient versions.
1. **General**: Set display name `Corp TLS Server v2`, template name `Corp-TLS-Server-v2`, approved validity, and renewal period.
1. **Request Handling**: Signature/encryption as required by the TLS stack; clear **Allow private key to be exported**; don't archive.
1. **Cryptography**: Select the approved KSP/provider, RSA or ECC algorithm, minimum key size, and SHA-2 hash supported end to end.
1. **Subject Name**: For domain computers, select **Build from this Active Directory information**, an appropriate subject format, and **DNS name** in SAN.
1. **Extensions**: Retain only Server Authentication (`1.3.6.1.5.5.7.3.1`) and required Key Usage. Add an issuance policy only if a relying party enforces it.
1. **Security**: Remove broad enrollment entries; grant Read and Enroll to `<TLS-Server-Enrollers>`; grant Autoenroll only if the template renewal, replacement, retirement unit lifecycle is approved.
1. **Issuance Requirements**: Add approval or signatures only when the assurance model requires them.
1. Save, record the object and display names, and wait for AD DS replication before any publication test.

> [!WARNING]
> **Security consequence:** Saving creates a forest-replicated policy object. Don't grant broad Enroll rights or publish the draft.  

There is no supported first-party PowerShell cmdlet that safely exposes every template property. Use the MMC for the controlled change and separate verification on the CA and issued certificate; don't normalize direct AD attribute editing as routine automation.
