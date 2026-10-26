First Up Consultants reviews access changes for auditing and troubleshooting. Your manager has asked for a report of Azure RBAC role-assignment write and delete operations, and custom-role-definition write and delete operations, recorded in Activity Log during the previous calendar month for a specified Azure subscription. This exercise covers the four operations listed below; it isn't a complete audit of Privileged Identity Management (PIM) assignment and activation workflows.

## View activity logs

Before you begin, confirm the subscription and reporting dates. You need permission to read that subscription's activity log, for example through **Monitoring Reader** at subscription scope. Permission to assign roles in one resource group doesn't necessarily give you access to the whole subscription's log.

To collect the report, follow these steps:

1. Sign in to the Azure portal. The portal link is in the Summary unit's More info section.

1. Search for **Subscriptions**, open the subscription being audited, and select **Activity log**. Confirm the selected subscription. Remove any unintended resource or resource-group filters that would narrow this subscription-wide report.

1. Set **Timespan** to the required reporting interval. Use **Last month** if its displayed dates match the requested month; otherwise specify the required date range. Record the dates and time zone used for the report.

1. Add an **Operation** filter and select these operations:

    - Create role assignment (`Microsoft.Authorization/roleAssignments/write`)
    - Delete role assignment (`Microsoft.Authorization/roleAssignments/delete`)
    - Create or update custom role definition (`Microsoft.Authorization/roleDefinitions/write`)
    - Delete custom role definition (`Microsoft.Authorization/roleDefinitions/delete`)

1. Open an event and inspect its status, timestamp, caller, and target scope. Use the **JSON** tab when you need the action and operation identifiers.

    Administrative events can record the start and the success or failure of an operation. An attempted or failed operation isn't a completed access change. Use successful completion records when reporting completed changes, and distinguish attempts and failures when reporting troubleshooting activity. Don't assume that each exported row represents a separate completed change.

    > [!NOTE]
    > The activity log is collected automatically. Recent events can take approximately 3 to 20 minutes to appear. An empty result can mean no matching activity, an incorrect scope or filter, or a recent event that hasn't arrived yet.

1. Select **Download as CSV**. Label the export with its subscription, reporting interval, operation filters, and coverage: **Activity Log records for the four listed Azure RBAC operations; not a complete PIM audit**. Unless you've also filtered by status, this file contains matching operation records, not only successful changes.

1. If the requested report is for completed changes only, filter the exported records to successful completion status (**Succeeded**) before preparing that report. Use operation identifiers and target scopes to reconcile related records rather than counting every row as a separate change. Retain the original export if attempted or failed operations are also needed for troubleshooting. If another subscription is in scope, repeat the procedure with that subscription selected.

> [!NOTE]
> Activity log events are retained for 90 days. This is sufficient for the last-month exercise, but a full calendar quarter and a later audit date can exceed that window. For longer audit retention, arrange a diagnostic setting to route activity logs to an approved destination, such as a Log Analytics workspace or Azure Storage, and configure the destination's retention to meet policy. Export doesn't recover events that have already been deleted. See Export activity log in the Summary unit's More info section.

The exported file is a scoped record of logged operations, not an inventory of the role assignments that currently exist. For a current inventory, use **Access control (IAM)** > **Download role assignments** at the required scope. See View activity logs for Azure RBAC changes in the Summary unit's More info section.

## Audit PIM activity separately

> [!IMPORTANT]
> The previous exercise can use eligible or time-bound PIM assignments. The four Activity Log operations above don't cover the complete PIM workflow, including eligibility changes, activation requests, and approval details. If those activities are in scope, have an administrator with access to PIM audit history also review the relevant resource's **Resource audit** in **Microsoft Entra admin center** > **ID Governance** > **Privileged Identity Management** > **Azure resources**. Use Microsoft Entra **Audit logs** when approval reasons, approvers, or ticket details are needed. Follow View audit report for Azure resource roles in PIM in the Summary unit's More info section for the required permissions and procedures; subscription Activity Log read access alone isn't sufficient for these additional audit views.
>
> Azure Activity Log's 90-day retention doesn't apply to Microsoft Entra audit logs. Native Microsoft Entra audit logs are retained for 30 days with P1 or P2, so a report for the previous calendar month can require previously archived records. Arrange retention for Microsoft Entra audit logs separately from subscription Activity Log export. If part of the reporting interval is no longer available, disclose the evidence gap rather than report that no changes occurred. Increasing retention or enabling export now doesn't recover expired records. See Microsoft Entra data retention in the Summary unit's More info section.
