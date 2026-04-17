## Business continuity and disaster recovery

Organization and enterprise application workloads have recovery time objective (RTO) and recovery point objective (RPO) requirements. Effective business continuity and disaster recovery (BCDR) design provides platform-level capabilities that meet these requirements. To design BCDR capabilities, capture platform disaster recovery (DR) requirements.

Modern BCDR strategies must address hybrid and multicloud environments where workloads span on-premises datacenters and multiple cloud platforms. This requires unified backup, consistent recovery processes, and coordinated failover capabilities across all environments.

### Design considerations

Consider the following factors when designing BCDR for application workloads:

- **Application and data availability requirements**:
  - RTO and RPO requirements for each workload.
  - Support for active-active and active-passive availability patterns.

- **BCDR for platform-as-a-service (PaaS) services**:
  - Native DR and high-availability (HA) feature support.
  - Geo-replication and DR capabilities for managed services.

- **Support for multiregion deployments** for failover, with component proximity for performance.

- **Application operations** with reduced functionality or degraded performance during an outage.

- **Workload suitability for availability zones or availability sets**:
  - Data sharing and dependencies between zones.
  - Impact on update domains when comparing availability zones to availability sets.
  - Percentage of workloads that can be under maintenance simultaneously.
  - Availability zone requirements for specific VM stock-keeping units (SKUs) or specialized storage tiers.

- **Consistent backups for applications and data**:
  - VM snapshots and application-consistent backups.
  - Centralized backup vaults with subscription or account-level limits on vault count and storage capacity.

- **Network connectivity if a failover occurs**:
  - Bandwidth capacity planning for dedicated interconnects (such as ExpressRoute or Direct Connect).
  - Traffic routing during a regional, zone, or network outage.

- **Planned and unplanned failovers**:
  - IP address consistency requirements, and the potential need to maintain IP addresses after failover and failback.
  - Maintaining engineering DevOps capabilities.
  - DR for secrets management services that store application keys, certificates, and secrets.

- **Data residency**:
  - Understand in-country/region guidance for data residency that specifies whether data should be kept within country or regional borders. This guidance affects your design for cross-region replication.
  - Cloud regions that reside within the same geography can help with cross-region replication to meet data residency requirements such as tax and law enforcement requirements. For more information, see [Azure cross-region replication](/azure/reliability/cross-region-replication-azure).

### Secure backup architecture

Design a ransomware-resilient backup architecture that protects backup data even if the production environment is fully compromised:

- **Immutable backup storage**: Configure backup storage that cannot be deleted or modified during the retention period. Immutability ensures backup data remains available even if administrative credentials are compromised. Most major cloud platforms and enterprise backup solutions support immutable storage policies.
- **Multi-person authorization**: Require approval from multiple administrators for critical backup operations such as disabling soft delete, reducing retention periods, or modifying backup policies. This separation of duties prevents a single compromised account from sabotaging the entire backup infrastructure.
- **Air-gapped or offline backup copies**: Maintain offline backup copies for the most critical systems, completely isolated from network-accessible storage. Air-gapped backups provide a last line of defense when online backups are compromised.
- **Regular restoration testing**: Test backup restoration procedures regularly, including ransomware recovery scenarios. Validate data integrity and measure restoration times against RTO targets. Document and rehearse the entire restoration workflow, including dependencies and sequencing.

### Hybrid and multicloud backup and recovery

Organizations with workloads across multiple environments need a unified approach:

- **Centralized backup management** across on-premises and cloud platforms. Look for solutions that provide a single management plane regardless of workload location.
- **Consistent protection policies** regardless of where workloads run. Uniform policy enforcement reduces gaps in coverage.
- **Secure connectivity** for backup traffic. Encrypt data in transit between environments and use private network paths where possible.
- **Integration with existing backup infrastructure** to avoid rip-and-replace migrations. Many organizations maintain a mix of legacy and cloud-native backup tools during transition periods.

In Azure environments, Azure Backup and Azure Arc provide this unified management. Azure Arc extends cloud management capabilities to on-premises and multicloud servers, enabling consistent BCDR policies and centralized backup management across all infrastructure.

### Design recommendations

The following design practices support BCDR for application workloads:

- **Use cloud-native site recovery for cross-region DR.**

  Cloud platforms offer native replication and recovery automation for VM workloads. These services use real-time replication to meet low RPO and RTO requirements. You can run recovery drills without affecting production workloads. Use policy-based governance to enforce replication and audit VM protection. In Azure, Azure Site Recovery provides these capabilities with built-in support for recovery testing and Azure Policy integration.

- **Use native PaaS DR capabilities.**

  Built-in PaaS features simplify both design and deployment automation for replication and failover in workload architectures. Organizations that define service standards can also audit and enforce the service configuration through policy-based governance.

- **Implement cloud-native backup with ransomware protection layers.**

  Cloud-native backup services provide integrated security features that strengthen ransomware resilience. Key capabilities to require in your backup solution:

  - **Immutable vaults**: Prevent deletion or modification of backup data for a specified retention period.
  - **Multi-person authorization**: Require multiple users to approve critical operations like disabling soft delete or modifying backup policies.
  - **Soft delete**: Retain deleted backup data for an additional period (commonly 14 days), allowing recovery even if backups are deleted.
  - **Security PIN or MFA**: Require additional authentication factors for critical operations.
  - **Encryption**: All backup data should be encrypted at rest and in transit.

  In Azure, Azure Backup provides all of these capabilities natively, including support for on-premises files, VMs, managed disks, file shares, and databases running on Azure VMs.

- **Extend management to hybrid and multicloud environments.**

  Use management plane extensions to apply consistent BCDR policies across on-premises, multicloud, and edge environments. This enables centralized backup management and disaster recovery orchestration regardless of where workloads run. In Azure, Azure Arc provides this capability for non-Azure servers and Kubernetes clusters.

- **Build redundancy into network interconnects.**

  Use multiple regions and peering locations for dedicated network connectivity. A redundant hybrid network architecture can help ensure uninterrupted cross-premises connectivity if an outage affects a cloud region or peering provider location.

- **Avoid using overlapping IP address ranges in production and DR networks.**

  Production and DR networks that have overlapping IP addresses require a failover process that can complicate and delay application failover. Plan for a BCDR network architecture that provides concurrent connectivity to all sites.

### AI considerations for BCDR

As AI systems become critical to business operations, BCDR planning must address AI-specific requirements:

- **Protection of AI assets**: Back up AI model weights, training data, configuration, and inference pipelines. These assets may be large and require specialized storage considerations.
- **Recovery procedures for AI systems**: Design recovery processes that account for AI system dependencies, data pipeline reconstruction, and service orchestration requirements.
- **Model integrity validation**: After restoration, validate AI model integrity to ensure models have not been compromised or corrupted. Establish baseline model behavior metrics for comparison.
- **AI-powered recovery operations**: AI-driven security operations tools can accelerate incident investigation and response by providing incident summarization, guided response recommendations, and automated analysis of attack patterns. These capabilities reduce mean time to detect (MTTD) and mean time to respond (MTTR).
- **Continuity planning for AI services**: Define fallback procedures for when AI-powered business services become unavailable during recovery operations. Consider degraded-mode operations that maintain core business functions without AI capabilities.
