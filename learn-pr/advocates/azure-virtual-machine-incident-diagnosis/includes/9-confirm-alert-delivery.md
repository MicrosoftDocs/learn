An alert rule evaluates a condition. The action group specifies whom to notify and how. **Fired** means the condition was met, not that someone received an email. An action-group test can reach a mailbox even if the real query never matches. Conversely, a rule can fire while notifications are suppressed (intentionally muted).

For the scheduled log search rule on the example's Analytics tables, trace four steps from the query to the mailbox:

1. **Could the row match?** For both delivery-check rules below, select the workspace scope, **Table rows**, count **greater than 0**, and **one evaluation period**. Leave dimensions and the **Azure Resource ID** target column unset. The VM filter in the query selects rows; the workspace remains the alert target. If measured ingestion delay warrants it, use a 15-minute window and evaluate every five minutes. Let the rule supply the time range: a five-minute KQL filter would exclude an eight-minute-old row. Return matching events, not `count` of events. Evaluation frequency isn't a delivery guarantee.
1. **Did the rule fire?** Rule **History** shows triggers, not every scheduled evaluation. If the marker is present but no instance is visible, first check the target subscription, time filter, access and retention as described in [Troubleshoot missing logs and notifications](xref:learn.devrel.azure-virtual-machine-incident-diagnosis.troubleshoot-telemetry-gaps). Then ask the rule owner to confirm the rule is enabled and check **Help > Resource health** for query execution problems on this five-minute rule. The row may not have been available at evaluation time. A stateful rule won't fire again for the same active condition and dimensions until it resolves; a stateless rule can fire again in overlapping windows.

   Check **Identity** in the rule details. If the rule uses a managed identity, that identity needs read access to every workspace the query uses. Otherwise the rule uses the permissions the last editing user or service principal had at the time of the edit. Your own successful query, the VM identity used by AMA, and the receiver's email verification don't establish that access. Have the rule owner address any missing workspace permission; investigate the mailbox only after you find the fired instance.
1. **Which action applied?** Open the fired instance. Compare its actual target IDs and **History** with the targets and actions you expected. Check which groups ran or were suppressed and whether the receiver is verified. For the two example rules, the target is the workspace; the VM's `_ResourceId` and the one-use ID identify the source row. Don't split by unique completion ID. Alert severity indicates urgency; it isn't the guest event's severity.
1. **Did the firing notification arrive?** Match the recipient's actual email to the instance link or ID **and** to the **Fired** condition shown in that message. In a common-schema payload, the fields are `data.essentials.alertId` and `data.essentials.monitorCondition`. A stateful rule can send a **Resolved** message for the same instance. If that's the only email received, record "resolution received; firing notification unconfirmed." If the message doesn't identify the condition, don't infer it from the current portal state. Record the rule ID, instance, fired UTC and receipt UTC separately.

Before selecting **Monitor > Alerts > Action groups > Test**, inspect every receiver and action of the types selected. The sample can reach multiple mailboxes or invoke a real webhook, function, or runbook. Use an isolated group for a single-recipient check. Don't remove receivers from a shared group or insert a test ID into a production rule.

:::image type="content" source="../media/alert-delivery-path.svg" alt-text="Diagram that shows a matching log row, the fired alert instance, and the recipient's Fired email. A sample or resolution email isn't proof.":::

Before enabling a delivery-check rule or emitting **either** marker, have the alerting owner identify every enabled rule that could independently match the event. For each rule, inspect the saved condition to determine where it can fire:

- **Workspace target:** For the example settings, check processing rules on the workspace, its resource group and its subscription. Filtering by `_ResourceId`, or using it as an ordinary dimension, doesn't retarget the alert.
- **VM target:** If a rule sets the **Azure Resource ID** target column (`resourceIdColumn`) to `_ResourceId`, check the returned VM, its resource group and its subscription. That subscription can differ from the workspace's.

For each possible target, check attached action groups and processing-rule filters and schedules at the planned test time. **Apply action groups** can add production actions. Matching **suppression** takes precedence and removes all groups, but changes to processing rules can take up to 30 minutes to take effect. Don't rely on newly saved suppression, a dedicated group, or the rule's own resource group to isolate a live test. If any action is unknown or unapproved, don't enable the test rule or emit the marker there. Use an approved isolated target or trace a naturally occurring alert instead. Obtain workload-owner approval for any test order.

**Linux example:** An approved delivery-check rule can count only Syslog messages carrying a dedicated tag and a one-use identifier:

