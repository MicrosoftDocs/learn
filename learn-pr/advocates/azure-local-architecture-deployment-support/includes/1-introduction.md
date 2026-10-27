Azure Local is Microsoft's distributed infrastructure platform for running virtual machines, containerized applications, and selected Azure services on infrastructure at customer-operated locations, such as datacenters, branch offices, and edge sites. It brings together local compute, storage, and networking on supported hardware. Organizations use it when workloads need local processing, low-latency access to equipment or data, or control over where application data resides.

In a connected deployment, workloads execute locally while Azure provides management integration through Azure Arc. Administrators can use Azure tools to provision and govern supported resources without moving the workload's execution into an Azure region. The customer remains responsible for the local infrastructure and its operation, including facilities, network connectivity, hardware support, and application recovery.

Depending on the deployment type and connectivity model, Azure Local can host the following workloads and service components.

| Workload or service | What runs locally |
| --- | --- |
| Azure Local virtual machines | Windows and Linux guest operating systems and their applications, using local compute, storage, and virtual networking |
| Azure Kubernetes Service (AKS) | Kubernetes clusters that orchestrate containerized applications on local infrastructure |
| SQL Server | Database services running inside supported Windows Server or Linux VMs; this isn't the same as hosting the Azure SQL Database managed service |
| Azure Virtual Desktop (AVD) | Session-host VMs that deliver Windows desktops and applications; connection brokering and connecting users still depend on the AVD service in Azure |
| Microsoft 365 Local | Exchange Server, SharePoint Server, and Skype for Business Server on supported customer-managed Azure Local infrastructure for email, document collaboration, and communications; not the entire Microsoft 365 cloud suite |
| GitHub Enterprise Local | A self-hosted GitHub Enterprise Server appliance for repositories, pull requests, code reviews, and project collaboration; workflow automation can use separately deployed self-hosted runners |
| Azure IoT Operations | Kubernetes-based services that collect, process, and route Internet of Things (IoT) data locally, including device connectors and messaging, on supported Azure Arc-enabled Kubernetes clusters; Azure management and cloud destinations retain their connectivity dependencies |

Azure Local isn't a complete Azure region installed on premises, and these services aren't available in every deployment configuration. Availability depends on the deployment type, connectivity model, service version, and applicable preview status. Supported disconnected operations provide a separately planned local control plane and a defined subset of services; support for disconnected infrastructure doesn't establish disconnected support for every workload. The deployment and workload matrix later in this module explains why service eligibility, connectivity, capacity, and support must be assessed together.

For the additional offerings, review the product-specific requirements for [Microsoft 365 Local](/azure/azure-sovereign-clouds/private/m365-local/microsoft-365-local-overview), [GitHub Enterprise Local](/azure/azure-sovereign-clouds/private/github-local/github-local-overview), and [Azure IoT Operations](/azure/iot-operations/overview-iot-operations). Their hardware, deployment, licensing, and operational prerequisites are separate from the ability to run a VM or Kubernetes cluster.

## Azure Local versus Windows Server Hyper-V failover cluster

Azure Local and a Windows Server Hyper-V failover cluster can both run local VMs and use clustering to improve their availability. The important distinction isn't simply which hypervisor runs the VM. It's the product you deploy, the supported configuration, the management and update model, and the commercial and operational responsibilities that accompany it.

This comparison concerns Azure Local deployments that support VMs and clustering. It doesn't imply that every Azure Local deployment, such as the small-form-factor preview, uses the same virtualization architecture.

> [!NOTE]
> A *virtual machine* (VM) is an isolated guest operating system and its allocated resources. A *hypervisor* runs those VMs on a physical host. A *cluster* coordinates multiple hosts so that supported workloads can use shared infrastructure and, where configured, recover from a host failure. Clustering doesn't by itself make an application continuously available.

### Understand the shared foundations

In a Windows Server Hyper-V failover cluster, Windows Server supplies the host operating system, Hyper-V runs the VMs, and Failover Clustering coordinates the VMs configured as clustered roles. A *clustered role* is a workload that the cluster manages for availability. If its host fails, the cluster can restart the VM on an eligible surviving host, provided that storage, quorum, and capacity remain available.

VM-capable Azure Local clusters use these familiar virtualization and clustering technologies as part of a more prescriptive infrastructure solution. In a hyperconverged deployment, Storage Spaces Direct pools the nodes' local drives into resilient storage. Storage Spaces Direct is also available in supported Windows Server Datacenter configurations; it isn't exclusive to Azure Local.

