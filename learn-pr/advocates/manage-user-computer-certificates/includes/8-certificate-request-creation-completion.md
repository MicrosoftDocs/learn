A custom CSR separates local key generation from CA submission. Use it when the issuer expects a request file or when the machine can't use the intended automatic enrollment path.

## Preserve the request context

Generate the request on the computer that needs the key and in the intended user or machine context. Keep the private key and outstanding request until the certificate is installed and verified.

The request leaves the computer; the key doesn't. The CA signs a certificate containing the submitted public key. Acceptance associates the returned certificate with the local private key.

The following diagram shows that separation. Sending a request or retrieving a response never substitutes for preserving the key.

:::image type="content" source="../media/certificate-request-workflow.svg" alt-text="Diagram that shows a certificate request while the originating Windows computer retains the private key." border="false" lightbox="../media/certificate-request-workflow.svg":::

A response accepted on the wrong computer or under the wrong account might have no matching key. Download the issued certificate to the computer where you created the request. Accept it under the same user account for a user request, or in the local computer's certificate store for a machine request. If the key is lost, a public certificate downloaded from the CA can't restore it.

## Create a custom request in MMC

For a machine TLS request, start elevated `certlm.msc`. For a user request, start `certmgr.msc` as the intended user.

1. Open the **Personal** shortcut menu. Select **All Tasks** > **Advanced Operations** > **Create Custom Request**.
1. On the enrollment policy page, select **Proceed without enrollment policy** when the issuer requires an independent request.
1. Select the appropriate request template or provider choice and **PKCS #10**. For a modern compatible application, use the CNG key option rather than choosing a legacy provider by habit.
1. Expand **Details** and select **Properties**. Set the approved subject and SAN values, required extensions, provider, key size, and export policy.
1. Save the request in the encoding accepted by the CA. Record its originating computer and account context.

> [!NOTE]
> Cryptography API: Next Generation (CNG) uses key storage providers (KSPs). Older CryptoAPI workflows use cryptographic service providers (CSPs). Application compatibility, hardware requirements, and template policy determine the choice. A product-specific requirement for a legacy provider isn't a general Windows requirement.

## Define a complete INF request

An INF file is a plain-text configuration file that `certreq.exe -new` reads to generate a certificate signing request (CSR). It specifies settings such as the subject, SANs, key algorithm and size, cryptographic provider, and user or machine context. Use an INF file when you need precise control over these settings or repeatable, scripted requests instead of entering values in the certificate request wizard. This approach is useful for workgroup computers or requests to an external CA. Submit the generated CSR to the CA, not the INF file.

The following INF file example is used to request an SSL/TLS server certificate with a non-exportable RSA machine key. Save the following content as `C:\CertWork\request.inf` in an ASCII-compatible encoding. If using it as the basis of your own request, replace the DNS names with the name for your use case before generating a request.

```ini
[Version]
Signature="$Windows NT$"

[NewRequest]
Subject = "CN=app.contoso.com"
RequestType = PKCS10
MachineKeySet = TRUE
ProviderName = "Microsoft Software Key Storage Provider"
KeyAlgorithm = RSA
KeyLength = 3072
HashAlgorithm = SHA256
Exportable = FALSE
KeyUsage = 0xa0

[Extensions]
2.5.29.17 = "{text}"
_continue_ = "DNS=app.contoso.com&"
_continue_ = "DNS=app-alt.contoso.com"
2.5.29.37 = "{text}1.3.6.1.5.5.7.3.1"
2.5.29.19 = "{text}ca=0"
```

This request has the following properties:

- `[Version]` identifies the INF format.
- `[NewRequest]` describes the request and key.
- `MachineKeySet = TRUE` creates the key in machine context rather than the administrator's user profile.
- `RequestType = PKCS10` creates a request, not a self-signed certificate.
- `Exportable = FALSE` prevents ordinary export of the new key. 
- `KeyUsage = 0xa0` requests digital-signature and key-encipherment usage for this RSA example. 

