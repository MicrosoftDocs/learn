**Rejoin** means the invoice process starts accepting jobs from the queue again after maintenance. A VM reboot alone isn't enough: two consecutive polls must show no active event for that VM, and both the guest and application health checks must pass each time. Before taking new jobs, the process must also account for its earlier invoices so none is posted twice.

## Check readiness to reopen intake

A VM can be running again while the outcome of the last invoice handled by its application is still unknown. Before invoice process A accepts new jobs, confirm that fresh polls show no active event for its VM, test that the process can write and read a result, and reconcile each invoice it owned. If you can't establish whether an invoice was posted, record it as unresolved rather than retrying it automatically.

A replacement process doesn't inherit a job's lease just because it runs on the same VM. Whether it resumes on the original VM or takes over on another, keep intake closed while it restores state, checks health, and accounts for its invoices.

Use this sequence to decide when the invoice process can safely accept new jobs:

1. **Restore state before accepting work.** Read the durable event records, including pending checkpoints, deadlines, approvals, active events, and any quarantine decision. For each write the invoice process recorded as pending, look in the checkpoint store to see whether that specific write completed. A pending entry doesn't mean the write failed. A process restart is neither a new event nor proof that a write completed.
1. **Check the guest and its dependencies while intake stays closed.** The invoice processor requires two successful polls in a row with no active event for this VM. At each poll, confirm administrative access, required services, and clock synchronization. Use a test job that can't post a customer invoice: acquire its lease, write and read back a test result, then release the lease. If either poll or any guest or application check fails, restart the count.
1. **Reconcile each owned job by its stable ID.** Query the authoritative posting outcome, not just a local attempt log. If the posting committed, durably record completion and settle any redelivery without posting the invoice again. If no posting exists and ownership is confirmed, resume a durable checkpoint or retry using the same stable idempotency key within its supported retry horizon. Each later ownership-dependent write must still pass the destination's atomic ownership check; a successful ownership read isn't a guarantee for future writes. Retain checkpoints until completion is confirmed. If a separate posting might've succeeded and can't be verified, put the job on a durable hold that every invoice process respects and name an owner to investigate. Keep the message recoverable unless a durable reconciliation handoff preserves the job details and responsibility for resolving it. Don't infer that posting failed merely because a separate completion record is absent.
1. **Reopen intake only when the evidence still holds.** Check for new events and confirm health again before resuming queue acquisition. Keep the invoice process out of service if it could pick up an unresolved invoice again or if you still can't tell which VM an event names. If a retry finds that the first attempt already posted the invoice, the process skips posting it again. There were two attempts but only one posting.

:::image type="content" source="../media/6-reconcile-invoice-outcomes.svg" alt-text="Diagram that shows when to settle a redelivered message, resume a job with confirmed ownership, or hold an invoice whose posting is uncertain.":::

## Worked example: one event disappears and another has started

A scheduled event lists only VM `worker-a`. Invoice process A stops taking jobs and checkpoints its two invoices before the deadline, but its readiness report doesn't reach the coordinator before the cutoff. The coordinator sends no approval. The next poll times out. The event consumer retains the event record, and process A keeps both checkpoints: a timeout says nothing about what Azure did.

The next valid document no longer lists the first event but shows a second event for VM `worker-a` already `Started`. The consumer records the first as *removed without observed start*. Because the previous poll timed out, it can't tell whether Azure canceled the first event or whether it started and finished between polls. Invoice process A stays drained. It doesn't attempt late preparation, and the coordinator doesn't approve the second event.

When the second event disappears, the first application check can't reach the result store. Invoice process A keeps intake closed. After two healthy polls with no event for VM `worker-a`, process A confirms it still owns both leases. It resumes each invoice from its checkpoint using ownership-checked writes and the same stable posting key, verifies one committed result per invoice, and settles the invoice messages before accepting new jobs. **Two results and zero approvals** is the correct outcome: the results account for the work, and neither event was safe to approve.

:::image type="content" source="../media/6-invoice-recovery-timeline.svg" alt-text="Diagram that shows why the coordinator approves neither event and the worker waits for two healthy polls before recovering both invoices.":::

## Distinguish a guest restart from application recovery

Use an existing authorized maintenance record rather than inducing a restart to collect evidence. For a planned restart, the change owner identifies the subscription, resource group, VM, operator, interruption window, and maximum wait. The operator needs restart permission at the appropriate scope; that permission doesn't grant network or role-assignment rights. Before the restart, confirm that you can view the VM's **Boot diagnostics**. Also confirm that you can sign in through Azure Bastion or a private administrative connection without relying on the invoice processor. Run Command depends on the guest agent and isn't sufficient as the only recovery route.

Before relying on a planned restart to exercise advance-notice preparation, inspect the applicable Scheduled Events policy on the VM, scale set, or availability set. Record whether user-initiated reboot is automatically approved. If it is, prepare the invoice processes before the authorized operation rather than expecting a `Scheduled` interval. Don't change the policy as part of an unapproved test. A guest that reboots successfully still hasn't demonstrated application rejoin.

