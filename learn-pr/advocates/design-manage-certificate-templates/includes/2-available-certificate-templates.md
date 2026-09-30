By default, an Active Directory Enterprise CA is configured to issue 11 templates.

:::image type="content" source="../media/default-templates.png" alt-text="Screenshot of the default certificate templates issued by an Active Directory Enterprise certification authority." lightbox="../media/default-templates.png":::

`certtmpl.msc` run on a Windows Server 2025 Enterprise CA displays 33 preconfigured templates.

:::image type="content" source="../media/templates-console.png" alt-text="Screenshot of the Certificate Templates console showing 33 preconfigured certificate templates." lightbox="../media/templates-console.png":::

These certificate templates can be used for the purposes outlined in the following table:

| Template display name | Schema version | Purpose |
|---|---|---|
| Administrator | 1 | Authenticate administrators and sign certificate trust lists. |
| Authenticated Session | 1 | Authenticate users to web servers with client certificates. |
| Basic EFS | 1 | Encrypt user files with Encrypting File System (EFS). |
| CA Exchange | 2 | Encrypt private keys sent to the CA for archival. |
| CEP Encryption | 1 | Protect SCEP enrollment requests to a registration authority. |
| Code Signing | 1 | Sign software and scripts to verify publisher identity. |
| Computer | 1 | Authenticate domain computers for client and server connections. |
| Cross Certification Authority | 2 | Establish trust between CA hierarchies through cross-certification. |
| Directory Email Replication | 2 | Secure legacy AD DS replication messages transported over SMTP. |
| Domain Controller | 1 | Authenticate domain controllers, including for LDAP over TLS. |
| Domain Controller Authentication | 2 | Authenticate domain controllers for TLS and smart-card sign-in. |
| EFS Recovery Agent | 1 | Recover EFS-encrypted files as a designated data recovery agent. |
| Enrollment Agent | 1 | Sign certificate requests on behalf of other subjects. |
| Enrollment Agent (Computer) | 1 | Request certificates for other computers using a computer enrollment agent. |
| Exchange Enrollment Agent (Offline request) | 1 | Sign delegated enrollment requests with supplied subject names, including NDES requests. |
| Exchange Signature Only | 1 | Sign email in legacy Exchange Key Management Service deployments. |
| Exchange User | 1 | Encrypt email in legacy Exchange Key Management Service deployments. |
| IPSec | 1 | Authenticate computers establishing IPsec-secured network connections. |
| IPSec (Offline request) | 1 | Authenticate IPsec peers whose subject names are supplied in the request. |
| Kerberos Authentication | 2 | Prove a domain controller's KDC identity during certificate-based Kerberos sign-in. |
| Key Recovery Agent | 2 | Recover private keys archived by an enterprise CA. |
| OCSP Response Signing | 3 | Sign certificate-status responses from an Online Responder. |
| RAS and IAS Server | 2 | Authenticate remote-access and RADIUS servers, including Network Policy Server (NPS). |
| Root Certification Authority | 1 | Represent a root CA's identity and certificate-signing authority. |
| Router (Offline request) | 1 | Provide device certificates for legacy SCEP-based router enrollment. |
| Smartcard Logon | 1 | Sign in to Windows using a smart card. |
| Smartcard User | 1 | Use a smart card for sign-in and secure email. |
| Subordinate Certification Authority | 1 | Authorize a subordinate CA to issue certificates under its parent. |
| Trust List Signing | 1 | Digitally sign certificate trust lists (CTLs). |
| User | 1 | Provide user authentication, secure email, and EFS file encryption. |
| User Signature Only | 1 | Digitally sign user data and email without encryption. |
| Web Server | 1 | Authenticate HTTPS websites and other TLS server endpoints. |
| Workstation Authentication | 2 | Authenticate client computers to servers and network services. |

## Procedure: Publish a template

To publish a template to an Enterprise CA so that the CA can issue certificates based on that template, ensure that you have the **Manage CA** permission and an existing template that has replicated in AD DS and is compatible with the CA. Then perform the following steps:

1. On the enterprise CA, open **Certification Authority** (`certsrv.msc`) and expand the CA name.
1. Open the shortcut menu for **Certificate Templates**, then select **New** > **Certificate Template to Issue**.
1. Select the template you want to issue, then select **OK**.
1. Confirm that the template appears under the CA's **Certificate Templates** node.

As an alternative to the console, you can publish the template with `certutil`:

1. On the enterprise CA, open **Windows PowerShell** as administrator.
1. List AD DS templates and identify the template name:

   ```powershell
   certutil.exe -ADTemplate
   ```

   Use the programmatic name, such as `WorkstationAuthentication`, rather than the display name.

1. Add the template, replacing `<TemplateName>` with its name. The `+` preserves existing templates:

   ```powershell
   certutil.exe -setcatemplates "+<TemplateName>"
   ```

1. Verify that the template appears in the CA's list of templates available for issuance:

   ```powershell
   certutil.exe -catemplates
   ```

Publishing a template doesn't issue a certificate. Requesters still need **Read** and **Enroll** permissions on the template.

## Procedure: Unpublish a template

The following procedure describes how to unpublish a template from an enterprise CA. It requires CA Admin permissions. Template administration permissions isn't required if the template object already exists and has replicated.  

1. On `<CAName>`, open **Certification Authority** > **Certificate Templates**
1. Open the shortcut menu for the template beneath the CA's **Certificate Templates** node, then select **Delete**. This removes CA publication; it doesn't delete the forest template object.

Use the following sequence to remove the template from this CA's publication list and verify the result.

```powershell
certutil.exe -catemplates
certutil.exe -setcatemplates "-<TemplateName>"
certutil.exe -catemplates
```

`<TemplateName>` will be absent from the final CA publication list.
