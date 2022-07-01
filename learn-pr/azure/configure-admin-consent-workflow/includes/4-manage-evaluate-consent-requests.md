You enabled the admin consent workflow to help you keep track of incoming consent requests and evaluate them properly. You tried to access the application using a non-admin user account and the workflow enabled you to request admin consent.

Once the request is submitted, a designated reviewer receives a notification of the request through email. The reviewer responds to the request through the Azure portal.

## Email notifications

Email notifications alert reviewers about active and expired admin consent requests. If configured, all reviewers will receive email notifications when:

- A new request has been created
- A request has expired
- A request is nearing the expiration date.

Requestors will receive email notifications when:

- They submit a new request for access
- Their request has expired
- Their request has been denied or blocked
- Their request has been approved

## Evaluate admin consent requests

Granting tenant-wide admin consent is a sensitive operation. Permissions will be granted on behalf of the entire organization, and they can include permissions to attempt highly privileged operations. Examples of such operations are role management, full access to all mailboxes or all sites, and full user impersonation.

Before you grant tenant-wide admin consent, it's important to ensure that you trust the application and the application publisher for the level of access you're granting. If you aren't confident that you understand who controls the application and why the application is requesting the permissions, don't grant consent.

When you're evaluating a request to grant admin consent, here are some recommendations to consider:

- **Understand the permissions and consent framework in the Microsoft identity platform**.

- **Understand the difference between delegated permissions and application permissions** - Application permissions allow the application to access the data for the entire organization, without any user interaction. Delegated permissions allow the application to act on behalf of a user who was signed into the application at some point.

- **Understand the permissions that are being requested** - The permissions requested by the application are listed in the consent prompt. Expanding the permission title displays the permission’s description. Permissions for the Microsoft Graph API are described in Microsoft Graph Permissions Reference. Refer to the documentation for other APIs to understand the permissions they expose. If you don't understand a permission that's being requested, don't grant consent.

- **Understand which application is requesting permissions and who published the application** - Be wary of malicious applications that try to look like other applications. If you doubt the legitimacy of an application or its publisher, don't grant consent. Instead, seek confirmation (for example, directly from the application publisher).

- **Ensure that the requested permissions are aligned with the features you expect from the application** - For example, an application that offers SharePoint site management might require delegated access to read all site collections, but it wouldn't necessarily need full access to all mailboxes, or full impersonation privileges in the directory. If you suspect that the application is requesting more permissions than it needs, don't grant consent. Contact the application publisher to obtain more details.

## How reviewers respond to the requests

When the user submits a consent request, the request shows up in the **Admin consent request** page in the Azure portal. Designated reviewers sign in to view and act on the new requests. Reviewers only see consent requests that were created after they were designated as reviewers.

:::image type="content" source="../media/4-consent-request-list.png" alt-text="Screenshot of admin consent request page.":::

The designated reviewers will be able to evaluate pending consent requests in the **My Pending** queue. Global administrators, Application administrators, Cloud application administrators, and Global readers will be able to see all pending, expired, and completed consent requests in the **All (Preview)** queue. Reviewers will only be able to act on requests that were made after they were designated as reviewers.

>[!NOTE]
>Only reviewers with the global administrator role can approve admin consent requests

After evaluating the request by reviewing the details of the application and the permissions it's requesting, the designated reviewers can choose to approve, deny or block requests.
