At `10:06 UTC` in the worked example, both VMs have fresh heartbeats but neither has a new completion in the dashboard. The last healthy baseline included Linux `user.warning` messages from ContosoLinuxA and Windows Application events from ContosoWinSrvB. Compare each VM with its own baseline:

| Evidence | ContosoLinuxA (Linux) | ContosoWinSrvB (Windows Server) |
|---|---|---|
| Latest AMA heartbeat | `10:05:40Z` | `10:05:43Z` |
| Worker state | systemd unit active | Windows service stopped at `10:00:08Z` |
| Local health file | updated `10:05:50Z` | last update `09:59:58Z` |
| Local completions | `order-worker` continues to emit `user.warning` | No new `OrderWorker` 4100 events after stop |
| Collection settings observed at `10:06Z` | Agent configuration: `user` minimum Error; flow to approved workspace | Last-known-good subscription selects Application, `OrderWorker`, Information, 4100; DCR flow to approved workspace |
| Last central completion | `Syslog`: source `09:59:50Z`, ingested `10:02:30Z` | `Event`: source `09:59:58Z`, ingested `10:00:42Z` |
| AMA upload errors | none in sampled interval | none in sampled interval |

**ContosoLinuxA: restore collection, not the worker.** The worker emits `user.warning`; its only applicable flow to the approved workspace now selects Error or higher. Before editing, the rule owner saves the full definition and rollback plan. In **DCR > Resources**, record the IDs of the VMs sharing the rule. For the reverse view, open **Monitor > Data Collection Rules > Resources** and select the affected VM's **Data collection rules** count to record all its rule IDs.

Restore only the approved `user` Warning minimum through the policy or template that manages the rule. Don't save a portal edit if the editor can't preserve the rule's JSON settings. Compare the before-and-after definitions: only the intended facility's levels should change, not the other sources, flows, transformations or destination. Separately compare the two sets of associations before and after the edit; they're not part of the rule definition. Save the observations and times. If membership is only partly visible, ask the owner rather than reporting it unchanged. Match a newly emitted warning from this VM to its workspace row. Restoring the filter doesn't replay previously excluded messages; use retained local records to reconcile that interval.

**ContosoWinSrvB: restore the worker, not collection.** Service Control Manager records the stop at `10:00:08Z`. The health file stops advancing and the Application log has no newer completions. The rule for ContosoWinSrvB still includes Information events of type 4100. The workload owner checks why the service stopped and whether restarting it could process unfinished orders twice. If the stop was unintended and it's safe to resume, start only the worker. Widening the Windows event filter can't deliver an event that never existed.

**A third possibility: the event was delivered, but the desk can't see it.** Look for the exact VM and application occurrence ID, not just Windows Event ID 4100. Compare the result with the approved destination:

| Where did you find the event? | What should change? |
|---|---|
| In approved workspace W2; the ticket or dashboard points to W1 | Correct the ticket or view. Leave collection alone. |
| In the approved workspace; the dashboard still omits it | Run the dashboard's own query with its identity, VM, UTC interval and parameters. Compare its filters, time binding and refresh with the raw row. Correct only the confirmed difference and show that the same order now appears. |
| In W2; W1 is the approved destination | Preserve the definition and identify all consumers. For an authorized same-region change, correct the affected flow if other consumers are unaffected. Across regions, use a DCR in **W1's region** with the approved source, flow, agent identity/network path and VM association. Overlapping routes can duplicate data; switching too early can create a gap. For an authorized transition, verify a fresh ID in W1 before retiring only the superseded route. Historical W2 records don't move. |

If W2 **wasn't authorized to receive order data**, notify the data owner and follow the incident containment procedure. Don't continue sending to W2 for the sake of a gap-free cutover. If no copy was found, the search hasn't established a routing error; return to the guest-to-workspace trace.

## Verify recovery with new order completions, not late-arriving logs

Before a change, record the current state, intended effect and reversal. Record when the repair took effect, separately for each VM if needed. The Linux event written at `09:59:50Z` and ingested around `10:02:30Z` arrived about 160 seconds later. That tells you neither why it was delayed nor whether the repair worked. If the corrections took effect at `10:12:00Z`, a corroborated Linux event written at `10:12:10Z` and observed in the workspace at `10:13:00Z` is evidence of new delivery. The same applies to a Windows event written at `10:12:12Z` and observed at `10:13:03Z`.

One fresh record establishes one delivery. Sample at least three distinct post-correction occurrence IDs per affected VM and match them to their local records. Save the query, workspace, time bounds, delays and gaps. If too few events arrive by the cutoff, report the sample you've collected rather than widening the repair. To assess backlog clearance, reconcile all keys due by that cutoff, including orders outstanding at the start, against the order system rather than the delivery sample.

To show that a worker completed **new work** after its repair, match the order key and worker attempt to the order system's first successful commit for that order. Compare that commit time with the worker's repair time: the commit must be later. A retry can emit a fresh event for an order committed earlier. If the owner can't establish when the order first committed, report "delivery restored; new order processing unconfirmed."

Use the [Linux or Windows worker query](xref:learn.devrel.azure-virtual-machine-incident-diagnosis.correlate-incident-records) for one VM. Both expose `Payload` and `Ingested`. Set its `begin`, `finish` and the portal time picker to include a pre-repair baseline through the observation cutoff, with a margin for expected lag and clock differences. For example, use `09:45Z` through `10:25Z` for the following repair and cutoff. Add these two bindings beside the other `let` statements, substituting your actual UTC times:

```kusto
let repairUtc = datetime(2026-11-14T10:12:00Z);
let cutoffUtc = datetime(2026-11-14T10:20:00Z);
```

Replace only that worker query's final `order by` with these lines:

```kusto
| where Payload matches regex @"(?:^|\s)status=complete(?:\s|$)"
| extend CompletionId = extract(@"(?:^|\s)event_id=(\S+)", 1, Payload),
         SourceUtc = todatetime(extract(@"(?:^|\s)source_utc=(\S+)", 1, Payload))
| where isnotempty(CompletionId) and isnotnull(SourceUtc) and isnotnull(Ingested)
| where Ingested <= cutoffUtc
| summarize arg_min(Ingested, SourceUtc) by _ResourceId, CompletionId
| where SourceUtc > repairUtc and SourceUtc <= cutoffUtc and Ingested > repairUtc
| project _ResourceId, CompletionId, SourceUtc, FirstIngested=Ingested
| order by SourceUtc asc, CompletionId asc
```

`arg_min` selects the earliest visible matching copy in the searched interval and keeps its source time. Checking freshness **after** that step prevents a later duplicate from hiding a pre-repair delivery. Work down the candidates until three distinct IDs match the guest evidence or none remain by the cutoff. Record why you skipped an ID, such as reuse or clock uncertainty at the repair boundary. If A is ambiguous and B, C and D are clear, inspect B, C and D; don't stop at the first three rows.

On a busy stream, filter to a shortlist of known local IDs across the **same baseline and cutoff** so earlier copies remain visible. Three corroborated IDs establish three deliveries, not three new commits or backlog clearance. Use the order system for those claims.
