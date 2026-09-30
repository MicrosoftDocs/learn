The following matrix summarizes the prerequisites, expected failures, and prohibited fallback for high-impact certificate scenarios. Use it as a release gate: a profile isn't ready merely because enrollment succeeds.

| Scenario | Prerequisites and trust decision | Expected failure modes | No unintended fallback |
|---|---|---|---|
| TLS server | Controlled DNS ownership, supported provider/algorithm, server-only EKU, trusted chain, private-key ACL, and client name validation | Wrong SAN, untrusted/revoked chain, inaccessible key, unsupported signature, service selects old certificate | Don't enable CA-wide SAN acceptance or use a multipurpose/exportable template to make enrollment succeed |
| Domain controller/Kerberos | Enterprise CA trust, AD-built DC/domain DNS identities, supported DC/client algorithms, KDC/Smart Card/Server/Client EKUs as required, tested autoenrollment | Missing KDC EKU, old DC template selected, LDAPS client rejects name/chain, renewal leaves multiple candidates | Don't publish all three DC templates to the same population or disable client validation |
| NPS/802.1X | Supplicants trust the NPS chain/name; NPS trusts/maps client UPN or DNS and evaluates Client Authentication/policy OID; noninteractive key access | NPS certificate absent from EAP UI, client rejects NPS name, NPS rejects mapping/EKU/revocation, user/computer context mismatch | Don't disable server validation or fall back to password because certificate policy is incorrect |
| Enrollment agent | Named operator/service, hardware-protected nonexportable agent key, Certificate Request Agent EKU, manager approval, target template authorized signature, CA agent restrictions, full audit | Agent certificate expired/revoked, signature count/policy wrong, target identity not permitted, CA restriction denies request | Don't grant a broad agent, remove target signatures, or manually issue around a failed authorization gate |
| TPM attestation | Supported client, TPM, CA, v4 template, RSA with Microsoft Platform Crypto Provider, and CA trust configuration for the selected attestation model | TPM unavailable/unready, EK absent/untrusted, wrong provider, invalid evidence, unsupported client, CA validation denial | Use **Required**, not **Required, if client is capable**, when hardware binding is an assurance requirement |

A smart-card user-authentication variant requires a dedicated user profile with AD-built UPN SAN, Smart Card Logon and Client Authentication only where relying systems require both, a nonexportable card key, trusted domain-controller Kerberos certificates, and tested account mapping. Card issuance failure must enter an approved recovery/identity-proofing process, not a software-exportable certificate fallback.

## TPM key-attestation profile

A Trusted Platform Module (TPM) can be used to secure a certificate's private key. TPM key attestation is the ability of the entity requesting a certificate to cryptographically prove to a CA that the RSA key in the certificate request is protected by either "a" or "the" TPM that the CA trusts.

TPM protection alone means a provider generated or stored a key in a TPM; **key attestation** lets the CA validate evidence that the certified key is TPM-bound. Document:

You can test this process using the following procedure:

1. Duplicate a suitable v4-capable computer authentication template.
1. Set CA compatibility to Windows Server 2012 R2 or later and recipient compatibility to Windows 8.1/Windows Server 2012 R2 or later.
1. On **Cryptography**, select **Key Storage Provider**, **RSA**, and **Requests must use one of the following providers**. Select only **Microsoft Platform Crypto Provider** and a key size supported by the pilot TPMs and the approved profile.
1. On **Request Handling**, clear **Allow private key to be exported** and **Archive subject's encryption private key**.
1. On **Key Attestation**, choose **Required**, select only the approved trust model or models, and keep **Include Issuance Policies** selected.
1. Complete the selected model's CA trust configuration before publication. For Endorsement certificate or Endorsement Key, verify the pilot TPM's trust. User credentials doesn't require an EKCA/EKROOT store or EKPub allowlist.
1. Grant the pilot group Read and Enroll, preserve Read for each issuing CA, and add Autoenroll only if computer autoenrollment policy is configured for this test. Don't publish a nonattested fallback template to the same group.
1. Publish only to the approved pilot CA using the template publication procedure in the available certificate templates unit, then attempt enrollment from one supported and one intentionally unsupported test device.
1. Inspect the issued certificate's certificate-policies extension and record the matching CA request. Expect `1.3.6.1.4.1.311.21.30` for Endorsement Key, `1.3.6.1.4.1.311.21.31` for Endorsement certificate, or `1.3.6.1.4.1.311.21.32` for User credentials. When multiple approved models succeed, record each corresponding OID. Also verify the local provider/private-key association.
1. Confirm the unsupported device received no certificate. Record the CA denial if its request reached the CA; otherwise record the client-side failure. Don't require a CA denial event for a request the client never submitted.

