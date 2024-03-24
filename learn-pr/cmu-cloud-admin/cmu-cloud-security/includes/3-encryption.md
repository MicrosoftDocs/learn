*Encryption* is the mathematical means by which information is obfuscated to all except those authorized to see and use it. A data file may be encrypted, and the session with which that data is transacted over a network may also be encrypted. Most Web sites and services today use *Transport Layer Security* (TLS) as a means of encrypting and securing traffic. You know a site uses TLS when your browser's address line includes the protocol identifier ***https://*** (instead of ***http://***), and the certificate of the service protecting the session is represented by some kind of "verified" icon like a green checkmark.

Encryption plays a huge role in the security of the internet and of applications hosted on public cloud platforms. Data can be *encrypted at rest* (for example, in an Azure SQL Database or AWS S3 storage) to render it useless if stolen, and it can be *encrypted in motion* using TLS to protect it as it travels over the wire between cloud services or between users and cloud services. The greatest challenge lies in key availability. If data is encrypted, how and where do you store the decryption key so that an application can retrieve it but an attacker cannot? Moreover, if you use TLS to encrypt traffic between a browser and a Web server (or, for example, between a Web server and a database or an application and an identity provider responsible for authenticating users), how do you make keys available without exposing them to potential attackers?

In order to answer these questions, let us review the basics of digital cryptography and explore some of the mechanisms used to make keys available to those authorized to have them without exposing them to those who are not.

## Symmetric encryption

In cryptography, a key is a sequence of digits used to alter the contents of a message -- that is, to either encrypt or decrypt it. Symmetric encryption, in which one key is used both to encrypt and decrypt data, is among the oldest forms of cryptography. It is commonly used to encrypt data at rest in databases and cloud storage services.

Over the years, several algorithms for symmetric encryption have evolved and been adopted as standards, in part because no one (thus far) has found a way to break them. One of those is the Advanced Encryption Standard, or AES. Adopted by the U.S. National Institute of Standards and Technology (NIST) in 2001, it replaced the Data Encryption Standard (DES), which is considered ineffectual in the face of modern computers. AES-256, which uses 256-bit keys, is widely used by cloud platforms such as AWS and Azure to encrypt the data that they store.

A brute-force attack on AES-256-encrypted data would take billions of supercomputers billions of years to crack, and that is simplifying matters. Suffice it to say that with today's computers, it is computationally infeasible to decrypt AES-256-encrypted data without the key. Thus, the primary challenge in symmetric encryption isn't encrypting and decrypting the data; it is storing the key in such a way that it is available to all parties that need it, but *only* to those authorized to have it.

## Key storage and maintenance

Encrypting (and decrypting) data is easy; securing the keys used to encrypt and decrypt it is not. In any communications system where secrets are stored, the secrets themselves become the most likely target of malicious actors.

Security engineers recommend that organizations use proven key-management services to ensure that key storage cannot be exploited. Azure Key Vault is one example of such a service. A key manager helps an organization maintain compliance with standards and frameworks such as PCI DSS (discussed later in this module), which mandate that encryption/decryption keys and other cryptographic secrets be changed or "rotated" periodically. It also reduces the chance that a decryption key, database connection string, or other "secret" can be successfully retrieved by an attacker.

Azure Key Vault is a SaaS service that permits users and applications to store keys, passwords, connection strings, certificates, and other secrets in a highly secure manner. It uses Microsoft Entra ID to authenticate users, and it integrates with other Azure services such as Azure SQL Database and Azure Storage. It is also accessible by API so applications can retrieve secrets stored there. For maximum protection, secrets can optionally be stored in Federal Information Processing Standards (FIPS) 140-2 Level 2 validated hardware security modules (HSMs). HSMs can be shared or dedicated. Significantly, secrets stored in Azure Key Vault are *not* visible to Microsoft.

Once keys and other secrets are stored in Key Vault, the system can be set up to rotate their values automatically, without human intervention. This brings an organization into compliance with terms of PCI DSS. In the event of a security incident, or during a regular security audit, Key Vault serves as a central location for producing IAM logs relevant to the entire organization.

AWS offers a similar service in the form of AWS Key Management Service (KMS). KMS also supports FIPS 140-2 Level 2 validated HSMs, and it integrates with AWS CloudTrail to produce an auditable access log. The fact that KMS and Azure Key Vault are integrated into their respective cloud platforms offers additional security to applications hosted in these platforms. A secret that never leaves a data center because the applications that use them and the key vaults that store them are co-located are more secure secrets indeed.

