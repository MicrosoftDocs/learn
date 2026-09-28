Choose the file type according to what must move: a public certificate, a chain, a request, or a certificate and private key. File extensions alone don't establish either the format or its sensitivity.

## Distinguish encodings and containers

A `.cer` or `.crt` file commonly contains one public X.509 certificate. Distinguished Encoding Rules (DER) represent the certificate as binary data; `.der` is another common extension for that encoding. Base64 represents binary data as text. Base64 isn't encryption.

PEM uses text boundaries such as `BEGIN CERTIFICATE` around Base64 content. A PEM file can instead contain a request or private key, and one file can contain several objects. Inspect the boundary labels and receiving application's requirements before handling it as public data.

PKCS #7, commonly `.p7b`, carries certificates and can carry a certificate chain without private keys. Microsoft serialized store files, `.sst`, contain collections of public certificates. Neither format is a backup of the associated private keys.

PKCS #12, commonly `.pfx` or `.p12`, can package certificates, private keys, and related properties. The extension doesn't guarantee that a key is present. Treat a package containing private keys as a secret, even when password protected.

A PKCS #10 request, commonly `.req` or `.csr`, contains a public key and requested certificate information. The requester signs it to demonstrate possession of the corresponding private key. A certificate signing request (CSR) isn't an issued certificate.

Renaming `.cer` to `.pfx` doesn't convert the data or add a private key. Use an export or conversion operation that produces the format required by the destination.

## Inspect files before installation

Opening a public certificate file in the certificate viewer doesn't require importing it. Inspect **Details** and **Certification Path** before choosing an installation action.

Use a native diagnostic command to inspect a public file:

```console
certutil.exe -dump "C:\CertWork\server.cer"
```

The output identifies encoded fields. It doesn't authenticate the source of the file or establish that the certificate should be trusted.

Inspect a protected PFX without importing it:

```console
certutil.exe -dumpPFX "C:\CertWork\server.pfx"
```

Enter the password only at the protected prompt. The command displays certificate information without installing the package. Inspect every included CA certificate, not just the end-entity certificate. Knowing the password doesn't make the contents trustworthy.

## Tools for multi-certificate files

Native tools and certificate wizards don't process every bundle identically. Verify the result or extract and import individually approved certificates into their correct stores.

An exported P7B containing one selected certificate doesn't automatically mean that every issuer was included. Inspect the file. Use the export wizard's chain option or explicitly supply the intended certificate collection where required.
