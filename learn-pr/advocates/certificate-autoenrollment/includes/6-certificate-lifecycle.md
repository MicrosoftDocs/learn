Certificate renewal and replacement keep credentials valid as certificates expire or identity and security requirements change. When considering certificate lifecycle, plan whether to reuse or replace the private key, verify that the intended service uses the new certificate, and retire obsolete certificates and keys without disrupting services or losing access to encrypted data.

Decide whether the change concerns only the certificate or also its identity and private key before triggering enrollment. If the Subject, SAN source, or represented identity changes, issue a replacement request and verify the corrected names. Renewal may copy names from the old certificate, especially when **Use subject information from existing certificates for autoenrollment renewal requests** is enabled, so it can't be assumed to remove an obsolete identity.

A CSP-to-KSP or other provider change requires a new key because provider ownership can't be migrated through same-key renewal. Algorithm changes and minimum-key-size increases also require a new key that meets the target profile, followed by relying-party testing. Treat a template schema, version, or compatibility change as replacement whenever it changes client eligibility, provider behavior, key requirements, or identity construction; pilot both policy visibility and issuance before broad rollout.

If only certificate lifetime changes, same-key renewal may be acceptable when key age and exposure remain within policy. Compromise, ownership transfer, or unauthorized export is different: revoke the affected certificate as approved, repair access, and replace it with a newly generated protected key. Never reuse a key whose custody is no longer trustworthy.

KBR authenticates a renewal with the existing certificate key; it doesn't require the newly issued certificate to reuse that key. Conversely, same-key renewal doesn't prove the remote requester crossed an acceptable authentication boundary.

## Procedure: Prove key behavior and active certificate

To replace a certificate after a provider/identity/profile change, determine whether the key changed, and prove the intended certificate is active before cleanup, perform the following steps:  

1. Record the old thumbprint, serial, template, provider, key-container identifier, subject/SAN, expiry, service binding, and revocation status.
1. Trigger renewal or a new enrollment under the actual identity. For provider, algorithm, key-size, identity, or material template changes, request a new key.
1. In Certificates MMC, compare old/new properties and private-key association. Archived view can reveal which certificate autoenrollment superseded.
1. Use the following read-only inspection for each thumbprint in the correct user/computer context:

```powershell
certutil.exe -store my "<Thumbprint>"
```

Provider and key-container information show whether the same private key was reused. Different certificate thumbprints alone don't prove a different key. Installing a certificate doesn't guarantee that a service uses it. Follow these steps to activate the new certificate, verify its use in a live service test, and retire obsolete certificates and keys after checking rollback, decryption, and recovery requirements.

1. Update the service/NPS/IIS/application binding through its supported interface. Perform a live TLS, EAP, signing, or decryption test and observe the presented/selected certificate.
1. Keep a bounded rollback overlap. Then remove obsolete bindings and certificates. Revoke only for compromise, unauthorized issuance, or policy requiring status invalidation; confirm CRL/OCSP publication and relying-party behavior.
1. Remove an old private key only after proving it isn't needed for decryption, rollback, archival recovery, or retained signatures. Document final state.

> [!WARNING]
> **Revocation, certificate removal, and private-key deletion can cause immediate outage or permanent data loss**: Preserve rollback and any decryption/signature-validation dependency, verify the new live binding from a relying client, obtain service-owner approval, and confirm revocation publication health before continuing.

Supersedence, successful renewal, and a newer NotBefore date don't automatically revoke, delete, or deactivate the predecessor certificate. 

## Key decisions

Use the following questions to review an AD CS enrollment design against this module's guidance. Consider the full certificate lifecycle, not just request submission, so the chosen methods meet identity, private-key protection, authentication, renewal, and cleanup requirements.

- Which method proves the required user, computer, service, or device identity at the correct boundary?
- Where is the private key generated, and can the chosen method enforce software, TPM, smart-card, or HSM custody?
- Is automatic initial enrollment required, or only HTTPS renewal for an already provisioned credential?
- Which CEP/CES authentication mode and constrained-delegation scope are justified?
- Is CA Web Enrollment retained only for an exceptional manual file workflow?
- How does NDES bind one-time authorization and template mapping to a managed device?
- Which profile changes require a new key, and how will service activation and old-certificate cleanup be verified?

## Operational risks

Successful certificate issuance doesn't prove that an enrollment design is secure or that future renewals will succeed. Use the following risks to guide testing and monitoring across requester identity, credential protection, service availability, and certificate cleanup.

- Testing as an administrator can mask target identity, provider, proxy, and delegation failures.
- A visible template can still fail at key generation, submission, CA disposition, retrieval, installation, or activation.
- Username/password CEP/CES bootstrap exposes reusable credentials if TLS, endpoint identity, or logging is weak.
- Unconstrained or overly broad CES delegation converts a web-tier compromise into CA-side impersonation.
- A single opaque load-balanced URI can disable native CEP/CES endpoint failover.
- NDES RA keys, service identity, challenge endpoint, and broad template mapping are high-value authorization assets.
- Renewal and supersedence can leave old credentials active; premature deletion/revocation can cause outages.
- CA Web Enrollment is manual legacy functionality, not modern automated enrollment over HTTPS.
