If a VM stops halfway through an invoice job, how can another application process finish it without posting the invoice to the customer twice? The answer depends on what the application saves outside the VM. A load-balanced front end places one job per invoice on a shared queue. Invoice process A runs on standalone VM `worker-a`, and invoice process B runs on standalone VM `worker-b` in a different availability zone. A shared ownership store records which process holds each job's lease. Both processes save checkpoints outside their VMs and write to a shared result store that accepts only one result per job ID.

In this example, the stable job ID identifies the business operation: posting only one invoice to the customer. The one-posting guarantee must be enforced where that posting happens. If posting the invoice and recording completion use the same transactional store, commit them atomically under the job ID. If the invoice process calls a separate posting service, send the same stable job ID as its idempotency key on every attempt, and require that service to deduplicate the posting and provide an authoritative way to establish its outcome. A unique row in a separate result store can't undo an invoice that was already posted twice.

:::image type="content" source="../media/1-invoice-workload-architecture.svg" alt-text="Diagram that shows invoice processes on worker VMs in two zones sharing a job queue, leases, checkpoints, and results.":::

Consider an invoice processor in which each job has a stable identifier and should produce one result. After a VM restarts, the Azure portal shows it as running. The invoice processor's queue tells a different story: two invoices were processed twice, and no one knows whether a third was posted. A VM that boots on another host within an Azure datacenter after a disruption and a recovered workload aren't the same thing.

Running invoice process B on a VM in another availability zone helps it survive a disruption to the first VM. It doesn't tell process B whether to retry the third invoice. That decision depends on who owns the job, whether a checkpoint survived, and whether the result store already contains a committed result.

## Environmental prerequisites

To read maintenance notices from inside the VM, send a `GET` to `http://169.254.169.254/metadata/scheduledevents?api-version=2020-07-01` with the `Metadata: true` header. The request must bypass proxies and use the VM's primary network interface and primary IP address, with DHCP enabled in the guest. The first request enables notifications; it doesn't approve maintenance. PowerShell 7 or another HTTP client can make the request. No Azure management token or Maintenance Configuration is required.

> [!NOTE]
> The VM is the Azure resource. A maintenance notice is data that Azure provides through its built-in Instance Metadata Service (IMDS), not a separate resource you create in a resource group. A process inside the VM reads the notice; it doesn't need to deploy an endpoint or approve maintenance to read it.

### Example workload

The example invoice workload uses a load-balanced front end and two standalone worker VMs in separate availability zones. That placement is a resilience choice, not a requirement for Scheduled Events. The front end needs permission to enqueue jobs. Each worker process needs network access and permission to receive and settle queue messages, claim and renew leases, save and restore checkpoints, and commit results. Keep those records outside both VMs. The result store must enforce one result per job ID. That uniqueness protects invoice posting only if the posting and completion record commit atomically, or a separate posting service enforces the same stable idempotency key. The selected design must also support authoritative outcome reconciliation after a timeout.

### Response automation

A single `GET` returns a snapshot; it doesn't start a monitor. Configure an event consumer to start at boot, poll continuously, and notify the worker processes on the affected VM. Each process must be able to stop taking jobs and save progress within its deadline. Provide an authenticated channel for readiness reports that identify both the VM and the `EventId`. Designate one coordinator to approve the event only after every named VM reports ready.

### Test that you can recover

To make sure you can recover, before an incident occurs in production, configure a test job that can acquire a lease and write and read a result without posting a customer invoice. Keep job and event records accessible if either VM is lost. Operators need access to Boot diagnostics and an administrative route, such as Azure Bastion or a private connection, that works when the application is down. Restart permission is needed to perform an authorized VM restart, not to observe events.
