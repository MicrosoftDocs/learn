Cryptography has many applications in today's modern world. You've seen how encryption can ensure the confidentiality of messages. You also learned how hashing is used in digital signatures to verify a message hasn't been tampered with. In this unit, you'll learn about digital certificates and how they provide an added layer of security. 

Certificates address the possibility of an unethical person intercepting, altering, or counterfeiting messages, that can occur in digital communication.

Essentially, a digital certificate is a credential issued by a **certificate authority** (CA) that can be used to verify the identity of an individual or entity to whom the certificate is issued, referred to as the subject. In this sense, a digital certificate is like a passport or other identity credential issued by a trusted authority or government agency, it's used to verify an identity. The data in a certificate includes information about the subject, the subject’s public key from their public/private key pair, and has been verified by the CA.  

To obtain a digital certificate, the individual or entity submits a certification request to a reputable CA. Details of the requestor's identity and their public key, from the public/private key pair generated from an available tool, are included in the certificate request.  In some cases, the requestor may look to have the CA issue a key pair on their behalf, as part of the request.  In either case, the private key is always kept secret by the individual or entity. The CA reviews all the identity information submitted in the request to determine whether it meets the CA's criteria for issuing a certificate. If the CA approves the request, it signs and issues a certificate containing information about the subject and the subject's public key.

The lifespan of a digital certificate tends to be one year, after which the certificate expires. When that happens, you'll see a warning message about expired certificates. The warning indicates that the subject’s identity can't be confirmed.

A common of application of digital certificates, that is transparent to the user, is in web-based communication.  Digital certificates are employed by websites that use secure *HTTPS* communication, and is denoted by a padlock icon in the browser's address bar.  Selecting the padlock on the address bar provides several options that can be selected and provide additional information.

:::image type="content" source="../media/digital-certificates-step1-inline.png" lightbox="../media/digital-certificates-step1-expanded.png" alt-text="Diagram showing padlock icon on website address bar.":::

Selecting "Connection is secure," provides information about the connection, as shown in the image below.

:::image type="content" source="../media/digital-certificates-step2-inline.png" lightbox="../media/digital-certificates-step2-expanded.png" alt-text="The site has a valid certificate issued by a trusted authority. Information will be securely sent to the site and can't be intercepted.":::

Selecting the certificate icon provides details about the digital certificate.

:::image type="content" source="../media/digital-certificates-step3-inline.png" lightbox="../media/digital-certificates-step3-expanded.png" alt-text="This image provides details about the digital certificate.  Information provided includes the purpose of the certificate, to whom it was issued, who issued the certificate, and for how long the certificate is valid.":::

### Why do we need digital certificates?

In an earlier unit, we described the process of asymmetric encryption and how the public/private key pairs are used. In the example, Quincy and Monica want to communicate securely so they each generate their key pair, using readily available software.  Monica and Quincy share their public key with each other but keep their private key secret.  When Quincy wants to send a secure message to Monica, Quincy uses Monica's public key to encrypt and send the message.  Monica uses her private key to decrypt the message.

The use of asymmetric encryption, described in the example, ensures the confidentiality of the message. Because public keys are public, there's nothing that validates the public key used by Quincy really came from Monica.  Similarly, there's nothing that validates the message was actually sent by Quincy.  There's a potential for an unethical person to intercept, alter, or counterfeit the messages. Digital certificates play an important role in addressing this risk.

Let's assume that Monica has been issued a digital certificate through a reputable CA and it's shared with Quincy.  The certificate links Monica's identity with the public key. Because Quincy uses the public key in Monica's certificate, Quincy is assured the public key came from Monica and only Monica's private key will decrypt the message.  

Let's assume that Quincy has also been issued a digital certificate through a reputable CA. Quincy's uses his private key to digitally sign the message. Quincy sends the signed message to Monica along with the digital certificate containing his public key. The digital certificate links Quincy's identity to the public key, so using public key in the certificate serves to verify the message hasn't been tampered and verifies the message came from Quincy.  Without the digital certificate, a digital signature only serves to verify the message hasn't been tampered with.
