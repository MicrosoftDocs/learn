Occasionally, an organization might need Microsoft engineers help to help troubleshoot and fix reported issues. Usually, issues are fixed through extensive telemetry and debugging tools Microsoft has in place for its services. However, some cases require a Microsoft engineer to access the organization’s content to determine the root cause and fix the issue.

Customer Lockbox ensures that Microsoft can't access the content to perform a service operation without explicit approval. Customer Lockbox brings the organization into the approval workflow for requests to access their content.

Customer Lockbox supports requests to access data in Exchange Online, OneDrive for Business, and SharePoint Online.
Here’s what the process looks like:

:::image type="content" source="../media/6-customer-lockbox-workflow-inline.png" lightbox="../media/6-customer-lockbox-workflow-expanded.png" alt-text="Simplified Customer Lockbox workflow.":::

1. Someone at an organization experiences an issue with their Microsoft 365 mailbox, for example. After the user troubleshoots the issue, but can't fix it, they open a support request with Microsoft Support.
1. A Microsoft support engineer reviews the service request and determines a need to access the organization's tenant to repair the issue in Exchange Online.
1. The Microsoft support engineer logs into the Customer Lockbox request tool and makes a data access request that includes the organization's tenant name, service request number, and the estimated time the engineer needs access to the data.
1. After a Microsoft Support manager approves the request, Customer Lockbox sends the designated approver at the organization an email notification about the pending access request from Microsoft.
1. The approver signs in to the Microsoft 365 admin center and approves the request. This step also triggers the creation of an audit record available by searching the audit log. If the customer rejects the request or doesn't approve the request within 12 hours, the request expires, and no access is granted to the Microsoft engineer.
1. After the approver from the organization approves the request, the Microsoft engineer receives the approval message, logs into the tenant in Exchange Online, and fixes the customer's issue. Microsoft engineers have the requested duration to fix the issue after which the access is automatically revoked.

Because Customer Lockbox follows a formal approval for access control, a common question is how this capability relates to Privileged Access Management, described in the previous unit, that also requires approval for access control.  Customer Lockbox allows a level of access control for organizations *when Microsoft accesses data*. Privileged access management allows granular access control *within an organization* for all Microsoft 365 privileged tasks.
