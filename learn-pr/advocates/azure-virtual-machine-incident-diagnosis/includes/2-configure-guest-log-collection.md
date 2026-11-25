Azure already records VM management operations and host metrics. It **doesn't** automatically collect the worker's guest logs. Both VMs can send to the same Log Analytics workspace. Each needs the Azure Monitor Agent (AMA) extension for its OS and an associated data collection rule (DCR) that selects the right source. This example uses a Linux rule for Syslog and a Windows rule for the Application log, so changing one filter doesn't change the other.

## Use the Activity Log to find resource changes and host metrics to track VM activity

Azure provides two sources of evidence for both Windows and Linux VMs before you install AMA or create a Log Analytics workspace. Use the **Activity Log** to find who requested a change and whether it succeeded. Use **Azure Monitor Metrics** to see how CPU, disk, and network activity changed over time. Neither source records which orders the worker completed.

**Management operations.** The subscription's Activity Log records Azure management requests such as starting, restarting, resizing, or deallocating a VM. Open the VM in the Azure portal and select **Activity log**. Set the incident time range, filter the event category to **Administrative**, and open an entry to see its timestamp, operation, caller, status, resource ID, and correlation ID. Check the final status: a *Started* entry alone doesn't mean the operation succeeded. To investigate a collection-rule change, open **Monitor > Activity log** and filter to the **DCR resource**, not the VM. Starting a worker service from inside the guest isn't an Azure VM start operation and doesn't appear here.

**Host metrics.** Azure Monitor stores numeric measurements against the VM resource, including **Percentage CPU**, **Disk Read Bytes**, and **Network In Total**. Open **VM > Monitoring > Metrics**. Select the VM's host metric namespace, choose the same incident interval, and select the aggregation appropriate to the question. For example, chart **Percentage CPU** as **Average** at one-minute granularity to see whether utilization changed when the dashboard went quiet. Use **Sum** for total bytes transferred in each interval. A gap in the chart isn't a measurement of zero, and steady CPU use doesn't identify which process was busy.

:::image type="content" source="../media/activity-log-host-metrics.svg" alt-text="Diagram that shows an Activity Log rule change beside a host CPU chart for the same interval. Neither proves an order completed.":::

The same native records are available through the Azure CLI. These read-only commands use PowerShell syntax. Substitute the **DCR** ID and its subscription for the filter edit, the **VM** ID for CPU metrics, and the UTC bounds of the incident:

```powershell
$vmId = '<full VM resource ID>'
$dcrId = '<full DCR resource ID>'
$dcrSubscription = '<subscription ID containing the DCR>'
$start = '2026-11-14T09:45:00Z'
$end = '2026-11-14T10:15:00Z'
az monitor activity-log list --subscription $dcrSubscription --resource-id $dcrId --start-time $start --end-time $end --output json
az monitor metrics list --resource $vmId --metrics "Percentage CPU" --aggregation Average --interval PT1M --start-time $start --end-time $end --query "value[0].timeseries[0].data[].{UTC:timeStamp,AverageCPU:average}" --output table
```

At `10:05Z`, a `10:00Z` write might not appear yet: native Activity Log entries typically take 3-20 minutes. Save the initial result and repeat the same bounded search later. The CLI defaults to at most 50 events; if you hit the limit, subdivide the interval. In the full entry, keep the caller, correlation ID, and final status in the private incident record.

The native Activity Log retains events for 90 days; standard VM platform metrics are retained for 93 days. Neither store is automatically a KQL table in your workspace. To query management events in `AzureActivity`, the relevant Activity Log category must already have been exported there. No export is needed for the portal and CLI views above.

## Choose the log destination and network path

Before configuring collection on either VM, choose where the logs will go, how long to keep them, and how the agent will reach Azure Monitor:

