
Data loss can harm an organization’s customers, business processes, and the organization itself. Organizations need to prevent data loss by detecting risky behavior and preventing sensitive information from being shared inappropriately.

In Microsoft Purview, you implement data loss prevention by defining and applying DLP policies. With a DLP policy, you can **identify, monitor, and automatically protect** sensitive items across:
- Microsoft 365 services such as Teams, Exchange, SharePoint, and OneDrive accounts
- Office applications such as Word, Excel, and PowerPoint
- Windows 10, Windows 11, and macOS (three latest released versions) endpoints
- Cloud apps
- on-premises file shares and on-premises SharePoint
- Power BI

DLP detects sensitive items by using deep content analysis, not by just a simple text scan. Content is analyzed for primary data matches to keywords, by the evaluation of regular expressions, by internal function validation, and by secondary data matches that are in proximity to the primary data match. Beyond that DLP also uses machine learning algorithms and other methods to detect content that matches your DLP policies.

### Protective actions of DLP policies
DLP policies are how you monitor the activities that users take on sensitive items at rest, sensitive items in transit, or sensitive items in use and take protective actions. Protective actions that DLP policies can take include:

- Show a pop-up policy tip to the user that warns them that they may be trying to share a sensitive item inappropriately.
- Block the sharing and, via a policy tip, allow the user to override the block and capture the users' justification.
- Block the sharing without the override option.
- For data at rest, sensitive items can be locked and moved to a secure quarantine location,
- For Teams chat, the sensitive information won't be displayed.

All DLP monitored activities are recorded to the Microsoft 365 Audit log by default and routed to Activity explorer. When a user performs an action that meets the criteria of a DLP policy, and you have alerts configured, DLP provides alerts in the DLP alert management dashboard.

### DLP Policy information

DLP policies can be created from predefined templates, or you can create a custom policy. No matter which you choose, all DLP policies require the same information.

- Choose the type of data to monitor. Predefined policy templates allow you to choose from categories such as Financial data, Medical and health data, or Privacy data for various countries and regions.  Alternatively, you can create a custom policy that uses the available sensitive information types, retention labels, and sensitivity labels.
- Choose administrative scoping. DLP policies can be applied to all users and groups by an unrestricted administrator, or they can be scoped to administrative units. Administrative units let you subdivide your organization into smaller units, and then assign specific administrators that can manage only the members of those units.
- Choose the location where the policy will be applied, such as Exchange, SharePoint, OneDrive, and more.
- Choose the conditions that must be matched for a policy to be applied to an item.
- Choose the protective action to take when the policy conditions are met.

:::image type="content" source="../media/dlp-policy-create-v2-inline.png" lightbox="../media/dlp-policy-create-v2-expanded.png" alt-text="A screen capture of the landing page when creating a DLP policy. The screen shows the option of starting with a template or custom policy.":::

:::image type="content" source="../media/dlp-policy-locations-v2-inline.png" lightbox="../media/dlp-policy-locations-v2-expanded.png" alt-text="A screen capture from creating a DLP policy. The screen shows the options for choosing a location to apply a DLP policy.":::

### What is endpoint data loss prevention?

Endpoint DLP enables you to audit and manage the many activities users take on sensitive items that are physically stored Windows 10, Windows 11, or macOS devices. The list that follows shows a few examples:

- Creating an item
- Renaming an item
- Copying items to removable media
- Copying items to network shares
- Printing documents
- Accessing items using unallowed apps and browsers

In the activity explorer, you can view information about what users are doing with sensitive content.

:::image type="content" source="../media/activity-explorer-endpoint-dlp-inline.png" lightbox="../media/activity-explorer-endpoint-dlp-expanded.png" alt-text="A screenshot of data classification information in the activity explorer as monitored through endpoint DLP.":::

Admins use this information to enforce protective actions for content through controls and policies.

### Data loss prevention in Microsoft Teams

Data loss prevention capabilities extend to Microsoft Teams chat and channel messages, whether it's in a message or a file, including messages in private channels. Just like with Exchange, Outlook, SharePoint, and OneDrive, administrators can use DLP policy tips that will be displayed to the user to show them why a policy has been triggered. For example, the screenshot that follows shows a policy tip on a chat message that was blocked because the user attempted to share a U.S. Social Security Number.

:::image type="content" source="../media/5-data-loss-prevention-policy-tip.png" alt-text="A screenshot of a Microsoft Teams chat that was blocked that includes a link for the user to obtain more information.":::

The user can then find out more about why their message was blocked by selecting the "What can I do?" link, and take appropriate action.

:::image type="content" source="../media/5-policy-tip-more-information.png" alt-text="A screenshot of a DPL policy tip presented to user whose message is blocked. The tip provides information about why their message was blocked, and actions to take.":::

DLP policies applied to Microsoft 365 services, including Microsoft Teams, can help users across organizations to collaborate securely and in a way that's in line with compliance requirements.
