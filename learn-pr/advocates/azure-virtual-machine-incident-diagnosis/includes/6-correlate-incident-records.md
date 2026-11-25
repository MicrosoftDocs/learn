Start in the store that holds the evidence you need. In **Logs** in the destination **Log Analytics workspace**, `Syslog` holds forwarded Linux messages and `Event` holds Windows events collected by the Windows Event Logs DCR. The Application records in this example aren't in `SecurityEvent`. Both OSes use `Heartbeat` for agent check-ins; `AzureActivity` holds exported Azure management records. For host measurements such as CPU usage, use **Metrics** on the VM instead.

:::image type="content" source="../media/evidence-query-locations.svg" alt-text="Diagram that shows Syslog, Event, Heartbeat, and AzureActivity in Log Analytics, with host CPU in VM Metrics.":::

An **Azure Monitor workspace**, despite the similar name, is a different resource. OpenTelemetry-based guest monitoring collects standardized measurements from inside the OS and stores them there as time series (values recorded over time). Use Prometheus Query Language (PromQL) for those metrics. Classic logs-based guest monitoring writes performance records to Log Analytics tables such as `InsightsMetrics` or `Perf`. Enabling guest metrics doesn't enable either guest log source; if you use both workspaces, record both destinations.

Azure records management operations in the subscription's **Activity log** without export. To search a DCR edit in `AzureActivity`, a diagnostic setting must have routed the **Administrative** category to that workspace during the incident. Inspect **Monitor > Activity log > Export Activity Logs**, then use deployment or change records to check the destination, category and start of coverage **at the time**. Today's setting doesn't establish yesterday's coverage. If coverage is absent or unknown, say so and use the native log; export doesn't backfill. Don't widen access or export unrelated subscription activity to fill the gap.

Choose the worker query for the VM's OS. Open **Logs** in the destination workspace and switch to **KQL mode** if the point-and-click view opens. Confirm the incident window is interactively queryable. Substitute the full VM resource ID, application-specific values, and UTC bounds; set the portal time picker to include those bounds. Each `|` passes rows to the next step. `where` keeps matching rows (`=~` ignores case), `extend` adds calculated columns, and `project` selects the columns to display.

**Linux (ContosoLinuxA)**: filter `Syslog` by the application's tag. The query names the message column `Payload` so the same recovery check can be used on either OS.

```kusto
let vmId = "<full VM resource ID>";
let workerTag = "order-worker";
let begin = datetime(2026-11-14T09:45:00Z);
let finish = datetime(2026-11-14T10:15:00Z);
Syslog
| where TimeGenerated between (begin .. finish)
| where _ResourceId =~ vmId
| where ProcessName == workerTag
| extend Ingested = ingestion_time()
| extend LagSeconds = datetime_diff("second", Ingested, TimeGenerated)
| project TimeGenerated, EventTime, Received=_TimeReceived, Ingested, LagSeconds,
          _ResourceId, Computer, Facility, SeverityLevel, Payload=SyslogMessage
| order by TimeGenerated asc
```

**Windows (ContosoWinSrvB)**: filter `Event` by the log, provider, and Event ID. The example provider includes the unique completion ID and source timestamp in its rendered message. If your provider stores them as structured fields instead, inspect `EventData` or `ParameterXml` and extract those fields rather than assuming the description is populated.

```kusto
let vmId = "<full Windows VM resource ID>";
let begin = datetime(2026-11-14T09:45:00Z);
let finish = datetime(2026-11-14T10:15:00Z);
Event
| where TimeGenerated between (begin .. finish)
| where _ResourceId =~ vmId
| where EventLog =~ "Application" and Source =~ "OrderWorker" and EventID == 4100
| extend Ingested = ingestion_time()
| extend LagSeconds = datetime_diff("second", Ingested, TimeGenerated)
| project TimeGenerated, Received=_TimeReceived, Ingested, LagSeconds, _ResourceId, Computer,
          EventLog, Source, EventID, EventLevelName, Payload=RenderedDescription
| order by TimeGenerated asc
```

For either VM, match the `event_id` and `source_utc` in `Payload` to the local completion. These are example application fields, not built-in Azure columns. `LagSeconds` estimates delay relative to `TimeGenerated`; it doesn't say whether the worker is still running. Keep the full resource ID privately and use a stable alias in shared reports.

Run the heartbeat query for **one VM** over the same window. With no grouping key, `summarize` returns one row even when nothing matches. In that case, `Records` is zero, `LastHeartbeat` is null, and `RequestedVm` identifies what you searched for, not a VM you observed. A missing table or access error isn't a zero count.

```kusto
let vmId = "<full VM resource ID>";
let begin = datetime(2026-11-14T09:45:00Z);
let finish = datetime(2026-11-14T10:15:00Z);
Heartbeat
| where TimeGenerated between (begin .. finish)
| where _ResourceId =~ vmId
| where Category == "Azure Monitor Agent"
| summarize LastHeartbeat=max(TimeGenerated), Records=count()
| project RequestedVm=vmId, LastHeartbeat, Records
```

For an exported rule change, filter on the DCR's resource ID, not the VM's. Azure records the write against the rule that was edited. The `CorrelationId` in the result links related management operations; it's not the worker's `event_id` and can't match a rule edit to an individual order.

```kusto
let dcrId = "<full DCR resource ID>";
AzureActivity
| where TimeGenerated between (datetime(2026-11-14T09:45:00Z) .. datetime(2026-11-14T10:15:00Z))
| where _ResourceId =~ dcrId
| project TimeGenerated, _ResourceId, OperationNameValue,
          ActivityStatusValue, CorrelationId
| order by TimeGenerated asc
```

A successful write doesn't prove that the filter value changed. Compare approved before/after definitions or an available Azure Resource Graph change record for a recent eligible DCR update (normally 14 days of history). An association add/remove is a different operation: search the VM's subscription for a write/delete on `{VM resource ID}/providers/Microsoft.Insights/dataCollectionRuleAssociations/{name}`. If the name is unknown, ask the authorized operator to search for association operations in that interval.

Record the control-plane save, the configuration observed in the guest and the first source event shown to be affected. If you know only that the new filter took effect between two observations, report that interval. A tag-only edit near the gap doesn't explain an excluded warning; the changed filter, matching local evidence and fresh delivery after restoration do.
