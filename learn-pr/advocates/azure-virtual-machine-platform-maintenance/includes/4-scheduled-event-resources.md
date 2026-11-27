Reading a maintenance notice and deciding to act on it are separate steps. Each standalone invoice VM polls its own local IMDS endpoint. Don't expect `worker-a` to receive `worker-b`'s notices just because the workers share a queue or subscription. The event consumer uses the affected VM names, status, and timing to decide whether local preparation is needed.

The metadata endpoint is local to the Azure guest and isn't an ordinary public service. Query it from the VM itself, bypass proxies, and include the `Metadata: true` header. The documented Scheduled Events application programming interface (API) version used here is `2020-07-01`.

The first request enables Scheduled Events for the service and can take up to two minutes to return. From the time of that request, allow up to five minutes for event delivery to begin. If Azure receives no requests to the Scheduled Events endpoint for 24 hours, it disables Scheduled Events for that service. The next request enables it again. A production consumer should normally poll once per second, with bounded request timeouts and explicit reporting of failures.

In a separate deployment, peers in an availability set or a Uniform scale-set placement group can receive a notice even when only one peer is affected. Placement groups are per zone; don't assume a broadcast reaches every scale-set VM or apply this rule to every Flexible scale set. The documented scope exception for GPU scale-set VMs using one fault domain limits delivery to the affected resource. Delivery scope determines who can receive a notice; `Resources` identifies the VMs facing impact.

For example, two non-GPU worker VMs in the same Uniform placement group might both observe an event whose `Resources` contains only `pool_0`. The invoice process on VM `pool_1` keeps taking jobs if no other hold applies. If one atomic operation instead explicitly lists both `pool_0` and `pool_1`, both VMs must be ready before the application approves that event. These are assumed example resource names, not values derived from a hostname or an arbitrary instance-number calculation. Don't combine event IDs merely because maintenance times coincide: Azure groups events by the operation it can act on as a unit.

For a `VirtualMachine` event, `Resources` lists the affected VMs or scale-set VM instances, not the processes or containers inside them. Match the local VM's verified event resource name against that list. Don't substitute a guest hostname, process name, or container ID. If the VM is listed, notify all worker processes running on it.

:::image type="content" source="../media/4-notice-delivery-scope.svg" alt-text="Diagram that shows two VMs seeing the same notice in a Uniform placement group. Only the VM listed in Resources prepares.":::

`EventType` describes the expected interruption. To decide whether and when to act, also check which VMs are named in `Resources`, whether `EventStatus` is `Scheduled` or `Started`, and how much time remains before `NotBefore`.

> [!NOTE]
> These fields come from a live JSON response from Azure Instance Metadata Service (IMDS), not from a file on the VM. To read them, send an HTTP `GET` from inside the VM to `http://169.254.169.254/metadata/scheduledevents?api-version=2020-07-01` with the `Metadata: true` header, bypassing any proxy. `DocumentIncarnation` is at the top level; each entry in the `Events` array contains fields such as `EventId`, `Resources`, and `NotBefore`. To keep a history after events disappear, save timestamped observations outside the VM.

Use these response fields to identify the affected resources and decide whether preparation is possible:

| Field | Operational meaning |
|---|---|
| `DocumentIncarnation` | Changes when event information changes; useful for observation, not a job deduplication key |
| `EventId` | Stable event identity for tracking preparation and approval |
| `ResourceType`, `Resources` | For `VirtualMachine`, the names of the affected VMs or scale set VM instances |
| `EventType` | `Freeze`, `Reboot`, `Redeploy`, `Preempt`, or `Terminate` |
| `EventStatus` | In IMDS, `Scheduled` or `Started`; a finished event disappears rather than returning a completed status |
| `NotBefore` | Earliest start without early approval; can be blank after start |
| `EventSource` | `Platform` or `User`, not a permission grant to bypass preparation |
| `DurationInSeconds` | Expected interruption duration; `-1` means unknown or not applicable |
| `Description` | Diagnostic context, not executable instructions |

:::image type="content" source="../media/4-scheduled-event-fields.svg" alt-text="Diagram that shows how IMDS separates the response version from the event ID and identifies which VM a scheduled freeze affects.":::

## Interpret the event's impact and preparation time

For the generally available Scheduled Events API used here, the event type identifies the expected impact. Normal scheduled delivery uses these documented notice intervals; an invoice process isn't guaranteed to observe the whole interval:

| Event type | Expected effect | Documented normal notice |
|---|---|---|
| `Freeze` | CPU execution and network connectivity can pause while memory and open-file state are preserved | 15 minutes |
| `Reboot` | Guest restart; in-memory state is lost. In rare cases the platform can use a freeze instead | 15 minutes |
| `Redeploy` | Move to another host; don't depend on temporary or other ephemeral local state surviving | 10 minutes |
| `Preempt` | Spot eviction; Deallocate or Delete determines the resource's subsequent lifecycle | 30 seconds, best effort |
| `Terminate` | Deletion of a scale-set instance with termination notifications enabled | Configured delay of 5 to 15 minutes |

Calculate preparation time from the latest valid `NotBefore` and the current observation, not from a nominal notice interval or from the moment the application first sees the event. `DurationInSeconds` describes the impact, not the time available for preparation. Polling delay consumes notice. Unexpected hardware failure can bypass the warning state, and Spot notice is best effort. The invoice processor's 30-second preparation cap is an upper bound on its own attempt, not a promise of 30 available seconds.

To use `Terminate` notifications, enable the termination-notification profile on an eligible non-Spot scale set, configure its delay, and ensure the updated model reaches the intended instances. Keep polling IMDS as well; polling alone doesn't enable that profile. These notifications concern instance deletion, including scale-in, not ordinary reboot, reimage, redeploy, or stop/deallocate operations. Don't assume this feature provides a grace period for every standalone VM deletion.

After `Terminate`, or Spot eviction with Delete, the deleted VM can't poll for event removal or rejoin. Recover its jobs on a replacement invoice process using the external ownership, checkpoint, and posting records. Keep the replacement process's intake closed while it restores those records and reconciles each invoice's authoritative posting outcome. Require two consecutive polls with no active event for the replacement VM and passing guest and application health checks, including a test lease and a synthetic result write and read. Confirm ownership before resuming unfinished jobs, and keep uncertain postings on a durable hold that prevents automatic retry. Don't wait for the deleted guest to return.

## Track event status and coordinate approval across affected VMs

An event disappears from a successful IMDS response when it reaches a terminal state. It can disappear without ever being observed as started, including cancellation before impact. A polling gap can also hide intermediate observations. Record “removed without observed start” unless you've independently confirmed the cancellation.

A failed request isn't an empty event list. If a poll times out, can't connect, or returns invalid data, keep the last known list of active events. A failed poll isn't evidence that an event ended. Likewise, a single empty result isn't proof of guest health.

:::image type="content" source="../media/4-imds-poll-timeline.svg" alt-text="Diagram that shows a scheduled event, a timed-out IMDS poll, and a later valid poll where the event is absent without an observed start.":::

Approval uses a `POST` body containing `StartRequests`, each with an `EventId`. Approval lets Azure start maintenance before `NotBefore`; it doesn't tell Azure to start immediately. Azure may still need to wait for other tenants or resources. Without approval, the operation can proceed once `NotBefore` is reached.

User-initiated reboot and redeploy operations can be configured for automatic approval through `scheduledEventsPolicy.userInitiatedReboot.automaticallyApprove` and `scheduledEventsPolicy.userInitiatedRedeploy.automaticallyApprove`. When enabled, the event proceeds directly to `Started`, skipping `Scheduled`. In that case, withholding the application's POST doesn't create a preparation interval. A first observation of `Started` can therefore reflect policy, a missed observation, or recovery that bypassed advance warning; it doesn't establish the cause on its own.

Approval applies to every VM named in the event. Designate one application coordinator to approve it. In the standalone invoice example, an event naming only `worker-a` requires readiness from that VM, not from `worker-b`. In the separate placement-group example, if one event explicitly lists both `pool_0` and `pool_1`, the coordinator waits for each VM to report readiness for that `EventId`. A readiness report for one event doesn't count for another, even if both list the same VMs.

If two invoice processes share VM `worker-a`, Azure still lists that VM only once. Both processes must stop intake and checkpoint their own jobs before the application reports VM `worker-a` ready. If either process is still processing invoices or hasn't reported back, withhold approval. VM readiness is the application's conclusion, not a status IMDS supplies.

## Observe metadata without approving anything