The provider uses software key storage. The example selects a 3,072-bit RSA key and SHA-256 for signing the request. Use algorithms and sizes supported by both organizational policy and the application. A stronger-looking setting that the application can't use isn't an operational solution.

RSA supports signing and certain encryption operations. The Elliptic Curve Digital Signature Algorithm (ECDSA) is a signing algorithm with different key-size and compatibility requirements. Don't compare RSA and elliptic-curve key lengths as equivalent security levels or change the algorithm without checking the consumer.

The extension `2.5.29.17` carries SAN values. `2.5.29.37` requests Server Authentication EKU through OID `1.3.6.1.5.5.7.3.1`. `2.5.29.19` requests end-entity basic constraints. An IP identity requires an IP-address SAN, not a DNS SAN containing the textual address.

The request signature algorithm doesn't determine the CA's certificate signature algorithm. The CA controls the issued certificate's validity and permitted extensions. Inspect the response even when the request was correct.

For a user request, change `MachineKeySet` to `FALSE`, use an appropriate user identity and purpose, and run the command with `-user`. Changing only the switch while leaving machine settings in the INF creates a conflicting request.

## Generate and inspect the CSR

To create a certificate signing request (CSR) from the example INF file, run the following code in an elevated Command Prompt. Doing this creates a new key and request, so don't rerun it as a routine retrieval step.

```console
certreq.exe -new -machine "C:\CertWork\request.inf" "C:\CertWork\request.req"
certutil.exe -dump "C:\CertWork\request.req"
```

Inspect the requested names, key algorithm, key size, and extensions. Record the key's context. The `.req` file isn't a backup of that key.

## Submit to AD CS or an external CA

For AD CS, identify the CA through `CAHostName\CAName`. The first component is the server name; the second is the CA's configured name. Don't substitute a certificate subject or web address.

The following example applies an existing template that permits this request. Replace both placeholders and verify the template's eligibility and identity policy.

```console
certreq.exe -submit -config "<CAHostName>\<CAName>" -attrib "CertificateTemplate:<ServerTemplateName>" "C:\CertWork\request.req" "C:\CertWork\issued.cer"
```

The template attribute is specific to the applicable AD CS workflow. Alternatively, an AD CS request can include `[RequestAttributes]` and `CertificateTemplate = <ServerTemplateName>` in its INF. Don't add contradictory template selections in different places.

An enterprise CA can reject based on an unavailable template, inadequate permissions, unsupported key settings, or identities inconsistent with policy. A standalone CA doesn't use this template attribute.

A CA can return a pending request ID without issuing a certificate. Record the ID and the displayed disposition. Don't proceed to acceptance merely because the process exited successfully or because a response file from an earlier attempt still exists. Use distinct request files and preserve their association with the current operation.

For a third-party issuer, submit only the CSR through its approved process. Complete its required identity and domain validation. Download the issued certificate and approved chain. Those steps replace AD CS submission and retrieval; they don't change the requirement to keep the original private key.

## Retrieve and accept the response

After an AD CS approver confirms issuance, retrieve the response for the recorded CA request ID using the following code:

```console
certreq.exe -retrieve -config "<CAHostName>\<CAName>" "<RequestID>" "C:\CertWork\issued.cer"
```

Use the CA owner's process for pending or denied requests. Submitting repeated requests doesn't resolve approval and can leave unnecessary keys and outstanding records.

Inspect the issued response, then accept it on the originating computer in the matching context:

```console
certreq.exe -accept -machine "C:\CertWork\issued.cer"
```

For a user request, run `certreq.exe -accept -user` as the originating user. Acceptance links the matching private key and issued certificate and resolves the matching outstanding request. It doesn't install an application binding.

Locate the issued certificate in the Personal store. Verify its names, EKU, issuer chain, validity, and key association. Test key access under the intended identity before putting the certificate into service.
