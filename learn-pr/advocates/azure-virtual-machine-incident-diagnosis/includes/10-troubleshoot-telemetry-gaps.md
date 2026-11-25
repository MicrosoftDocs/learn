Start with what the query actually returned. **Access denied** means you couldn't read the data. **Table not found** means the named table wasn't available in that scope. A successful event search can return no rows; the single-VM heartbeat summary instead returns one row with `Records=0` if no check-ins match. Neither result proves the VM stopped or tells you what's in another workspace.

If a `Syslog` query returns a partial-results warning across a table-plan change, use the separate historical searches described under **Choose the log destination and network path** in [Configure Azure Monitor](xref:learn.devrel.azure-virtual-machine-incident-diagnosis.configure-guest-log-collection). Don't report a collection gap from the partial result or switch the plan to investigate.

Match the symptom to its next check before changing a collection rule, widening access, or sending another alert.

| Symptom | Next check | Avoid |
|---|---|---|
| Query denied | Record the error. Check tenant, query scope and workspace/table permissions. For private queries, check access mode, DNS and reachability from the responder's network. | Granting Owner or opening public queries to diagnose a denial |
| Expected guest table absent | For the examples, confirm `Syslog` for Linux or `Event` for Windows, the destination, the association and the first matching event. For a transformed route, follow the configured output to its actual table and fields. | Assuming every workspace contains the default tables or every output preserves individual events |
| Linux journal has a completion; `Syslog` doesn't | Check facility and severity first. If selected, inspect the rsyslog forwarding queue and AMA upload or persistence errors, then trace the ID after connectivity returns. | Clearing queues or treating backlog delivery as fresh work |
| Windows Application log has a completion; `Event` doesn't | If the log was relocated, confirm its backing file is on local disk. Match channel, provider, ID and level against the downloaded DCR and the last-known-good `Subscription`. Check agent errors and lag. | Assuming a downloaded rule is active, or searching `SecurityEvent` for this Application event |
| Both billable guest streams stopped in one workspace | Check the workspace's daily cap banner, reset time and ingestion operations as well as shared network paths | Raising the cap or editing both DCRs as a test |
| No local completion | Check demand and workload results. On Linux, read the unit journal and runtime limits; on Windows, check the service and its System log transitions. | Changing the collection rule |
| Activity query empty | Historical export coverage, correct subscription and change object, native Activity Log latency and result limit | Ruling out a write at `10:00` from an empty search at `10:05` |
| No matching alert instance is visible | In **Monitor > Alerts**, select the actual target subscription and incident interval; clear unrelated filters. The summary defaults to 24 hours and instances are retained for 30 days. Rule **History** requires read access on the subscription containing the fired target; ask its owner if needed. If coverage is adequate, check rule state, health, query identity, evaluation window and ingestion lag. | Concluding "never fired" from expired or inaccessible history; record "firing unconfirmed" instead |
| The instance fired, but the intended action group didn't run | Open the **instance's History** to see which groups were invoked, added or suppressed at firing time. | Reconstructing past actions solely from today's group or processing-rule settings |
| The intended group ran, but direct email is missing | Check the exact address, receiver status and verification, unsubscribe notices and rate limiting. Ask the mail owner about distribution-list restrictions on external senders, inbox rules, junk and quarantine for that interval. Without the matching **Fired** message, report "group invoked; receipt unconfirmed." | Re-firing a shared rule or sending repeated markers to troubleshoot one mailbox |

:::image type="content" source="../media/diagnostic-next-steps.svg" alt-text="Diagram that shows which check to run next when a workspace result, guest event, Activity Log entry, or alert notification is missing.":::

If both streams stopped, look for a workspace cap event in the incident interval. If the cap might already have been reached, extend the start time and portal time picker back to the preceding workspace reset:

```kusto
_LogOperation
| where TimeGenerated between (datetime(2026-11-14T09:45:00Z) .. datetime(2026-11-14T10:15:00Z))
| where Category =~ "Ingestion" and Detail contains "OverQuota"
| project TimeGenerated, Category, Detail
```

An `OverQuota` operation supports a workspace ingestion stop. Ask the workspace owner to confirm the cap and reset time. If the query returns no rows, you still can't tell whether the agent or the network failed.

Before closing the incident, preserve the evidence and inventory any temporary diagnostic resources. Disable only temporary alert rules once their owners confirm they're no longer needed. Remove an action group only if it's unshared. Have the subscription administrator review temporary diagnostic settings: deleting a resource group doesn't remove a subscription-level Activity Log export. Leave AMA and shared guest logging services in place on both OSes; don't clear event logs or undo a required collection fix as housekeeping.

Agree on authorized spend, notification threshold, owner and removal date before enabling temporary diagnostics. A Cost Management budget notifies; it doesn't stop resources or billing. If you enable a daily cap for your workspace, this setting limits eligible data ingestion by volume. It doesn't limit retention or alert charges, and ingestion can exceed the cap. Reaching it can leave monitoring blind until the reset.

At closure, account for remaining charges. Deallocating a VM releases compute capacity; disks, networking, workspace retention or alert evaluations can still incur charges. Deleting the VM doesn't delete previously ingested logs. Give retained temporary resources an owner and expiry, and preserve incident evidence according to policy.