1. In the Azure portal, open **Log Analytics workspaces**. Reuse the workspace approved for the application. If none exists, select **Create**, choose the subscription and resource group, enter a name, select an approved region, and create it. Record its Azure resource ID and region. Choose a **Log Analytics workspace**, not the similarly named **Azure Monitor workspace** used for metrics.
1. In **Workspace > Tables**, check the table plan and both interactive and total retention. This walkthrough's ordinary queries and scheduled log alerts assume the **Analytics** plan and dates within interactive retention. If data is retained only for the long term, ask the workspace owner about a historical search job and its cost; it won't supply a real-time alert. `Syslog` can use Auxiliary/Lake, which supports neither this alert nor VM resource-context queries. `Event` doesn't support Auxiliary/Lake. Don't change a production plan or retention to run the example.

   For historical `Syslog` data, check which plan was in effect **when the rows were ingested**. If the table switched from Analytics to Auxiliary/Lake, a query spanning the change can return partial results. Split the search at the change time and query each interval from the workspace using the method its plan supports. If the table switched back to Analytics, use an approved search job or the documented search API for retained rows ingested under Auxiliary; the current Analytics query alone won't show them. Record the change time, intervals searched and any history you couldn't access.
1. Give AMA an outbound HTTPS path on TCP port 443 to retrieve configuration and upload logs. Have the network owner allow the endpoints for the VM's cloud and region. Standard Windows Event Log and Linux Syslog collection over ordinary public service endpoints requires neither a separate data collection endpoint (DCE) nor a public IP on the VM.

For **public endpoints**, ask the network owner which outbound path the subnet uses. A private subnet needs explicit egress, such as a NAT gateway or a route through an egress firewall; a rule allowing port 443 doesn't create that path. From the guest, check the configuration and upload endpoints separately using AMA's cloud-specific endpoint list and its configured proxy, if any. AMA requires its endpoints to be exempt from HTTPS inspection. A successful TCP connection or browser session doesn't show that the agent completed TLS. Look for agent errors, a current downloaded rule and a fresh event at the destination. Don't attach a public IP or relax network controls to run these checks.

For **Azure Monitor Private Link Scope (AMPLS)**, check two paths separately:

- **Configuration:** Associate the VM with the approved configuration DCE in the **VM's region** (`configurationAccessEndpoint`), and link the DCE to AMPLS. This single endpoint serves all the VM's rules; it doesn't replace its DCR associations. Check the existing endpoint before creating an association, because another configuration DCE replaces the first. Include agents on networks that share the AMPLS DNS configuration.
- **Log upload:** Link the destination Log Analytics workspace to AMPLS. This guest-log path doesn't need a second DCE just for ingestion. If the DCR does specify an ingestion DCE for this private destination, check that it too is linked to AMPLS. From the guest, check private DNS resolution and approved HTTPS connectivity for configuration and upload. Then verify configuration download and delivery of a matching log; a private IP alone proves neither.

:::image type="content" source="../media/log-destination-retention-network.svg" alt-text="Diagram that shows public and private log paths. The private path links the VM's regional configuration endpoint and workspace to AMPLS.":::

## Configure data collection rules for Windows Event Logs and Linux Syslog

First check whether Azure Policy or the monitoring team already manages a rule for these VMs. If it does, update that configuration through its owner rather than adding overlapping collection. For a new rule, use an account authorized to configure the workspace, create the DCR and its associations, and install the VM extension.

On ContosoLinuxA, enabling Syslog collection for the first time installs AMA's forwarding configuration and automatically restarts `rsyslog`. Other services may use that daemon. Agree on timing with its owner before onboarding a live VM. Afterwards, confirm that `rsyslog` is running, existing destinations still receive their messages, and a fresh qualifying message reaches the approved workspace. A severity-only correction doesn't call for a manual restart.

To create a rule for either VM:

1. Open **Monitor > Data Collection Rules > Create**. Choose the monitoring resource group and the **same region as the destination workspace**. Choose the guest telemetry option for the intended OS. In the classic experience, set **Platform Type** to **Linux** for ContosoLinuxA or **Windows** for ContosoWinSrvB.
1. Under **Resources > Add resources**, select the VMs that should use that rule. The portal creates each association and installs AMA if needed. Use the system-assigned managed identity option, or explicitly select the approved user-assigned identity if the environment uses one.
1. Under **Collect and deliver**, add the source for that OS using the settings below. Select **Azure Monitor Logs** as the destination, choose the approved workspace, and create the rule.
1. In the DCR's **Resources** view, confirm the intended VM's full resource ID. On the VM, open **Extensions + applications** and check that its extension provisioned successfully: `AzureMonitorLinuxAgent` on Linux or `AzureMonitorWindowsAgent` on Windows. Installation alone doesn't select a log source or prove delivery.

