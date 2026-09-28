Inspection establishes what a certificate represents, where it resides, and whether it's a candidate for the intended task. 

In the appropriate console, expand **Personal** > **Certificates**. Sort by expiration date or intended purpose. Use **Action** > **Find Certificates** when the store contains many entries, and confirm the search scope.

To inspect a certificate in the 

- **General** summarizes its purpose, validity, and private-key association. The message that a corresponding private key exists doesn't prove that another account can use it.
- **Details**, inspect the subject, issuer, SAN, EKU, key usage, basic constraints, public-key algorithm and size, signature algorithm, serial number, and thumbprint. Template information can identify an enterprise enrollment source. A friendly name is an editable local label, not a signed identity.
- **Certification Path**, inspect every certificate and its reported status. A locally successful path doesn't prove that another computer has the same intermediates, trust policy, or network access.

:::image type="content" source="../media/certificate-details.png" alt-text="Screenshot of a certificate Details tab with the Subject field selected." lightbox="../media/certificate-details.png":::

Compare renewed certificates by thumbprint, validity, and key information rather than subject alone. Two certificates with the same subject can represent different issuance events and different keys.

## Inspect exact certificate objects

List each Personal store, then inspect an exact certificate by full thumbprint:

```console
certutil.exe -user -store My
certutil.exe -store My
certutil.exe -store My "<CertificateThumbprint>"
```

Add `-user` to the final command when the certificate is in Current User Personal. Inspect the subject, issuer, serial number, validity, extensions, provider, and key-container information. The SAN extension has object identifier (OID) `2.5.29.17`; inspect that extension rather than treating the subject common name as a DNS SAN.

Key-container information indicates an association. It isn't a test of service permissions, hardware availability, PIN requirements, or the requested cryptographic operation.

## Find certificates by purpose and expiry

In the Certificates snap-in, sort by **Expiration Date** or **Intended Purposes**, or use **Action** > **Find Certificates**. Confirm each candidate by full thumbprint and inspect the actual SAN, EKU, `NotBefore`, and `NotAfter` values.

Server Authentication uses OID `1.3.6.1.5.5.7.3.1`. A certificate without an EKU extension can be treated as unrestricted by some consumers, but an application can still require an explicit EKU. Separate already-expired and not-yet-valid certificates from certificates approaching expiry before creating an action queue.

## Produce an actionable inventory

An inventory needs certificate properties and operational ownership. Capture diagnostic store listings, then associate each certificate with its consuming application, owner, and renewal mechanism in your management system.

```console
certutil.exe -user -store My > C:\CertWork\user-personal-store.txt
certutil.exe -store My > C:\CertWork\computer-personal-store.txt
```

These files contain public certificate metadata, provider details, and potentially internal names or account identities, but not private-key material. Treat them as operational information, verify important fields in MMC, and sanitize extracts before sharing them.
