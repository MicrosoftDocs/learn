When Contoso's order desk calls at `10:05 UTC`, the dashboard shows a gap for both ContosoLinuxA and ContosoWinSrvB, but the `10:00` Syslog rule change applies only to ContosoLinuxA. The engineer's first question is which order each worker last completed, not just which order last appeared on the dashboard.

An investigation should start with what customers or operators can no longer do. Record the affected resource IDs, the last confirmed successful order, when someone first noticed the gap, and the interval you'll investigate. In this simulated case, operations can't reconcile the two workers' orders. That establishes a loss of observability: the team can't see what happened. It doesn't yet establish a processing outage.

Use Coordinated Universal Time (UTC) throughout; a timestamp ending in `Z` is in UTC. Keep the original timestamp and offset when converting it. The Azure portal, Windows Event Viewer, and the Linux journal can display local times. A Windows event's XML includes `TimeCreated/@SystemTime`; on Linux, `journalctl --utc` displays journal times in UTC. Normalize these before ordering events from different machines.

:::image type="content" source="../media/normalize-event-timestamps.svg" alt-text="Diagram that shows both workers emitted events before the rule change when all times are in UTC. Neither event proves an order committed.":::

The worker writes `source_utc` into each completion. Check the guest clock against a trusted time source before using that field to place an event on either side of a repair. In forwarded Syslog, `EventTime` comes from the message header; a header without a time zone can be interpreted in the forwarder's zone. `TimeGenerated` can reflect when the forwarder processed the message rather than when the order finished.

`_TimeReceived` records cloud receipt. `ingestion_time()` approximates when the record was stored in the workspace and became available to queries. Neither is the UTC time when your query actually returned the row; record that observation separately. To investigate delay, compare receipt minus `TimeGenerated` with ingestion minus receipt. Neither interval isolates a network hop. If an interval is negative, check clock skew and the meaning of each field.

There's an exception when logs arrive very late or a source clock is far ahead. If the supplied `TimeGenerated` is more than two days before receipt or more than one day after it, Azure Monitor replaces it with the received time. A completion emitted on 14 November and uploaded on 17 November can have a 17 November `TimeGenerated` and a small apparent ingestion delay. It's still a 14 November event.

The timeline distinguishes when each worker emitted an event, when the workspace ingested it, and when the investigator looked for it.

| UTC time | Observation | Interpretation |
|---|---|---|
| `09:59:50-09:59:58` | ContosoLinuxA and ContosoWinSrvB each emit a completion event | Last completion events observed from each worker before the gap; order commits not yet checked |
| `10:00:00` | Someone saves a collection rule specifying which messages to send and where | A possible cause; saving the rule doesn't tell you when the VM started using it |
| `10:00:10` | The worker on ContosoLinuxA emits locally; the worker on ContosoWinSrvB has stopped | The identical dashboard symptom hides different states |
| `10:02:30` (approx.) | Workspace ingestion time for the earlier Linux event | Late arrival, not new work or proof of what delayed it |
| `10:05:00` | Investigator runs the missing-event query | Detection time is later than either fault |

Before telling the desk that an order completed, ask the order owner to match its stable order key and processing attempt to the successful commit in the order system. Record the commit time separately. If you've found only the worker event or its workspace copy, report "completion logged; order outcome unconfirmed."

Before changing anything, write down plausible explanations in a hypothesis log. For each one, record an observation that supports it, one that counts against it, and a test that could distinguish it from the alternatives. Confidence reflects the evidence, not how familiar the repair feels.

Use the hypothesis log to compare four explanations for the dashboard gap and choose a test that can distinguish between them.

| Hypothesis | Supporting evidence | Contradictory evidence | Confidence | Next discriminating test |
|---|---|---|---|---|
| Application stopped | No completion events in the workspace | The event counter on ContosoLinuxA keeps increasing | Low for ContosoLinuxA | Check the service and whether the worker is still updating its local health file |
| Collection filter excludes warnings | Rule changed near the gap | Not yet inspected | Medium | Compare a local message's severity with the rule the agent is actually using |
| Agent disconnected | No application events in the workspace | Recent heartbeat: a periodic check-in from the monitoring agent | Low, not zero | Inspect agent errors and other streams |
| Wrong workspace | Query is empty | Workspace identity not recorded | Medium | Compare rule destination with query scope |

Save the initial result and query time, even for a successful search with no matching events. After a correction, search the original interval again, then search a new interval. An event written at `09:59:50Z` and ingested around `10:02:30Z` still describes earlier work.
