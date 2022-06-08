
When deciding which consent setting to use in an organization, the security of your organization's data should be prioritized. As admin, you can control how users access applications in your tenant with the following options. 

- Disable user consent. For example, you may choose to turn off user consent so that the IT administrator has full control over all the applications that are used in your tenant.
- Allow users to consent to the required permissions. It's NOT recommended to keep user consent open if you have sensitive data in your tenant.
- If you still want to retain admin-only consent for certain permissions but want to assist your end-users in onboarding their application, you can use the admin consent workflow to evaluate and respond to admin consent requests. This way, you can have a queue of all the requests for admin consent for your tenant and can track and respond to them directly through the Azure portal. To learn how to configure the admin consent workflow, see configure-admin-consent-workflow.md.

## Consent experience when the admin consent workflow is disabled

When user consent is disabled or the application requires permissions that only an admin can grant consent, the user won't be able to grant consent to the application. The user will see a generic error message telling them they are unauthorized to access the app and they should ask their admin for help.

:::image type="content" source="../media/2-need-admin-approval.png" alt-text="Require admin approval consent prompt.":::

In most cases, users don't know who their admin is, so either they give up or they create a new local account on the application. Even when the admin has been notified of the user's problem, there isn't a streamline process to help admins to grant access and notify their users.

## Why use the admin consent workflow?

The admin consent workflow enables end-users to request consent for applications that require admin consent or where the organization doesn't allow end-users to consent to applications. The workflow gives admins a secure way to grant access to applications that require admin approval.

When a user tries to access an application but is unable to provide consent, they can send a request for admin approval. The request is sent via email to admins who have been designated as reviewers. A reviewer takes action on the request, and the user is notified of the action.

Designated reviewers with the privilege to grant admin consent will review the pending requests and grant or deny admin consent. The workflow enables your organization to securely onboard applications while still allowing users to access apps in a more streamlined and supportive way.
