In this module, you learned how Azure Site Recovery orchestrates disaster recovery for supported Azure VMs between regions and for supported on-premises machines to Azure. You also distinguished zone-to-zone protection from regional disaster recovery. You learned where replication components run and how replication policies, recovery plans, isolated test failovers, and platform-specific failback procedures contribute to recovery readiness. Recovery-plan startup order, application readiness, and multi-VM consistency address different requirements.

For Adatum, Site Recovery addresses outage recovery, while an appropriate backup solution supplies independently retained historical recovery points. Application-level alternatives such as Azure File Sync also need a recovery and client-access plan. Choosing the solution requires checking workload support, connectivity, recovery objectives, target capacity, operational monitoring, and cost.

## Learn more

- [About Site Recovery](/azure/site-recovery/site-recovery-overview)
- [General questions about Azure Site Recovery](/azure/site-recovery/site-recovery-faq)
- [Protect your on-premises infrastructure from disasters with Azure Site Recovery](/training/modules/protect-on-premises-infrastructure-with-azure-site-recovery/)
- [Azure-to-Azure architecture and replication policies](/azure/site-recovery/azure-to-azure-architecture)
- [Hyper-V support matrix](/azure/site-recovery/hyper-v-azure-support-matrix)
- [Modernized VMware replication architecture](/azure/site-recovery/vmware-azure-architecture-modernized)
- [ExpressRoute and Site Recovery](/azure/site-recovery/concepts-expressroute-with-site-recovery)
- [Run an Azure VM disaster-recovery drill](/azure/site-recovery/azure-to-azure-tutorial-dr-drill)
- [Fail back Hyper-V VMs from Azure](/azure/site-recovery/hyper-v-azure-failback)
- [Understand Azure VM backup](/azure/backup/backup-azure-vms-introduction)
- [Azure-to-Azure recovery-point retention and pruning](/azure/site-recovery/azure-to-azure-common-questions#replication-policy)
- [Configure Hyper-V replication policies with VMM](/azure/site-recovery/hyper-v-vmm-azure-tutorial#set-up-a-replication-policy)
- [Modernized physical-server replication and recovery](/azure/site-recovery/physical-server-azure-architecture-modernized)
- [Monitor Site Recovery health and alerts](/azure/site-recovery/site-recovery-monitor-and-troubleshoot)
- [Understand Site Recovery costs](/azure/site-recovery/site-recovery-cost)
- [Choose a service for planned migration to Azure](/azure/site-recovery/migrate-tutorial-on-premises-azure)
- [Hyper-V replication architecture with and without VMM](/azure/site-recovery/hyper-v-azure-architecture)
- [Recovery-plan sequencing and application orchestration](/azure/site-recovery/recovery-plan-overview)
- [Customize recovery plans with automation and manual actions](/azure/site-recovery/site-recovery-create-recovery-plans)
- [Zone-to-zone disaster recovery for Azure VMs](/azure/site-recovery/azure-to-azure-how-to-enable-zone-to-zone-disaster-recovery)
- [Azure File Sync disaster-recovery planning](/azure/storage/file-sync/file-sync-disaster-recovery-best-practices)
- [Azure VM backup retention questions](/azure/backup/backup-azure-vm-backup-faq)
