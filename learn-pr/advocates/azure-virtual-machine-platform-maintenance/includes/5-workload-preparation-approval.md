Preparation protects work already in progress; approval tells Azure it may start maintenance early. Suppose two non-GPU worker VMs, `pool_0` and `pool_1`, share a Uniform scale-set placement group and one event names both VMs. The invoice process on `pool_0` can stop taking invoices and save every job it owns, but that says nothing about jobs owned by the process on `pool_1`. Each process records its checkpoint results before reporting ready. The coordinator approves only while the event is still scheduled, time remains, and every named VM is ready. For two standalone invoice VMs in separate zones, an event naming only `worker-a` doesn't require readiness from `worker-b`.

## Checkpoint before the deadline

For example, the invoice processor caps preparation at 30 seconds and reserves five seconds before `NotBefore`. If a checkpoint needs 20 seconds but only 12 seconds of notice remain, the usable budget is seven seconds. The worker process stops taking jobs and records which invoices it owns. Because it can't finish the checkpoint in seven seconds, it doesn't start the write or report itself ready. The coordinator withholds approval. Withholding approval doesn't change `NotBefore`. Once that time arrives, Azure can start maintenance even if the application isn't ready.

:::image type="content" source="../media/5-checkpoint-time-budget.svg" alt-text="Diagram that shows why a 20-second checkpoint cannot fit when a 5-second reserve leaves only 7 of the 12 seconds before NotBefore.":::

Implement real checkpoints with cancelable or time-bounded operations. If the invoice process stops waiting but the checkpoint write continues, the write can still change stored data after the deadline. The deadline must apply to the write itself. Before releasing a job's lease, for example, record the planned release in durable storage. Mark it complete only after the ownership store confirms the release. Record each checkpoint against both the `EventId` and the job ID so a restarted process can tell what it already saved for that event. Use the stable job ID to prevent a second invoice posting, even if a different event triggers the retry.

Keep polling while a checkpoint is pending. In this example, use whichever deadline comes first: 30 seconds after preparation began, or five seconds before the latest `NotBefore` time. Seeing the same event again doesn't restart the 30-second timer. Mark preparation complete only when a durable write is confirmed within that window. If a write times out, check the store during recovery rather than backdating a success or assuming that nothing was written.

## Decide whether to let Azure start VM maintenance early

The coordinator validates the entire IMDS response before considering any event for approval. A malformed event or a conflict with a saved event record blocks approval for the whole response. For a valid response, the coordinator decides separately for each `EventId`. Readiness reports come from the application, not from IMDS. A worker process reports ready only after it's stopped taking new jobs and confirmed that every unfinished job it owns has a checkpoint in durable storage.

```text
if consumer is quarantined or event is no longer Scheduled:
    withhold approval
else if now >= event.NotBefore - safety_margin:
    withhold approval
else if any listed VM lacks a fresh, authenticated VM readiness report for this EventId:
    withhold approval
else if an approval intent already exists for this EventId:
    reconcile its outcome rather than creating another intent
else:
    persist approval intent for this EventId before sending the request
```

### Send the approval request

Reject a VM readiness report if the current document doesn't contain its `EventId` or the event doesn't list that VM in `Resources`. A report for one event doesn't count toward approval for another. Immediately before approval, the in-guest sender rechecks status, membership, deadline, and readiness. If all conditions still hold, it sends a `POST` to `http://169.254.169.254/metadata/scheduledevents?api-version=2020-07-01` with the `Metadata: true` header and the actual event ID in the JSON body:

```json
{"StartRequests": [{"EventId": "<event-id-from-imds>"}]}
```

### Handle missing approval responses

Log when the coordinator decided to approve the event, when it sent the `POST`, and what response it received. If no response arrived, record that too. Azure accepts an approval `POST` for a still-valid `EventId` even if another VM approved it first. A successful response doesn't tell you which VM approved it first. If the coordinator can't tell whether Azure received its approval, it polls again. Before resending, it confirms that the same event is still `Scheduled`, time remains before the safety margin, and every named resource is still ready. Don't repeat checkpointing or invoice processing because an approval response was lost. A successful response isn't evidence that maintenance has started.

:::image type="content" source="../media/5-reconcile-approval-response.svg" alt-text="Diagram that shows why a lost approval response calls for a fresh IMDS poll, not another checkpoint or a new approval intent.":::

## Handle incomplete or conflicting observations

When a maintenance notice is incomplete or conflicts with a saved record, distinguish three decisions: whether to checkpoint invoices, whether to approve maintenance early, and whether to accept new jobs.

| Observation | Preparation and approval | Recovery decision |
|---|---|---|
| Only unrelated resources | No local preparation or approval | Keep serving if no other hold applies |
| Repeated scheduled event | Reuse recorded preparation | Don't duplicate job effects |
| First observation already started | No late preparation claim or approval | Keep intake closed until the event clears and work can be reconciled |
| Preparation failure or short budget | Withhold approval and escalate | Keep work identifiable for safe retry |
| Event removed before observed start | Don't invent a cancellation status | Recheck health and reconcile |
| Same ID but changed resource membership or type, or `Started` reverting to `Scheduled` | Quarantine the consumer; withhold all approvals | Preserve both documents and require operator review |
| Metadata unavailable or malformed | Retain active event and job state; withhold approval | Keep intake closed and reset the healthy observation count |

### Validate the IMDS response

Validate the complete document before changing event or job state or emitting approval. This workload's conservative validator requires a non-negative integer `DocumentIncarnation` and an `Events` array. Each entry needs an `EventId` unique within the response, `ResourceType` set to `VirtualMachine`, and a nonempty `Resources` list of distinct, nonblank VM names. Accept the GA event types `Freeze`, `Reboot`, `Redeploy`, `Preempt`, and `Terminate`, with `EventStatus` set to `Scheduled` or `Started`. For a `Scheduled` event, parse `NotBefore` as a UTC timestamp, including the documented GMT format such as `Mon, 19 Sep 2016 18:29:47 GMT`. For a `Started` event, `NotBefore` can be blank. These conservative collection checks are application policy, not an exhaustive Azure service schema.

For each known `EventId`, compare the current resource list with the saved list **before** filtering for the local VM's name. Otherwise, if the list changes and drops that VM, the consumer could mistake the change for an unrelated event. If any entry is malformed or conflicts with the saved event record, don't approve any event in that response, even one that appeared valid earlier in the list.

:::image type="content" source="../media/5-validate-event-membership.svg" alt-text="Diagram that shows how a changed VM list for E2 blocks approval for both events, even though E1 still lists the local VM.":::

### Handle overlapping or changing events

When multiple events overlap, finishing one event can't reopen intake while another relevant event remains active. If an event disappears or becomes `Started` while preparation is pending, cancel the attempt. If a checkpoint finishes after its event disappears or changes to `Started`, don't use that completion to mark the invoice process ready or approve the event. Repeated `Started` observations don't start another checkpoint or retry a job.
