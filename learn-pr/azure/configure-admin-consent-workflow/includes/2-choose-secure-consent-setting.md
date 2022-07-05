Admin consent workflow is a feature in Azure Active Directory that provides administrators with a secure way for onboarding applications that employees use. When you enable the workflow, users can request for admin consent when they're unable to consent for themselves.

## Consent setting options

As administrator, you can control how users consent to applications with the following options available through the Azure portal:

- **Disable user consent** - For example, you may choose to turn off user consent so that the IT administrator has full control over all the applications that are used in your tenant.
- **Allow users to consent to the required permissions** - It's NOT recommended to keep user consent open if you have sensitive data in your tenant.
- **Allow user consent from verified publishers for selected permissions** - Users can consent to permissions classified as low impact for applications from verified publishers or applications registered in your tenant.

## Why enable admin consent workflow?

Some organizations turn off user consent to prevent users from consenting to malicious apps that compromise the security of the organization's resources. In other situations, applications may request permissions that require admin consent. In such scenarios, enabling admin consent workflow ensures that users get the support they need to onboard applications when they're unable to grant consent.

With the workflow, administrators gain more control over what applications their users can access by screening all consent requests from a single location before granting tenant-wide admin consent. The workflow streamlines the process of receiving and acting on the admin consent requests.

## Consent experience without admin consent workflow

When user consent is disabled or the application requires permissions that only an admin can grant consent, the user won't be able to grant consent to the application. The user will see a generic error message that says they're unauthorized to access the app and they should ask their admin for help.

:::image type="content" source="../media/2-need-admin-approval.png" alt-text="Screenshot of requiring admin approval consent prompt.":::

In most cases, users don't know who their admin is, so either they give up or they create a new local account on the application's portal. Even when the admin has been notified of the user's problem, there isn't a streamlined process to help admins to grant access and notify their users.

## Consent experience with admin consent workflow

When a user tries to access an application but is unable to provide consent, they can send a request for admin approval.

:::image type="content" source="../media/2-need-admin-approval-justification.png" alt-text="Screenshot of the consent screen for requesting admin consent.":::

Designated reviewers with the privilege to grant admin consent review the pending requests and grant or deny admin consent, then the user is notified of the action.
