Outside of relatively rare cross-zone scenarios, typical disaster recovery (DR) designs rely on failover to a secondary Azure region. Each tier uses a different strategy to provide disaster recovery protection.

## Application servers

SAP application servers don't contain business data. On Azure, a simple DR strategy is to create SAP application servers in the secondary region, then shut them down. Upon any configuration changes or kernel updates on the primary application server, the same changes must be applied to the virtual machines in the secondary region. For example, copy the SAP kernel executables to the DR virtual machines. For automatic replication of application servers to a secondary region, Azure Site Recovery is the recommended solution.

## Central Services servers

This component of the SAP application stack also doesn't persist business data. You can build a virtual machine in the secondary region to run the Central Services role. The only content from the primary Central Services node to synchronize is the **/sapmnt** share content. Also, if configuration changes or kernel updates take place on the primary Central Services servers, they must be repeated on the virtual machine in the secondary region running Central Services. To synchronize the two servers, you can use either Azure Site Recovery, to replicate the cluster nodes, or use a regularly scheduled copy job to copy **/sapmnt** to the DR side. For Central Services Linux and Windows virtual machines, use Azure Site Recovery to replicate the cluster nodes and storage. Alternatively, you can create a three-node geo-cluster using a High Availability Extension for Linux virtual machines or multi-site Failover Cluster for Windows virtual machines. Azure Site Recovery doesn't support ultra disks.

## Database servers

Use DBMS-specific mechanisms such as SQL Server Always On Availability Group or HANA System Replication to facilitate disaster recovery requirements. These mechanisms support multi-tier, asynchronous replication to a node in a separate Azure region, in addition to a local, two-node high availability setup with synchronous replication. The failover to the DR node is typically a manual process since it implies the possibility of a data loss.
