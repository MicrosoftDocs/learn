To confirm which individual messages a user opened, an investigation needs the `MailItemsAccessed` event from Audit (Premium). That event captures message-level access details that Audit (Standard) doesn't record. Working with it means understanding when Exchange records a bulk sync operation instead of individual bind events, and when throttling can create gaps in the log. It also means seeing how the healthcare compliance team applies those results to investigate unusual electronic health record (EHR) access.

## Investigate compromised accounts with MailItemsAccessed

**MailItemsAccessed** provides detailed records of how and when emails are accessed, making it a critical event type for investigations involving sensitive communications.

### Understand sync and bind access

- **Sync access**: Logs a single event when multiple emails are downloaded during a session, like when using Outlook.
- **Bind access**: Logs each time an individual email is opened or interacted with.

### Manage audit log volume

To maintain performance, Exchange Online throttles MailItemsAccessed logging if a mailbox logs more than 1,000 bind events in 24 hours. Throttling:

- Affects less than 1% of mailboxes
- Only pauses logging for MailItemsAccessed events, not other activities
- Applies to bind operations only. Sync activities aren't affected.
- Might result in gaps where bind events weren't recorded

If your investigation window overlaps a throttled period, the missing bind events don't backfill. Cross-reference the gap with **Exchange message trace** or **Microsoft Entra sign-in logs** to reconstruct what happened. If the question is "what was the user searching for" rather than "what did they open," `SearchQueryInitiatedExchange` and `SearchQueryInitiatedSharePoint` aren't throttled and can help fill the gap.

### Scenario: Investigate using MailItemsAccessed in a healthcare setting

The Standard-tier mailbox search confirmed unauthorized deletions but not which specific patient messages the physician opened. To close that gap, the healthcare compliance team turns to `MailItemsAccessed`. Here's how they proceed:

1. **Set up and pull the data**:

   Identify the mailboxes linked to users who have access to sensitive patient data. Define the time period the suspicious activities were detected, converted to UTC. Then use the `Search-UnifiedAuditLog` cmdlet to pull the `MailItemsAccessed` records for that window:

   ```powershell
   $log = Search-UnifiedAuditLog -StartDate "2026-01-06" -EndDate "2026-01-20" -UserIds "user1, user2" -Operations MailItemsAccessed -ResultSize 1000
   ```

   `-StartDate` and `-EndDate` are interpreted as UTC. `-ResultSize` counts audit events, not mail items, so raise it or narrow the date range if you expect more than 1,000 records. `Search-MailboxAuditLog` is being deprecated in Exchange Online in favor of `Search-UnifiedAuditLog`.

1. **Slice the results to answer specific questions**:

   Pipe `$log` into a `Where-Object` filter that matches the property you want to check.

   Given the sensitivity of the data, start with a throttling check to confirm no gaps in the log:

   ```powershell
   $log | Where {$_.AuditData -like '*"IsThrottled","Value":"True"*'} | FL
   ```

   Then look at sync access, which is how Exchange logs bulk downloads that pull folders of messages:

   ```powershell
   $log | Where {$_.AuditData -like '*"MailAccessType","Value":"Sync"*'} | FL
   ```

   And at bind access, which shows the specific messages the user opened:

   ```powershell
   $log | Where {$_.AuditData -like '*"MailAccessType","Value":"Bind"*'} | FL
   ```

1. **Contextual analysis of access**:

   Compare IP addresses and session IDs to separate regular user actions from unusual or unauthorized access. The comparison narrows down how, and sometimes why, the access happened.

1. **Forensic recovery and reporting**:

   For each bind access event where an email was opened, identify the affected emails using their `InternetMessageId`. Check whether they contain sensitive patient data. Record findings clearly for healthcare compliance rules and use the documentation to guide response and future protections.

### Manage duplicate audit records

In high-activity environments, duplicate audit records can clutter and complicate log analysis. Audit (Premium) filters out duplicate `MailItemsAccessed` records within a one-hour window, so investigators see meaningful activity instead of the same access repeated dozens of times. A new record still gets logged when properties that change the context of the access differ, like `ClientIPAddress`, `SessionId`, or `MailAccessType`.

For the full list of properties that break the deduplication window, see [Filter duplicate audit records](/purview/audit-log-investigate-accounts?azure-portal=true#filter-duplicate-audit-records).

## Other Audit (Premium) events worth knowing

`MailItemsAccessed` is the flagship Premium event, but the tier logs other high-value events that let you answer questions Audit (Standard) can't:

- **`Send`**: Records each time a user sends or replies to a mail item. If you're confirming whether a compromised account was used to send messages during a suspected timeframe, this is the event to filter on.

  ```powershell
  Search-UnifiedAuditLog -StartDate "2026-01-06" -EndDate "2026-01-20" -UserIds "user1" -Operations Send -ResultSize 1000
  ```

- **`SearchQueryInitiatedExchange`** and **`SearchQueryInitiatedSharePoint`**: Record the search terms a user runs against their mailbox or against SharePoint sites. Both help reconstruct what a user was looking for around the time of an incident.

  ```powershell
  Search-UnifiedAuditLog -StartDate "2026-01-06" -EndDate "2026-01-20" -UserIds "user1" -Operations SearchQueryInitiatedExchange,SearchQueryInitiatedSharePoint -ResultSize 1000
  ```

Like `MailItemsAccessed`, these events only log for users with Microsoft 365 Advanced Auditing enabled, and only from the date of enablement forward.

Message-level events show which patient messages the physician opened, but the investigation still doesn't know whether the same records were reached through any other channel. Copilot and AI app activity is where the healthcare compliance team looks next.
