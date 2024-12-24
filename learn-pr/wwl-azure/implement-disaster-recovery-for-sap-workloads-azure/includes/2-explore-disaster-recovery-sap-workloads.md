Outside of relatively rare cross-zone scenarios, typical disaster recovery (DR) designs rely on failover to a secondary Azure region. Each tier uses a different strategy to provide disaster recovery protection.

## Application servers

SAP application servers don't contain business data. On Azure, a simple DR strategy is to create SAP application servers in the secondary region, then shut them down. Upon any configuration changes or kernel updates on the primary application server, the same changes must be applied to the virtual machines in the secondary region. For example, copy the SAP kernel executables to the DR virtual machines. For automatic replication of application servers to a secondary region, Azure Site Recovery is the recommended solution.

## Central Services servers

This SAP application stack component doesn't store business data. You can construct a virtual machine in the secondary region to operate the Central Services role. The only content to sync from the primary Central Services node is the **/sapmnt** share content. Additionally, any configuration changes or kernel updates on the primary Central Services servers need to be duplicated on the secondary region's virtual machine running Central Services. You can sync the two servers through Azure Site Recovery for cluster node replication, or a regular copy job to duplicate **/sapmnt** to the disaster recovery side. For Central Services Linux and Windows virtual machines, use Azure Site Recovery for cluster nodes and storage replication. Alternatively, you can establish a three-node geo-cluster using a High Availability Extension for Linux virtual machines or a multi-site Failover Cluster for Windows virtual machines. Note, Azure Site Recovery doesn't support ultra disks.

## Database servers

Use DBMS-specific mechanisms such as SQL Server Always On Availability Group or HANA System Replication to facilitate disaster recovery requirements. These mechanisms support multi-tier, asynchronous replication to a node in a separate Azure region, in addition to a local, two-node high availability setup with synchronous replication. The failover to the DR node is typically a manual process since it implies the possibility of a data loss.
