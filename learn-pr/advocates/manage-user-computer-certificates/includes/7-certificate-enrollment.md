Enrollment requests a certificate under an enrollment policy and, when issuance succeeds, installs the response with its key association. It differs from importing a certificate that already exists.

## Understand template-driven enrollment

An AD CS enterprise CA uses certificate templates published through Active Directory. A template describes eligibility, permitted purpose, subject construction, key settings, lifetime, renewal behavior, and issuance requirements.

Publishing a template in Active Directory isn't sufficient by itself. The issuing CA must be configured to issue it. The requester also needs the applicable template and CA request permissions.

- **Read** permits template discovery.
- **Enroll** permits requesting a certificate.
- **Autoenroll** permits the policy-driven automatic path when its other prerequisites are satisfied.

Local administrator rights on a computer don't supply permissions for enrollment, enrollment permissions must be assigned in the certificate template.

Which security principal is used for the request is important. A user enrollment and a computer enrollment have different contexts and can have different eligible templates. Verify the target account and template permissions instead of substituting an administrator's user certificate for a computer certificate.

The template's internal name can differ from its display name. Use the configured template name or supported OID in command examples, not an assumed display label.

## Determine who supplies identity

In environments where clients are domain joined, a template can build subject and SAN information from Active Directory. Another template can permit the requester to supply approved identity values. 

Don't change a broadly available template to accept arbitrary subjects merely to make a request succeed. Certificate identities can participate in authentication, and unsafe issuance policy can authorize unintended identities.

Requested values aren't guaranteed issued values. The CA and template can reject, replace, or constrain them. Inspect the actual issued certificate.

Standalone AD CS CAs and third-party CAs use different policy and approval arrangements. A standalone Windows Server CA doesn't consume Active Directory certificate templates. A file-based request is often the appropriate path for a workgroup server or external issuer.

## Enroll through either certificate console

Use `certmgr.msc` to request enrollment for a user certificate. Use elevated `certlm.msc` to manage enrollment for a machine certificate. The workflow is similar, but the account context and eligible templates differ.

1. Expand **Personal** and open the **Certificates** shortcut menu. Select **All Tasks** > **Request New Certificate**.
1. Select the intended enrollment policy, such as **Active Directory Enrollment Policy**.
1. Select an eligible template. If the wizard shows **More information is required to enroll for this certificate**, provide the approved values through its properties.
1. Select **Enroll** and inspect the result for each request.
1. For an issued certificate, inspect the resulting Personal-store entry and confirm its identity, purpose, and private-key association.

An issued result means that the CA returned a certificate. A pending result means that approval or another issuance requirement remains. A failed result requires diagnosis.

## Enroll with certreq

As an alternative to the certificates, console, you can use the `certreq.exe` command line utility.

To request an existing user template as the intended user use the following command:

```console
certreq.exe -enroll -user "<UserTemplateName>"
```

To request a certificate based on a computer template, issue the following command in an elevated prompt:

```console
certreq.exe -enroll -machine "<ComputerTemplateName>"
```

An issued request should create a certificate in the corresponding Personal store. For a pending request, record the CA request ID and follow the approval process. For supplied subject or SAN values, use an approved custom request rather than assuming the template name authorizes an identity.

## Recognize other enrollment policy sources

Certificate Enrollment Policy and Certificate Enrollment Web Services provide configured HTTPS policy and enrollment endpoints. They aren't prerequisites for ordinary AD enrollment, and they aren't the same as the older CA web enrollment pages.

Use only the approved endpoint and authentication method. Workgroup membership doesn't automatically make AD enrollment available; a separately configured web-service arrangement or external request workflow is required.
