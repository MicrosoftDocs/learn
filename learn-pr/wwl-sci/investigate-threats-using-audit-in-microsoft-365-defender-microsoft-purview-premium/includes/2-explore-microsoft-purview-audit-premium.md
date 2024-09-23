
In the Microsoft Purview Audit (Standard) module, you learned that the Unified Audit Log (UAL) provides organizations with the ability to log and search for audited activities. It also enables an organization to power its forensic, IT, compliance, and legal investigations.

In this module, you'll learn how Microsoft Purview Audit (Premium) builds on the capabilities of Microsoft Purview Audit (Standard). It provides advanced features designed specifically for organizations that conduct forensic and compliance investigations. These features provide:

- Customized retention policies
- Increased audit log retention required to conduct an investigation.
- Access to High-value, crucial events that help determine scope of compromise.
- Higher bandwidth access, and thus, faster access to Office 365 Management Activity API.

This unit provides an overview of Audit (Premium) capabilities.

### Organization subscription and user licensing

Audit (Premium) is available for organizations with an Office 365 E5/A5/G5 or Microsoft 365 Enterprise E5/A5/G5 subscription. For organizations with an E5/A5/G5 subscription, eligible customers and users who are assigned the appropriate E5/A5/G5 license have access to Audit (Premium) events. Audit (Premium) events are only generated for users with E5/A5/G5 licenses once those licenses are assigned.

To benefit from user-level Audit (Premium) capabilities that retain audit logs for longer than 180 days (and up to one year), the user who generates the audit log (by performing an audited activity) must be assigned an Office 365 E5 or Microsoft 365 E5 license or have a Microsoft 365 E5 Compliance or E5 eDiscovery and Audit add-on license. To retain audit logs for 10 years, the user who generates the audit log must also be assigned a 10-year audit log retention add-on license in addition to an E5 license.

### Long-term retention of audit logs

When an audited activity is performed by a user or admin, an audit record is generated and stored in the audit log for the organization. In Microsoft Purview Audit (Standard), audit log records are retained for 180 days. In comparison, Audit (Premium) retains all Exchange, SharePoint, and Microsoft Entra audit records for one year.

Audit (Premium) provides this extra retention time by implementing a default audit log retention policy. Retaining audit records for longer periods can help with on-going forensic or compliance investigations. For more information, see the "Default audit log retention policy" section in [Manage audit log retention policies](/microsoft-365/compliance/audit-log-retention-policies?azure-portal=true).

> [!NOTE]
> In addition to the one-year retention capabilities of Audit (Premium), Microsoft 365 can optionally retain audit logs for 10 years. The 10-year retention of audit logs helps support long running investigations and respond to regulatory, legal, and internal obligations. **Retaining audit logs for 10 years requires an extra per-user add-on license**. After this license is assigned to a user and an appropriate 10-year audit log retention policy is set for that user, audit logs covered by that policy will start to be retained for the 10-year period. This policy isn't retroactive. As such, it can't retain audit logs that were generated before the 10-year audit log retention policy was created.

### Audit log retention policies

All audit records generated in other services that aren't covered by the default audit log retention policy are retained for 180 days. But you can create customized audit log retention policies to retain other audit records for up to 10 years. You can create a policy to retain audit records based on one or more of the following criteria:

- The Microsoft 365 service where the audited activities occur.
- Specific audited activities.
- The user who performs an audited activity.

You can also specify how long to retain audit records that match the policy and a priority level. This design enables specific policies to take priority over other policies.

Any custom audit log retention policy takes precedence over the default audit retention policy in case you must retain Exchange, SharePoint, or Microsoft Entra audit records for less than a year (or up to 10 years) for some or all users in your organization.

> [!CAUTION]
> Any audit log data covered by a 10-year audit log retention policy that you created after the feature was released to general availability in the last quarter of 2020 will be retained for 10 years. This design includes 10-year audit log retention policies that were created before the required add-on license was released for purchase in March 2021. However, because the 10-Year Audit Log Retention Add On license is now available, you must purchase and assign those add-on licenses for all users whose audit data is covered by a 10-year audit retention policy.

### Audit (Premium) events

Audit (Premium) helps organizations conduct forensic and compliance investigations by providing access to important events, such as:

- when mail items were accessed.
- when mail items were replied to and forwarded.
- when and what a user searched for in Exchange Online and SharePoint Online.

These events can help you investigate possible breaches and determine the scope of compromise. Along with these events in Exchange and SharePoint, there are events in other Microsoft 365 services that are also considered important events. These events also require that users are assigned the [appropriate Audit (Premium) license](/microsoft-365/compliance/auditing-solutions-overview?azure-portal=true).