## Five approved reference profiles

Maintain a small catalog of approved Certificate Template profiles. The following examples are reference decisions rather than universal defaults; each implementation still needs an owned design record, relying-party validation, and a retirement plan.

- TLS server certificate
- Domain controller and Kerberos authentication certificate
- User or computer client-authentication certificate for 802.1X
- Encryption certificate with key archival
- Enrollment-agent-certificate

### TLS server certificate

The server platform owner is accountable for Windows and approved non-Windows TLS clients. For host-only services, build DNS identity from AD DS; aliases require a controlled inventory and approval path. Limit purpose to Server Authentication, and include an assurance OID or CPS reference only when clients enforce the claim. Use an approved KSP or HSM with RSA 3072, or organization-approved ECC only when every consumer supports it, and use SHA-2.

Use a short, automated lifetime with enough overlap for repeated renewal attempts, and generate a new key at the defined rotation interval or whenever the provider or algorithm changes. The key should be nonexportable and not archived. Grant enrollment to `<TLS-Server-Enrollers>`; enable Autoenroll only for AD-built identities and require approval for exceptional aliases. During decommissioning, replace service bindings and validate live TLS before unpublishing the template, inventorying remaining certificates, and revoking or removing them as approved.

### Domain controller and Kerberos authentication certificate

The AD DS service owner is accountable for Kerberos clients, LDAP/TLS clients, and smart-card sign-in. Build the domain controller DNS and required domain DNS identities from AD DS and never accept them from the requester. Retain Server Authentication, Client Authentication, Smart Card Logon, and KDC Authentication because controlled DC services use those related purposes; add no unrelated EKUs. Select an algorithm and provider supported by every DC and authentication client, and keep the machine key nonexportable and unarchived.

Use Autoenroll with enough overlap for repeated attempts, but generate a new key after compromise or a provider, algorithm, or key-size change. Grant Read, Enroll, and Autoenroll to a dedicated DC group. Don't impose manager approval that could strand unattended renewal. When replacing the profile, verify Kerberos and LDAPS certificate selection in each site before unpublishing the predecessor and removing old certificates.

### User or computer client-authentication certificate for 802.1X

The network access owner is accountable for NPS and managed supplicants. Build a user's UPN or a computer's DNS identity from AD DS, and use Client Authentication as the only EKU unless a separately justified purpose exists. An NPS policy OID is useful only when network policy actually enforces an assurance tier. Use a nonexportable KSP or TPM-backed key where supported and an algorithm accepted by both NPS and supplicants; don't archive the authentication key.

Create separate user and computer templates when their identities, stores, or renewal behavior differ. Autoenrollment must tolerate offline periods, while material assurance or profile changes require a new key. Grant Read, Enroll, and Autoenroll to separate scoped groups rather than broadly to Authenticated Users. To retire the profile, migrate network policy and supplicant configuration, verify successful access with the replacement, then unpublish and remove obsolete credentials.

### Encryption certificate with key archival

The data-protection owner is accountable for the named encryption application and its authorized recovery process. Build the required user or service identity from AD DS and limit the certificate to the application's encryption purpose. Include an assurance or recovery-policy OID and maintained CPS only when consumers use them. The provider and algorithm must support both the application and the CA archival exchange, with a strong key and SHA-2 certificate signature.

Disable ordinary endpoint export but configure the CA to archive the encryption private key. Renew according to the application's data-access requirements, rotating the active key while preserving older private keys needed to decrypt retained data. Restrict enrollment to a narrow data-user group, enable autoenrollment only after proving the application lifecycle, and use manager approval when business authorization is manual. At decommissioning, stop new enrollment but preserve archived keys and certificates for the full data-retention period.

### Enrollment-agent certificate

PKI enrollment operations own the agent profile, while the CA policy module and approved target templates are its relying controls. Build the named operator or service identity from AD DS and limit the EKU to Certificate Request Agent. Add a dedicated high-assurance policy OID only if policy enforcement gives it meaning. Protect the nonexportable signing key in hardware and require interactive operator protection where feasible; never archive it.

