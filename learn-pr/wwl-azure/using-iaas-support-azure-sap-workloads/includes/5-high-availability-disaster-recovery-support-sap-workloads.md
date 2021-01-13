Resource redundancy is the general theme in highly available infrastructure solutions. For enterprises that have a less stringent SLA, single-instance Azure VMs offer an uptime SLA. In a distributed installation of the SAP application, the base installation is replicated to achieve high availability and disaster recovery. For each layer of the architecture, the high availability and disaster recovery design varies.

High availability of SAP workloads on Azure VMs can be analyzed in two different contexts:

**High availability of SAP workloads**– which, in case of NetWeaver-based deployments, comprises of: 

* SAP application servers

* SAP ASCS/SCS instance

* DBMS server

**High availability capabilities of Azure infrastructure**, which includes:

* Azure VM restart capability (playing particularly important role in single-VM scenarios). 

> [!NOTE]
> It is important to note that these two contexts complement each other, so your design should combine benefits provided by each of them.

The following high availability provisions are available to Azure VM-based deployments:

* **Windows Server**: Microsoft supports Windows Server Failover Cluster in Azure virtual machines with replication for non-shared storage. Whereas SAP does not test its applications with replication for non-shared storage, Microsoft guarantees full transparency of this technology for SAP applications. Therefore, SAP applications following the guidelines on how to set up HA configurations for SAP NetWeaver applications on Azure. 

* **SUSE Linux Enterprise Server for SAP Applications**: SUSE and Microsoft support the SUSE Linux Enterprise Server for SAP Applications based cluster for HANA System Replication and SAP NetWeaver ASCS.

* **Red Hat Enterprise Linux HA Add-on**: Red Hat and Microsoft support the Red Hat Enterprise Linux HA Add-On for HANA System Replication and SAP NetWeaver ASCS.

When evaluating high availability and disaster recovery requirements, consider the implications of choosing between 2 tier and 3 tier architecture. In 2-tier configurations, the database and NetWeaver components are installed on the same Azure VM to avoid network contention. In 3-tier configurations, database and application components are installed on separate Azure VMs. This choice has also additional implications regarding sizing, since 2-tier and 3-tier SAPS ratings for a given VM SKU differ.

Microsoft supports the following SAP HANA high-availability and disaster recovery capabilities:

* **Storage replication**: The storage system's ability to replicate all data to another HANA Large Instance stamp in another Azure region. SAP HANA operates independently of this method. This functionality is the default disaster recovery mechanism offered for HANA Large Instances.

* **HANA system replication**: The replication of all data in SAP HANA to a separate SAP HANA system. The recovery time objective is minimized through data replication at regular intervals. SAP HANA supports asynchronous, synchronous in-memory, and synchronous modes. Synchronous mode is used only for SAP HANA systems that are within the same datacenter or less than 100 km apart.

ExpressRoute Global Reach allows users to connect ExpressRoute circuits from on-premise to Azure from separate regions to make a private network between on-premises networks. Global Reach can be used for SAP HANA Large Instance deployment to enable direct access from on-premise to HANA Large Instance units deployed in different regions. Additionally, GlobalReach can enable direct communication between  HANA Large Instance units deployed in different regions.

A system replication. If the master node becomes unavailable, then configure one or more standby SAP HANA nodes in scale-out mode, and SAP HANA automatically fails over to a standby node.

SAP HANA MCOD (Multiple Components in One Database) deployments as overlaying scenarios work with the HA and DR methods listed above. An exception is the use of HANA System Replication with an automatic failover cluster based on Pacemaker. Such a case only supports one HANA instance per unit. For SAP HANA MDC deployments, only non-storage-based HA and DR methods work if more than one tenant is deployed. With one tenant deployed, all methods listed are valid.

A multipurpose DR setup is where the HANA Large Instance unit on the DR site runs a non-production workload. In case of disaster, customers would shut down the non-production system, mount the storage-replicated (additional) volume sets, and then start the production HANA instance. Most customers who use the HANA Large Instance disaster recovery functionality use this configuration.

## High-availability of DBMS instances

The DBMS also constitutes a single point of failure in an SAP system. To protect it by using a high-availability solution, you typically deploy the DBMS layer in an active/passive mode with a failover clustering solution to protect from infrastructure or software failures. The failover cluster solution could be a DBMS-specific failover framework, Windows Server Failover Clustering, or Pacemaker. 

The DBMS-specific failover framework commonly integrates with the operating system-level clustering functionality and takes advantage of the Azure platform support. For example, SQL Server Always On high-availability solution in Azure integrates with Windows Server Failover Clustering and involves the use of an Azure load balancer and an availability set. SQL Server Always On replicates DBMS data and log files by using its own DBMS replication. This eliminates the need for shared storage.

* High availability of compute (VMs), network, and storage, based on:

     * Availability Sets

     * Availability Zones

> [!NOTE]
> It is important to note that these two contexts complement each other, so your design should combine benefits provided by each of them.


SAP HANA MCOD (Multiple Components in One Database) deployments as overlaying scenarios work with the HA and DR methods listed above. An exception is the use of HANA System Replication with an automatic failover cluster based on Pacemaker. Such a case only supports one HANA instance per unit. For SAP HANA MDC deployments, only non-storage-based HA and DR methods work if more than one tenant is deployed. With one tenant deployed, all methods listed are valid.

A multipurpose DR setup is where the HANA Large Instance unit on the DR site runs a non-production workload. In case of disaster, customers would shut down the non-production system, mount the storage-replicated (additional) volume sets, and then start the production HANA instance. Most customers who use the HANA Large Instance disaster recovery functionality use this configuration.