## Asymmetric encryption (Public Key Cryptography)

Symmetric encryption is great for encrypting data at rest, but it poses a problem when two parties wish to exchange encrypted messages. If Bob encrypts a message and sends it to Alice, how is Alice to decrypt it? If Bob sends Alice a decryption key, the key may be compromised (stolen), in which case the security Bob and Alice were counting on is actually no security at all. History is replete with people who lost their lives because communications that they thought were private turned out to not be so private after all. One example is Mary Queen of Scots, who was executed because she used a weak cipher to obfuscate messages sent to co-conspirators while plotting the assassination of Queen Elizabeth<sup>[1][^1]</sup>.

The challenge of exchanging encrypted messages without exposing decryption keys is not an academic one. It happens every time you connect to an *https://* URL in your browser, whenever an application reaches out to a third-party identity provider, and at other times. The solution is *asymmetric encryption*. With an asymmetric system, one key is used to encrypt a message, and another key is used to decrypt it. This way, a message directed to a specific recipient may be encrypted using a key -- the *public key* -- that is publicly distributed by the recipient. Only the second key may be used to decrypt a message encrypted with the public key. This key is kept private by the recipient and becomes the *private key*. Asymmetric keys are sometimes referred to as *public-private keys* for this reason.

## Certificates

If Bob wants to receive encrypted messages from Alice, he can e-mail her his public key or write it down on a piece of paper and leave it on her desk. But if a browser wants a public key from a Web server and also wants to verify that it's connecting to the server it *thinks* it's connecting to it, how does it do it? That's where certificates come in.

The purpose of a certificate is to present a public key to any entity that would establish the authenticity of its bearer. The certification authority (CA) is the producer of this certificate, and it is trusted with the task of physically verifying the identity of each person or corporate entity seeking certification. Consequently, every certificate is *signed* by the CA using code that may be challenged and verified.

The international standard for the format of a digital identity certificate is X.509, established in 1998. As Figure 3 shows, there have been three versions of X.509, with newer versions adding extra fields that became necessary in transactions involving CSPs, particularly when multiple providers are involved in a service and those parties require extra information about the issuer and signer of the certificate.

![Figure 3: Parts of an X.509 certificate. \[Courtesy Microsoft\]](../media/fig8-3.png)

_Figure 3: Parts of an X.509 certificate. \[Courtesy Microsoft\]_

When a browser connects to a Web server using an *https://* URL, it initiates a *TLS handshake* in which the Web server returns a certificate verifying its authenticity and containing a public key. But it doesn't use the public key to encrypt the requests it transmits to the server. (It could, but while requests would be encrypted so that only the Web server could decrypt them since only the server has the private key, responses from the server would be insecure because they could be decrypted by anyone who has the public key.) Instead, the browser uses the public key to encrypt a symmetric *session key* that it transmits to the server. Thereafter, the session key is used to encrypt (and decrypt) all communications between the browser and the Web server. TLS, therefore, uses a combination of symmetric and asymmetric encryption: asymmetric to encrypt symmetric keys, and symmetric to encrypt requests and responses.

Certificates aren't used solely by Web servers. They're used by identity providers to encrypt credential exchanges, by database servers to encrypt database connections, and more. In short, they are used throughout the internet and within data centers to secure data in motion. Part of the job of a cloud administrator is to manage these certificates -- obtaining them from a trusted CA, installing them on Web servers, database servers, identity servers, and other places where they are needed, and renewing them before they expire.

## Homomorphic encryption

As cryptography evolves as both a process and an industry, one promising technology that may soon play a significant role in data security is *homomorphic encryption* (HE). It's a means of attaining information from an encrypted entity while it remains technically encrypted.

HE would replace asymmetric key management, and with it, the need for a private key management system or vault. A user seeking authentication could pass a certificate containing a valid signature that not even the user has access to. This signature would be the result of a derivative function such as a hash function. To validate the user, the identity provider would attain an encrypted validation key from the certificate authority and use that key to extract the signature without actually decrypting the certificate. Research into this methodology is ongoing, and for the most part, is currently confined to academic and research institutions.

### References

1. _Simon Singh. *The Black Chamber*. <https://simonsingh.net/The_Black_Chamber/maryqueenofscots.html>._

[^1]:  <https://simonsingh.net/The_Black_Chamber/maryqueenofscots.html>  "Simon Singh. *The Black Chamber*."