Run these PowerShell 7 commands inside a Windows or Linux Azure VM to read metadata from Azure Instance Metadata Service (IMDS). The first request reads the VM's name, ID, resource group, and availability zone (if assigned). The second lists the Scheduled Events visible to that VM, including each event's type, status, affected resources, and `NotBefore` time when available. With DHCP enabled in the guest, requests to `169.254.169.254` must use the primary network interface and its primary IP address. `NoProxy` sends each request directly to IMDS, and `Metadata = 'true'` sets the required header. Neither `GET` needs an Azure management token or approves maintenance. The component that polls IMDS (the *event consumer*) can run inside a worker process or as a separate guest service that notifies the local invoice processes. Only the designated coordinator should send approvals.

`Metadata: true` marks a request as intended for IMDS; it doesn't authenticate an invoice process. IMDS is available to local processes without process-level authentication. "Only the coordinator approves" is an application rule the deployment must enforce, not an IMDS permission setting. Use a trusted guest service as the sender. If other workloads in a guest aren't equally trusted, isolate them or restrict local IMDS access to the services that need it. Apply the same trust model to peers that can acknowledge the event.

Before restricting IMDS, inventory legitimate clients, including managed-identity clients. An Azure Resource Manager role assignment doesn't restrict a process's local IMDS POST, and protecting the readiness queue doesn't protect that guest endpoint.

```powershell
$imds = 'http://169.254.169.254/metadata'
$request = @{
    Method      = 'Get'
    Headers     = @{ Metadata = 'true' }
    NoProxy     = $true
    TimeoutSec  = 130  # Allow for the first Scheduled Events request.
    ErrorAction = 'Stop'
}
$identity = Invoke-RestMethod @request -Uri "$imds/instance/compute?api-version=2021-02-01"
$document = Invoke-RestMethod @request -Uri "$imds/scheduledevents?api-version=2020-07-01"

[pscustomobject]@{
    ObservedUtc = [DateTime]::UtcNow.ToString('o')
    Identity    = $identity | Select-Object name, vmId, resourceGroupName, zone
    Document    = $document
} | ConvertTo-Json -Depth 20
```

`Identity` describes the VM where the command ran. Compare its verified event resource name with `Resources` in each entry in `Document.Events`. Run the command locally on each standalone invoice VM; one VM's result isn't a view of the other VM's notices. In the separate non-GPU Uniform placement-group example, a command on `pool_1` can show an event listing only `pool_0`. The invoice process on `pool_1` then keeps taking jobs if no other hold applies; it neither drains nor approves on behalf of `pool_0`. An empty `Events` array in a valid response means no events are listed at that observation, not that maintenance will never occur. This example reads Scheduled Events once and exits. The event consumer must keep polling to see later changes.

## Choose where the maintenance response runs

An Azure Scheduled Events notice identifies an operation that can interrupt a VM and lists the affected VMs in `Resources`. For example, if an IMDS poll returns a `Reboot` event that lists `worker-a` and has `EventStatus` set to `Scheduled`, a restart is planned for `worker-a`. Its invoice process can stop taking jobs and verify that it saved checkpoints for the jobs it owns. Use a central service to notify operators or coordinate the response across VMs.

:::image type="content" source="../media/4-maintenance-response-options.svg" alt-text="Diagram that shows three response paths: checkpoint on the VM, notify through Event Grid (preview), or collect VM readiness in a queue.":::

A maintenance notice can call for local action to protect in-flight invoices, central reporting, or both:

- **Stop intake and save invoices: run inside the VM.** Scheduled Events through the Instance Metadata Service (IMDS) is generally available. Start the consumer with the invoice application or at boot as a Windows service or Linux `systemd` service. Poll about once per second. When a `Scheduled` event lists the local VM in `Resources`, each invoice process stops taking jobs and checkpoints its own invoices within the remaining time. Record progress by `EventId` and job ID so the next poll doesn't repeat a checkpoint. A failed poll isn't an all-clear. If the first notice already says `Started`, keep intake closed and reconcile jobs during recovery.
- **Notify operators or log activity centrally: use Event Grid and a serverless handler.** A remote Azure Function can't poll another VM's IMDS address. The optional Event Grid path requires registration of the `Microsoft.Compute/SendScheduledEventsPolicy` and `Microsoft.Maintenance/ScheduledEventsActivity` preview features. Confirm that registration has completed before configuring publishing.

## Publish Scheduled Events to Event Grid (preview)

