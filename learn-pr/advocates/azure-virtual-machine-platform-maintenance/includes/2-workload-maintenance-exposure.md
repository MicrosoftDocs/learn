Mapping maintenance exposure means identifying what can stop together and what the surviving components still need. 

If VM `worker-a` pauses, invoice process B may keep running in another zone but still be unable to finish a job leased to process A. You need to be able to trace the invoice from the queue through its lease to its committed result to see which dependencies must remain available.

The example runs one worker process per VM: **invoice process A** runs on VM `worker-a`, and **invoice process B** runs on VM `worker-b`. Each process can stop taking jobs on its own, but both depend on the same queue and result store.

One application instance per VM is a deployment choice we are using in this module's example to simplify understanding. A worker process can run as a Windows service, as a Linux process, or inside a container. Several such processes can share a VM: restarting one process doesn't require restarting its neighbors, but rebooting their VM interrupts them all.

When determining maintenance exposure, Map each component's placement, shared dependencies, and preparation capability:

| Component | Placement and dependency | Preparation capability |
|---|---|---|
| Invoice process A | VM `worker-a`, one fault boundary | Stop intake and checkpoint its own jobs |
| Invoice process B | VM `worker-b`, another fault boundary | Continue only if shared queue and result store remain usable |
| Ingress tier | Load-balanced request acceptance | Continue to accept and enqueue invoices while the queue and remaining processing capacity permit |
| Queue and ownership store | Shared service outside the application processes' memory | Preserve leases and reject competing owners |
| Result store and any external posting service | Durable completion keyed by job ID; posting is atomic with completion or independently idempotent under the same job ID | Reject duplicate business effects and expose committed outcomes for reconciliation |
| Operator | Independent administrative path | Reach the VM even if the invoice process is down |

:::image type="content" source="../media/2-invoice-maintenance-responsibilities.svg" alt-text="Diagram that shows invoice process A stopping intake while process B uses shared stores and an operator accesses worker VM A.":::

## Points of failure

Placing the two worker VMs in different zones or fault domains reduces the chance that one disruption stops both. Even with this placement, both invoice processes can still lose access to a shared queue or result store. A database lock, an exhausted connection pool, or a lease held by a paused process can prevent either process from completing a job. A surviving VM also needs enough capacity for its invoice process to take on the extra jobs.

## Placement boundaries

Placement boundaries protect against different kinds of interruption. In an availability set, a fault domain groups shared infrastructure, while an update domain groups VMs that can restart together during planned maintenance. Azure-scheduled reboot maintenance restarts one update domain at a time, not necessarily in numeric order. Routine rebootless maintenance rolls through fault domains and can overlap across availability zones.

For zonal VMs, one Azure infrastructure-update deployment that requires a reboot proceeds one zone at a time. Independent deployments aren't all serialized. Zone separation reduces correlated impact; it doesn't guarantee that both invoice workers can never encounter overlapping disruption. Availability-set update-domain rules don't describe every scale-set orchestration mode.

## Load balancing limitations

The load balancer routes requests to front-end backends; it doesn't choose which invoice process receives the next queue message. To drain invoice process A, stop its new receives and account for work it's already received, including buffered jobs. Invoice process B can keep consuming while the shared dependencies are healthy. Stopping front-end routing doesn't stop a queue consumer.

When draining a front-end backend, a failed health probe can stop new connections to that backend. Existing TCP connections can continue, so the front end must also finish or safely terminate in-flight requests. This is separate from stopping a worker process's queue intake.

## Tracing the invoice process

For each job already in progress, the invoice process renews its lease while it still owns and processes the job. After saving a durable checkpoint and stopping ownership-dependent work, it can release the lease or allow it to expire under the workload's handoff policy. If renewal fails or ownership can't be confirmed, it stops ownership-dependent work and records any uncertain outcome for reconciliation. A lease expiring doesn't itself stop the old process.

Receiving an invoice message, acquiring its business lease, saving a checkpoint, and acknowledging the message are separate actions. Use a queue mode that can redeliver unacknowledged work. Don't remove the only recoverable copy of an invoice merely because a checkpoint exists or its worker VM is ready for maintenance. Normally, complete or delete the message only after the authoritative posting is confirmed and completion is durable. This is the invoice queue's settlement rule, not a readiness report or maintenance approval.

If an invoice process crashes after posting but before acknowledgment, the next process looks up the same stable job ID. When posting is confirmed, it records the existing completion and settles the redelivery without posting again. If the outcome remains unknown, put the job on a durable hold that all invoice processes respect and assign an owner to reconcile it. Retire the original message only if a durable handoff preserves the job details and responsibility for resolving it; otherwise keep it recoverable without allowing automatic reposting. These idempotent-consumer rules complement ownership checks; a broker lock doesn't replace a business lease or protect an external posting by itself.

:::image type="content" source="../media/2-invoice-job-trace.svg" alt-text="Diagram that shows how invoice workers hand off a lease and check posting by job ID before acknowledging or holding a redelivered message.":::

## Prepare invoice workers for maintenance and hand off jobs safely

An event names the VMs facing maintenance. The worker processes on those VMs stop taking jobs and save progress if time permits. Approval requires readiness from every named VM; returning an application process to service requires evidence that it can process jobs safely.

For each dependency, decide whether the invoice process can drain, checkpoint, pause, or recover independently. A completed result is durable only after its result-store transaction commits. Save each job's progress under its job ID in storage that a replacement process can read. If the only checkpoint is on the VM's temporary disk, redeploying or deleting the VM can erase it.

Keep the job ledger outside the VM. Acquire or transfer each job's lease atomically so the ownership store recognizes only one current owner. Also protect the resources that the invoice process writes: checkpoint and result operations must atomically validate the current ownership token or version and reject writes from a former owner. A separate ownership check followed by an unprotected write leaves a race.

For example, invoice process A can pause long enough for its lease to expire. Invoice process B then acquires the job. When process A resumes, the protected store must reject A's stale-owner writes, even if A hasn't yet noticed that it lost the lease. Use the selected store's supported conditional-write or fencing mechanism; don't assume a lease on one store automatically protects another. Neither an in-memory ledger nor a file on the operating system disk is a recovery plan for loss of the VM.

:::image type="content" source="../media/2-invoice-lease-handoff.svg" alt-text="Diagram that shows how VMs prepare for maintenance and how durable stores reject worker A's stale writes after worker B acquires the lease.":::

## Define a measurable health contract

The **health contract** is an agreement between the invoice application team and the VM operations team about when an invoice process may accept new jobs after maintenance. Operations checks the guest and polls for events affecting the VM. The application supplies a test transaction that leases a job and writes and reads back a result without posting a customer invoice. Intake stays closed unless both sets of checks pass on two consecutive polls.

Guest health means the machine boots, required services start, time is synchronized, and its administrative path works. Application health means the worker process can reach its dependencies, acquire and release a test lease, and commit and retrieve a synthetic result.

Rejoin means the invoice process can accept jobs again, not merely that its VM is running. The invoice processor requires two successful polls in a row that show no active event for its VM. The guest and application health checks must pass both times. A failed poll or check resets the count. Two observations are this workload's policy, not an Azure guarantee; even two passes don't establish what happened to an individual invoice.

:::image type="content" source="../media/2-invoice-health-contract.svg" alt-text="Diagram that shows guest and application checks, a two-poll health count, and invoice reconciliation before intake resumes.":::
