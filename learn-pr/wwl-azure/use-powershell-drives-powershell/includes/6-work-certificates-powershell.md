If you've reviewed or managed security certificates on a client or server computer, you've probably used the Certificates snap-in for the Microsoft Management Console (MMC). The Certificates snap-in enables you to browse the certificates stores on local or remote computers. The Windows PowerShell Certificates provider also allows you to review and manage security certificates.

The Certificates provider creates a PowerShell drive named **Cert**. The **Cert** drive always has at least two high-level store locations that group certificates for the users and the local computer. These locations are **CurrentUser** and **LocalMachine**. The certificates specific to the user or computer are in the **My** subfolder, represented by the **Cert:\\CurrentUser\My** notation.

The Certificates provider supports the **Get**, **Set**, **Move**, **New**, **Remove**, and **Invoke** verbs in combination with the **Item** and **ChildItem** nouns. (Note that the **ItemProperty** noun is not supported.) All ***-Location** commands are also supported.

The **Invoke-Item** cmdlet in combination with the Certificates provider opens the MMC with the Certificates snap-in automatically loaded. 

The **Get-ChildItem** command has various dynamic parameters that are unique to the **Certificate** provider. These parameters include:

- *-CodeSigningCert*. Gets certificates that can be used for code signing.
- *-DocumentEncryptionCert*. Gets certificates for document encryption.
- *-DnsName*. Gets certificates with the domain name in the **DNSNameList** property of the certificate. This parameter accepts wildcards.
- *-EKU*. Gets certificates with the specified text in the **EnhancedKeyUsageList** property. This parameter supports wildcards.
- *-ExpiringInDays*. Gets certificates that are expiring within the specified number of days.
- *-SSLServerAuthentication*. Gets only Secure Sockets Layer (SSL) server certificates.

There are also many certificate management cmdlets in the **pki** module that don't require you to use the **Cert** drive. For example, to create a self-signed certificate for the server `webapp.contoso.com`, use the following code:

```powershell
New-SelfSignedCertificate -DnsName "webapp.contoso.com" -CertStoreLocation "Cert:\LocalMachine\My"
```

> [!NOTE]
> For a list of certificate management cmdlets in the **pki** module, run **Get-Command -Module pki**.
