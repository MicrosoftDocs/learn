A week after the rollout, the portal still returns the right link. That doesn't tell you whether one VM is overloaded, another has stopped reporting, or a network interface has moved to the wrong subnet. Use **Azure Monitor** to see how the fleet has behaved over time. Use **Azure Policy and Azure Resource Graph** to determine whether its Azure resources still match the approved configuration. The portal paths and queries below illustrate the workflow with example results.

Match the question to its evidence source. The counts below describe different populations: health monitoring covers the public backends, while the size and security reports cover the whole fleet.

:::image type="content" source="../media/fleet-monitoring-evidence-map.svg" alt-text="Diagram that shows which Azure tools answer health, compliance, and threat questions and why missing evidence stays unknown.":::

## Track health over time and find missing VMs

Start with the resource IDs you expect to monitor. The public dashboard covers all 190 portal backends, including the 130 deferred from the display trial. The staff team monitors its 10 VMs separately. Both teams contribute to subscription-wide security reporting, but monitoring access doesn't authorize a write.

1. **Build a trend before choosing a threshold**: In **Azure Monitor > Metrics**, select an East US backend pool and the platform metric **Percentage CPU**. Compare individual backends over the last seven days, then narrow the chart to the rollout window. Use a workbook with a pool selector and per-VM detail so that you can find one overloaded instance without plotting 190 lines on the same chart. Compare with a similar traffic period, disk and network activity, and an application check.
1. **Connect guest telemetry**: Host metrics such as CPU are available without a guest agent. For guest logs, start with the canary. In **Monitor > Data Collection Rules**, associate a rule with the VM, select the Windows event logs and severity levels you need, and set the destination to the intended Log Analytics workspace. Confirm that Azure Monitor Agent is installed and sending data there before onboarding the rest. Collecting more logs affects ingestion costs. A missing agent heartbeat means missing evidence, not necessarily a stopped VM.
1. **Query the expected fleet**: Open that **Log Analytics workspace > Logs** in Kusto Query Language (KQL) mode. This example reconstructs the 190 public names from M1; in production, load the actual approved inventory rather than assuming a naming convention. Join it to reporting records so machines with no telemetry don't disappear. Set the time picker to at least 24 hours.

```kusto
let vmPrefix = "/subscriptions/00000000-0000-0000-0000-000000000000/resourcegroups/rg-returns/providers/microsoft.compute/virtualmachines/";
let numbered = range n from 1 to 188 step 1
    | project VM = strcat("fc-web-", substring(tostring(1000 + n), 1));
let named = datatable(VM:string) ["fc-canary", "fc-later"];
let expected = union named, numbered
    | extend ResourceKey = tolower(strcat(vmPrefix, VM));
expected
| join kind=leftouter (
    Heartbeat
    | where TimeGenerated >= ago(24h)
    | extend ResourceKey = tolower(_ResourceId)
    | where ResourceKey startswith vmPrefix
    | summarize LastSeen = max(TimeGenerated) by ResourceKey
) on ResourceKey
| extend Reporting = case(isnull(LastSeen), "No heartbeat in 24h",
                          LastSeen < ago(10m), "Stale", "Recent")
| project VM, LastSeen, Reporting
| order by VM asc
```

For example, in a later monitoring review at 10:00 UTC, 187 backends have recent heartbeats, two are stale, and one has no heartbeat in 24 hours: all 190 are accounted for. A 09:59 heartbeat for `fc-canary` is recent; a 09:38 heartbeat for `fc-later` is stale. Check power state, agent, collection-rule association, and workspace destination on the three exceptions. If a wave depends on their telemetry, hold it. A fresh heartbeat doesn't prove the support link works.

## Configure an alert that identifies the affected VM

In **Azure Monitor > Alerts > Create > Alert rule**, scope multi-resource metric alerts to the portal backends, grouped by pool. Each VM is evaluated separately; group targets of the same type in the same region and subscription. For this example, choose **Percentage CPU**, **Average**, **Greater than 85%**, a **15-minute** window, and evaluation **every 5 minutes**. Tune these example thresholds to the workload's normal peak.

