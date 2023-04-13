You enabled the admin consent workflow to help you keep track of incoming consent requests and evaluate them properly. You tried to access the application using a non-admin user account and the workflow enabled you to request admin consent.

Once the request is submitted, a designated reviewer receives a notification of the request through email. The reviewer responds to the request through the Azure portal.

## Email notifications

Email notifications alert reviewers about active and expired admin consent requests. If configured, all reviewers will receive email notifications when:

:::image type="content" source="../media/4-requesters-reviewers-notification.png" alt-text="Screenshot of requesters and reviewers notification details.":::

## Evaluate admin consent requests

Granting tenant-wide admin consent is a sensitive operation. Permissions will be granted on behalf of the entire organization, and they can include permissions to attempt highly privileged operations. Examples of such operations are role management, full access to all mailboxes or all sites, and full user impersonation. Therefore, you should evaluate the contents of the consent request before granting access.

Check out the following example of a consent request prompt. We'll review the most important aspects of the prompt that you should look at when evaluating a consent request.

:::image type="content" source="../media/4-consent-request-prompt-example.png" alt-text="Screenshot of admin consent request prompt components.":::

| No | Component | Description |
|--|--|--|
| 1 | Application information | Understand which application is requesting permissions and who published the application. This component shows you whether the application was published by Microsoft or not. If the application was published by another organization that's verified by Microsoft, you'll see a blue "verified" badge next to the publisher name. Some malicious applications may try to look like other applications.  If you doubt the legitimacy of an application or its publisher, don't grant consent. Instead, seek confirmation (for example, directly from the application publisher). |
| 2 | Permissions title and description | Understand the permissions that are being requested. Expanding the permission title displays the permission’s description. Permissions for the Microsoft Graph API are described in Microsoft Graph Permissions Reference. Refer to the documentation for other APIs to understand the permissions they expose. If you don't understand a permission that's being requested, don't grant consent. |
| 3 | Report it here | Use this link if you find the app to be suspicious, if you believe the app is impersonating another app, if you believe the app will misuse your data, or for some other reason.

After reviewing the application details and the permissions requested, ensure that the permissions are aligned with the features you expect from the application. For example, an application that offers SharePoint site management might require delegated access to read all site collections. It wouldn't necessarily need full access to all mailboxes, or full impersonation privileges in the directory. If you suspect that the application is requesting more permissions than it needs, don't grant consent. Contact the application publisher to obtain more details.

## How reviewers respond to the requests

When the user submits a consent request, the request shows up in the **Admin consent request** page in the Azure portal. Designated reviewers sign in to view and act on the new requests. Reviewers only see consent requests that were created after they were designated as reviewers.

:::image type="content" source="../media/4-reviewer-deny-block-add.png" alt-text="Diagram shows what actions reviewers and global administrators can take on admin consent requests.":::

The designated reviewers will be able to evaluate pending consent requests in the **My Pending** queue. Global administrators, Application administrators, Cloud application administrators, and Global readers will be able to see all pending, expired, and completed consent requests in the **All (Preview)** queue. Reviewers will only be able to act on requests that were made after they were designated as reviewers.

:::image type="content" source="../media/4-consent-request-list.png" alt-text="Screenshot of admin consent request page.":::

>[!NOTE]
>Only reviewers with the global administrator role can approve admin consent requests

After evaluating the request by reviewing the details of the application and the permissions it's requesting, the designated reviewers can choose to approve, deny or block requests.
