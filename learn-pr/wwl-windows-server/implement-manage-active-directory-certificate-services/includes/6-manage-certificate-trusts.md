Certificates play a crucial role in protecting and validating authentication and other security-related tasks. One of the core principles that enable these capabilities is a certificate trust. For a certificate to be effective, every user, device, or application using it must trust the CA that issued it.

## What is certificate trust?

When using certificates, it is important that you consider who or what might need to assess their authenticity and validity. There are three types of certificates that you can use:

 -  Internal certificates from an organizational CA, such as a server hosting the AD CS role.
 -  External certificates from a public CA such as an organization that provides commercial cybersecurity software or identity services.
 -  A self-signed certificate.

If you deploy an Enterprise Root CA and use it to enroll certificates onto your users' domain-joined devices, these devices will accept the enrolled certificates as trusted. However, any workgroup device will consider the same certificates as untrusted. To resolve this issue, you can:

 -  Obtain public certificates from an external CA for the workgroup devices. This comes with an extra cost of public certificates.
 -  Configure the workgroup devices to trust the Enterprise Root CA. This requires additional configuration.

## Manage certificates and certificate trusts in Windows

You can manage certificates that are stored within the Windows operating system by using a range of tools, including Windows Admin Center, the Certificates Microsoft Management Console snap-in, Windows PowerShell, and certutil command line tool. Each of them gives you access to certificate stores of the current user, the local computer, and its services. Each store consists of several folders, including:

:::row:::
  :::column:::
    **Store**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Personal
  :::column-end:::
  :::column:::
    Contains certificates issued to the local user, the local computer, or its service, depending on the store you selected.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Trusted Root Certification Authorities
  :::column-end:::
  :::column:::
    Contains certificates of trusted root CAs.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Enterprise Trust
  :::column-end:::
  :::column:::
    Contains certificate trust lists to implement trusts of self-signed certificates from other organizations.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Intermediate Certification Authorities
  :::column-end:::
  :::column:::
    Contains certificates issued to subordinate CAs in the certification hierarchy.
  :::column-end:::
:::row-end:::


To ensure that workgroup devices trust your Enterprise Root CA, export its certificate from the Trusted Root Certification Authorities folder on a domain-joined computer and import it into the same folder on these devices.

> [!NOTE]
> Alternatively, you can obtain the certificate of the Enterprise Root CA from the CertEnroll share on the server hosting that role.

## Create a self-signed certificate for testing purposes

While self-signed certificates are not suitable for production scenarios, they can be useful for testing purposes. You can use the Windows PowerShell `New-SelfSignedCertificate` cmdlet to create a self-signed certificate. If you include the `CloneCert` parameter and provide an existing certificate, the new one will have the matching settings with exception of the public key. Instead, the cmdlet will create a new key of the same algorithm and length.

The following example creates a self-signed SSL server certificate in the local machine personal store with the subject alternative name set to www.fabrikam.com, www.contoso.com and Subject and Issuer name set to www.fabrikam.com.

```powershell
New-SelfSignedCertificate -DnsName "www.fabrikam.com", "www.contoso.com" -CertStoreLocation "cert:\LocalMachine\My"

```