> [!IMPORTANT]
> Users must be assigned an Audit (Premium) license so that audit logs will be generated when users perform these events.

Audit (Premium) provides the following new events, each of which is introduced in the following sections:

- [MailItemsAccessed event](/microsoft-365/compliance/audit-premium)
- [Send event](/microsoft-365/compliance/audit-premium)
- [SearchQueryInitiatedExchange event](/microsoft-365/compliance/audit-premium)
- [SearchQueryInitiatedSharePoint event](/microsoft-365/compliance/audit-premium)
- [Other Audit (Premium) events in Microsoft 365](/microsoft-365/compliance/audit-premium)

> [!NOTE]
> These new events in Audit (Premium) events are available in the Office 365 Management Activity API. As long as audit records are generated for users with the appropriate license, you'll be able to access these records through the Office 365 Management Activity API.

#### MailItemsAccessed event

The MailItemsAccessed event is a mailbox auditing action. It's triggered when mail data is accessed by mail protocols and mail clients. This event can help investigators identify data breaches and determine the scope of messages that  have been compromised. If an attacker gained access to email messages, the MailItemsAccessed action is triggered even if there's no explicit signal that messages were read. In other words, the type of access such as a bind or sync is recorded in the audit record.

The MailItemsAccessed event replaces MessageBind in mailbox auditing logging in Exchange Online. It provides the following improvements:

- MessageBind was only configurable for the AuditAdmin user sign-in type. It didn't apply to delegate or owner actions.
     - **Improvement**. MailItemsAccessed applies to all sign-in types.
- MessageBind only covered access by a mail client. It didn't apply to sync activities.
     - **Improvement**. MailItemsAccessed events are triggered by both bind and sync access types.
- MessageBind actions would trigger the creation of multiple audit records when the same email message was accessed. This design resulted in auditing "noise".
     - **Improvement**. MailItemsAccessed events are aggregated into fewer audit records.

To search for MailItemsAccessed audit records, organizations can search for the **Accessed mailbox items** activity in the Exchange mailbox activities drop-down list in the audit log search tool in the Microsoft Purview compliance portal.

:::image type="content" source="../media/advanced-audit-mail-items-accessed-3ce3f22d.png" alt-text="Screenshot of the Search window with the Accessed mailbox items option selected for the Activities setting.":::


You can also run the [Search-UnifiedAuditLog -Operations MailItemsAccessed](/powershell/module/exchange/search-unifiedauditlog?azure-portal=true) or [Search-MailboxAuditLog -Operations MailItemsAccessed](/powershell/module/exchange/search-mailboxauditlog?azure-portal=true) commands in Exchange Online PowerShell.

#### Send event

The Send event is another mailbox auditing action. It's triggered when a user completes one of the following actions:

 -  Sends an email message.
 -  Replies to an email message.
 -  Forwards an email message.

Investigators can use the Send event to identify email sent from a compromised account. The audit record for a Send event contains information about the message, such as:

 -  when the message was sent.
 -  the InternetMessage ID.
 -  the subject line.
 -  whether the message contained attachments.

This auditing information can help investigators identify information about email messages sent from a compromised account or sent by an attacker. Additionally, investigators can use a Microsoft 365 eDiscovery tool to search for the message (by using the subject line or message ID). By doing so, they can identify the recipients the message was sent to and the actual contents of the sent message.

To search for Send audit records, you can search for the **Sent message** activity in the Exchange mailbox activities drop-down list in the audit log search tool in the Microsoft Purview compliance portal.

:::image type="content" source="../media/advanced-audit-sent-message-79c18307.png" alt-text="Screenshot of the Search window with the Sent message option selected for the Activities setting.":::


You can also run the [Search-UnifiedAuditLog -Operations Send](/powershell/module/exchange/search-unifiedauditlog?azure-portal=true) or [Search-MailboxAuditLog -Operations Send](/powershell/module/exchange/search-mailboxauditlog?azure-portal=true) commands in Exchange Online PowerShell.

#### SearchQueryInitiatedExchange event

The SearchQueryInitiatedExchange event is triggered when a person uses Outlook to search for items in a mailbox. Events are triggered when searches are performed in the following Outlook environments:

- Outlook (desktop client)
- Outlook on the web (OWA)
- Outlook for iOS
- Outlook for Android
- Mail app for Windows 10

