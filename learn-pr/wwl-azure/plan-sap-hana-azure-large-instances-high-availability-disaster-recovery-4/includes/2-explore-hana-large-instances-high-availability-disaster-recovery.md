High availability and disaster recovery (DR) are crucial aspects of running your mission-critical SAP HANA on the Azure (Large Instances) server. It's important to work with SAP, your system integrator, or Microsoft to properly architect and implement the right high-availability and disaster recovery strategies. It's also important to consider the recovery point objective (RPO) and the recovery time objective (RTO), which are specific to your environment.

Microsoft supports some SAP HANA high-availability capabilities with HANA Large Instances. These capabilities include:

 -  **Storage replication**: The storage system's ability to replicate all data to another HANA Large Instance stamp in another Azure region. SAP HANA operates independently of this method. This functionality is the default disaster recovery mechanism offered for HANA Large Instances.
 -  **HANA system replication (HSR)**: The replication of all data in SAP HANA to a separate SAP HANA system. The recovery time objective is minimized through data replication at regular intervals. SAP HANA supports asynchronous, synchronous in-memory, and synchronous modes. Synchronous mode is used only for SAP HANA systems that are within the same datacenter or less than 100 km apart. With the current design of HANA Large Instance stamps, HANA system replication can be used for high availability within one region only. HANA system replication requires a third-party reverse proxy or routing component for disaster recovery configurations into another Azure region.
 -  **Host auto-failover**: A local fault-recovery solution for SAP HANA that's an alternative to HANA system replication. If the leading node becomes unavailable, you configure one or more standby SAP HANA nodes in scale-out mode, and SAP HANA automatically fails over to a standby node.

When you set up HANA Large Instances HSR with automatic failover, you can request the Microsoft Service Management team to set up a STONITH device for your existing servers.

This architecture supports disaster recovery between HANA Large Instances in different Azure regions. There are two ways to support DR with HANA Large Instances:

 -  **Storage replication**. The primary storage contents are constantly replicated to the remote DR storage systems that are available on the designated DR HANA Large Instances server. In storage replication, the HANA database is not loaded into memory. This DR option is simpler from an administration perspective. To determine if this is a suitable strategy, consider the database load time against the availability SLA. Storage replication also enables you to perform point-in-time recovery. If multi-purpose (cost-optimized) DR is set up, you must purchase additional storage of the same size at the DR location. Microsoft provides self-services storage snapshot and failover scripts for HANA failover as part of the HANA Large Instances offering.
 -  **Multi-tier HSR with a third replica in the DR region** (where the HANA database is loaded onto memory). This option supports a faster recovery time but does not support a point-in-time recovery. HSR requires a secondary system. HANA system replication for the DR site is handled through proxies such as nginx or IP tables.

SAP HANA on Azure (Large Instances) is offered in pairs of Azure regions in four geopolitical areas (US, Australia, Europe, and Japan). Two regions within a geopolitical area that host HANA Large Instance stamps are connected to separate dedicated network circuits. These are used for replicating storage snapshots to provide disaster recovery methods. The replication is not established by default but is set up for customers who order disaster recovery functionality. Storage replication is dependent on the usage of storage snapshots for HANA Large Instances. It's not possible to choose an Azure region as a DR region that is in a different geopolitical area.

The following table shows the currently supported high availability and disaster recovery methods and combinations:

:::row:::
  :::column:::
    **Scenario supported in HANA Large Instances**
  :::column-end:::
  :::column:::
    **High availability option**
  :::column-end:::
  :::column:::
    **Disaster recovery option**
  :::column-end:::
  :::column:::
    **Comments**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Single node
  :::column-end:::
  :::column:::
    Not available.
  :::column-end:::
  :::column:::
    Dedicated DR setup. Multipurpose DR setup.
  :::column-end:::
  :::column:::
    \-
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Host auto-failover: Scale-out (with or without standby) including 1+1
  :::column-end:::
  :::column:::
    Possible with the standby taking the active role. HANA controls the role switch.
  :::column-end:::
  :::column:::
    Dedicated DR setup. Multipurpose DR setup. DR synchronization by using storage replication.
  :::column-end:::
  :::column:::
    HANA volume sets are attached to all the nodes. DR site must have the same number of nodes.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    HANA system replication
  :::column-end:::
  :::column:::
    Possible with primary or secondary setup. Secondary moves to primary role in a failover case. HANA system replication and OS control failover.
  :::column-end:::
  :::column:::
    Dedicated DR setup. Multipurpose DR setup. DR synchronization by using storage replication. DR by using HANA system replication is not yet possible without third-party components.
  :::column-end:::
  :::column:::
    Separate set of disk volumes is attached to each node. Only disk volumes of secondary replica in the production site get replicated to the DR location. One set of volumes is required at the DR site.
  :::column-end:::
:::row-end:::


A dedicated DR setup is where the HANA Large Instance unit in the DR site is not used for running any other workload or non-production system. The unit is passive and is deployed only if a disaster failover is executed. Though, this setup is not a preferred choice for many customers.

SAP HANA MCOD deployments (multiple HANA Instances on one unit) as overlaying scenarios work with the HA and DR methods listed in the table. An exception is the use of HANA System Replication with an automatic failover cluster based on Pacemaker. Such a case only supports one HANA instance per unit. For SAP HANA MDC deployments, only non-storage-based HA and DR methods work if more than one tenant is deployed. With one tenant deployed, all methods listed are valid.

A multipurpose DR setup is where the HANA Large Instance unit on the DR site runs a non-production workload. In case of disaster, shut down the non-production system, mount the storage-replicated (additional) volume sets, and then start the production HANA instance. Most customers who use the HANA Large Instance disaster recovery functionality use this configuration.

You can find more information on SAP HANA high availability in the following SAP articles:

 -  [SAP HANA Administration Guide](https://help.sap.com/viewer/6b94445c94ae495c83a19646e7c3fd56/2.0.03/)
 -  [SAP HANA Academy Videos on SAP HANA System Replication](https://www.youtube.com/playlist?list=PLkzo92owKnVxnHQo_Q_5BUNfmp2qDmjXs)
 -  [SAP Note \#1999880 – FAQ on SAP HANA System Replication](https://launchpad.support.sap.com/#/notes/1999880)
 -  [SAP Note \#2165547 – SAP HANA Back up and Restore within SAP HANA System Replication Environment](https://launchpad.support.sap.com/#/notes/2165547)
 -  [SAP Note \#1984882 – Using SAP HANA System Replication for Hardware Exchange with Minimum/Zero Downtime](https://launchpad.support.sap.com/#/notes/1984822)