Both platforms require a design for surviving capacity, storage access, networking, and application dependencies. Both can use supported live migration for planned movement of running VMs. Neither platform can live-migrate a VM's running memory from a host that's already failed, and restarting a VM doesn't guarantee uninterrupted application service.

These shared foundations make existing Hyper-V and clustering skills useful when operating Azure Local. They don't make the two products interchangeable. For background, see the [Hyper-V overview](/windows-server/virtualization/hyper-v/overview) and [Storage Spaces Direct overview](/windows-server/storage/storage-spaces/storage-spaces-direct-overview).

### Compare the operating models

A Windows Server cluster is a virtualization solution assembled from supported Windows Server components, hardware, storage, and management tools. Azure Local adds a defined infrastructure product, Azure-integrated resource management, deployment-specific service capabilities, and a coordinated solution lifecycle.

The following table compares the responsibilities and constraints of these two operating models.

| Design consideration | Azure Local | Windows Server Hyper-V failover cluster |
| --- | --- | --- |
| Product boundary | A dedicated infrastructure solution with its own deployment, host-configuration, and servicing requirements | Windows Server with the Hyper-V role and Failover Clustering feature, subject to the selected release and edition |
| Hardware qualification | The exact hardware and configuration must meet the chosen Azure Local deployment's qualification requirements | Hardware must meet Windows Server certification, clustering validation, and relevant vendor compatibility requirements |
| Storage choices | Hyperconverged local storage or supported external storage, according to the selected deployment and qualified configuration | Supported shared storage, such as SAN or SMB 3 file storage, or Storage Spaces Direct where supported by the edition and design |
| Management | Azure-integrated deployment and resource management for supported services, plus supported local administration paths | Tools such as Hyper-V Manager, Failover Cluster Manager, PowerShell, Windows Admin Center, and optional management products |
| Azure connectivity | Connected deployments have Azure dependencies; supported disconnected operations are a separately planned offering | Hyper-V and Failover Clustering don't require Azure registration merely to operate; optional Azure integrations introduce their own dependencies |
| Lifecycle | Platform updates follow Azure Local solution workflows, with hardware-partner integration where provided | Windows Server servicing follows its release lifecycle; the operator coordinates operating system, driver, firmware, storage, and management-tool updates |
| Service capabilities | Includes deployment-specific integrations such as Azure Local VM management, AKS, and AVD on supported configurations | Runs supported VM workloads and can use supported hybrid integrations, but doesn't automatically acquire Azure Local-specific services |
| Commercial model | An Azure Local infrastructure service charge or eligible benefit, with guest and application rights assessed separately | Windows Server licensing under the applicable edition and agreement, with guest rights, applications, management products, and optional cloud services assessed separately |

*Server Message Block* (SMB) is a network file-sharing protocol. In a supported Hyper-V-over-SMB design, VM files reside on SMB file shares rather than on block-storage volumes presented directly to each host. The existence of that Windows Server option isn't evidence that the same storage arrangement is supported by a particular Azure Local deployment.

Don't reduce the choice to "Azure Local uses local disks, while Windows Server uses a SAN." Both product families have more than one supported storage arrangement. Instead, verify the actual configuration using the [Windows Server cluster requirements](/windows-server/failover-clustering/clustering-requirements) or the relevant Azure Local deployment guidance.

### Keep Azure Arc integration separate from platform identity

Azure Arc can connect supported Windows Server machines to Azure management services. That connection doesn't replace the host operating system, qualify the hardware for Azure Local, register the cluster as an Azure Local deployment, or supply Azure Local's solution-update workflow.

Likewise, visibility of a server in Azure isn't the same as Azure management of the full VM lifecycle. Managing the host, creating and deleting VM resources, and managing software inside a guest are separate capabilities. A Windows Server environment can use supported additional integrations, but each integration has its own scope and prerequisites.

Azure Local's host also isn't a general-purpose Windows Server application server. Keep business applications in supported VMs or service environments rather than installing arbitrary roles on infrastructure hosts. Although Windows Server is a general-purpose operating system, combining unrelated roles with production Hyper-V hosts can enlarge the failure and security boundary; a dedicated virtualization-host design is still an important consideration.

### Choose from requirements, not product familiarity