Attach an **action group** that notifies the portal on-call team, set the severity, and include the pool name in each rule name. The action group's test notification checks delivery, not the rule condition. Review historical metrics or use a nonproduction test. If one VM averages 92% while its nine pool peers average 35% each, the alert should identify the hot VM. Compare its alert time with traffic, application errors, and recent changes before attributing the symptom to the rollout.

## Monitor security across the fleet

A VM can serve the right link, have normal CPU, and still generate a security alert. Monitor three things separately: **coverage** (which machines can report), **posture** (which protections need attention), and **threat alerts** (which activity needs investigation). The following walkthrough uses fictional evidence and requires no subscription.

1. **Reconcile coverage against inventory**: In **Microsoft Defender for Cloud > Environment settings**, check the Defender for Servers plan and endpoint protection integration for the intended subscriptions. In **Inventory**, filter to the fleet and compare Azure resource IDs with your inventory. In the **Microsoft Defender portal > Assets > Devices**, match those VMs to their Defender for Endpoint device IDs and check onboarding status, sensor health, and last seen. A discovered device isn't necessarily onboarded, and an Azure Monitor heartbeat isn't an endpoint sensor check. If 192 of 200 expected VMs report current endpoint telemetry, five sensors are stale, and three VMs aren't onboarded, report all three counts. Have the endpoint protection team assign an analyst to each gap and coordinate sensor repairs with fleet operations. Don't treat eight silent VMs as alert-free.
1. **Separate recommendations from incidents**: In Defender for Cloud, open **Recommendations**, select a finding, and inspect its affected resources. A recommendation about exposed management ports identifies a weakness to correct through an approved change; it isn't proof of an intrusion. In **Security alerts**, inspect the activity time, severity, affected resources, account, and evidence. Prioritize by both the signal and the workload's exposure. Route actionable alerts to a monitored security operations queue, for example through your organization's Microsoft Sentinel integration, and assign each alert investigation to a security operations analyst.
1. **Establish the extent of an alert**: Suppose a sign-in alert names `fc-canary` during a change window. Compare the account, source, time, and device with the approved maintenance record. Inspect the device timeline for related logons and process activity, then compare with other fleet devices. The Azure Activity Log can corroborate a management action such as submitting Run Command; it doesn't record every sign-in or process inside Windows.

For a focused investigation, an analyst can start with two representative endpoints from the affected rings, then add the other fleet device IDs to determine the extent. The two placeholders below illustrate that first comparison, not a fleet coverage report. Substitute Defender for Endpoint device IDs, not Azure resource paths or `vmId` values. This **Advanced hunting** query runs in Microsoft Defender with the appropriate permissions:

```kusto
DeviceLogonEvents
| where Timestamp >= ago(1h)
| where DeviceId in ("<canary-device-id>", "<later-device-id>")
| where ActionType == "LogonFailed"
| summarize Failures = count(), FirstSeen = min(Timestamp), LastSeen = max(Timestamp)
    by DeviceId, DeviceName, AccountDomain, AccountName, RemoteIP
| order by Failures desc
```

**Triage an unexpected identity**: Suppose the same service account and source appear on both VMs, but the approved job used a different identity. A stale service credential and unauthorized activity are both possible. Check with the team responsible for that service account, look for successful logons and related processes in the same time window, and check sensor coverage before interpreting an empty result. Hold the next wave if you can't explain the activity. Send the alert ID, affected device IDs, UTC time window, and change ticket to the security team through its approved incident channel. The change approval does not authorize fleet-wide isolation or credential resets; use the incident-response authority and preserve the evidence.

## Report fleet compliance against an approved baseline

Machine Configuration checks settings **inside** the operating system. For infrastructure drift, compare Azure resource properties with the baseline for the relevant workload. The portal workload owner approves the portal baseline; the staff workload owner approves the staff baseline. ARM what-if previews a proposed deployment but doesn't keep watching resources afterward. Record the expected values, accountable teams, and time-limited exceptions with each baseline. For example:

