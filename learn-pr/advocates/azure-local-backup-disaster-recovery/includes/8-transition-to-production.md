A production transition changes which system is authoritative. *Ownership of writes* is the authority to accept and save changes to production data, such as creating orders or updating existing records. In this recovery design, either the original service or the recovered service holds that authority, not both. This applies to changes made by users, background jobs, and integrations.

Before the recovered service accepts production changes, the recovery team must prevent the original service from accepting them and explicitly authorize the handover. Otherwise, both copies might accept different orders or conflicting updates, leaving two versions of the business data that must be reconciled. A recovered VM being ready to run doesn't automatically give it ownership of writes.

## Distinguish test, planned, and unplanned failover

The type of failover depends on whether you're testing recovery or moving production service, and whether the source system is still available:

- A *test failover* evaluates a recovery copy in isolation. Production remains authoritative. The test mustn't introduce a second live writer, and its temporary artifacts must be cleaned up using the product's supported procedure.
- A *planned failover* coordinates an orderly handover while the source is available. The team quiesces the application, shuts down or stops the source as required, transfers final changes, and activates the destination. *Quiescing* means bringing writes to a controlled state so that outstanding work can complete or be safely paused.
- An *unplanned failover* uses an available recovery point when the source can't be operated normally. Some changes mightn't have reached the destination. Record the selected point, the expected loss, and the authority accepting that risk.

Disk replication doesn't preserve running memory. Applications must recover their on-disk state and reestablish connections at the destination.

## Fence the previous writer

*Fencing* prevents the previous source from writing or serving production after the new copy becomes authoritative. Without fencing, both copies might accept transactions. This condition is often called *split brain*, and it can create divergent data that's difficult to reconcile.

An unreachable source isn't necessarily stopped. A network partition can hide a healthy server, and an old VM can restart when power returns. Use the approved infrastructure and application controls to prevent that copy from becoming active unexpectedly.

In Azure Site Recovery, an option to shut down the source before failover is an attempt, not proof of fencing. The documented failover process can continue if shutdown fails. Require independent confirmation of the source state or an approved alternative fencing mechanism.

## Release only the validated service

Use the following runbook to make the handover explicit.

1. Confirm the selected recovery point, accepted data-loss risk, validation evidence, and named release approver.
1. Confirm that the previous production writer is fenced and that the destination is the sole authorized writer.
1. Apply approved routing, firewall, load-balancer, and DNS changes. Account for cached name-resolution results and dependent systems that retain connections.
1. Enable approved application jobs and integrations in the required order. Observe representative business transactions and error rates.
1. Record the time at which the business owner accepts the defined service. Don't stop the recovery clock at VM startup if application validation or user access is still incomplete.
1. Establish protection for the new production location and verify new backup or replication evidence. Track any unprotected interval as a residual risk.

Some products have an explicit commit operation. For Azure Site Recovery failover, validate before **Commit** because committing removes other available recovery points and ends the option to change the selected point through that workflow. Don't treat commit as a harmless acknowledgment.

## Separate reprotection from failback

*Reprotection* establishes the ability to recover the workload from its new production location. *Failback* is a later controlled handover to the original location or a supported replacement. Neither occurs just because the original hardware is repaired.

During operation at the recovery site, new transactions accumulate there. Failback must synchronize that authoritative state to a supported destination. Reusing the old source disks without synchronization can discard valid business changes.

For Hyper-V-to-Azure ASR, failback uses the documented planned-failover workflow from Azure to on-premises. Prerequisites include a running, connected destination host and completion of the required failover and commit stages. After the returned workload is validated and committed, **Reverse Replicate** restores the on-premises-to-Azure protection direction.

Failback options and restrictions are product-specific. For example, Azure Site Recovery alternate-location failback isn't available through recovery plans, and the alternate-location procedure includes Azure VM and disk deletion at commit. A runbook must identify such irreversible points before execution. Don't cancel synchronization or reactivate an old VM as an improvised rollback.

## Reconcile local service and Azure management separately

Recovery of the application and recovery of Azure management are distinct outcomes. Azure Local VM lifecycle management, the guest's Azure Arc connection, extensions, policy, and monitoring are related but aren't the same control surface.

General resilience guidance discusses registration and reconnection after certain cross-cluster recoveries. Product-specific guidance can be narrower. MABS alternate-location recovery and Trusted Launch cross-instance recovery have explicit unmanaged or local-management restrictions. The general guidance doesn't override those restrictions, and there's no universal conversion command.

Use this sequence to reconcile management through supported product interfaces.

1. Match the restored local VM identity to the intended workload and destination. Record whether the chosen recovery route supports Azure Local lifecycle management. Prevent duplicate onboarding and duplicate production writers.
1. For an eligible same-instance recovery, inspect the existing Azure resource and guest Azure Arc connection. Distinguish a disconnected agent from an unsupported restored-VM management model.
1. If cross-instance reconnection is supported for the exact product and build, use its approved procedure. Confirm the destination custom location, storage path, logical network, and applicable resource metadata. If the route is unsupported, retain the documented local-management boundary and escalate.
1. Reconcile tags, role assignments, policy, monitoring, extensions, backup enrollment, and application ownership with the approved inventory. Confirm that alerts and operational ownership now cover the active workload.

The Azure Local guidance refers to Azure Arc's 45-day reconnection window for eligible in-place restoration or failback. This is an identity and connectivity consideration, not a backup retention limit. An Arc-enabled server that remains disconnected can reach an expired managed-identity state depending on its credential-renewal timing. Don't assume that an old connection remains valid indefinitely.

## Account for governance changes during Azure failover

When an Arc-managed workload fails over to Azure through the documented Azure Local Azure Site Recovery route, management visibility changes. Arc-installed extensions don't become Azure VM extensions that you can manage through the Azure VM resource. Guest Configuration policies have documented limitations during failover.

Log context also changes. Logs generated in Azure are associated with the Azure VM resource, while historical logs remain associated with the Arc-enabled server resource. A dashboard filtered to one resource ID can therefore omit part of the incident history.

Don't install a second guest-agent extension-management stack to make the portal look complete. Follow the Azure Site Recovery caveats, especially if failback is intended. The guidance recommends against installing the Azure VM Guest Agent for that return scenario unless the documented extension-management precautions are applied.
