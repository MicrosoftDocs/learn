Contoso can use digital certificates to verify and authenticate the identity of each party involved in an electronic transaction. Digital certificates also help establish trust between computers and the corresponding applications that are hosted on application servers. Remote access uses certificates to verify the identity of servers and provide encryption. Contoso can also use certificates to verify the identity of users or computers signing in for remote access.

## Methods for obtaining certificates

In most cases, you obtain certificates from a certification authority (CA). The most important consideration for a CA is trust. If a certificate is issued by a trusted CA, then that certificate is trusted and can be used for authentication. If a CA is not trusted, then the certificates issued by that CA can't be used for authentication.

To obtain certificates, you can:

- Create your own private CA by using Windows Server. The certificates issued by a private CA are automatically trusted by domain joined Windows clients and servers. However, the certificates issued by an internal CA are not automatically trusted by any devices not joined to the domain.
- Purchase certificates from a public CA. The certificates issued by a public CA are trusted automatically by almost all devices whether they are domain joined or not. Windows doesn't include tools to automatically deploy certificates from a public CA to users or computers.
- Generate self-signed certificates within some applications. By default, these certificates are trusted only by the issuing server and not by other computers in the organization.
- Generate self-signed certificates by using PowerShell. You can use the `New-SelfSignedCertificate` cmdlet to generate a new self-signed certificate.

> [!NOTE]
> You use self-signed certificates in small and medium-sized organizations that use DirectAccess configured with the Getting Started Wizard, which provides easy setup and configuration.

## Considerations when planning PKI

To determine whether you should implement an internal PKI for remote access, you need to plan how you will use certificates. If you are using certificates only on a few servers, then the cost of using a public CA is low. Certificates from a public CA are also beneficial if you expect devices that aren't joined to the domain to access the servers.

A private CA is beneficial primarily for remote access when you are issuing certificates to client devices and individual users for authentication. For example, it is common to require a valid computer certificate to allow VPN access as a second level of authentication beyond a username and password. If you are issuing certificates to many computers, then the automatic enrollment provided by a private CA is important. There is also a significant cost savings because you don't need to pay for certificates issued by a private CA.

The following table summarizes the advantages and disadvantages of certificates issued by private and public CAs.

| CA type    | Advantages                                                   | Disadvantages                                                |
| ---------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Private CA | A private CA provides greater control over certificate management and has a lower cost when compared to a public CA. There is no cost per certificate. You also have the option to use customized templates and automatic enrollment. | By default, certificates by private CAs aren't trusted by external clients (web browsers and operating systems) and require greater administration. |
| Public CA  | A certificate issued by a public CA is trusted by many external clients (web browsers and operating systems) and requires minimal administration. | The cost is higher when compared to a private CA. Cost is based per certificate. Certificate procurement is also slower. |
