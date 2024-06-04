Microsoft Purview Audit (Premium) offers advanced features that enable detailed investigations of user activities within Microsoft 365 services. This version is useful for forensic analysis, helping organizations in-depth reviews of security incidents and irregular access patterns.

Following the discovery of unusual activities in the electronic health records (EHR) at our network of healthcare facilities, the IT compliance team is now turning to Audit (Premium). Their goal is to conduct thorough investigations to ensure all access to patient data is scrutinized and to identify any potential breaches.

Here you learn to:

- Apply Audit (Premium) features for detailed investigations.
- Log and analyze email access with MailItemsAccessed.
- Interpret and manage large volumes of audit data.
- Conduct forensic analysis to uncover potential breaches.
- Document findings to meet compliance and assist in response strategies.

## Audit (Premium) overview

Microsoft Purview Audit (Premium) enhances the capabilities of Audit (Standard) by adding advanced features tailored for deeper and more extensive auditing requirements. These enhancements include:

- **Extended data retention**: Offers default retention for up to one year for services like Microsoft Entra ID, Exchange, OneDrive, and SharePoint. For extended retention periods up to 10 years, an additional add-on license is required.
- **Customizable retention policies**: Allows you to set custom audit log retention times based on the service, specific activities, or user actions. This flexibility helps meet specific compliance and investigative needs.
- **Increased API bandwidth**: Audit (Premium) users benefit from higher bandwidth access to the Office 365 Management Activity API, allowing for quicker and more efficient data retrieval.
- **Intelligent insights**: Delivers detailed views of user activities, helping you spot potential breaches and understand user behavior in services like Exchange Online and SharePoint Online.

Audit (Premium) enhances security with its advanced features, making it easier for organizations to handle incidents quickly. Next, we show how to use Audit (Premium) to look into compromised accounts, using its detailed logs and analysis tools to address security threats.

## Investigate compromised accounts with Microsoft Purview Audit (Premium)

**MailItemsAccessed** is an auditing action in Microsoft Purview Audit (Premium) designed to provide detailed records of how and when email items are accessed. This functionality is crucial for organizations to manage sensitive communications securely and effectively.

### Understand sync and bind access

- **Sync access**: Often occurs when users download emails via desktop clients like Outlook. Instead of recording each email separately, Audit (Premium) logs one event for all the emails downloaded during the session, simplifying log management.
- **Bind access**: Occurs when a user actively reads or interacts with an individual email. Audit (Premium) captures each interaction, including details like the email’s unique identifier, the InternetMessageId, ensuring precise tracking of data access.

### Manage audit log volume

Exchange Online uses throttling to manage the volume of MailItemsAccessed logs. If a mailbox logs over 1,000 MailItemsAccessed events in 24 hours, logging for that mailbox is paused for the rest of the day to maintain performance. Here's a few things to keep in mind about throttling:

- Throttling affects less than 1% of mailboxes.
- It only pauses logging for MailItemsAccessed, not other activities.
- Only bind operations are throttled; sync activities aren't affected.
- Missing logs due to throttling could indicate unrecorded access during that time.

### Scenario: Investigate using MailItemsAccessed in a healthcare setting

In response to observed unusual access patterns to electronic health records (EHR) at a network of healthcare facilities, the compliance team uses Microsoft Purview Audit (Premium) to thoroughly investigate and ensure compliance with health data protection laws. Here's how they proceed:

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

   - Investigate the extent of data access, focusing on whether entire folders containing sensitive patient information were downloaded (sync) or specific sensitive emails were opened (bind).
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

Distinguishing between legitimate user activities and potential security breaches requires understanding the context of each access. Audit (Premium) allows you to analyze access patterns and contexts deeply. For instance, by comparing session IDs and IP addresses across audit records, you can differentiate between typical user behavior and potential unauthorized access. This is crucial for identifying security incidents where an attacker might access the mailbox concurrently with the legitimate user.

Here's how you can use contextual data to track and understand access patterns:

- **Identify and compare access contexts**: Look for variations in the properties like _ClientInfoString_ and _SessionId_ among audit records to identify unusual access patterns.
- **Analyze detailed properties**: Properties like _ClientIPAddress_ and _InternetMessageId_ provide specific details about each access instance, helping in forensic analysis.

By integrating this information into your investigations, you can enhance the accuracy of your security assessments and ensure that your responses to incidents are informed and effective.

## Knowledge check

Choose the best response for the question below, then select **Check your answers**.