| Control | Expected state in this example | What a reviewer should compare |
|---|---|---|
| VM size | Portal VMs use `Standard_D2s_v5`. | `properties.hardwareProfile.vmSize` on each VM. A resize to `Standard_D4s_v5` is a difference even if the application is healthy. |
| Data disk | A VM that requires a data disk has its approved managed disk ID attached at logical unit number (LUN) `0`. | On the VM, compare the `lun` and `managedDisk.id` entries in `properties.storageProfile.dataDisks` with that VM's baseline. Checking only that the disk resource still exists would miss a detachment. |
| Networking | The portal network interface uses the approved subnet and has no public IP association. | Check the subnet ID and public IP reference on each relevant IP configuration of the network interface. The VM name or subnet name alone isn't sufficient. |

1. **Assign reporting controls**: In **Azure Policy > Definitions**, group the controls into an initiative, for example `returns-infra-baseline`. For size, the built-in **Allowed virtual machine size SKUs** has a deny effect: set the allowed list to `Standard_D2s_v5` and disable enforcement on the pilot assignment so you can see compliance without blocking writes. For disk attachments and subnet membership, use audit definitions with supported aliases for the relevant array entries. Assign the initiative at a scope that includes the intended VMs **and** network interfaces. Record scope exclusions separately from exemptions, with the policy administrator responsible for reviewing each entry and a review date. A report does not require remediation.
1. **Read the results**: Open **Azure Policy > Compliance**, select the assignment, and drill into a definition and then a noncompliant resource. Compare the evaluated value with the expected value and note the evaluation time. Assignments are reevaluated periodically, normally once every 24 hours, and resource updates can trigger earlier evaluations. After an approved correction you can request an on-demand scan, but its results aren't instantaneous.
1. **Repeat the report**: In **Resource Graph Explorer**, select the intended subscriptions. The following query counts distinct evaluated resources **per control and state** for one initiative assignment. Replace the example assignment ID with its full ID from Azure Policy. Save the query; for a historical trend, have a scheduled reporting job export a dated snapshot after evaluation with the baseline version, scope, and exception list. Count missing evaluations separately by reconciling each control's resource IDs with the expected inventory.

```kusto
PolicyResources
| where type =~ 'microsoft.policyinsights/policystates'
| where tostring(properties.policyAssignmentId) =~ '/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-returns/providers/Microsoft.Authorization/policyAssignments/returns-infra-baseline'
| project Control = tostring(properties.policyDefinitionReferenceId),
          Target = tolower(tostring(properties.resourceId)),
          State = tostring(properties.complianceState)
| distinct Control, Target, State
| summarize Resources = count() by Control, State
| order by Control asc, State asc
```

For a fictional size report covering 200 VMs, suppose 193 are compliant, four are noncompliant, two are exempt, and one expected VM has no result. Report all four categories. Don't call the missing VM compliant or add the disk and network counts to the VM count: those controls can evaluate different resources.

**Investigate differences before correcting them**: Group the four noncompliant VMs by pool, responsible workload team, and change window. They might be four approved resizes, four unintended changes, or a mixture. For one finding, `fc-later`, the **Resource Graph Explorer** query below shows how to trace the size change by resource ID. Repeat that comparison for the other findings rather than assigning all four the same cause. This is Resource Graph data, not the `Heartbeat` table in Log Analytics.

```kusto
resourcechanges
| extend Target = tostring(properties.targetResourceId),
         ChangedAt = todatetime(properties.changeAttributes.timestamp),
         SizeChange = properties.changes['properties.hardwareProfile.vmSize']
| where Target =~ '/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-returns/providers/Microsoft.Compute/virtualMachines/fc-later'
| where ChangedAt >= ago(7d) and isnotnull(SizeChange)
| project ChangedAt, Before = tostring(SizeChange.previousValue),
          After = tostring(SizeChange.newValue), ChangedBy = tostring(properties.changeAttributes.changedBy),
          CorrelationId = tostring(properties.changeAttributes.correlationId)
| order by ChangedAt desc
```

For each resize, match its time and correlation ID with the **Activity log** and the affected workload team's approved change record. If three were authorized and one wasn't, review the baseline or exceptions for the three and investigate the fourth. Don't resize the whole pool to make the report green. Resource Graph change history covers the last 14 days, so an empty history doesn't cancel a current finding. Reconcile the next compliance report with the fleet inventory and confirm application health on any corrected targets.