Consider an organization that needs a supported local VM platform, already operates compatible shared storage, and intends to retain its established Windows Server management and servicing processes. A Windows Server Hyper-V failover cluster can be a suitable candidate. It still requires validated hardware, appropriately licensed hosts and guests, failure-state capacity, and an application recovery design.

Now consider an organization standardizing multiple locations around Azure-based resource provisioning and governance, qualified infrastructure configurations, and Azure Local-supported workload services. Azure Local can better match that operating model, provided its connectivity, hardware, lifecycle, and commercial requirements are acceptable.

Permanent isolation from Azure doesn't by itself settle the choice. A Windows Server cluster can operate without Azure integration, while Azure Local offers supported disconnected operations with additional infrastructure and eligibility requirements. Compare the required local services and operational responsibilities rather than assuming that disconnecting a connected Azure Local cluster creates an equivalent system.

Neither option is automatically cheaper, faster, or more available. Include hardware, licensing, support, management tooling, staffing, maintenance capacity, and recovery in the comparison. A valid decision explains which operating model meets the workload requirements and which tradeoffs the organization accepts.

Finally, moving from Windows Server Hyper-V to Azure Local is a migration and platform-lifecycle decision, not a change of label. Shared virtualization technology doesn't prove that an in-place conversion or any particular VM migration path is supported. Validate the migration method, guest configuration, networking, storage, backup integration, and licensing for the target deployment before committing to the move.

## Understanding your Azure Local requirements

A branch application can need local execution without needing a locally hosted cloud control plane. A datacenter can need independent storage expansion without needing rack-scale infrastructure. These distinctions prevent expensive designs that meet a physical requirement but violate a workload or operational constraint.

Start by identifying a specific business operation that users must be able to complete, such as recording an inventory movement. Here, *transaction* means that complete operation, not just a database write. Trace everything it needs: the VM running the application, the database and storage holding its records, the identity service that authenticates the user, and the network and name-resolution services connecting these components.

Next, define what must happen when a particular component or location fails. Losing one host, one network switch, or an entire site creates different recovery requirements. For each failure, specify whether the operation must continue without interruption or may resume after a stated outage, how much data loss is acceptable, and how much workload the remaining infrastructure must handle.

For example, a requirement could be: "After one host fails, the inventory service must resume within 15 minutes, lose no committed inventory records, and support normal peak transaction demand." This is more useful than saying "the service must be highly available" because it defines measurable recovery and capacity targets. Those targets must be demonstrated by the design; redundant hosts alone don't establish that they can be met.

## Turn a business statement into a design requirement

Consider a fictional manufacturer whose regional facility runs production scheduling and a local inventory database. Factory clients must continue completing local inventory transactions during a wide area network (WAN) interruption. The organization wants Azure-based governance, but it hasn't requested operation permanently isolated from Azure.

"Keep the factory running" isn't yet a testable requirement. Rewrite it as a set of observable conditions.

| Requirement area | Example question | Why the answer changes the design |
| --- | --- | --- |
| Workload capability | Does the application require existing Windows or Linux VMs, or can it run in containers? | Not every deployment exposes the same workload services |
| Latency | Which transaction has a response-time target, and under what load? | Local placement helps only the dependencies actually placed locally |
| Locality | Must application data, backups, identity records, and diagnostics stay in a particular location? | A local data disk doesn't constrain every management or support flow |
| Connectivity | Is Azure management expected to work continuously, intermittently, or through a supported disconnected offering? | Connectivity is a product and operating-model decision |
| Resilience | Must service survive a node failure, a switch failure, maintenance, or loss of the entire site? | Different failures remove different amounts of capacity and infrastructure |
| Recovery | How much data loss and interruption can the business tolerate? | Backup, replication, application design, and recovery procedures become necessary |
| Operations | Who can restore service at night and coordinate multiple suppliers? | Staffing and support contracts are part of feasibility |

The manufacturer's initial assumptions are four candidate nodes, 960 gibibytes (GiB) of planned workload memory, existing VMs, reliable outbound connectivity, and no qualified external storage array. The design must accommodate one unavailable node at a time. You'll test these assumptions rather than treating them as an approved design.

A useful architecture decision has three parts: 

- **What's chosen**
- **Why the evidence supports it**
- **What remains conditional**. 

A procurement preference or a successful demonstration addresses only part of that decision.