```kusto
Syslog
| where _ResourceId =~ "<full VM resource ID>"
| where ProcessName == "monitoring-check"
| where SyslogMessage == "delivery-check id=<one-use identifier>"
```

For an authorized check on a VM collecting `user.warning`, `logger -p user.warning -t monitoring-check 'delivery-check id=<one-use identifier>'` emits this message. Use the same fresh identifier in the rule and message.

**Windows example:** If the workload supports an approved test order with a known completion ID, its normal provider can emit the event. Filter the workspace query to that VM, provider, event type, and ID rather than firing on every Information event:

```kusto
Event
| where _ResourceId =~ "<full Windows VM resource ID>"
| where EventLog =~ "Application" and Source =~ "OrderWorker" and EventID == 4100
| extend CompletionId = extract(@"(?:^|\s)event_id=(\S+)", 1, RenderedDescription)
| where CompletionId == "<one-use completion ID>"
```

Allow a bounded observation interval based on ingestion delay and evaluation frequency; investigate a missed marker rather than sending it repeatedly. If the Windows application has no supported test route, don't fabricate a completion. Label the evidence **action-group sample**, **fired delivery-check alert**, or **fired production alert**. Only a recipient's **Fired** message for the production instance proves delivery of that production page. If the route can't be exercised safely, trace a naturally occurring alert or record receipt as unconfirmed.

These marker rules detect **presence**, not silence. To investigate missing completions, establish that orders were due for that worker and interval, allow for normal lag, then compare expected workers with observed completions. Grouping only rows that arrived can't produce a group for an absent VM. No demand, a stopped worker and missing telemetry need different responses.

Suppose the order owner confirms both workers were due to emit at least one completion in the same UTC window. After allowing for delivery lag, the workspace searches find two Linux rows and no Windows rows. This read-only example uses aliases for the two VMs. In an incident, compare normalized full VM resource IDs from the owner-confirmed assignments with those in the observed completion rows.

```kusto
let Expected = datatable(Worker:string) ["linux-a", "windows-b"];
let Observed = datatable(Worker:string) ["linux-a", "linux-a"];
Expected
| join kind=leftanti (Observed | distinct Worker) on Worker
```

The `leftanti` join keeps expected workers with no observed match. It returns `windows-b`: at least one completion was expected, but none was observed centrally by the cutoff. The duplicate Linux rows don't hide Windows. If Windows had nothing due, leave it out of `Expected`. If demand, assignment or query coverage is unknown, including when access is denied, report that limit rather than declaring silence. For a flagged worker, check the guest and the order history. This query detects a worker with **no** visible completions; it can't identify a missing order on a worker that reported others.

In the incident handoff, separate evidence of application recovery, log delivery, and notification receipt. Record missing evidence explicitly rather than reporting an illustrative result as an observation. The following template applies to one or many affected resources:

```text
Incident and environment: [incident reference, affected application, environment]
Impact: [confirmed workload effect versus observability loss]
Resources: [VM aliases and OS, private full-ID mapping, DCRs, workspace]
Window and clocks: [UTC begin/end, source and query times]
Baseline: [application completion IDs, service states, normal lag]
Hypotheses: [support, contradiction, confidence, discriminating test]
Diagnosis per VM: [cause, local workload result, agent and effective-rule evidence]
Actions: [actor alias, timestamp, exact narrow change, reversal]
Delivery: [fresh occurrence IDs per VM, source and destination times, table and query]
Orders: [opening backlog plus new arrivals; due by cutoff vs. not yet due; stable key alias across attempts, outcome, authoritative source, as-of UTC, gaps and owner]
Alert: [sample/check/production, rule ID and health, instance ID/link, fired UTC, effective actions, condition in received message (Fired/Resolved/unknown), receipt UTC or unconfirmed]
Hypothesis dispositions: [per VM, supported/contradicted/unresolved, evidence, interval and limits]
Unresolved: [missing export, delay, delivery issue, next owner]
Cleanup: [restoration, deletions, retained costs, evidence expiry]
```

For example: "ContosoLinuxA kept emitting completions; its rule excluded Warning messages. No new worker completions were recorded on ContosoWinSrvB after its service stopped. Fresh IDs from both VMs reached the approved workspace after the repairs. The order owner is reconciling queued orders; the on-call lead hasn't confirmed alert receipt." In a live handoff, attach the actual evidence.

Don't redact every identifier into the same word. Use stable aliases so colleagues can correlate records without exposing subscription identifiers, user identities, recipient addresses, or customer messages. Keep the original evidence in the approved incident record with an owner and retention date.
