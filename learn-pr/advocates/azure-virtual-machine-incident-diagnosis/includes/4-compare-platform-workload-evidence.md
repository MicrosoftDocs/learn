ContosoLinuxA's local completion counter keeps rising even though the dashboard shows no new orders. On ContosoWinSrvB, the engineer can see a recent agent heartbeat, but that only confirms the monitoring agent checked in. To answer the order desk, the engineer needs to find the last order the Windows worker itself completed.

Choose signals that don't all depend on the same collection path. A dashboard and a query of the same log table can both go blank because of one filter. The worker's local health file is independent of log delivery; the order system's committed result answers a different question: did that order finish?

The Azure Activity Log records control-plane operations: actions that manage Azure resources, such as saving a rule or restarting a VM. It doesn't record individual orders. Azure Service Health reports service incidents and maintenance; Resource Health reports Azure's assessment of a particular VM. A platform metric is a numeric measurement, such as CPU usage, observed by Azure's hosting infrastructure. A guest log records individual events observed inside the VM.

Use the table to choose a signal for the question you're investigating and identify what it can't establish on its own.

| Signal | Can support | Can't establish alone | Prerequisite |
|---|---|---|---|
| Activity Log | A rule update or VM operation occurred | Application success or all authentication failures | Correct subscription, resource, time, and read permission |
| Service Health | A relevant regional/service incident exists | That this particular workload is affected | Subscription visibility and relevance check |
| Resource Health | Azure's availability assessment for the VM during the incident | A functioning application or guest collector | Correct VM and health history covering the incident interval |
| Platform metrics | Processor, network, or disk activity changed | Which application action succeeded | Select the right VM, metric family (namespace), and summary for the interval, such as average CPU usage |
| Guest logs and service state | Source process ran, stopped, or failed | Successful delivery into a workspace | Guest access and logs that are still stored locally |
| Workload check | A defined operation produced the expected result | Complete platform or telemetry health | An independent, workload-specific check |

Open **Resource health > Health history** on each VM. Record the UTC interval and any platform or non-platform cause Azure reports. **Available** now doesn't rule out an earlier interruption; **Unavailable** can follow a user-initiated stop, and **Unknown** means Azure lacks information. The Administrative Activity Log is useful for the DCR write, not a substitute for health history: some short VM health transitions never appear in the Activity Log.

In **Service Health**, select the relevant subscription, service and region. Look for incidents and maintenance in both the active view and history. Compare any matching event and tracking ID with each VM's timeline and guest evidence. If nothing matches, record "no matching report visible for this interval," not "no platform incident."

:::image type="content" source="../media/incident-evidence-sources.svg" alt-text="Diagram that shows six evidence sources for Azure changes, service health, VM availability, host activity, worker state, and order outcomes.":::

For each source, record the resource ID, destination, and retention period (how long records are kept). Check where you opened **Logs**. From a VM, you search records associated with that resource (resource context). From a workspace, you search the tables and records you can read there (workspace context), which may cover many VMs. Workspace settings and your permissions also affect what you can see.

If a query returns no data, that result alone doesn't tell you whether the VM is healthy. A metric with no points might be unsupported or outside retention. A heartbeat can arrive even when the collection rule excludes the application's messages.

This diagram summarizes the evidence journey and the independent observations you use to test it.

:::image type="content" source="../media/module-overview.svg" alt-text="Diagram that shows how to scope the gap, check local events, trace collection, compare evidence, and verify recovery for each worker.":::

When investigating, follow one event from the worker to the workspace. At each step, ask: did this event arrive, did it move on, and how do I know it's the same event? Use control-plane and platform-health records for context. If you can't show what happened at a step, record it as unknown.
