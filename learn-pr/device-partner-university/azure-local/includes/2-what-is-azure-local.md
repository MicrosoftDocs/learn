Azure Local is a cloud-managed infrastructure solution that allows organizations to run virtual machines and services on-premises while maintaining centralized control through Azure. It's designed for scenarios where workloads need to stay local—for performance, compliance, or connectivity reasons—but still benefit from the tools and services of the Azure ecosystem.

Typically deployed in branch offices, data centers, or edge environments, Azure Local enables businesses to host and manage compute, storage, and networking resources locally, while integrating with Azure for monitoring, backup, updates, and security.

## How Azure Local works

Azure Local is a cloud-connected platform that enables organizations to run virtualized workloads on-premises while taking advantage of Azure for centralized management, security, and scalability. It's built on hyperconverged infrastructure (HCI), which combines computing, storage, and networking into a single, integrated system.

### Core components

Azure Local includes several key components that work together to deliver high performance and resilience:

- *Hyper-V*: The built-in virtualization engine that runs Windows virtual machines.
- *Software-defined storage*: Pools local disks across servers to create shared, high-availability storage.
- *Software-defined networking*: Manages virtual networks, load balancing, and network security policies.
- *Failover clustering*: Ensures workloads continue running even if a server in the cluster fails.
- *Windows Admin Center*: A web-based interface for managing and monitoring the local environment.
- *Azure Arc integration*: Connects the on-premises environment to Azure for policy management, security, monitoring, backup, and updates.

These components are typically deployed as a cluster of 2 to 16 servers, allowing workloads to automatically shift to another node during a hardware failure.

### Management tools

Azure Local can be managed both on-premises and from the cloud, giving you flexibility in how you operate your infrastructure:

- **Windows Admin Center**: Used locally to configure, manage, and monitor servers, storage, and virtual machines.
- **Azure Portal (via Azure Arc)**: Enables centralized policy enforcement, monitoring, update management, and back up from the cloud.
- **Azure Monitor and Log Analytics**: Collects and analyzes system performance and health metrics.
- **Azure Backup and Site Recovery**: Protects data and ensures business continuity through cloud-based backups and disaster recovery options.

### Scenario: Running a branch office workload

Imagine a retail company with dozens of branch offices. Each location needs to run local applications (like point-of-sale systems) but also wants central IT to monitor system health, apply security policies, and back up data.

![Shop owner updates inventory using a laptop in a pottery studio.](../media/store.png)

With Azure Local:

- Each office runs virtual machines locally on Azure Local clusters.
- Local apps operate with low latency and continue functioning during internet outages.
- Azure Arc enables central IT to apply consistent security policies and perform backups from the cloud.

### Security and Resilience Features

Azure Local is designed for secure and continuous operation:

- Cluster-aware updating reduces downtime during system updates.
- Storage mirroring protects against disk or server failure.
- BitLocker encrypts data at rest.
- Secure Boot and shielded virtual machines ensure only trusted software runs.
- Integration with Microsoft Defender for Cloud adds a layer of threat detection and policy compliance.