A self-signed certificate is useful for controlled demonstrations of certificate properties and key operations. It doesn't provide the identity assurance or lifecycle controls of an approved issuing service.

## Create an isolated test certificate

Run this example as a test user. Save the following content as `C:\CertWork\selfsigned.inf`. It defines a short-lived certificate and a non-exportable software key in Current User context.

```ini
[Version]
Signature="$Windows NT$"

[NewRequest]
Subject = "CN=app.contoso.com"
RequestType = Cert
MachineKeySet = FALSE
ProviderName = "Microsoft Software Key Storage Provider"
KeyAlgorithm = RSA
KeyLength = 3072
HashAlgorithm = SHA256
Exportable = FALSE
KeyUsage = 0xa0
FriendlyName = "Certificate management demonstration"
ValidityPeriod = Days
ValidityPeriodUnits = 30

[Extensions]
2.5.29.17 = "{text}DNS=app.contoso.com"
2.5.29.37 = "{text}1.3.6.1.5.5.7.3.1"
2.5.29.19 = "{text}ca=0"
```

Use the following command to create and install the certificate, then locate it in Current User Personal:

```console
certreq.exe -new -user "C:\CertWork\selfsigned.inf" "C:\CertWork\selfsigned.cer"
certutil.exe -user -store My "app.contoso.com"
```

Record the certificate thumbprint and key-container name. A repeated invocation creates another certificate and key; it doesn't refresh the existing object.

This certificate requests the DNS identity and server purpose used in the examples. Its presence in Current User Personal doesn't make it available to a machine service or make clients trust it.

If an isolated demonstration specifically requires PFX export, decide to create an exportable test key before generation and document why. Don't change production key policy merely to reproduce an export example.

## Keep testing separate from production trust

Don't import the demonstration certificate into enterprise Root stores. Test application trust belongs in an isolated environment with an explicit scope and cleanup plan.

Replacing a self-signed certificate creates a new certificate and usually a new key. Consumers that explicitly trust or select the old certificate need corresponding changes. A reused friendly name doesn't preserve its thumbprint.

After the demonstration, remove its bindings and verify that no retained data depends on the key. Inspect the exact recorded certificate before cleanup:

```console
certutil.exe -user -store My "<DemonstrationCertificateThumbprint>"
```

After confirming the thumbprint and recorded key-container name, remove the disposable certificate and then its key:

```console
certutil.exe -user -delstore My "<DemonstrationCertificateThumbprint>"
certutil.exe -user -delkey "<DemonstrationKeyContainerName>"
```

Native deletion has no preview mode. Never use the key-deletion command for a production key or a key shared by another retained certificate.