Choose a filter that includes the event the application actually writes:

| VM and source | Example source settings | Destination table |
|---|---|---|
| ContosoLinuxA: **Linux Syslog** | The worker sends messages tagged `order-worker` to rsyslog. For facility `user` (the message category), select minimum **Warning**. **Error** excludes warnings. Leave unrelated facilities at **None** on a new rule. | `Syslog` |
| ContosoWinSrvB: **Windows Event Logs** | The worker writes **Information** events to the **Application** log under provider `OrderWorker`, Event ID `4100`. Select Application and Information, or use **Custom** for a narrower filter: `Application!*[System[Provider[@Name='OrderWorker'] and EventID=4100 and Level=4]]`. The provider and ID here are examples, not Windows defaults. | `Event` |

:::image type="content" source="../media/data-collection-rule-setup.svg" alt-text="Diagram that shows how a data collection rule connects VMs to Log Analytics and where to check the VM association and agent installation.":::

## Grant responders read access and verify that VM logs reach the workspace

Have an authorized role administrator open **Access control (IAM) > Add role assignment** on the relevant resources. Grant the responder group **Reader** on the VMs and their DCRs and **Log Analytics Reader** on the destination workspace, or use approved narrower roles. Keep write permissions separate. For local evidence, provide an approved private SSH connection to Linux or Remote Desktop (RDP) to Windows, directly or through Azure Bastion. The guest account needs permission to read the journal or the relevant Windows event logs; workspace access doesn't grant either.

Test access as the responder at each scope. VM and DCR read access doesn't extend up to the subscription or across to a separate alerting resource group. If the subscription export or relevant Service Health view isn't visible, ask the subscription monitoring owner for the scoped observation. Ask the alerting owner for rule health, the fired instance and its effective actions; ask the recipient to confirm receipt. Testing an action group requires separate authorization. Record **not visible to this account**, not **not configured**, and don't grant subscription Owner just to collect this evidence.

Use the responder's account to open **Logs** in the destination workspace. If public queries are restricted, use an approved network connected to the workspace's AMPLS. The VM may be uploading while the responder's portal or workbook query is blocked. Record the actual error. With the network or workspace owner, check the workspace's query-access setting, the AMPLS query mode, and private DNS and reachability **from the responder's client**, separately from workspace and table permissions. Don't enable public queries or widen access to test this.

For each VM, query `Heartbeat` for its full `_ResourceId`, then query `Syslog` for ContosoLinuxA or `Event` for ContosoWinSrvB over the same interval. Match a recent order's completion ID and source timestamp in the guest to its workspace row. A heartbeat alone proves only agent contact. Save the query, VM and DCR resource IDs, destination, and typical delivery delay.

## Optional: export the Activity Log, enable boot diagnostics, and configure alerts

You can collect Linux Syslog and Windows Event Log records without enabling any of the three features below. Use **Activity Log export** to query Azure rule changes alongside those records, **boot diagnostics** to inspect VM startup when you can't sign in, and **alerts** to notify the on-call team.

| If responders need to... | Set up this Azure feature |
|---|---|
| Query rule changes alongside guest logs | In **Monitor > Activity log > Export Activity Logs**, have the subscription administrator add a diagnostic setting, select **Administrative**, and send it to the same Log Analytics workspace. New matching operations appear in `AzureActivity`; earlier ones aren't exported. The native Activity Log is available without this setting. |
| Inspect startup when guest sign-in fails | On the VM, open **Boot diagnostics > Settings**, enable boot diagnostics with a managed storage account, and save. This provides console output and a screenshot, not application logs. |
| Notify the on-call team | In **Monitor > Alerts**, configure a workspace-scoped log search rule with an explicit condition, window, frequency, and action group. For a one-mailbox check, use a separate rule and a dedicated group with only the approved, verified receiver. Before enabling the rule or emitting a marker, check the actual alert targets and processing rules for every rule that could match. A dedicated group alone can't prevent a production page or automation. |

:::image type="content" source="../media/optional-diagnostic-features.svg" alt-text="Diagram that shows three optional checks: query exported Activity Log entries, inspect VM startup, and trace a fired alert to its recipient.":::
