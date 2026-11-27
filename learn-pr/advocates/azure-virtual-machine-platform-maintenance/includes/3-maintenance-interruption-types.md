A restart tells you that a VM rebooted, not why it rebooted or whether its application had time to prepare. If VM `worker-a` restarts during an invoice run, a guest update, an operator request, and a host failure call for different responses. Check the guest's update history for patching and the Azure Activity log for an operator request; after a sudden host failure, be prepared to recover invoices without a fresh checkpoint.

:::image type="content" source="../media/3-virtual-machine-restart-cause.svg" alt-text="Diagram that shows guest update history, Activity Log, and Resource Health evidence used to identify a worker VM restart cause.":::

Assign responsibility according to what triggered the interruption, not just whether the VM rebooted.

| Operation | Primary control | What this consumer contributes |
|---|---|---|
| Host or platform maintenance | Azure platform scheduling and eligible maintenance controls | Application preparation when notice is usable |
| Guest operating system updates | Guest patch orchestration and Azure Update Manager | An additional response only when a relevant event exists |
| Operator restart or redeploy | Authorized management operation | Coordination with the change owner |
| Unexpected hardware failure | Platform recovery and application resilience | Recovery even when preparation was bypassed |
| Spot eviction or instance termination | Capacity lifecycle and configured notifications | Best-effort handoff, not a promise of survival |

## Platform updates

Most platform updates don't require a reboot. Some pause the VM or use live migration. Short pauses can still cause timeouts, retransmissions, lease expiry, and retry storms. Don't approve a freeze solely because its advertised duration looks small. Before approving a freeze, ask whether the pause could last long enough for a job lease to expire or a client request to time out.

A maintenance configuration is an Azure resource that lets you choose an update scope and set a maintenance window for the resources you assign it to. The Host scope covers platform updates that don't require a restart on eligible isolated VMs, isolated scale sets, and dedicated hosts. You can schedule these updates within 35 days, with a minimum two-hour window. The Host scope doesn't control rack-level maintenance.

> [!NOTE]
> Azure schedules host updates by default. To choose a recurring window, open **Maintenance Configurations** in the Azure portal and select **Create**. Choose the **Host** scope and select **Add a schedule**. Set the start date and time, time zone, duration, and recurrence: daily, weekly, or monthly. For example, reserve Sundays from 02:00 to 04:00 UTC. On the **Machines** tab, select the eligible resources, then select **Review + create** and **Create**. For an on-demand update, use `az maintenance update list` to check the target resource for pending updates and `az maintenance applyupdate create` to apply them. In Azure PowerShell, use `Get-AzMaintenanceUpdate` to check and `New-AzApplyUpdate` to apply.

The minimum two-hour Host window is a scheduling window, not expected VM downtime. Eligible outstanding Host updates are applied automatically after 35 days. A maintenance configuration starts updates on its assigned resources at the same time. If replica groups need separate windows and their resources support separate assignments, use a different maintenance configuration for each group. Choose nonoverlapping windows and confirm that the first group has recovered before starting maintenance on the next. Separate windows don't override mandatory maintenance limits or prevent unrelated failures.

A Host-scope maintenance configuration assigned to a dedicated host doesn't defer maintenance on VMs running on shared hosts. Confirm that the target resource supports the scope you chose and that you've assigned the maintenance configuration to it. The operating system (OS) image scope applies to scale sets with automatic OS image upgrades enabled. The Guest scope uses Azure Update Manager for updates inside the VM. Neither scope controls the physical host.

Starting updates together under one maintenance configuration doesn't mean every VM reboots at once. For example, OS image upgrades still roll through a scale set in batches. The 35-day rule applies only to Host-scope maintenance configurations.

Planned platform maintenance that requires a reboot can have a separate self-service phase before Azure's scheduled maintenance phase. A Host-scope maintenance configuration doesn't set that self-service window; it controls only eligible platform updates that don't require a reboot. Starting self-service maintenance also differs from approving an existing IMDS event. Use the published maintenance information and the VM's current eligibility to establish the actual window; don't assume every event provides a fixed 35-day self-service period.

## Planned maintenance schedule

Azure groups host updates that require VM reboots into regional maintenance waves. The published schedule gives a window, not an exact restart time for each VM. Use that window to plan invoice handoffs.

For a published reboot-maintenance wave, open **Service Health > Planned maintenance** in the affected subscription and inspect **Impacted Resources** when supplied. For a standalone VM, inspect its instance view for the self-service and scheduled windows and `isCustomerInitiatedMaintenanceAllowed`. No current maintenance record isn't an assurance against future or unexpected maintenance.

An operator signed in with Azure CLI, in the correct subscription and with VM instance-view read permission, can use this read-only query. Replace the resource-group and VM-name placeholders:

```azurecli
az vm get-instance-view --resource-group <resource-group> --name <vm-name> --query instanceView.maintenanceRedeployStatus
```

If an operator chooses an eligible self-service action, Azure redeploys the VM to an already updated node. Temporary-disk contents are lost, and a dynamic public IP address can change. Confirm the recovery route and external job state before proceeding. Early self-service isn't automatically preferable: Microsoft cautions against it for some deployments, including workloads already using Scheduled Events for proactive failover or graceful shutdown. Choose the maintenance path with the change owner rather than starting it merely to collect evidence.

## Host failure prediction

Azure can sometimes predict a potential host failure. A warning may arrive days ahead, but notice can be shorter and the host can fail before the planned move. `NotBefore` describes the scheduled operation, not how long the hardware will remain healthy. Confirm that another worker and the external stores are healthy, and promptly checkpoint or hand off work under the workload's authorized response policy. Follow the actual event and Resource Health annotation when choosing whether to await the planned move or arrange another authorized recovery action.

To find this information:

- **Operator:** In the Azure portal, open the VM's **Resource health** page. A notice about degraded host hardware can explain the risk and give a redeployment deadline. To notify the on-call team when the VM's health changes to **Degraded**, create a Resource Health alert for platform-initiated changes on that VM and attach an Azure Monitor action group that sends email or SMS.
- **Workload:** A process inside the VM polls the Scheduled Events endpoint in Azure Instance Metadata Service (IMDS). If a `Scheduled` event lists the VM in `Resources`, start preparing. `NotBefore` is the earliest the planned move can start without early approval.

If using the pending event, approve it only when every named VM is ready. Escalate missing readiness promptly instead of waiting silently for days. Keep preparation bounded and automate it where the preauthorized policy permits; a warning doesn't require an immediate manual redeploy in every case. A redeploy request and acknowledgment of an existing event are separate actions.

## Sudden hardware failure

After a sudden hardware failure, the first event visible inside the VM may already say `Started`. If the VM is unavailable, software inside it can't poll for events or checkpoint jobs. Spot preemption notice is best effort. Never claim that every failure provides usable advance notice.

The Spot VM's eviction policy determines whether you can try to restart the original VM after eviction or must use a replacement. With **Deallocate**, a restart depends on capacity, quota, and price; there's no guaranteed return time. With **Delete**, the VM and its underlying disks are deleted. In either case, a replacement invoice process needs access to the job ledger and checkpoints without relying on the original VM.

Replicate the queue and result store, and reserve enough capacity on the surviving VMs for their invoice processes to take over. Store job ownership outside the VM, back off between retries, prevent duplicate invoice postings, and keep an administrative connection that works when the application is down. Scheduled Events improves preparation opportunities; it doesn't replace these measures.

:::image type="content" source="../media/3-virtual-machine-interruption-response.svg" alt-text="Diagram that shows preparation for planned changes and invoice recovery after host failure, Spot eviction, or termination.":::
