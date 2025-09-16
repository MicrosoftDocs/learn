Troubleshooting workflows in Microsoft Entra ID is needed for secure and efficient identity management. Learn to monitor audit logs, use Microsoft Graph APIs for reporting, address common issues, and evaluate workflow task summaries.

## Monitor audit logs and workflow history
Audit logs in Microsoft Entra ID provide a detailed record of system activities, including changes to users, groups, applications, and custom security attributes. Logs are crucial for tracking modifications and troubleshooting issues with workflows. Did the new hire get added to the right groups and granted the right application access?

- **Users**: Audit logs can show recent changes to user accounts, such as password updates or account modifications.
- **Groups**: Logs display information about group additions, ownership changes, and license assignments.
- **Applications**: You can track updates, removals, or changes to service principals and application names.

The logs include details like the date and time of events, the service involved, activity categories, and success or failure statuses. Event details like these are valuable in confirming the workflow outcomes.

:::image type="content" source="../media/audit-log-tabs.png" alt-text="Screenshot of the audit logs, with the Directory and Custom Security tabs highlighted.":::

> [!NOTE]
> Audit log entries are system-generated and can't be modified or deleted.

## Using Microsoft Graph APIs for reporting and diagnostics of workflows
Sign-in logs in Microsoft Entra ID offer insights into user access patterns, failed sign-ins, and resource usage. These logs are valuable for diagnosing workflow-related issues and monitoring tenant health.

Key questions that sign-in logs can answer include:
- How many users signed into a specific application?
- What were the failed sign-in attempts in the last 24 hours?
- Which browsers or operating systems are users accessing?

Sign-in logs categorize data by identity (who), client (how), and target resource (what). You can access these logs via the Microsoft Entra admin center or programmatically using Microsoft Graph APIs. Filters can help narrow down specific log sets for analysis.

> [!NOTE]
> Sign-in log entries are also system-generated and immutable.

### Use Security Copilot to analyze and troubleshoot lifecycle workflows in Microsoft Entra
Microsoft Security Copilot simplifies the analysis and troubleshooting of lifecycle workflows. Use natural language prompts to perform the following tasks:

- **Analyze active workflows:** Retrieve details about active, disabled, or deleted workflows. For example, ask, "List all mover workflows in my tenant."
- **Troubleshoot processing results:** Generate summaries of workflow runs, identify failed tasks, and review user processing results. Example prompts include, "Which tasks failed for {workflow} in the last 7 days?" or "Summarize the runs for {workflow} in the last 7 days."
- **Compare workflow versions:** Identify differences between workflow versions to track changes and ensure consistency.

## Common issues and resolution strategies
Lifecycle Workflow history in Microsoft Entra ID Governance provides summaries and detailed views of user processing, workflow runs, and task execution. These features help identify and resolve common issues in lifecycle management.

- **Users summary**: Displays the total number of users processed, along with successful and failed counts.
- **Runs summary**: Shows workflow run statuses, including successful and failed tasks.
- **Tasks summary**: Highlights processed, failed, and unprocessed tasks within workflows.

Filtering options allow administrators to focus on specific dates, statuses, or execution types. For example, you can filter by "Completed with errors" to identify workflows that partially succeeded.

## Evaluate workflow task summaries for troubleshooting failures
Task summaries in Lifecycle Workflows provide granular details about individual tasks within a workflow. This helps pinpoint failed tasks and unprocessed items for targeted troubleshooting.

- **Status categories**: Tasks can have statuses like "Completed," "In Progress," "Queued," "Canceled," "Completed with errors," or "Failed."
- **Filtering options**: Administrators can filter tasks by date, status, or specific task names to isolate issues.

By analyzing task summaries, you can determine whether errors stem from specific tasks or broader workflow configurations. This enables more effective resolution of workflow failures.

:::image type="content" source="../media/task-summary-concept.png" alt-text="Screenshot of a workflow task summary.":::

> [!NOTE]
> Separating workflow processing from task execution is critical for identifying root causes of failures.
