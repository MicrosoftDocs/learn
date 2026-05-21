The cutover is the most critical phase of any storage migration. It's the moment when applications and users switch from the source to the target storage. If you don't plan the cutover carefully, you risk extended downtime and data inconsistency. Plan and rehearse the cutover before executing it in production.

## Rehearse the cutover

Before executing a production cutover, run at least one full rehearsal:

- Perform the rehearsal in a non-production environment or against a representative subset of data to validate every step of the cutover sequence.
- Time each step (quiesce, final sync, redirection, verification) to build a realistic estimate of the total cutover window.
- Identify steps that take longer than expected and optimize them before the production cutover.
- Test the rollback procedure as part of the rehearsal. A rollback plan that has never been executed provides false confidence.
- Document lessons learned from each rehearsal and update the cutover runbook accordingly.

When you rehearse consistently, you experience shorter cutover windows and fewer surprises during production execution.

## Pre-cutover checklist

- Confirm that the initial data copy and all delta sync passes have completed successfully.
- Verify file/object counts and total data volume match between source and target (within expected tolerances for actively changing data).
- Ensure all required network configurations are in place (Private Endpoints, firewall rules, and DNS entries).
- Confirm identity and access controls are configured on the target (RBAC roles, share-level permissions, and ACLs).
- Notify all stakeholders of the cutover window and expected downtime.
- Prepare rollback procedures in case you need to reverse the cutover.
- Confirm that monitoring and alerting is active on the target storage (see monitoring section below).

## Communication plan

Clear communication before, during, and after cutover reduces confusion and ensures a coordinated effort:

- **Before cutover**: Notify all affected teams (application owners, end users, helpdesk, management) of the scheduled window, expected downtime, and whom to contact if issues arise. Send reminders at 1 week, 1 day, and 1 hour before the window opens.
- **During cutover**: Provide real-time status updates through a dedicated channel (for example, a Teams channel or bridge call). Designate a single communication lead to avoid conflicting messages.
- **After cutover**: Send a completion notification confirming that the cutover succeeded and services are restored. Include any known issues and follow-up actions.
- **If rolling back**: Communicate immediately that the cutover is being reversed, provide an estimated time to restore the original state, and follow up with a root cause summary.

## DNS and redirection preparation

If your cutover relies on DNS changes or other redirection mechanisms, prepare well in advance:

- **Lower DNS TTLs**: Reduce TTL values on relevant DNS records days or weeks before the cutover. This ensures that after the switch, clients pick up the new target address quickly rather than caching the old source address for hours.
- **Mount points and connection strings**: Inventory all applications, scripts, and services that reference the source storage by path, UNC, connection string, or URL. Prepare updated configurations and test them in advance.
- **DFS Namespaces**: For Windows file share migrations, DFS Namespaces can abstract the server path and allow you to redirect clients by updating the namespace target without changing the path that users and applications see.
- **Restore DNS TTLs**: After the cutover is confirmed successful and the retention period begins, restore DNS TTLs to their normal values.

## Cutover execution

With DNS and redirections prepared, you're ready to execute the cutover itself. A typical cutover sequence:

1. Stop or quiesce applications writing to the source storage to prevent further changes.
2. Run a final delta synchronization to capture any remaining changes.
3. Validate that the final sync completed without errors.
4. Redirect applications to the target storage. This may involve DNS changes, mount point updates, connection string changes, or server identity swaps (for Storage Migration Service).
5. Verify that applications can read and write to the target storage as expected.
6. Monitor the target environment closely for the first hours or days after cutover.

## Rollback strategy

Always have a documented rollback plan. Key considerations:

- Keep the source storage online and accessible (read-only if possible) during the cutover window.
- Define a point-of-no-return: the moment after which rollback becomes impractical (for example, when applications have written significant new data to the target).
- If using Data Box for initial seeding combined with online sync, the source remains the authoritative copy until you confirm the cutover is successful.
- Test the rollback procedure during migration rehearsals.

## Minimize downtime

A good rollback plan gives you confidence to execute. Another way to protect yourself is to minimize the downtime window itself:

- Run multiple delta sync passes before cutover to reduce the size of the final sync.
- Schedule cutover during low-activity periods.
- Use managed migration tools (Azure Storage Mover, Azure File Sync) that natively support incremental synchronization and minimize the final delta.

For Azure File Sync, data is already tiered to Azure Files before cutover, so the switch is nearly instantaneous once cloud tiering is complete.

## Monitoring and alerting

Set up monitoring on the target storage before the cutover so that issues are detected immediately, not hours later:

- **Azure Monitor metrics**: Configure alerts on storage account availability, end-to-end latency, and transaction error rates. Set thresholds based on your application's expected behavior.
- **Throttling alerts**: Monitor for HTTP 429 and 503 responses, which indicate the storage account is being throttled. This is especially important in the first hours after cutover when all applications hit the new target simultaneously.
- **Diagnostic logging**: Enable Storage Analytics or Azure Monitor diagnostic logs for the target storage account to capture detailed request-level data. These logs are invaluable for troubleshooting issues reported after cutover.
- **Application-level monitoring**: Ensure that existing application monitoring (APM tools, health checks) is updated to reflect the new storage endpoints so dashboards and alerts remain accurate.

With the cutover complete and your source in read-only retention, you've crossed the finish line of the active migration phase.

Learn more: [Monitoring Azure Storage](/azure/storage/common/storage-monitoring-diagnosing-troubleshooting)

## Post-cutover source decommission

After a successful cutover, follow a planned path to decommission the source:

- Keep the source storage in a read-only state for the agreed retention period (for example, 30–90 days). This provides a fallback if issues surface after the cutover that weren't caught during validation.
- During the retention period, monitor whether any applications or users are still attempting to access the source. Unexpected traffic indicates a redirection that was missed.
- At the end of the retention period, confirm with all stakeholders that no dependencies remain, then decommission the source.
- For on-premises hardware, coordinate decommission timing with data center operations, lease agreements, and hardware disposal or return procedures.
- Close out the migration project with a summary that documents the timeline, any issues encountered, and lessons learned for future migrations.

Learn more: [Azure Storage migration execution guide](/azure/storage/common/storage-migration-execution)