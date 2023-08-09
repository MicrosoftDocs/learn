As an administrator, you need to understand the consent setting options that exist in the Azure portal. You'll also need to understand how the different consent settings affect user experience during sign-in. With this knowledge, you'll be able to see the benefits of admin consent workflow both to you as the admin and to the users of applications in your organization.

## Consent setting options

As administrator, you can control how users consent to applications with the following options available through the Azure portal:

- **Disable user consent** - For example, you may choose to turn off user consent so that the IT administrator has full control over all the applications that are used in your tenant.
- **Allow users to consent to the required permissions** - It's NOT recommended to keep user consent open if you have sensitive data in your tenant.
- **Allow user consent from verified publishers for selected permissions** - Users can consent to permissions classified as low impact for applications from verified publishers or applications registered in your tenant.

## Why enable admin consent workflow?

Admin consent workflow is necessary in the following scenarios:

- In organizations where user consent is disabled to prevent users from consenting to malicious apps that compromise the security of the organization's resources.
- For applications that require admin consent. Non-admin users won't be able to grant consent.

With the workflow, administrators gain more control over what applications their users can access by screening all consent requests from a single location before granting tenant-wide admin consent. The workflow streamlines the process of receiving and acting on the admin consent requests.

| Consent experience without admin consent workflow | Consent experience with admin consent workflow |
|--|--|
| When user consent is disabled or the application requires permissions that only an admin can grant consent, the user won't be able to grant consent to the application. The user will see a generic error message that says they're unauthorized to access the app and they should ask their admin for help. | When a user tries to access an application, but is unable to provide consent, they can send a request for admin approval. |
| In most cases, users don't know who their admin is, so either they give up or they create a new local account on the application's portal. Even when the admin has been notified of the user's problem, there isn't a streamlined process to help admins to grant access and notify their users. | Designated reviewers with the privilege to grant admin consent review the pending requests and grant or deny admin consent, then the user is notified of the action. |