Use a short validity period, controlled manual renewal, and a new key whenever the operator or role changes. Membership of the agent enrollment group must remain very small, manager approval should govern issuance, target templates must require the authorized signature, and CA enrollment-agent restrictions must limit subjects and templates. At decommissioning, remove authorization, revoke the agent certificate, verify status publication, remove the key, and retain the complete audit trail.

## Key backup, archival, recovery, and renewal

The key backup, key archival, key recovery and certificate renewal lifecycle operations solve different problems.

- **Key backup** copies a key under endpoint or HSM backup controls and isn't automatically tied to a CA database record.
- **Key archival** transports an eligible encryption private key to the CA during enrollment, encrypted to one or more **key recovery agent (KRA)** certificates. 
- **Key recovery** uses CA authorization and a KRA private key to extract that archived key so protected data can be decrypted.
- **Certificate renewal** merely issues another certificate and may reuse or replace the endpoint key; it can't recover a key that was lost before it was archived or backed up.

> [!NOTE]
> Archive keys for business data encryption only when data must survive user/device key loss. Don't archive TLS, code-signing, smart-card, KDC, 802.1X, or general authentication keys merely for convenience.

## Procedure: Configure KRA and recover an archived encryption key

A KRA can recover archived private keys. In this procedure you will issue a KRA certificate, enable CA archival, configure an encryption template, and recover one authorized archived key. This procedure requires the following privileges:

- Template administrator for KRA/encryption templates
- CA Admin to configure Recovery Agents
- Designated KRA holder to decrypt recovery material
- Data owner/security approval for an actual recovery.  

To complete this procedure:

1. In `certtmpl.msc`, duplicate **Key Recovery Agent** if policy requires a custom profile. Grant Enroll only to `<KRA-Holders>` and require approval.
1. Publish the KRA template. As the designated KRA account, enroll into the **Current User** personal store.
1. Open **Certificates MMC** for Current User and verify the KRA certificate, private-key association, validity, chain, and Key Recovery Agent application policy. Export an approved protected backup only under dual control.
1. On `<CAName>`, open **CA Properties** > **Recovery Agents**. Select **Archive the key**, add the valid KRA certificate, and apply the service restart through the change plan.
1. Duplicate an encryption template. On **Request Handling**, select **Archive subject's encryption private key**; on **Cryptography**, use a provider that supports key archival; retain encryption-only usages.
1. Publish to a test group, enroll, and confirm the issued request indicates archived key material before testing recovery.

Use the following command on the CA that holds the approved certificate record to extract its archived key blob. This explicit retrieve operation doesn't yet produce an importable PFX.

```powershell
certutil.exe -getkey "<SerialNumber>" retrieve recovered
```

The command will report successful retrieval of the one approved archived-key candidate and writes a recovery blob whose filename contains the `recovered` base, a certificate-specific string, and the `.rec` extension. Record the exact output path as `<RecoveryBlobFile>`.

The designated KRA holder must have the applicable KRA certificate and private key in that account's **Current User** personal store. Securely transfer the exact recorded recovery blob to that holder, who then uses the following command to decrypt it and protect the recovered key in a password-encrypted PFX. The `-user` option selects the KRA holder's user certificate store; don't move the KRA private key to the CA or replace this split workflow with one-step `-getkey ... recover`.

```powershell
certutil.exe -user -recoverkey "<RecoveryBlobFile>" recovered.pfx
```

Running this command will generate the file `recovered.pfx`. You can import this using the set password. 

> [!WARNING]
> **Sensitive key material**: Verify `<SerialNumber>` against the approved recovery ticket before extraction. Keep `<RecoveryBlobFile>` and `recovered.pfx` on encrypted, access-controlled storage; audit custody; validate data recovery; then securely destroy transient copies according to policy. Separate CA Admin, KRA holder, data owner, and auditor where staffing permits.

## Operational risks

The following are operational risks related to certificate templates:

- Forest-replicated template changes can affect every enterprise CA after replication.
- Template safety can be defeated by CA-wide SAN acceptance, broad CA permissions, or an enrollment interface with unsafe delegation.
- Broad authentication EKUs, exportable keys, enrollment-agent rights, and template Write permission are credential-escalation risks.
- Compatibility, provider, and algorithm changes can create silent policy-discovery or application failures.
- Supersedence and unpublication don't neutralize certificates already issued.
- Manager approval and KRA processes create availability and insider-risk dependencies.
- Multiple valid DC, NPS, or TLS certificates can leave services using the wrong credential.
