You've learned to design recovery around an application outcome rather than a backup status. High availability handles supported component failures, replication prepares another operational copy, and retained backups provide historical recovery choices. Disaster recovery combines these mechanisms with compatible targets, independent access, and controlled decisions.

A workable protection policy accounts for usable recovery-point age, complete backup chains, offsite delay, and measured recovery throughput. It also prepares for loss of the backup service or Azure connectivity, distinguishes cyber recovery from routine restoration, and detects coverage drift as workloads change.

Infrastructure recovery adds another layer. Repair a failed member through supported orchestration while preserving retained disks and identities. For full-instance loss, distinguish management failure from operating-system or storage loss, establish a supported preservation or reconstruction path, and validate the platform before accepting restored applications.

A dependable runbook restores prerequisites before dependent services, validates data in isolation, fences the previous writer, and releases only an accepted business service. It then restores protection and reconciles management within the documented support boundaries.

The central acceptance question is: can an authorized team restore trusted service, from an appropriate recovery point, within the agreed interruption limit, when the planned failure domain is unavailable?

## More info

The concepts required for the learning activities are explained in this module. Use these references to confirm current product support and obtain environment-specific implementation procedures.

- [Azure Local VM resilience and protection-method boundaries](/azure/azure-local/manage/disaster-recovery-vm-resiliency?view=azloc-2610&preserve-view=true)
- [Azure Local release information](/azure/azure-local/release-information-23h2?view=azloc-2610&preserve-view=true)
- [Back up and recover Azure Local VMs with MABS](/azure/backup/back-up-azure-stack-hyperconverged-infrastructure-virtual-machines)
- [MABS protection matrix](/azure/backup/backup-mabs-protection-matrix)
- [MABS release notes](/azure/backup/backup-mabs-whats-new-mabs)
- [Create an Application Control supplemental policy for MABS](/azure/backup/backup-server-application-control-supplemental-policy-create)
- [Hyper-V backup consistency with MABS](/azure/backup/back-up-hyper-v-virtual-machines-mabs)
- [Trusted Launch backup and recovery restrictions](/azure/azure-local/manage/trusted-launch-vm-overview?view=azloc-2610&preserve-view=true)
- [Back up and restore Trusted Launch guest state protection keys](/azure/azure-local/manage/trusted-launch-vm-import-key?view=azloc-2610&tabs=azure-local-release-2505-and-later&preserve-view=true)
- [Hyper-V Replica overview](/windows-server/virtualization/hyper-v/replication-overview)
- [Configure Hyper-V Replica on a failover cluster](/windows-server/virtualization/hyper-v/configure-replication-failover-cluster)
- [Configure per-VM Hyper-V replication and monitor progress](/windows-server/virtualization/hyper-v/replication-virtual-machines)
- [Test failover and recover a Hyper-V replica](/windows-server/virtualization/hyper-v/replication-failover)
- [Test Hyper-V Replica connectivity](/powershell/module/hyper-v/test-vmreplicationconnection?view=windowsserver2025-ps&preserve-view=true)
- [Configure Hyper-V Replica source authorization](/powershell/module/hyper-v/new-vmreplicationauthorizationentry?view=windowsserver2025-ps&preserve-view=true)
- [Change VM replication settings](/powershell/module/hyper-v/set-vmreplication?view=windowsserver2025-ps&preserve-view=true)
- [Manual Hyper-V-to-Azure ASR deployment](/azure/site-recovery/hyper-v-azure-tutorial)
- [ASR Hyper-V-to-Azure support matrix](/azure/site-recovery/hyper-v-azure-support-matrix)
- [ASR failover and failback tutorial](/azure/site-recovery/hyper-v-azure-failover-failback-tutorial)
- [ASR Hyper-V failback requirements and restrictions](/azure/site-recovery/hyper-v-azure-failback)
- [Azure Local ASR workflow and governance caveats](/azure/azure-local/manage/azure-site-recovery?view=azloc-2610&preserve-view=true)
- [Azure Arc-enabled server agent status](/azure/azure-arc/servers/overview#agent-status)
- [Get-DPMRecoveryPoint command reference](/powershell/module/dataprotectionmanager/get-dpmrecoverypoint?view=systemcenter-ps-2025&preserve-view=true)
- [Get-DPMJob command reference](/powershell/module/dataprotectionmanager/get-dpmjob?view=systemcenter-ps-2025&preserve-view=true)
- [Query online DPM recovery points with PowerShell](/azure/backup/backup-dpm-automation#view-the-backup-points)
- [Back up and recover the MABS server and database](/azure/backup/backup-the-mabs-server)
- [Recover online data through another backup server](/azure/backup/backup-azure-alternate-dpm-server)
- [MABS and DPM support matrix, including connectivity requirements](/azure/backup/backup-support-matrix-mabs-dpm)
- [Prepare and deploy Microsoft Azure Backup Server](/azure/backup/backup-azure-microsoft-azure-backup)
- [Configure Modern Backup Storage for MABS](/azure/backup/backup-mabs-add-storage)
- [Monitor MABS protection, jobs, and recovery points](/azure/backup/backup-server-monitor)
- [Azure Backup monitoring and workload-specific alert support](/azure/backup/monitoring-and-alerts-overview)
- [Azure Local connectivity and operating requirements](/azure/azure-local/faq?view=azloc-2610&preserve-view=true)
- [Supported Azure Local VM operations](/azure/azure-local/manage/virtual-machine-operations?view=azloc-2610&preserve-view=true)
- [Prepare backup and recovery for ransomware incidents](/azure/security/fundamentals/backup-plan-to-protect-against-ransomware)
- [Microsoft Incident Response ransomware containment and recovery guidance](/security/ransomware/incident-response-playbook-dart-ransomware-approach)
- [Repair an Azure Local node](/azure/azure-local/manage/repair-server?view=azloc-2610&preserve-view=true)
- [Understand cluster and pool quorum](/windows-server/storage/storage-spaces/quorum)
- [Add a node to an Azure Local instance](/azure/azure-local/manage/add-server?view=azloc-2610&preserve-view=true)
- [Suspend and resume Azure Local cluster maintenance](/azure/azure-local/manage/suspend-resume-cluster-maintenance?view=azloc-2610&preserve-view=true)
- [Install the Azure Local operating system, including the repair exception for data drives](/azure/azure-local/deploy/deployment-install-os?view=azloc-2610&preserve-view=true)
- [Deploy Azure Local and select supported existing-data-drive options](/azure/azure-local/deploy/deploy-via-portal?view=azloc-2610&preserve-view=true)
- [Prepare Active Directory and preserve repair dependencies](/azure/azure-local/deploy/deployment-prep-active-directory?view=azloc-2610&preserve-view=true)
- [Inspect Azure Local solution health with PowerShell](/azure/azure-local/manage/use-get-solution-health-summary-powershell-command?view=azloc-2610&preserve-view=true)
- [Azure Local VM management and resource bridge recovery questions](/azure/azure-local/manage/azure-arc-vms-faq?view=azloc-2610&preserve-view=true)
- [Connected hyperconverged Azure Local baseline architecture](/azure/architecture/hybrid/azure-local-baseline)
- [Azure Local release features and platform-management changes](/azure/azure-local/whats-new?view=azloc-2610&preserve-view=true)
- [Restore the disconnected-operations control plane](/azure/azure-local/manage/disconnected-operations-restore?view=azloc-2610&preserve-view=true)
- [Reconnect resources after disconnected control-plane restoration](/azure/azure-local/manage/disconnected-operations-post-restore-overview?view=azloc-2610&preserve-view=true)
