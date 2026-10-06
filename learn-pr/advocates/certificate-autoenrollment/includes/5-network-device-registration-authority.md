A registration authority (RA) is a trusted intermediary that checks whether a certificate request is authorized and submits it to a certificate authority (CA) for issuance. NDES translates SCEP requests into AD CS requests through RA credentials. The RA validates the permitted enrollment path and signs or protects its exchange with the CA; it isn't the CA and never holds the CA private key. NDES isn't a general template browser and should run on a dedicated member server rather than on the issuing CA. Its optional challenge is commonly called a one-time password (**OTP**), but the challenge proves authorization only when the surrounding management process binds it to a known device or user.

## Architecture and controls

The following table identifies the NDES components that collectively authorize and transport SCEP requests. A secure design must protect every row because no single template or IIS setting establishes device identity by itself.

| Component | Required control | Failure/security consequence |
|---|---|---|
| NDES service account | Dedicated least-privilege identity; Enroll only on mapped templates and required RA templates; protect logon and rotation | Broad template enrollment lets a web-tier compromise obtain unintended certificates |
| RA certificates | Separate signing/enrollment-agent and encryption roles as installed by NDES; monitor expiry and private-key ACL | Expired/missing RA certificate stops SCEP; exported RA signing key can authorize fraudulent requests |
| IIS SCEP endpoint | HTTPS for `/certsrv/mscep`; restrict verbs, request size, logging, source networks, and management integration | HTTP or unvalidated TLS exposes challenge/request metadata and enables endpoint impersonation |
| Admin challenge endpoint | Restrict `/certsrv/mscep_admin` to authorized operators/management connector; issue short-lived, one-time challenges | Shared/static or broadly obtainable challenge defeats enrollment authorization |
| Template mappings | `SignatureTemplate`, `EncryptionTemplate`, and `GeneralPurposeTemplate` beneath `HKLM\SOFTWARE\Microsoft\Cryptography\MSCEP` map SCEP key usage to exact template names | Wrong/unpublished template causes denial; broad GeneralPurpose authentication template expands device identity beyond intent |
| CA/template | Enterprise CA publishes only approved device templates; NDES identity has Read/Enroll; subject/SAN and EKU fit device mapping | SCEP submission capability doesn't prove device identity. The management system must bind challenge/profile to a managed device |
| Availability | Consistent RA certs/configuration and tested management integration across nodes; understand OTP/node state and affinity | A naive stateless load balancer can send challenge and request to incompatible nodes or hide application failure |

One-time password issuance is an authorization ceremony, not device identity by itself. Correlate the challenge to a device-management record, requester, intended template, expected subject/SAN, issuance time, and CA `<RequestId>`. Never log reusable secrets.

## Procedure: Managed network/mobile device

A device-management platform such as Microsoft Intune supplies SCEP profiles and manages certificate enrollment, renewal, and retirement. Devices generate nonexportable private keys locally and submit certificate requests to AD CS through NDES, which checks enrollment authorization. Intune deployments using AD CS also require the Certificate Connector for Microsoft Intune on the NDES server.

1. Device management establishes device/user identity and authorizes the SCEP profile.
1. The platform obtains or brokers a one-time challenge without exposing the admin endpoint to devices or the internet.
1. Device validates `<PkiWebHost>`, generates its key locally (secure hardware where supported), and submits SCEP.
1. NDES selects one configured template based on request key usage and signs/forwards the request as RA.
1. CA evaluates mapped template, NDES identity, request, and policy; device installs the result.
1. Management validates certificate presence and renewal, and removes/revokes credentials when the device is retired or compromised.

## Procedure: Install and validate NDES

To install and validate NDES on a Windows Server member server, perform the following steps:

1. In Server Manager, choose **Add Roles and Features** > **Active Directory Certificate Services** > **Network Device Enrollment Service**.
1. Provide the approved NDES service identity and RA information. Ensure the account has only required template permissions.
1. Verify NDES obtains valid RA signing and encryption certificates and record their expiry monitoring.

To perform these steps from the command line, run the following command on the dedicated NDES member server to install the role service and its management tools.

```powershell
Install-WindowsFeature ADCS-Device-Enrollment -IncludeManagementTools
```

To configure IIS on the server, perform the following steps:

1. Bind the NDES site to HTTPS with the approved `<PkiWebHost>` certificate.
1. Require HTTPS for SCEP and admin applications.
1. Restrict the admin challenge application to the management connector or operator network and strong Windows authentication; expose only the SCEP path to enrolled devices.
1. Validate endpoint authentication, TLS chain/name, logging, and application-aware health checks.

To create an appropriate certificate template:

1. Create separate narrow device-signing, device-encryption, or general-purpose templates only where the device truly needs those usages.
1. Publish them on `<CAName>`, grant the NDES service account Read/Enroll, and remove broad populations.
1. Set the MSCEP `SignatureTemplate`, `EncryptionTemplate`, and `GeneralPurposeTemplate` values to exact template **names**, not display names, through the approved deployment/configuration process.
1. Restart the NDES/IIS service only within the change plan; test each requested key-usage variant and confirm the selected template in **Certification Authority** > **Issued Certificates**.

Use the following PowerShell command to confirm that each SCEP key-usage category maps to the exact approved template name.

```powershell
Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Cryptography\MSCEP' |
    Select-Object SignatureTemplate,EncryptionTemplate,GeneralPurposeTemplate
```

The result should show each populated value exactly matches an approved, published template name.

## Understanding the AD CS and NDES relationship

AD CS and NDES participate in adjacent identity systems without replacing their product-specific controls. A device-management platform distributes SCEP or PKCS profiles, authorizes the device, and brokers the NDES challenge; product enrollment, compliance evaluation, connector deployment, and device retirement remain responsibilities of that platform.

For certificate-based authentication, AD CS supplies the client credential, but the consuming application still defines account mapping, Conditional Access, protocol behavior, and user experience. Windows Hello for Business may use AD CS in a certificate-trust design or related enrollment flow, but Hello provisioning, trust-model selection, and the cloud or on-premises deployment architecture remain outside the certificate service.
