The purpose of CA is to allow users and devices to enroll for and use certificates. This, however, just as with CA implementation, requires careful planning and preparation that determines the type of certificates that a CA can issue.

## What is a certificate?

A certificate is a small file that contains several pieces of information about its owner. This data can include the owner's email address, the owner's name, the certificate usage type, the validity period, and the URLs for AIA and CDP locations.

A certificate also contains the public key and corresponding metadata, which consists of a private key and the corresponding public key. You can use these keys in processes of validating identities, digital signatures, and encryption. The key pair that each certificate generates has the following conditions:

 -  When content is encrypted with the public key, it can be decrypted only with the private key.
 -  When content is encrypted with the private key, it can be decrypted only with the public key.
 -  No other key is involved in the relationship between the keys from a single key pair.
 -  The private key can't be derived in a reasonable amount of time from a public key, and vice versa.

As part of the certificate enrollment process, the client generates the public/private key pair. The client then sends the public key to CA, which confirms client information, signs it with its own private key, and then sends the certificate, which includes the client public key, back to the client.

> [!NOTE]
> You can think of a certificate as being like a driver's license. Many businesses accept a driver's license as a form of identification because they consider the license issuer (a government institution) as trustworthy. Because businesses understand the process by which someone can obtain a driver's license, they trust that the issuer verified the identity of the individual before issuing the license. Therefore, the driver's license is acceptable as a valid form of identification. A certificate trust is established in a similar way.

:::image type="content" source="../media/m10-ca-cert-issuance-2c357fab.png" alt-text="Several stages of CA lifecycle, focusing on the certificate issuance.":::


## What are certificate templates?

Certificate templates define how users and devices can request and use Enterprise CA issued certificates based on that template. For example, you can create a template that will provide file encryption or email signing functionality. CA relies on AD DS to store the templates you configure.

> [!IMPORTANT]
> Certificate templates are available only when using Enterprise CA. This means that with a Standalone CA, every certificate request must be created manually and include all required information to be included in the certificate.

CA provides templates for users and for computers. You can assign permissions to certificate templates to define who can manage them, who can perform enrollment or autoenrollment, and what is their validity and renewal periods. You can apply additional modifications by duplicating pre-defined certificate templates. To make templates available to users and devices, you must explicitly allow their usage.

### Template versions

The CA in Windows Server AD CS supports four versions of certificate templates, with the following functional differences:

 -  Version 1 templates. These templates allow you to modify certificate related permissions only. When you install a CA, version 1 certificate templates are created by default.
 -  Version 2 templates. With these templates, you can customize additional settings, such as validity and renewal periods. This is also the minimum version that supports autoenrollment. The default installation of AD CS provides several preconfigured version 2 templates. You can create version 2 templates or duplicate a version 1 certificate template to create a new version 2 template.
 -  Version 3 templates. Version 3 certificate templates support Cryptography Next Generation (CNG). CNG supports advanced cryptographic algorithms. You can duplicate default version 1 and version 2 templates to upgrade them to version 3. When you use the version 3 certificate templates, you can use CNG encryption and hash algorithms for certificate requests, issued certificates, and protection of private keys for key exchange and key archival scenarios.
 -  Version 4 templates. Version 4 certificate templates support both cryptographic service providers (CSPs) and key storage providers. You can also configure them to require renewal with the same key.

## Demonstration

The following video demonstrates how to:

 -  Create a new template based on the Web Server template.
 -  Configure templates so that they can be issued.

The main steps in the process are:

1.  Create an AD DS environment. Create a single-domain AD DS forest.
2.  Deploy an Enterprise Root CA.
3.  Create a custom certificate template. Use the Certificate Templates console to duplicate the Web Server template.
4.  Configure the template so that it can be issued. Use the Certification Authority console, to make the template available for use.

> [!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4MjvJ]

---

##