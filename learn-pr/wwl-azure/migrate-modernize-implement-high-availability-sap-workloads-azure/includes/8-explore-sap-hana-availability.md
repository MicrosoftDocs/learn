## Replicate backups to a second virtual machine

One of the most rudimentary methods to provide a basic level of resiliency for SAP HANA is to use backups. You might have transaction log backups shipped from one Azure Virtual Machine to another. In this setup, you're responsible for scripting the process of scheduled backups that are performed on the first virtual machine and then copied to the second virtual machine. If you need to use the second virtual machine, you must restore the full, incremental/differential, and transaction log backups.

This setup isn't well suited for delivering optimal Recovery Point Objective (RPO) and Recovery Time Objective (RTO) times. RTO times especially would suffer due to the need to fully restore the complete database by using the copied backups. However, this setup is useful for recovery from unaccidental data deletions. With this setup, you can restore to a certain point in time, extract the data, and import the deleted data into your primary instance. Hence, it might make sense to use a backup copy method in combination with other high-availability methods.

## SAP HANA system replication without automatic failover

The next few scenarios use SAP HANA system replication. Scenarios without automatic failover aren't common for deployments within one Azure region. Configurations without automatic failover, while avoiding the need for Pacemaker, warrant extra monitoring and require manual failover. Most customers are relying on Azure service healing instead.

### SAP HANA system replication without auto failover and without data preload

In this scenario, you use SAP HANA system replication to transfer data synchronously to bring RPO down to 0. On the other hand, you have a long enough RTO that you don't need either failover or data preloading into the SAP HANA instance cache. In such a case, you can realize more benefits by taking the following actions:

- Run another SAP HANA instance in the second Azure Virtual Machine. The SAP HANA instance in the second virtual machine will likely use most of its memory. If there's a failover to the second virtual machine, you need to shut down the running SAP HANA instance that has the data fully loaded in the second virtual machine, so that the replicated data can be loaded into the cache of the targeted SAP HANA instance in the second virtual machine.
- Use a smaller virtual machine size on the second virtual machine. If a failover occurs, you have an extra step before the manual failover. In this step, you resize the virtual machine to the size of the source virtual machine.

Even if you don't use data preload in the SAP HANA system replication target, you need at least 64 GB of memory. You also need enough memory in addition to 64 GB to keep the rowstore data in the memory of the target instance.

### SAP HANA system replication without auto failover and with data preload

In this scenario, data that are replicated to the SAP HANA instance in the second virtual machine is preloaded. This eliminates the two advantages of not preloading data. In this case, you can't run another SAP HANA system on the second virtual machine. You also can't use a smaller virtual machine size. Hence, customers rarely implement this scenario.

## SAP HANA system replication with automatic failover

One method for achieving SAP HANA high availability is by configuring host auto failover. To configure host auto failover, you add one or more virtual machines to the SAP HANA system and configure them as standby nodes. When active node fails, a standby node automatically takes over. In the presented configuration with Azure virtual machines, you achieve auto failover by using [NFS on Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-introduction.md).  

> [!NOTE]
> The standby node needs access to all database volumes. The SAP HANA volumes must be mounted as NFSv4 volumes. The improved file lease-based locking mechanism in the NFSv4 protocol is used for `I/O` fencing.

> [!IMPORTANT]
> To build the supported configuration, you must deploy the SAP HANA data and log volumes as NFSv4.1 volumes and mount them by using the NFSv4.1 protocol. The SAP HANA host auto-failover configuration with standby node is not supported with NFSv3.

In the standard and most common availability configuration within one Azure region, two Azure Virtual Machines running SLES Linux have a failover cluster defined. The SLES Linux cluster is based on the Pacemaker framework, with a STONITH fencing agent device.

From an SAP HANA perspective, the replication uses the synchronous mode with an automatic failover. In the secondary virtual machine, the SAP HANA instance acts as a hot standby node. The standby node receives a synchronous stream of change records from the primary SAP HANA instance. As transactions are committed by the application at the SAP HANA primary node, the primary SAP HANA node waits to confirm the commit to the application until the secondary SAP HANA node confirms that it received the commit record. SAP HANA offers two synchronous replication modes.

You might choose this solution because it enables you to achieve an RPO = 0 and a low RTO. Configure the SAP HANA client connectivity so that the SAP HANA clients use the virtual IP address to connect to the SAP HANA system replication configuration. Such a configuration eliminates the need to reconfigure the application if a failover to the secondary node occurs. In this scenario, the Azure Virtual Machine SKUs for the primary and secondary virtual machines must be the same.

## SAP HANA scale-out configurations in Azure

High availability for SAP HANA scale-out configurations is relying on service healing of Azure Virtual Machines and the restart of the SAP HANA instance.

At the time of authoring this content, the highly available NFS cluster is supported with SUSE Linux only.
