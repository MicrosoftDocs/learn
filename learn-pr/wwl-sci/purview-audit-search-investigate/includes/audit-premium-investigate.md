Microsoft Purview Audit (Premium) offers advanced features for conducting detailed investigations of user activities within Microsoft 365 services. These capabilities support forensic analysis, help identify irregular access patterns, and provide the detail needed to respond to incidents effectively.

## Audit (Premium) overview

Audit (Premium) builds on Audit (Standard) by adding capabilities that make investigations more thorough and efficient, including:

- **Extended data retention**: Default one-year retention for Microsoft Entra ID, Exchange, OneDrive, and SharePoint audit records; up to 10 years with the appropriate add-on license.
- **Customizable retention policies**: Retain audit records for specific services, activities, or users for defined periods.
- **Increased API bandwidth**: More capacity for retrieving data through the Office 365 Management Activity API.
- **Intelligent insights**: Detailed visibility into certain activities, like labeled mail item access and user search behavior in Exchange Online and SharePoint Online.

## Investigate compromised accounts with MailItemsAccessed

**MailItemsAccessed** provides detailed records of how and when emails are accessed, making it a critical event type for investigations involving sensitive communications.

### Understand sync and bind access

- **Sync access**: Logs a single event when multiple emails are downloaded during a session, like when using Outlook.
- **Bind access**: Logs each time an individual email is opened or interacted with.

### Manage audit log volume

To maintain performance, Exchange Online throttles MailItemsAccessed logging if a mailbox logs more than 1,000 bind events in 24 hours. Throttling:

- Affects less than 1% of mailboxes
- Only pauses logging for MailItemsAccessed events, not other activities
- Applies to bind operations only; sync activities are unaffected
- Might result in gaps where bind events weren't recorded

### Scenario: Investigate using MailItemsAccessed in a healthcare setting

In response to unusual access patterns to electronic health records (EHR) at a network of healthcare facilities, the compliance team is using Microsoft Purview Audit (Premium) to investigate the activity in detail. They want to confirm whether the access was authorized and ensure compliance with health data protection laws. Here's how they proceed:

1. **Setup and data collection**:

   - Start by identifying the mailboxes linked to users who have access to sensitive patient data and define the time period that suspicious activities were detected.
   - Use the `Search-UnifiedAuditLog` or `Search-MailboxAuditLog` cmdlets to pull records of MailItemsAccessed during the suspected period.

   ```powershell
   Search-UnifiedAuditLog -StartDate "2020-01-06" -EndDate "2020-01-20" -UserIds "user1, user2" -Operations MailItemsAccessed -ResultSize 1000
   ```

1. **Check for throttling**:

   - Given the high sensitivity of the data, check for any signs of throttling, which might suggest periods where logging was paused and unauthorized access might be unrecorded.

   ```powershell
   Search-UnifiedAuditLog -StartDate "2020-01-06" -EndDate "2020-01-20" -UserIds "user1, user2" -Operations MailItemsAccessed -ResultSize 1000 | Where {$_.AuditData -like '*"IsThrottled","Value":"True"*'} | FL
   ```

1. **Analyze sync and bind activities**:

   - Investigate the extent of data access. Focus on whether entire folders containing sensitive patient information were downloaded (sync) or whether specific sensitive emails were opened (bind).
   - **Sync activity check**:

   ```powershell
   Search-UnifiedAuditLog -StartDate "2020-01-06" -EndDate "2020-02-20" -UserIds "user1, user2" -Operations MailItemsAccessed -ResultSize 1000 | Where {$_.AuditData -like '*"MailAccessType","Value":"Sync"*'} | FL
   ```

   - **Bind activity check**:

   ```powershell
   Search-UnifiedAuditLog -StartDate "2020-01-06" -EndDate "2020-01-20" -UserIds "user1, user2" -Operations MailItemsAccessed -ResultSize 1000 | Where {$_.AuditData -like '*"MailAccessType","Value":"Bind"*'} | FL
   ```

1. **Contextual analysis of access**:

   - Compare IP addresses and session IDs to separate regular user actions from unusual or unauthorized access. This helps identify the specifics of how and potentially why access was gained.

1. **Forensic recovery and reporting**:

   - For each instance where an email was accessed (bind access), identify the affected emails using their InternetMessageId. Check if these emails contain sensitive patient data.
   - Record all findings clearly to ensure they meet healthcare compliance rules. Use this documentation to help manage any potential consequences and strengthen data protection measures.

### Manage duplicate audit records

In high-activity environments, duplicate audit records can clutter and complicate log analysis. Audit (Premium) filters out duplicate records for the same bind operations that occur within an hour to streamline audit logs. Here's how duplicates are handled:

- **Sync operations** are filtered at one-hour intervals unless distinct changes in key properties are detected.
- **Bind operations** generate a new audit record only if certain properties differ from previously logged operations within the same hour. These properties include:

  - **ClientIPAddress**: The IP address from where the mailbox was accessed.
  - **ClientInfoString**: Details about the client and protocol used.
  - **ParentFolder**: Location within the mailbox.
  - **Logon_type**: Distinguishes between owner, admin, or delegate access.
  - **MailAccessType**: Specifies if the operation was a bind or sync.
  - **MailboxUPN** and **User**: Identity of the mailbox and the user accessing it.
  - **SessionId**: Helps in distinguishing between different sessions of access, providing a clear timeline of actions.

This filtering ensures that the logs remain manageable and meaningful by reducing redundancy without losing the granularity needed for thorough investigations.

### Contextual analysis of audit records

To distinguish legitimate activity from possible breaches, the compliance team reviews contextual data such as IP addresses, session IDs, and message identifiers. This allows them to confirm whether access fits established patterns or indicates an incident requiring further action.
