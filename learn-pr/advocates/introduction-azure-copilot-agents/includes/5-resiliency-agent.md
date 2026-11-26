Ask the Azure Copilot Resiliency agent, "Is the checkout service group prepared for an availability-zone outage?" A service group lets you assess related resources together. To check a single resource, you don't need a service group or an assigned goal. You can also ask the agent to review a design or infrastructure-as-code template before deployment.

## Interpret a zone assessment

An availability zone is a physically separate location within an Azure region. First, check that the checkout service group includes the resources checkout depends on, such as its application virtual machines (VMs) and database.

> [!IMPORTANT]
> Before assigning the group's first goal, check its usage-plan enrollment. Without enrollment, goals, posture, and recommendations have no additional Infrastructure Resiliency Manager charge. Starting [**1 December 2026**](/azure/resiliency/availability-zone-down-drill-define#prerequisites), [hourly billing applies](/azure/resiliency/infrastructure-resiliency-manager-pricing#when-a-service-group-is-billed) when a group is enrolled in a valid plan and has a resiliency artifact. A goal counts even if no drill runs. If the group is enrolled, confirm the plan's billing subscription with the owner before assigning the goal.

On the group's [**Goals and Recommendations** page](/azure/resiliency/quickstart-infrastructure-resiliency-manager), assign a zone-resilience goal if the group doesn't have one. The discovered count reflects what the person assigning the goal or triggering rediscovery could access. Seeing the count doesn't grant read access to each resource. If checkout's database is missing, ask the group owner to check membership and [discovery permissions](/azure/resiliency/goals-recommendations-support-matrix#rbac-requirements-for-goals-and-recommendations) before relying on the report.

The [assessment](/azure/resiliency/goals-recommendations-assign-goals-view-posture#view-resilience-summary) distinguishes three results:

- **Zone resilient** means Azure detected a [recognized zone configuration](/azure/resiliency/goals-recommendations-support-matrix), such as a VM scale set with instances in multiple zones, or someone attested that a custom solution protects the resource.
- **Non zone-resilient** means Azure evaluated the resource but didn't detect a zone-resilience solution. Review the recommendation or verify a custom solution with its owner.
- **Not evaluated** means the resource is unsupported or was excluded from the assessment. It doesn't mean the resource is protected.

None of these results proves that a customer can complete checkout during an outage. An [availability set](/azure/virtual-machines/availability-set-overview), for example, spreads VMs across fault and update domains to limit the impact of hardware failures and planned maintenance. It doesn't protect against losing a whole zone.

Even a good zone assessment doesn't show that the app can recover from a region outage. Plan and test regional recovery separately. For example, Azure Site Recovery can replicate an eligible VM to a [supported target region](/azure/site-recovery/azure-to-azure-support-matrix#region-support) that meets the app's needs. The target doesn't have to be the Azure-paired region.

Before acting on a recommendation, check [what the resource type supports](/azure/copilot/resiliency-agent#enable-resilience-and-generate-scripts). For some resource types, the agent can enable zone resilience in place after you confirm. For an existing VM that needs redeployment, the agent provides migration guidance and scripts instead. It can't switch a running VM to zone-redundant operation.

## Check and enable VM backup

Ask, "Which checkout VMs show no Azure Backup protection?" The agent reports on [supported protection solutions](/azure/resiliency/resiliency-support-matrix). A missing record doesn't rule out a third-party backup. Check that product's catalog before enabling another backup.

For the backup example, use `checkout-vm`: it has a persistent OS disk, meets the [Azure VM backup requirements](/azure/backup/backup-support-matrix-iaas), and isn't using zone-to-zone Site Recovery. Azure VM Backup doesn't support VMs with [ephemeral OS disks](/azure/virtual-machines/ephemeral-os-disks#unsupported-features). Check the VM's existing protection before starting the [guided backup workflow](/azure/resiliency/tutorial-manage-data-using-copilot#configure-backup-for-azure-vms):

1. Check your [backup permissions](/azure/backup/backup-rbac-rs-vault#minimum-role-requirements-for-azure-vm-backup). To enable protection with an existing policy, the built-in roles are **Backup Operator** on the vault's resource group and **Virtual Machine Contributor** on the VM, or equivalent permissions.
1. Ask, "Help me configure backup for checkout-vm." Select the VM and a compatible **Recovery Services vault** in the VM's region. Before confirming, check the vault's [storage redundancy](/azure/backup/backup-create-recovery-services-vault#set-storage-redundancy) with its owner. Once backup is configured in a vault, its normal redundancy selector is disabled. If the setting doesn't meet checkout's requirements, stop and select an approved vault.
1. Choose an approved policy, or create one if you have **Backup Contributor** on the vault or equivalent permissions. Review the VM, vault, schedule, and retention, then confirm. This enables protection; it doesn't immediately create a recovery point.
1. Open the VM's backup item in its **Recovery Services vault** to check protection. With VM-scoped permissions, the VM's own **Backup** page can show **Enable Backup** even for a protected VM. Don't enable it again or request broader access just to change that display.
1. Wait for the first scheduled backup, or select **Backup now** on the vault's backup item, choose the retention, and confirm. On-demand backup requires **Backup Operator** on the vault or equivalent permissions. **Initial backup pending** is expected until the first backup finishes.
1. Check the first **backup job**, not just the configuration notification. If the job failed, investigate the failure. If it succeeded, verify that checkout-vm has a recovery point with the expected time and retention. Also check vault security settings such as soft delete.

> [!NOTE]
> A successful job and a recovery point confirm that backup ran, not that checkout can meet its recovery objectives. If you need that assurance, ask the backup and application owners to [test a restore](/azure/well-architected/reliability/reliability-test#backup-and-restore) in an approved, isolated environment. Have them compare data completeness and elapsed recovery time with those objectives. Don't restore over the live VM.

For [Azure SQL Database](/azure/azure-sql/database/automated-backups-overview?view=azuresql&preserve-view=true), the service takes automatic backups; review retention and recovery settings on the database. For [SQL Server running in an Azure VM](/azure/backup/backup-azure-sql-database), database-level backup is a separate option from backing up the whole VM.

## Prepare a zone-down drill

Drills and recovery plans require enrollment. Enrolling a group that already has a goal meets both billing conditions. Ending a drill doesn't stop charges while the group stays enrolled with that goal. If the owner wants only the free posture features, remove **that group's enrollment** with their approval, not the shared plan.

For an enrolled group, the agent can help [prepare a zone-down drill](/azure/resiliency/goals-recommendations-use-agent#prerequisites-for-drills-and-recovery-plans). To execute it, you need at least one existing service-level indicator (SLI) or Azure Monitor health model. Choose one that shows checkout health, such as the percentage of successful checkout requests. The agent can attach it but can't create it. If any selected resources need manual failover, have a recovery orchestration plan ready.

For this drill, use two different VMs, `checkout-db-z1` and `checkout-app-z1`, already protected by zone-to-zone Azure Site Recovery. This configuration supports [file-level backup and restore, not disk- or VM-level backup and restore](/azure/site-recovery/azure-to-azure-how-to-enable-zone-to-zone-disaster-recovery#prerequisites). Don't use the whole-VM backup configuration from `checkout-vm` for these VMs.

Configure the [recovery orchestration plan](/azure/resiliency/recovery-orchestration-plan-create-configure#include-a-resource-in-the-plan) for the two protected VMs:

1. Explicitly include each protected VM, not its passive replica. For each VM, select **Azure Site Recovery** and supply the cache storage account required for reprotection.
1. Under **Start group order**, put `checkout-db-z1` in the first group and `checkout-app-z1` in the next. [Groups run in sequence](/azure/resiliency/recovery-orchestration-plan-create-configure#create-and-order-groups); VMs in the same group fail over in parallel.
1. Checkout needs the database to accept connections, not just the database VM to start. Add a [manual post-step](/azure/resiliency/recovery-orchestration-plan-create-configure#add-a-manual-step) to the database group. During failover, the database owner checks connectivity before acknowledging the step and resuming the plan.
1. Select **Review + Update > Update** to save the plan, then recheck its readiness before the drill.

Creating the plan doesn't enable replication. Failover uses the [Site Recovery replica](/azure/resiliency/recovery-orchestration-plan-support-matrix#supported-protection-solutions); it doesn't restore a database backup. A zone-redundant Azure SQL Database handles its own zone failover.

In [**Drills scope**](/azure/resiliency/availability-zone-down-drill-define#review-and-configure-resources-for-the-drill), compare the included and excluded resources with the checkout dependencies. In **Fault designer**, check which targets are prepared for fault injection and which are intentionally excluded. Check **Identity and permissions** for role-assignment errors. After edits, refresh the drill and select **Overview > Resync and check readiness**. Resolve any **Not Ready** errors and rerun the check. **Ready** applies only to the configured targets.

The [native VM fault](/azure/resiliency/availability-zone-down-drills-support-matrix#supported-resource-types-and-native-faults) shuts down the targeted VMs and can interrupt checkout. For `checkout-db-z1` and `checkout-app-z1`, confirm each VM's active source region and map its logical zone to its [physical zone](/azure/reliability/availability-zones-overview#physical-and-logical-availability-zones) using its subscription's mapping. Don't infer the zone from `-z1`. Ask the workload owner to approve both targets, the region and physical zone, and the interruption. Agree on the expected checkout success rate, when to stop, and who will recover checkout.

Once the drill is **Ready** and the owner approves, an authorized operator can [execute the drill](/azure/resiliency/availability-zone-down-drill-execute#execute-the-drill) in the Azure portal, not in chat:

1. On the drill's **Overview** page, select **Execute drill**.
1. After the recovery plan passes its readiness check, select the source region and zone in **Drill execution**.
1. Check that the selection matches the approved region and physical zone for both VMs and that the fault targets are exactly the two approved VMs. If anything differs, stop. Otherwise, select **Execute fault injection**.

Watch the selected SLI or health model and test checkout before marking each stage complete. If checkout misses the agreed threshold, don't advance just because the infrastructure job finished. Record the time, affected resources, and failed check. Have the recovery owner follow the agreed procedure and verify the active zone, client traffic, and replication state.

When it's safe to continue, use the failover stage of the same drill job. Don't start a separate failover.

If you're running [**Failover** from the recovery plan](/azure/resiliency/recovery-orchestration-plan-execute#execute-failover) instead of a drill, use **Review zone mapping** and check **Resources qualified for operation** and **Resources skipped for operation**. Being in drill scope doesn't guarantee eligibility. Confirm only when both checkout VMs qualify and you've selected both. If either is missing, stop and investigate the skip reason rather than failing over one tier alone.

After drill failover, verify that the newly active database and application VMs are both in the service group and recovery plan and [qualify for reprotection](/azure/resiliency/recovery-orchestration-plan-execute#reprotect-resources-after-failover). If either VM is missing or shows **Needs Attention**, stop and check whether its failover succeeded. Have the recovery owner correct the membership or missing permissions for the plan's identity, as needed. Recheck both VMs rather than granting the operator broader access.

Use the same drill job's reprotection stage. Successful checkout traffic doesn't prove that replication is healthy. Before reverse failover, verify healthy replication from both newly active VMs to the original zone.

When returning to the original zone, follow the [reverse failover and reverse reprotection steps](/azure/resiliency/availability-zone-down-drills-about#drill-execution-lifecycle). Test checkout again and verify healthy replication for both VMs from the original zone to the recovery zone.

:::image type="content" source="../media/resiliency-replication-direction.svg" alt-text="Diagram that shows which zone receives VM replicas before the drill, after failover and reprotection, and after failback and reprotection.":::

After drill operations finish, use [**End execution**](/azure/resiliency/availability-zone-down-drill-execute#end-the-drill-execution-process) to attest what happened. Record any missed objective or unresolved recovery work and save the drill report. Attestation doesn't stop a fault, restore checkout, or reestablish replication.

## Reassess after a change or drill

After you change the app or complete a drill, check whether the group's membership changed. If it did, select **Re-discover resources** on the group's **Goals and Recommendations** page first. Then ask the agent to [reassess the service group](/azure/resiliency/goals-recommendations-use-agent#reassess-your-application) against its zone-resilience goal and review the remaining gaps. Download and keep the reports if you want to compare assessments over time. The agent runs assessments on demand, not continuously or as a built-in release check.
