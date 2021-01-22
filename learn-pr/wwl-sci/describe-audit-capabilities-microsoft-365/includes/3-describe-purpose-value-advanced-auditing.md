Advanced Audit helps organizations to conduct forensic and compliance investigations by increasing audit log retention that's required to conduct an investigation. Audit log retention provides access to crucial events that help determine the scope of compromise, and faster access to Office 365 Management Activity API.

These capabilities differentiate Advanced Audit from the core audit functionality described in the previous unit and require a Microsoft 365 E5 license, or a Microsoft 365 E3 or Office 365 E3 license with a Microsoft 365 E5 Compliance, or Microsoft 365 E5 eDiscovery and Audit add-on license.

## Long-term retention of audit logs

Advanced Audit keeps all Exchange, SharePoint, and Azure Active Directory audit records for one year. Keeping audit records for longer periods can help with ongoing forensic or compliance investigations. Microsoft is planning to release the capability to keep audit logs for 10 years. The 10-year retention of audit logs helps support long-running investigations and respond to regulatory, legal, and internal obligations.

> [!NOTE]
> Retaining audit logs for 10 years will require an additional add-on license. This new license will be available in 2021.

## Access to crucial events for investigations

Advanced Auditing helps organizations to conduct forensic and compliance investigations by providing access to crucial events, such as when mail items were accessed, when mail items were replied to and forwarded, and when and what a user searched for in Exchange Online and SharePoint Online. These crucial events can help admins and users investigate possible breaches and determine the scope of compromise. Advanced Auditing provides the following crucial events:

- **MailItemsAccessed** - The MailItemsAccessed event is a mailbox auditing action that's triggered when mail data is accessed by mail protocols and mail clients. The MailItemsAccessed action can help investigators identify data breaches and determine the scope of messages that may have been compromised.
- **Send** - The Send event is also a mailbox auditing action and is triggered when a user does one of the following actions:

    - Sends an email message
    - Replies to an email message
    - Forwards an email message

Investigators can use the Send event to identify emails sent from a compromised account. The audit record for a Send event contains information about the message. The actual content of the message isn't displayed. However, information such as when the message was sent, the InternetMessage ID, the subject line, and if the message contained attachments, are accessible. This auditing information can help investigators identify information about email messages sent from a compromised account or sent by an attacker.

- **SearchQueryInitiatedExchange** - The SearchQueryInitiatedExchange event is triggered when a person uses the Search bar in Outlook on the web (OWA) to search for items in a mailbox. Investigators can use the SearchQueryInitiatedExchange event to determine if an attacker may have compromised an account, or tried to access sensitive information in the mailbox. The audit record for a SearchQueryInitiatedExchange event contains information such as the actual text of the search query. By looking at the search queries that an attacker may have made, an investigator can better understand the intent of the email data that was searched for.

- **SearchQueryInitiatedSharePoint** - Similar to searching for mailbox items, the SearchQueryInitiatedSharePoint event is triggered when a person searches for items in the SharePoint home site for your organization. Investigators can use the SearchQueryInitiatedSharePoint event to determine if an attacker tried to find (and possibly accessed) sensitive information in SharePoint. The audit record for a SearchQueryInitiatedSharePoint event also contains the actual text of the search query.  By looking at the search queries that an attacker may have performed, an investigator can better understand the intent and scope of the file data being searched for.

## High-bandwidth access to Office 365 Management Activity API

Organizations that access auditing logs through the Office 365 Management Activity API were previously restricted by throttling limits at the publisher level. This means that for a publisher pulling data on behalf of multiple customers, the limit was shared by all those customers.

With the release of Advanced Audit, Microsoft is moving from a publisher-level limit to a tenant-level limit. The result is that each organization will get their own fully allocated bandwidth quota to access their auditing data. The bandwidth isn't a static, predefined limit but is modeled on a combination of factors, including the number of seats in the organization and the type of Microsoft 365 license (organizations with an E5 license will get more bandwidth than non-E5 organizations).

## Interactive guide

Your organization is working with an audit team to find information about activities, such as whether a user sent an email, viewed a document, or whether an admin has had their password reset.  To help the audit team, you’ve been asked to verify whether a specific user has sent emails about a particular confidential project. Audit log searches will help you find this kind of information. You do an audit log search:

[![Interactive guide](../media/3-audit-log-inter-active-guide-expanded.png)](https://edxinteractivepage.blob.core.windows.net/edxpages/Security%20fundamentals/LP04M06%20-%20Search%20the%20audit%20log/index.html?azure-portal=true)
