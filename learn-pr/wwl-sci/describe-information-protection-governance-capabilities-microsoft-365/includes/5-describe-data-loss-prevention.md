

Data loss can harm an organization’s customers, business processes, and the organization itself. Organizations need to prevent data loss by detecting risky behavior and preventing sensitive information from being shared inappropriately. Admins can use data loss prevention policies, available in the Microsoft Purview compliance portal, to help their organization.

Microsoft Purview Data Loss Prevention (DLP) is a way to protect sensitive information and prevent its inadvertent disclosure. With DLP policies, admins can:

- **Identify, monitor, and automatically protect** sensitive information across Microsoft 365, including:
  - OneDrive for Business
  - SharePoint Online
  - Microsoft Teams
  - Exchange Online
- **Help users learn how compliance works** without interrupting their workflow. For example, if a user tries to share a document containing sensitive information, a DLP policy can send them an email notification and show them a policy tip.
- **View DLP reports** showing content that matches the organization's DLP policies. To assess how the organization is following a DLP policy, admins can see how many matches each policy has over time.

DLP policies protect content through the enforcement of rules that consist of:

- **Conditions** that the content must match before the rule is enforced.
- **Actions** that the admin wants the rule to take automatically when content that matches the conditions has been found.
- **Locations** where the policy will be applied, such as Exchange, SharePoint, OneDrive, and more.

For example, an admin can configure a DLP policy that helps detect information that's subject to a compliance regulation like the Health Insurance Portability and Accountability Act (HIPAA) across all SharePoint sites and OneDrive for Business. The admin can block the relevant documents from being shared inappropriately.

DLP policies protect information by identifying and automatically protecting sensitive data.
Here's some scenarios where DLP policies can help:

- Identify any document containing a credit card number stored in users’ OneDrive for Business accounts.
- Automatically block an email containing employee personal information from being sent outside the organization.

A policy can contain one or more rules, and each rule consists of conditions and actions at a minimum. For each rule, when the conditions are met, the actions are taken automatically. Rules can be grouped into one policy, to help simplify management and reporting.  The diagram below shows how multiple rules, each with their own conditions and actions, are grouped into a single policy.

:::image type="content" source="../media/5-data-loss-prevention-rules.png" alt-text="Diagram showing how a single policy can consist of multiple rules.":::

The rules inside the policy are prioritized in how they’re implemented. For example, in the above diagram, rule one will be prioritized before rule two, and so on.

## What is endpoint data loss prevention?

Endpoint data loss prevention (Endpoint DLP) extends the activity monitoring and protection capabilities of DLP to sensitive items that are physically stored on Windows 10, Windows 11, and macOS (Catalina 10.15 and higher) devices

Endpoint DLP enables admins to audit and manage activities that users complete on sensitive content.  Listed below are a few examples:

- Creating an item
- Renaming an item
- Copying items to removable media
- Copying items to network shares
- Printing documents
- Accessing items using unallowed apps and browsers

In the activity explorer, you can view information about what users are doing with sensitive content.

:::image type="content" source="../media/5-activity-explorer-endpoint-data-loss-prevention.png" alt-text="The activity explorer show activities monitored through endpoint DLP.":::

Admins use this information to enforce protective actions for content through controls and policies.

## Data loss prevention in Microsoft Teams

Data loss prevention capabilities have been extended to Microsoft Teams chat and channel messages, including messages in private channels. With DLP, administrators can now define policies that prevent users from sharing sensitive information in a Teams chat session or channel, whether it's in a message, or a file. Just like with Exchange, Outlook, SharePoint, and OneDrive for Business, administrators can use DLP policy tips that will be displayed to the user to show them why a policy has been triggered. For example, the screenshot below shows a policy tip on a chat message that was blocked because the user attempted to share a U.S. Social Security Number.

:::image type="content" source="../media/5-data-loss-prevention-policy-tip.png" alt-text="A policy tip is shown in Microsoft Teams so that the user knows why their message was blocked.":::

The user can then find out more about why their message was blocked by selecting the "What can I do?" link, and take appropriate action.

:::image type="content" source="../media/5-policy-tip-more-information.png" alt-text="The user can find more information about why their message was blocked, and take recommended actions.":::

With DLP policies, Microsoft Teams can help users across organizations to collaborate securely and in a way that's in line with compliance requirements.