Configure publishing using Azure Compute Resource Manager REST API `2025-04-01` or newer, or tooling that supports the required policy properties. This management API version is separate from the Scheduled Events payload version, which is `2020-07-01` in this integration. Set `scheduledEventsAdditionalPublishingTargets.eventGridAndResourceGraph.enable` to `true` and its `scheduledEventsApiVersion` to `2020-07-01` within the applicable `scheduledEventsPolicy`. Configure the policy on a standalone VM, or on the parent scale set or availability set for member VMs; members can't configure this policy independently. Preserve unrelated policy settings, including user-operation automatic approval.

### Set permissions for the system topic and event subscription

MaintenanceResources notifications are subscription-scoped; the resource group hosting the system topic isn't a data boundary. Have an authorized operator provision the topic and event subscription. Restrict this ability to principals authorized to read across the source subscription, and provide the required Event Grid and MaintenanceResources subscription permissions. Authorize the destination separately.

Topic creation, event-subscription creation, and source/destination authorization are separate concerns. The current Azure Resource Notifications System Topics Subscriber role includes `Microsoft.ResourceNotifications/systemTopics/subscribeToMaintenanceResources/action` and Event Grid event-subscription writes, but neither `Microsoft.EventGrid/systemTopics/write` nor ordinary subscription-wide read permission. Don't assume that role alone provisions the complete path or grant broad Contributor access just to bypass a provisioning error.

### Create the system topic and filter notifications

Create a `Microsoft.ResourceNotifications.MaintenanceResources` system topic with the Azure subscription as its source and `global` as its location, then create an event subscription to an Azure Function or Azure Logic Apps workflow. For an Azure Function endpoint, use an Event Grid trigger. This isn't the queue trigger used by the readiness collector. The handler can log a status change or notify an operator; receiving notifications doesn't grant maintenance-approval authority.

Filter notifications by the outer event type `Microsoft.ResourceNotifications.MaintenanceResources.ScheduledEventEmitted` and a verified scheduled-event subject prefix. In the documented virtual machine scale set (VMSS) payload, `subject` names a scheduled-event resource beneath the scale set, not an individual member VM's ARM ID. For a member-specific handler, validate the parent scope and map the affected `Resources` entries against the correct VM inventory. A filter selects a whole notification; it doesn't remove other affected resources, grant access, or narrow maintenance approval.

### Handle duplicate and out-of-order notifications

Event Grid delivery is unordered and can be duplicated. Deduplicate notification deliveries by the outer `id`; correlate maintenance lifecycle updates by `data.resourceInfo.properties.EventId` and read `EventStatus` from the same properties object. Don't discard every later status notification merely because it has the same maintenance `EventId`. If the event is already recorded as `Started`, `Completed`, or `Canceled`, log a late `Scheduled` update without reopening it or announcing new upcoming maintenance. Likewise, don't overwrite a terminal outcome with a delayed earlier lifecycle update; retain conflicting evidence rather than inventing a transition.

These are handler rules, not an Event Grid ordering guarantee. Successful Event Grid delivery acknowledges notification receipt, not permission for maintenance to proceed. The outer and inner IDs have different roles even if their values happen to match. Central terminal-status notifications don't change the GA IMDS consumer: in IMDS, a terminal event disappears.

**Scheduled Events delivery through Event Grid is in preview; Microsoft doesn't recommend this delivery path for production workloads.** The local IMDS consumer and queue-based readiness coordinator don't require this preview.

:::image type="content" source="../media/4-event-grid-delivery-order.svg" alt-text="Diagram that shows an Event Grid handler ignoring a duplicate delivery and keeping a completed event from reverting to Scheduled.":::

## Collect VM readiness reports before approving maintenance

When all invoice processes on a named VM have saved their checkpoints, its guest service sends an authenticated readiness report to a durable queue, separate from the invoice queue. A queue-triggered Azure Function records readiness by `EventId` and VM in a shared ledger. In the separate placement-group example, when an event lists both `pool_0` and `pool_1`, two reports from `pool_0` can't stand in for a missing report from `pool_1`. This hybrid design doesn't require the Event Grid preview.

**A notice isn't proof that an invoice was saved.** Use one logical approval coordinator per event. In the hybrid design, the Function collects fresh readiness from every VM named in the event and designates one guest service to send the approval through local IMDS. Before sending, that service rechecks the event ID, VM list, `Scheduled` status, time remaining, and readiness. If a report is missing or stale, or the deadline is too close, withhold early approval. Azure can still proceed at `NotBefore`.

:::image type="content" source="../media/4-vm-readiness-approval.svg" alt-text="Diagram that shows why two reports from one VM cannot replace fresh readiness reports from both VMs before a guest approves through IMDS.":::
