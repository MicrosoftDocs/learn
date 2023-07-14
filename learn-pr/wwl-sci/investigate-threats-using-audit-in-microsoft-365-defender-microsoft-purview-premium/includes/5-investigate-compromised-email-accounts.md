
A compromised user account is also referred to as an account takeover. It's a type of attack where an attacker gains access to a user account and operates as the user. These types of attacks sometimes cause more damage than the attacker may have intended.

When an organization investigates compromised email accounts, it must assume that more mail data was compromised than may be indicated by tracing the attacker's actual presence. Depending on the type of data in email messages, the organization may have to assume that sensitive information was compromised or face regulatory fines unless it can prove that sensitive information wasn't exposed.

For example, HIPAA-regulated organizations face significant fines if there's evidence that patient health information (PHI) was exposed. In these cases, attackers are unlikely to be interested in PHI. However, organizations still must report data breaches unless they can prove otherwise.

To help organizations investigate compromised email accounts, Microsoft 365 audits access to mail data by mail protocols and clients. It does so by using the **MailItemsAccessed** mailbox-auditing action. This audited action can help investigators:

- better understand email data breaches.
- identify the scope of compromises to specific mail items that may have been compromised.

The goal of using this auditing action is forensics defensibility. In other words, it helps assert that a specific piece of mail data wasn't compromised. If an attacker gained access to a specific piece of mail, Exchange Online audits the event even though there's no indication the mail item was read.

### The MailItemsAccessed mailbox-auditing action

