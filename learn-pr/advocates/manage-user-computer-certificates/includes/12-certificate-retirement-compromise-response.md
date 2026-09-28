Retirement removes material that no longer serves an approved purpose. It requires dependency checks because a certificate's age doesn't reveal every application or data dependency.

## Distinguish four different actions

Deleting a certificate removes a local store entry. Deleting its private key removes cryptographic material. Revoking a certificate changes the issuer's published status. Removing or explicitly distrusting a CA changes local or managed trust.

Those actions aren't interchangeable. Deleting a certificate from one computer doesn't invalidate a copied PFX elsewhere. Revocation doesn't delete the key on an endpoint. Removing a root can affect many unrelated leaf certificates.

Removing a certificate store entry doesn't necessarily remove its associated private key. Several certificates can reuse the same key, so separate key deletion can break a certificate that you didn't remove.

## Remove only the approved target

Before retirement, confirm the exact thumbprint, store, application dependencies, historical decryption needs, and any required recovery copy. Confirm that the replacement works.

Inspect an exact user certificate and record its key-container name before removal:

```console
certutil.exe -user -store My "<RetiredCertificateThumbprint>"
```

After approval, remove that exact store entry:

```console
certutil.exe -user -delstore My "<RetiredCertificateThumbprint>"
```

Native deletion has no preview mode. Delete a recorded key separately with `certutil.exe -user -delkey "<KeyContainerName>"` only when key destruction is explicitly approved and the key isn't shared with another retained certificate.

For machine certificates, omit `-user` and use elevation. In MMC, confirm the thumbprint before selecting **Delete** from the certificate's shortcut menu. Don't assume a graphical or command-line certificate deletion proves that every associated key or backup copy is gone.

Never pipe every expired certificate into deletion. An expiry report is an investigation queue, not an authorization to destroy keys.

## Respond to a compromised key

Treat suspected key exposure as a security incident. Identify affected certificates and consumers, generate a replacement key, obtain a new certificate, and coordinate revocation with the CA owner.

Revocation is effective when relying applications obtain and honor current status information. CRL publication, cache lifetime, network access, and application policy affect that timing. Local deletion alone doesn't contain a leaked key.

Preserve necessary incident evidence and follow the organization's handling requirements for backups and exported packages. Don't continue distributing a known-compromised PFX merely because it still imports successfully.

CA compromise requires coordinated trust changes and broader assessment. Escalate to the PKI and security owners rather than trying to resolve it through independent workstation root-store edits.