Investigators can use the SearchQueryInitiatedExchange event to determine if an attacker (who compromised an account) looked for or tried to access sensitive information in the mailbox. The audit record for a SearchQueryInitiatedExchange event contains information such as the actual text of the search query. The audit record also indicates the Outlook environment the search was performed in. By looking at the search queries that an attacker performed, an investigator can better understand the intent of the email data that was searched for.

To search for SearchQueryInitiatedExchange audit records, you can search for the **Performed email search** activity in the Search activities drop-down list in the audit log search tool in the Microsoft Purview compliance portal.

:::image type="content" source="../media/advanced-audit-search-exchange-fea27fe7.png" alt-text="Screenshot of the Search window with the Performed email search option selected for the Activities setting.":::


You can also run the [Search-UnifiedAuditLog -Operations SearchQueryInitiatedExchange](/powershell/module/exchange/search-unifiedauditlog?azure-portal=true) in Exchange Online PowerShell.

You must enable SearchQueryInitiatedExchange to be logged so you can search for this event in the audit log.

#### SearchQueryInitiatedSharePoint event

The SearchQueryInitiatedSharePoint event is similar to searching for mailbox items. It's triggered when a person searches for items in SharePoint. Events are triggered when searches are performed on the root or default page of the following types of SharePoint sites:

- Home sites
- Communication sites
- Hub sites
- Sites associated with Microsoft Teams

Investigators can use the SearchQueryInitiatedSharePoint event to determine if an attacker tried to find (and possibly accessed) sensitive information in SharePoint. The audit record for a SearchQueryInitiatedSharePoint event contains the actual text of the search query. The audit record also indicates the type of SharePoint site that was searched. By looking at the search queries that an attacker ran, an investigator can better understand the intent and scope of the file data the attacker searched for.

To search for SearchQueryInitiatedSharePoint audit records, you can search for the **Performed SharePoint search** activity in the Search activities drop-down list in the audit log search tool in the Microsoft Purview compliance portal.

:::image type="content" source="../media/advanced-audit-search-sharepoint-86a40402.png" alt-text="Screenshot of the Search window with the Performed SharePoint search option selected for the Activities setting.":::


You can also run the [Search-UnifiedAuditLog -Operations SearchQueryInitiatedSharePoint](/powershell/module/exchange/search-unifiedauditlog?azure-portal=true) in Exchange Online PowerShell.

> [!NOTE]
> You must enable SearchQueryInitiatedSharePoint to be logged so you can search for this event in the audit log.

#### Other Audit (Premium) events in Microsoft 365

Besides the events in Exchange Online and SharePoint Online, there are events in other Microsoft 365 services that are logged when users are assigned the appropriate Audit (Premium) licensing. The following Microsoft 365 services provide Audit (Premium) events. Select the corresponding link to go to an article that identifies and describes these events.

 -  [Microsoft Forms](/microsoft-365/compliance/search-the-audit-log-in-security-and-compliance?azure-portal=true)
 -  [Microsoft Stream](/stream/audit-logs#actions-logged-in-stream?azure-portal=true)
 -  [Microsoft Teams](/microsoftteams/audit-log-events#teams-activities?azure-portal=true)
 -  [Yammer](/microsoft-365/compliance/search-the-audit-log-in-security-and-compliance?azure-portal=true)

### High-bandwidth access to the Office 365 Management Activity API

Organizations that previously accessed auditing logs through the Office 365 Management Activity API were restricted by throttling limits at the publisher level. As a result, for publishers who pulled data on behalf of multiple customers, the limit is shared by all those customers.

With the release of Audit (Premium), Microsoft 365 moved from a publisher-level limit to a tenant-level limit. The result is that each organization gets their own fully allocated bandwidth quota to access their auditing data. The bandwidth isn't a static, predefined limit. Instead, it's modeled on a combination of factors. These factors include the number of users in the organization, and the fact that E5/A5/G5 organizations get more bandwidth than non-E5/A5/G5 organizations.

All organizations are initially allocated a baseline of 2,000 requests per minute. This limit dynamically increases depending on an organization's user count and their licensing subscription. E5/A5/G5 organizations get about twice as much bandwidth as non-E5/A5/G5 organizations. There will be a cap on the maximum bandwidth to protect the health of the service.

**Additional reading**. For more information, see the "API throttling" section in [Office 365 Management Activity API reference](/office/office-365-management-api/office-365-management-activity-api-reference#api-throttling?azure-portal=true). [FAQs for Audit (Premium)](/microsoft-365/compliance/audit-premium#faqs-for-audit-premium)

## Knowledge check

Choose the best response for the following question. Then select “Check your answers.”
