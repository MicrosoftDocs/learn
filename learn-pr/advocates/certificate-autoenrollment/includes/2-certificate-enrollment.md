Certificate enrollment on domain joined Windows Client and Windows Server computers proceeds through the following sequence:

1. Discover enabled enrollment policy sources.
1. Retrieve templates and filter on publication, Read, compatibility, subject type, and provider support.
1. Evaluate Enroll/Autoenroll, validity/renewal window, supersedence, pending state, and current certificates.
1. Generate or select a key and request under the actual identity.
1. Submit, process issue/pending/deny, install, and associate the private key.

Autoenrollment triggers at sign-in/startup and periodic policy processing. To trigger the autoenrollment process from the command line:

- Run `gpupdate /force` to refresh Group Policy
- Run `certutil.exe -pulse` to trigger the autoenrollment process

> [!NOTE]
> Neither command repairs a bad ACL, unpublished template, unreachable CA, incompatible provider, or denied request.

The autoenrollment policy options to renew expired certificates, update pending certificates, remove revoked certificates, and update certificates that use templates control client processing. They don't make revocation or cleanup instantaneous, and they don't rebind every application.

## Procedure: Configure user and computer autoenrollment

> [!NOTE]
> **Placeholders used throughout this module's procedures**: `<CAName>`, `<CAConfig>`, `<TemplateName>`, `<SerialNumber>`, `<RequestId>`, `<CertificateFile>`, `<Thumbprint>`, and `<PkiWebHost>`. `<CAConfig>` is the CA connection string in `CAHost\CACommonName` form. Stable sample files are `request.inf`, `request.req`, and `issued.cer`.

In this procedure, you'll enable controlled autoenrollment, trigger it, and verify user and computer stores under their real identities. To perform this demo, you need the following permissions:

- Group Policy administrator permissions to edit/link the GPO
- Template administrator to configure template ACL
- Local administrator only to inspect Local Computer keys
- A user test must run as the target user

To complete this procedure, perform the following steps:

1. For computers, go to **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Public Key Policies** > **Certificate Services Client - Auto-Enrollment**.
1. Set **Configuration Model: Enabled**. Select the renewal/pending/template-update options required by the lifecycle. Enable revoked-certificate removal only after application impact is tested.
1. Repeat under **User Configuration** for user profiles when required.
1. In `certtmpl.msc`, grant the pilot group Read, Enroll, and Autoenroll. Confirm the template is published on the intended CA.

Use the following commands on the domain joined client to refresh Group Policy and then use `certutil.exe` to prompt the native autoenrollment engine to process eligible templates

```powershell
gpupdate /force
certutil.exe -pulse
```

To locate the autoenrolled certificates, perform the following steps:

1. Add the **Certificates** snap-in for **My user account**, and inspect **Current User** > **Personal** > **Certificates**.
1. Add the **Certificates** snap-in for **Computer account** > **Local computer**, and inspect **Personal** > **Certificates**.
1. Request manually through **All Tasks** > **Request New Certificate** to compare visible policies/templates, but don't use an administrator account as proof that the target can enroll.
1. Add the archived-certificate view when comparing renewals. Verify thumbprint, serial, subject/SAN, template information, EKUs, validity, provider, and private-key icon.

To find the autoenrolled certificates using PowerShell, use the PowerShell certificate provider to list the current user's and local computer's personal stores after policy processing with the following commands.

```powershell
Get-ChildItem Cert:\CurrentUser\My
Get-ChildItem Cert:\LocalMachine\My
```

> [!NOTE]
> The PowerShell certificate provider and PKI cmdlets can inventory, import/export where authorized, and invoke native enrollment scenarios such as `Get-Certificate`. They're an automation surface, not a new CA transport or authorization boundary; template, identity, provider, and network rules still apply.

The following PowerShell command requests the named template for the current user through the configured native enrollment policy.

```powershell
Get-Certificate -Template "<TemplateName>" -CertStoreLocation Cert:\CurrentUser\My
```

## Pending requests, policy refresh, and supersedence

A pending disposition retains client and request state. Autoenrollment can revisit that request when pending-request updates are enabled, while a manual client retrieves it by `<RequestId>`. If a template is absent from the wizard, determine whether the actual identity can read it, whether an intended CA publishes it, whether recipient and provider compatibility match, whether the subject type is correct, whether supersedence changes eligibility, and whether the selected policy source exposes it.

Policy refresh can introduce a superseding template, but it doesn't remove or deactivate the old certificate. Likewise, a denial belongs to the CA disposition stage and should be diagnosed from the recorded disposition and policy evidence. Broadening Enroll or subject permissions before understanding the denial can convert a configuration problem into an unauthorized issuance path.
