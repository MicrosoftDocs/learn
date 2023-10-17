You can integrate your applications with the Microsoft identity platform to allow users to sign in with their work or school account and access the organization's data to deliver rich data-driven experiences.

Before an application can access the organization's data, a user must grant the application permissions to do so. Different permissions allow different levels of access. By default, all users can consent to applications for permissions that don't require administrator consent. For example, by default, a user can consent to allow an app to access their mailbox. However, they can't consent to allow an app unfettered access to read and write to all files in your organization.

By allowing users to grant apps access to data, users can easily acquire useful applications and be productive. However, in some situations this configuration can represent a risk if it isn't carefully monitored and controlled.

> [!IMPORTANT]
> To reduce the risk of malicious applications attempting to trick users into granting them access to your organization's data, it is recommended that you allow user consent only for applications that have been published by a verified publisher.

## User consent settings

App consent policies describe conditions that must be met before an app can be consented to. These policies might include conditions on the app requesting access, and the permissions the app is requesting.

By choosing which app consent policies apply for all users, you can set limits on when end users are allowed to grant consent to apps and when they'll be required to request administrator review and approval.

 -  **Disable user consent** – Users can't grant permissions to applications. Users can continue to sign into apps they had previously consented to or that are consented to by administrators on their behalf, but they'll not be allowed to consent to new permissions or to new apps on their own. Only users who have been granted a directory role that includes the permission to grant consent will be able to consent to new apps.
 -  **Users can consent to apps from [verified publisher](/azure/active-directory/develop/publisher-verification-overview)s or your organization, but only for permissions you choose**– All users can only consent to apps that were published by a verified publisher and apps that are registered in your tenant. Users can only consent to the permissions you have classified as `low impact`. You must classify permissions to choose which permissions users are allowed to consent to.
 -  **Users can consent to all apps** – This option allows all users to consent to any permission that doesn't require administrator consent for any application.
 -  **Custom app consent policy** – For even more options over the conditions governing when users consent, you can create custom app consent policies and configure those to apply for user consent.
    
    :::image type="content" source="../media/set-for-all-users-8eb060cf.png" alt-text="Screenshot of the User consent settings dialog in the enterprise apps registration process.":::
    

## Risk-based step-up consent

Risk-based step-up consent helps reduce user exposure to malicious apps that make illicit consent requests. If Microsoft detects a risky end-user consent request, the request will require a step-up to admin consent instead. This capability is enabled by default, but it will only result in a behavior change when end-user consent is enabled.

When a risky consent request is detected, the consent prompt will display a message indicating that admin approval is needed. If the admin consent request workflow is enabled, the user can send the request to an administrator for further review directly from the consent prompt. If it isn't enabled, the following message will be displayed:

 -  **AADSTS90094:** needs permission to access resources in your organization that only an admin can grant. Ask an admin to grant permission to this app before you can use it.

In this case, an audit event will also be logged with a Category of **ApplicationManagement**, an Activity Type of **Consent to application**, and a Status Reason of **Risky application detected.**

> [!IMPORTANT]
> Administrators should evaluate all consent requests carefully before approving a request, especially when Microsoft has detected risk.