### Compare restart and recovery evidence

Collect separate evidence for the management operation, guest restart, and application recovery:

| Evidence | What it establishes |
|---|---|
| Administrative restart start record and final status in **Activity log** | Correlate the VM resource ID, UTC interval, and operation/correlation ID where available. The start record identifies Azure's processing of the operation; its `eventTimestamp` is when the service generated that record, not an exact operator-click or guest-reboot time. The final operation status doesn't prove application recovery. A restart can wait for Scheduled Event approval or `NotBefore` unless applicable policy bypasses preparation. |
| Linux: `uptime -s` and `systemctl --failed`; Windows: `(Get-CimInstance Win32_OperatingSystem).LastBootUpTime` and `Get-Service WindowsAzureGuestAgent` | Compare with the pre-change baseline. A changed boot time confirms a reboot; service status helps identify guest problems. Neither says whether an invoice committed. |
| Successful reconnection and a fresh IMDS `GET` | The administrative path and metadata endpoint respond. If that's all you know after confirming the reboot, record *guest restart verified; application rejoin not verified*. |
| Successful application transaction and reconciled job ledger | The worker process can reach the queue and result store. Its ledger shows which jobs finished, which can safely resume, and which need investigation. Use this evidence for the rejoin decision. |

Administrative Activity Log records distinguish operations that begin processing from their final success or failure. Resource Health details can arrive later; neither an empty health view nor a successful management operation proves there was no platform impact or that invoices recovered.

:::image type="content" source="../media/6-restart-evidence.svg" alt-text="Diagram that shows a successful restart and a reachable guest, but a failed test transaction keeps the invoice worker from reopening intake.":::

### Handle a verification timeout

If the maximum wait expires, preserve the observations off the VM and use the approved recovery route. Don't send blanket approvals, repeatedly restart the guest, or interrupt a host or zone to obtain evidence.

## Troubleshoot and recover safely

First distinguish a failure in the invoice process from a failure of the VM. Restarting the process affects the application; rebooting the VM interrupts every process in the guest.

Match each symptom to the evidence and safe response it requires:

| Symptom | Diagnostic reasoning and safe response |
|---|---|
| Metadata request fails | From inside the VM, confirm that the request goes directly to `169.254.169.254` through the primary interface and primary IP, with DHCP enabled and no proxy. Include `Metadata: true`. The first Scheduled Events request can take up to two minutes to return. |
| Previously observed event vanishes | Require a successful fresh response; distinguish removal from transport failure and avoid asserting unobserved cancellation |
| Consumer restarts | Restore the ledger, including pending preparation and approval attempts. Before retrying an invoice, look up its job ID in the authoritative posting store or service. If the posting already committed, record the job as complete instead of posting it again. Keep uncertain posting outcomes out of automatic retry. |
| Preparation exceeds budget | Stop cancellable work, withhold approval, preserve unresolved ownership, and notify the operator |
| Event fields conflict | Preserve both documents, verify the resource map, and reconcile jobs. Only an authorized operator releases quarantine; a later empty response doesn't clear it. |
| Health never recovers | Keep intake closed; inspect boot, service, dependency, and synthetic transaction evidence independently |
| Duplicate results appear | Stop intake and compare job IDs, leases, attempts, and result transactions. Deduplicating event IDs doesn't deduplicate invoices. |

## Retain event and invoice records

Keep a compact record of handled event IDs and outcomes long enough for a restarted consumer to recognize duplicates, then expire it under an explicit retention policy. Limit log volume, retries, checkpoint size, and dependency timeouts so maintenance preparation can't consume the surviving fleet's capacity.

Keep invoice-posting and deduplication evidence for the full period in which retries or authorized manual replays can occur, including replay from a dead-letter or reconciliation queue. Ensure that the downstream idempotency and outcome-reconciliation contract covers any permitted repeat call. Expiring an event log doesn't authorize deleting invoice-completion evidence. If an old job falls outside the supported retry horizon, require reconciliation rather than treating an absent marker as proof that it wasn't posted.

:::image type="content" source="../media/6-record-retention-windows.svg" alt-text="Diagram that shows why invoice posting evidence must remain available for a permitted replay even after the maintenance event record expires.":::

### Log the recovery timeline

Record the time of each observation in UTC and store the log outside the affected VM so the next operator can read it even if the VM is unavailable. For each event, list its `EventId` and the VM names from `Resources`. Separately record which worker processes ran on each VM and which jobs each process owned. Record when preparation began and when it was confirmed complete. Log the approval decision and any response, or explain why approval was withheld. Distinguish when the interruption was first observed, when each invoice process began recovery, and when it resumed taking jobs. For each job, record its attempts and checkpoints. If it finished, record the committed result ID. If its outcome is unknown, name the person responsible for investigating. Record when the event consumer first saw `Started`, not when you think maintenance began. If no poll saw `Started`, leave the start time unknown. Retain the minimum necessary evidence without credentials or customer payloads.
