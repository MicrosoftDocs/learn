A digital certificate is a signed electronic credential that associates a public key with the identity of a user, computer, service, or organization. Windows commonly uses the X.509 format, which records the certificate holder's identity, public key, issuer, serial number, validity period, and extensions that can define permitted uses and other constraints. The issuer, usually a certification authority (CA), signs this information so applications can detect changes and verify the signature with the issuer's public key. Certificates support authentication, digital signature verification, and encryption by giving applications a basis for deciding which public key to use. A certificate doesn't contain its associated private key or establish trust by itself. Before accepting it, an application evaluates its identity, intended use, validity, trust chain, and revocation information according to policy.

## A certificate is different from a key

The main elements of an X.509 certificate include:

- **Version:** Specifies the X.509 format version, typically version 3, which supports extensions.
- **Issuer name:** Identifies the CA or other entity that signed the certificate.
- **Serial number:** Identifies the certificate uniquely within its issuer's namespace.
- **Public key:** The shareable part of a key pair, used to verify signatures or support encryption, depending on the algorithm.
- **Public-key algorithm and parameters:** Identify the key type and how to interpret it, such as RSA or an elliptic-curve key with a named curve.
- **Identity fields:** Identify the certificate holder through the subject and subject alternative name (SAN), such as a user identity or server DNS name.
- **Validity dates:** Specify when the certificate becomes valid (`NotBefore`) and when it expires (`NotAfter`).
- **Extensions:** Provide additional information and restrictions, such as permitted key uses, application purposes, alternative identities, and CA constraints.
- **Signature algorithm:** Identifies how the issuer signed the certificate, such as SHA-256 with RSA.
- **Issuer signature:** Created with the issuer's private key so validators can verify the certificate's integrity using the issuer's public key.

A **thumbprint** is a hash calculated from the encoded certificate. It helps identify the certificate for management tasks but isn't a field stored within the X.509 certificate itself.

An X.509 certificate doesn't contain the private key. In this module, which is focused on Windows client and server operating systems, Windows stores the private key separately through a cryptographic provider and associates the certificate with it.

> [!NOTE]
> A private key is a secret cryptographic value mathematically linked to a public key. It enables authentication, digital signing, or decryption, depending on the algorithm and permitted use. Protect it from unauthorized access.

The issuer's digital signature lets a validator check that the signed certificate data hasn't changed and that the signature matches the issuer's public key. Signing doesn't encrypt the certificate's contents.

> [!NOTE]
> A validator is software that evaluates a certificate's signature, chain, validity, identity, intended use, and revocation status against applicable policy.

The private key proves certificate possession during authentication or signing and supports decryption where the algorithm and usage permit it. Protecting the certificate file alone doesn't protect the private key. Conversely, publishing a public certificate doesn't disclose the private key.

An end-entity certificate identifies a user, computer, service, or publisher. An intermediate CA certificate authorizes a subordinate CA to issue certificates within its constraints. A root CA certificate commonly has a self-signature and serves as a trust anchor when local policy accepts it.

A self-signature proves that the signature matches the included public key. It doesn't prove that the organization behind the certificate deserves trust. Trust in a root comes from an approved trust decision or distribution mechanism.

## Certificate identity and purpose

Common certificate purposes include:

- **Server authentication:** Proving a server's identity.
- **Client authentication:** Proving a client's identity.
- **Code signing:** Signing executable content.
- **Secure email (S/MIME):** Signing and encrypting messages with Secure/Multipurpose Internet Mail Extensions.
- **File encryption (EFS):** Protecting access to encrypted files with Encrypting File System.

The certificate subject identifies the certificate holder. For TLS server authentication, the subject alternative name (SAN) extension identifies DNS names or IP addresses that the certificate covers. Don't rely on the subject common name as a substitute for a correctly issued SAN. A DNS SAN for `app.contoso.com` doesn't cover a connection to an IP address merely because that address resolves from the name. An IP-based connection needs the appropriate IP-address SAN. Use only identities that the requester is authorized to represent.

Key usage constrains the available cryptographic operations, such as digital signatures or key encipherment. Enhanced key usage (EKU) constrains application purposes. Both restrictions can matter to the application.

> [!NOTE]
> Applications select and validate certificates for specific tasks, such as server authentication or code signing. When both Key Usage and EKU are present, the intended use must satisfy both restrictions. Trust and valid dates alone don't make a certificate suitable for an application.

Those purposes aren't interchangeable. A certificate for a DNS name with only Client Authentication EKU can still be unsuitable for an HTTPS server. An application can impose additional requirements beyond the certificate's extensions.

Basic constraints identify whether a certificate is a CA certificate and can limit subordinate CA depth. A certificate's location in a store doesn't rewrite its extensions or convert an end-entity certificate into a CA certificate.

## Read identifiers and validity

The `NotBefore` and `NotAfter` properties define the certificate's validity interval. Check the actual system time when diagnosing apparent expiry or premature use. 

> [!NOTE]
> Fudging a computer's clock isn't a reliable method of bypassing validity periods.

A serial number identifies a certificate within the issuer's namespace. A thumbprint is a hash of the encoded certificate. The same subject can appear on several certificates with different keys, issuers, serial numbers, and thumbprints.

Windows commonly shows a SHA-1 certificate thumbprint. That value is a lookup identifier, not the certificate's signature algorithm. A certificate signed with SHA-256 can still have a displayed SHA-1 thumbprint.

Use a full thumbprint and store path to identify a certificate for a change such as replacing, renewing, or modifying usage. For approval or distribution, compare the fingerprint and algorithm specified by the CA owner through an authenticated channel.

## Distinguish validation failures

Chain building finds a path from an end-entity certificate through intermediate certificates to a trust anchor, such as an offline root CA or public CA. Chain validation evaluates signatures, constraints, validity, intended use, and applicable policy. A constructed path isn't necessarily an accepted path.

Windows can obtain intermediate certificates from stores, cached information, or issuer download locations. A TLS server should provide the required intermediate chain rather than depend on every client downloading it. Providing a root in that chain doesn't make the client trust the root.

Authority Information Access (AIA) can identify issuer-certificate download locations and Online Certificate Status Protocol (OCSP) responders. CRL Distribution Points (CDP) identify locations for certificate revocation lists (CRLs). A CRL is a signed list of revoked certificates; OCSP allows a validator to check certificate validity without having to read the base and delta CRLs..

Revocation checking depends on the relying application, available status information, freshness, and policy. An unavailable responder doesn't mean that a certificate is revoked. It also doesn't establish that the certificate is good.

Common problems with certificates and their causes:

- An untrusted root is a trust problem.
- A missing intermediate is a chain-construction problem.
- An expired certificate is a validity problem.
- A wrong SAN is an identity problem.
- An inappropriate EKU is a purpose problem.

Importing more certificates into the Root store doesn't fix all these failures.

Certificate validation also doesn't prove private-key access. A service can possess a valid certificate but fail to authenticate because its account can't use the associated key. Successful certificate authentication doesn't grant application authorization automatically.