The **MailItemsAccessed** action is part of the Audit (Premium) functionality and [Exchange mailbox auditing](/office365/securitycompliance/enable-mailbox-auditing#mailbox-auditing-actions?azure-portal=true). This action is enabled by default for:

- Users that are assigned an Office 365 or Microsoft 365 E5 license.
- Organizations with a Microsoft 365 E5 Compliance add-on subscription.

**MailItemsAccessed** is a mailbox-auditing action that covers all mail protocols: POP, IMAP, MAPI, EWS, Exchange ActiveSync, and REST. It also covers both types of accessing mail: **sync** and **bind**.

Auditing of the sync and bind mail access events are examined in more detail in the next two sections.

#### Auditing sync access

Sync operations are only recorded when a mailbox is accessed by a desktop version of the Outlook client for Windows or Mac. During the sync operation, these clients typically download a large set of mail items from the cloud to a local computer.

The audit volume for sync operations is huge. So, instead of generating an audit record for each mail item that's synched, Microsoft generates an audit event for the mail folder containing items that were synched.

> [!IMPORTANT]
> This design assumes that **all** mail items in the synched folder have been compromised.

The access type is recorded in the **OperationProperties** field of the audit record.

See step 2 in the section below titled **Use MailItemsAccessed audit records for forensic investigations** for an example of displaying the sync access type in an audit record.

#### Auditing bind access

A bind operation is an individual access to an email message.

> [!IMPORTANT]
> Bind activities help determine whether an attacker was able to access, and potentially compromise, individual email messages.

For bind access, the **InternetMessageId** of individual messages are recorded in the audit record. The **MailItemsAccessed** audit action records bind operations and then aggregates them into a single audit record. The following actions occur during this process:

- All bind operations that occur within a 2-minute interval are aggregated in a single audit record in the **Folders** field within the **AuditData** property.
- Each message that was accessed is identified by its **InternetMessageId**.
- The number of bind operations that were aggregated in the record is displayed in the **OperationCount** field in the **AuditData** property.

See step 4 in the section below titled **Use MailItemsAccessed audit records for forensic investigations** for an example of displaying the bind access type in an audit record.

### Throttling of MailItemsAccessed audit records

If more than 1,000 **MailItemsAccessed** audit records are generated for a mailbox in less than 24 hours, Exchange Online stops generating auditing records for the MailItemsAccessed activity. When a mailbox is throttled in this manner, MailItemsAccessed activity won't be logged for 24 hours after the mailbox was throttled.

> [!IMPORTANT]
> If the mailbox was throttled, there's a potential the mailbox could have been compromised during this period.

The recording of MailItemsAccessed activity will be resumed following a 24-hour period.

Here's a few things to keep in mind about throttling:

- Less than 1% of all mailboxes in Exchange Online are throttled.
- When a mailbox is throttling, only audit records for MailItemsAccessed activity aren't audited. Other mailbox auditing actions aren't affected.
- Mailboxes are throttled only for Bind operations. Audit records for sync operations aren't throttled.
- If a mailbox is throttled, you can probably assume there was MailItemsAccessed activity that wasn't recorded in the audit logs.

See step 1 in the following section for an example of displaying the **IsThrottled** property in an audit record.

### Use MailItemsAccessed audit records for forensic investigations

Mailbox auditing generates audit records for access to email messages. By doing so, organizations can be confident that email messages haven't been compromised. For this reason, in circumstances where Microsoft isn't certain that data has been accessed, it assumes that it has been. As such, it records all mail access activity.

> [!NOTE]
> Using **MailItemsAccessed** audit records for forensics purposes is typically performed after a data breach has been resolved and the attacker has been evicted.

When an organization conducts an investigation, it should complete the following steps:

1. Identify the mailboxes that have been compromised.
1. Determine the time frame when the attacker had access to those mailboxes.
1. Use the **Search-UnifiedAuditLog** or **Search-MailboxAuditLog** cmdlets in Exchange Online PowerShell to search audit records that correspond to the data breach.

Organizations can run one of the following commands to search for **MailItemsAccessed** audit records (these examples assume a time from of 1/06/2020 through 1/20/2020):

**Unified audit log:**

```powershell
Search-UnifiedAuditLog -StartDate 01/06/2020 -EndDate 01/20/2020 -UserIds <user1,user2> -Operations MailItemsAccessed -ResultSize 1000
```

**Mailbox audit log:**

```powershell
Search-MailboxAuditLog -Identity <user> -StartDate 01/06/2020 -EndDate 01/20/2020 -Operations MailItemsAccessed -ResultSize 1000 -ShowDetails
```

> [!TIP]
> One primary difference between these two cmdlets is that the **Search-UnifiedAuditLog** cmdlet can be used to search for audit records for activity performed by one or more users. It's able to locate activities performed by multiple users because **UserIds** is a multi-value parameter. In comparison, the **Search-MailboxAuditLog** cmdlet searches the mailbox audit log for a single user.

Here are the steps for using **MailItemsAccessed** audit records to investigate a compromised user attack. Each step shows the command syntax for the **Search-UnifiedAuditLog** and **Search-MailboxAuditLog** cmdlets.

1. **Check whether the mailbox has been throttled**. If a mailbox was throttled, then some mailbox-auditing records weren't logged. In the case that any audit records have the "IsThrottled" is "True," you should assume that for a 24-hour period after that record was generated, any access to the mailbox wasn't audited and that all mail data was compromised.
    
    To search for MailItemsAccessed records where the mailbox was throttled, run either of the following commands:
    
    **Unified audit log:**
    
    ```powershell
    Search-UnifiedAuditLog -StartDate 01/06/2020 -EndDate 01/20/2020 -UserIds <user1,user2> -Operations MailItemsAccessed -ResultSize 1000 | Where {$_.AuditData -like '*"IsThrottled","Value":"True"*'} | FL
    ```
    
    **Mailbox audit log:**
    
    ```powershell
    Search-MailboxAuditLog -StartDate 01/06/2020 -EndDate 01/20/2020 -Identity <user> -Operations MailItemsAccessed -ResultSize 10000 -ShowDetails | Where {$_.OperationProperties -like "*IsThrottled:True*"} | FL
    ```
1. **Check for sync activities to determine whether mail items were compromised.** If an attacker uses an email client to downloaded messages in a mailbox, they can disconnect the computer from the Internet and access the messages locally without interacting with the server. In this case, mailbox auditing wouldn't be able to audit these activities.
    
    To search for MailItemsAccessed records where the mail items were accessed by a sync operation, run either of the following commands:
    
    **Unified audit log:**
    
    ```powershell
    Search-UnifiedAuditLog -StartDate 01/06/2020 -EndDate 02/20/2020 -UserIds <user1,user2> -Operations MailItemsAccessed -ResultSize 1000 | Where {$_.AuditData -like '*"MailAccessType","Value":"Sync"*'} | FL
    ```
    
    **Mailbox audit log:**
    
    ```powershell
    Search-MailboxAuditLog -StartDate 01/06/2020 -EndDate 01/20/2020 -Identity <user> -Operations MailItemsAccessed -ResultSize 10000 -ShowDetails | Where {$_.OperationProperties -like "*MailAccessType:Sync*"} | FL
    ```
1. **Check for sync activities to determine whether an entire mailbox was compromised**. To do so, you must determine whether any sync activities occurred in the same context as the one used by the attacker to access the mailbox. Context is identified and differentiated by the IP address of the client computer used to access the mailbox and the mail protocol. For more information, see the section below titled: **Identify the access contexts of different audit records**.
    
    Investigate the properties listed in the following table. These properties are located in the **AuditData** or **OperationProperties** property. If any of the sync activities occurred in the same context as the attacker activity, an organization should assume the attacker has synced all mail items to their client. In this event, the entire mailbox has probably been compromised.
    
    | **Property**     | **Description**                                                                                                                            |
    | ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
    | ClientInfoString | Describes protocol, client (includes version)                                                                                              |
    | ClientIPAddress  | IP address of the client machine.                                                                                                          |
    | SessionId        | Session ID helps to differentiate attacker actions versus day-to-day user activities on the same account (useful for compromised accounts) |
    | UserId           | UPN of the user reading the message.                                                                                                       |
1. **Check for bind activities to determine whether mail items were compromised**. After an organization performs steps 2 and 3, it can be confident that all other access to email messages by the attacker will be captured in the **MailItemsAccessed** audit records that have a **MailAccessType** property with a value of **Bind**.
    
    To search for **MailItemsAccessed** records where the mail items were accessed by a **Bind** operation, run either of the following commands:
    
    **Unified audit log:**
    
    ```powershell
    Search-UnifiedAuditLog -StartDate 01/06/2020 -EndDate 01/20/2020 -UserIds <user1,user2> -Operations MailItemsAccessed -ResultSize 1000 | Where {$_.AuditData -like '*"MailAccessType","Value":"Bind"*'} | FL
    ```
    
    **Mailbox audit log:**
    
    ```powershell
    Search-MailboxAuditLog -StartDate 01/06/2020 -EndDate 01/20/2020 -Identity <user> -Operations MailItemsAccessed -ResultSize 10000 -ShowDetails | Where {$_.OperationProperties -like "*MailAccessType:Bind*"} | FL
    ```
    
    Email messages that were accessed are identified by their internet message ID. You can also check to see if any audit records have the same context as the ones for other attacker activity. For more information, see the section below titled: **Identify the access contexts of different audit records**.
    
    Organizations can use the audit data for bind operations in two different ways:
    
    
     -  Access or collect all email messages the attacker accessed by using the **InternetMessageId** to find them. Then verify whether any of those messages contain sensitive information.
     -  Use the **InternetMessageId** to search audit records related to a set of potentially sensitive email messages. This process is useful if you're concerned only about a few messages.

### Filter duplicate audit records

Duplicate audit records for the same bind operations that occur within an hour of each other are filtered out to remove auditing noise. Sync operations are also filtered out at one-hour intervals.

The exception to this deduplication process occurs if, for the same **InternetMessageId**, any of the properties described in the following table are different. If one of these properties is different in a duplicate operation, a new audit record is generated. This process is described in more detail in the next section.

| **Property**     | **Description**                                                                                                                                                                                                                                                                                                                                                                                                   |
| ---------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ClientIPAddress  | IP address of the client computer.                                                                                                                                                                                                                                                                                                                                                                                |
| ClientInfoString | The client protocol, client used to access the mailbox.                                                                                                                                                                                                                                                                                                                                                           |
| ParentFolder     | The full folder path of the mail item that was accessed.                                                                                                                                                                                                                                                                                                                                                          |
| Logon\_type      | The logon type of the user who performed the action. The logon types (and their corresponding Enum value) are Owner (0), Admin (1), or Delegate (2).                                                                                                                                                                                                                                                              |
| MailAccessType   | Property that indicates whether the access is a bind or sync operation.                                                                                                                                                                                                                                                                                                                                           |
| MailboxUPN       | The UPN of the mailbox where the message being read is located.                                                                                                                                                                                                                                                                                                                                                   |
| User             | The UPN of the user reading the message.                                                                                                                                                                                                                                                                                                                                                                          |
| SessionId        | If an account was compromised, the Session ID helps to differentiate attacker actions and day-to-day user activities in the same mailbox. For more information about sessions, see [Contextualizing attacker activity within sessions in Exchange Online](https://techcommunity.microsoft.com/t5/exchange-team-blog/contextualizing-attacker-activity-within-sessions-in-exchange/ba-p/608801?azure-portal=true). |

### Identify the access contexts of different audit records

During an attack, it's common that an attacker accesses a mailbox at the same time the mailbox owner is accessing it. To differentiate between access by the attacker and the mailbox owner, there are audit record properties that define the context of the access.

As previously explained, when the values for these properties are different, even when the activity occurs within the aggregation interval, separate audit records are generated. In the following example, there are three different audit records. Each one is differentiated by the **Session ID** and **ClientIPAddress** properties. The messages that were accessed are also identified.

| **Audit record 1**                                                                       | **Audit record 2**                       | **Audit record 3**             |
| ---------------------------------------------------------------------------------------- | ---------------------------------------- | ------------------------------ |
| ClientIPAddress1<br>SessionId2                                                           | ClientIPAddress2<br>SessionId2           | ClientIPAddress1<br>SessionId3 |
| InternetMessageIdA<br>InternetMessageIdD<br>InternetMessageIdE<br>InternetMessageIdF<br> | InternetMessageIdA<br>InternetMessageIdC | InternetMessageIdB             |

If any of the properties listed in the table in the previous section are different, a separate audit record is generated to track the new context. Accesses will be sorted into the separate audit records depending on the context in which the activity took place.

For example, in audit records shown in the following screenshot, mail was accessed from EWSEditor and OWA simultaneously. However, the access activity is collated in different audit records depending on the context in which the access took place. In this case, the context is defined by different values for the **ClientInfoString** property.

:::image type="content" source="../media/mail-items-accessed-4-959b4774.png" alt-text="Screenshot of the Search Mailbox Audit Log command in PowerShell and the resulting audit records that it retrieved.":::


The following PowerShell command was used in this screenshot:

```powershell
Search-MailboxAuditLog -Identity admin -ShowDetails -Operations MailItemsAccessed -ResultSize 2000 | Select LastAccessed,Operation,AuditOperationsCountInAggregatedRecord,ClientInfoString
```
