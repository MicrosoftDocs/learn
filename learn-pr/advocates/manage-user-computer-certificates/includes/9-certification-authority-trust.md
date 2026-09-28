Trusting a root changes which CA hierarchies an application might accept. Treat that change as a security decision with an owner, scope, approval record, and rollback plan.

## Verify the CA before import

Obtain the root and intermediate public certificates from the CA owner through an approved channel. A client doesn't need the CA's private key. A package that includes a CA private key isn't a normal trust-distribution package.

Compare the CA certificate's fingerprint with a value obtained through an independently authenticated channel. Confirm which algorithm produced the expected value. A matching subject name or a valid self-signature isn't sufficient.

Hash the certificate's DER bytes when comparing a certificate fingerprint. A file hash can differ when the same certificate is encoded as PEM or Base64 text.

For a DER-encoded certificate file, calculate its SHA-256 certificate fingerprint without importing it:

```console
certutil.exe -hashfile "C:\CertWork\approved-root.cer" SHA256
certutil.exe -dump "C:\CertWork\approved-root.cer"
```

For PEM or Base64 input, decode the certificate to DER before hashing because a text-file hash isn't the certificate fingerprint. Compare the result before continuing. Also inspect basic constraints, key usage, validity, and the expected hierarchy. A technically valid CA certificate can still be an unauthorized trust anchor.

## Install roots and intermediates in the correct stores

Choose user scope when the approved requirement is limited to that user's Windows trust context. Choose machine scope when the device's services or all affected users need the trust. Machine trust has a broader impact.

To install root and intermediate CA certificates in the correct stores:

1. Open the correct console and expand **Trusted Root Certification Authorities**.
1. Open **Certificates** and select **All Tasks** > **Import** from its shortcut menu.
1. Import the verified root public certificate into that explicitly selected store. Review and accept any trust warning only after the approval checks.
1. Import each approved intermediate under **Intermediate Certification Authorities** > **Certificates**.
1. Validate an end-entity certificate from the intended hierarchy and then test the consuming application.

To perform these steps from the command line, run the following commands. If importing CAs in the machine-context, ensure you're running an elevated prompt:

```console
certutil.exe -addstore Root "C:\CertWork\approved-root.cer"
certutil.exe -addstore CA "C:\CertWork\approved-intermediate.cer"
```

For approved user-scoped trust, add `-user` to each command and run as the intended user. Don't import an intermediate CA into the Root store to make an incomplete chain appear acceptable.

A server certificate in Personal doesn't authorize its issuer. A root CA in the Root store doesn't correct a wrong SAN, EKU, expiry date, or revoked leaf certificate.

## Replace or remove trust deliberately

During CA replacement, clients might need both old and new trust paths while valid certificates remain in use. Account for intermediate changes, cross-certificates where applicable, and the path the actual application builds.

Record the exact certificate thumbprint and deployment source. Before removal, identify dependent services, validate the replacement path, and retain the approved public certificate and policy configuration needed for rollback.

Inspect only the approved local trust entry before removal:

```console
certutil.exe -store Root "<RetiredRootThumbprint>"
```

After approval, remove that exact entry and recheck the store:

```console
certutil.exe -delstore Root "<RetiredRootThumbprint>"
certutil.exe -store Root "<RetiredRootThumbprint>"
```

Native deletion has no preview mode. Policy-managed trust should be removed through the authoritative policy or management service rather than by repeating a local command.

Removing a root isn't the same as revoking an end-entity certificate. Explicit distrust through Disallowed is also a separate policy action. Escalate compromise of a CA to the PKI and security owners rather than making uncoordinated local changes.
