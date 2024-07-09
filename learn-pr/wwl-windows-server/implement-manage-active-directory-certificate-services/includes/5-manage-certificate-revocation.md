As part of managing a certificate lifecycle, you not only need to control their issuance but also keep track of their usage, and, whenever necessary, enforce their revocation. This is critical to mitigate and remediate potential compromise of certificate-based security.

## What is certificate revocation?

Revocation is the process in which you disable the validity of one or more certificates. By initiating the revocation process, you publish a certificate thumbprint in the corresponding CRL. This indicates that a specific certificate is no longer valid.

> [!IMPORTANT]
> Every certificate has its own validity period, after which it is no longer considered valid. With revocation, you can invalidate the certificate before that period passes, for example, to remediate certificate compromise.

:::image type="content" source="../media/m10-ca-cert-revocation-4df2cccf.png" alt-text="Several stages of CA lifecycle, focusing on the certificate revocation.":::


The revocation process consists typically of the following sequence of steps:

1.  Revoke a certificate and provide the reason and the target date and time. You can perform this task from the CA console.
2.  Publish a CRL. You have the option to trigger publishing from the CA console or schedule automatic publishing in regular intervals. You can publish CRLs in AD DS, in a shared folder, or on a website.
3.  If an operating systems, applications, or service initiates a secure action that involves the use of a certificate, that triggers an automatic check of the revocation status of that certificate by querying the issuing CA and the corresponding CDP location. This process determines whether the certificate is revoked.

> [!IMPORTANT]
> The support for the automatic check of a certificate revocation status is dependent on the way an operating system, application, or service was implemented. Most modern commercial software supports this functionality.

Windows operating systems include CryptoAPI, which is responsible for the certificate revocation and status-checking processes. CryptoAPI uses the following phases in the certificate-checking process:

 -  Certificate discovery. Certificate discovery collects CA certificates, AIA information in issued certificates, and details of the certificate enrollment process.
 -  Path validation. Path validation is the process of verifying the certificate through the CA chain, or path, until the root CA certificate is reached.
 -  Revocation checking. Each certificate in the certificate chain is verified to ensure that none of the certificates are revoked.
 -  Network retrieval and caching. Network retrieval is performed by using OCSP. CryptoAPI is responsible for checking the local cache first for revocation information, and if there is no match, making a call by using OCSP, which is based on the URL that the issued certificate provides.

## What is an Online Responder service?

An Online Responder service offers a more efficient way to check certificate revocation status. The Online Responder service relies on OCSP to determine the revocation status of a certificate. OCSP submits certificate status requests by using HTTP.

Clients access CRLs to determine the revocation status of a certificate. CRLs might be large, and clients might use a significant amount of time to search through these CRLs. An Online Responder service can search these CRLs dynamically for the clients and respond to the client with the status of the requested certificate. You can use a single Online Responder to determine revocation status information for certificates that are issued by a single CA or by multiple CAs. You also can implement multiple Online Responders to distribute CA revocation requests.

You must configure the CAs to include the URL of the Online Responder in the AIA extension of issued certificates. The OCSP client uses this URL to validate the certificate status. You also must issue the OCSP Response Signing certificate template, so Online Responders can enroll that certificate.

## Demonstration

The following video demonstrates how to:

 -  Configure CRL publishing.
 -  Configure CDP location.

The main steps in the process are:

1.  Create an AD DS environment. Create a single-domain AD DS forest.
2.  Deploy an Enterprise Root CA.
3.  Configure CRL publishing. Use the Certification Authority console to configure CRL publishing.
4.  Configure CDP location. Use the Certification Authority console to configure CDP location.

> [!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4MjvK]

---


##