## Replicate backups to a second virtual machine

One of the most rudimentary methods to provide a basic level of resiliency for SAP HANA is to use backups. You might have transaction log backups shipped from one Azure VM to another. In this setup, you're responsible for scripting the process of scheduled backups that are performed on the first VM and then copied to the second VM. If you need to use the second VM, you must restore the full, incremental/differential, and transaction log backups.

This setup isn't well suited for delivering optimal Recovery Point Objective (RPO) and Recovery Time Objective (RTO) times. RTO times especially would suffer due to the need to fully restore the complete database by using the copied backups. However, this setup is useful for recovery from unaccidental data deletions. With this setup, you can restore to a certain point in time, extract the data, and import the deleted data into your primary instance. Hence, it might make sense to use a backup copy method in combination with other high-availability methods.

## SAP HANA system replication without automatic failover

The next few scenarios use SAP HANA system replication. Scenarios without automatic failover aren't common for deployments within one Azure region. Configurations without automatic failover, while avoiding the need for Pacemaker, warrant additional monitoring and require manual failover. Most customers are relying on Azure service healing instead.

### SAP HANA system replication without auto failover and without data preload

In this scenario, you use SAP HANA system replication to transfer data synchronously to bring RPO down to 0. On the other hand, you have a long enough RTO that you don't need either failover or data preloading into the HANA instance cache. In such a case, you can realize more benefits by taking the following actions:

- Run another SAP HANA instance in the second Azure VM. The SAP HANA instance in the second VM will likely use most of its memory. If there's a failover to the second VM, you need to shut down the running SAP HANA instance that has the data fully loaded in the second VM, so that the replicated data can be loaded into the cache of the targeted HANA instance in the second VM.
- Use a smaller VM size on the second VM. If a failover occurs, you have an additional step before the manual failover. In this step, you resize the VM to the size of the source VM.

Even if you don't use data preload in the HANA system replication target, you need at least 64 GB of memory. You also need enough memory in addition to 64 GB to keep the rowstore data in the memory of the target instance.

### SAP HANA system replication without auto failover and with data preload

In this scenario, data that are replicated to the HANA instance in the second VM is preloaded. This eliminates the two advantages of not preloading data. In this case, you can't run another SAP HANA system on the second VM. You also can't use a smaller VM size. Hence, customers rarely implement this scenario.

## SAP HANA system replication with automatic failover

In the standard and most common availability configuration within one Azure region, two Azure VMs running SLES Linux have a failover cluster defined. The SLES Linux cluster is based on the Pacemaker framework, with a STONITH device.

From an SAP HANA perspective, the replication uses the synchronous mode with an automatic failover. In the secondary VM, the SAP HANA instance acts as a hot standby node. The standby node receives a synchronous stream of change records from the primary SAP HANA instance. As transactions are committed by the application at the HANA primary node, the primary HANA node waits to confirm the commit to the application until the secondary SAP HANA node confirms that it received the commit record. SAP HANA offers two synchronous replication modes.

You might choose this solution because it enables you to achieve an RPO = 0 and a low RTO. Configure the SAP HANA client connectivity so that the SAP HANA clients use the virtual IP address to connect to the HANA system replication configuration. Such a configuration eliminates the need to reconfigure the application if a failover to the secondary node occurs. In this scenario, the Azure VM SKUs for the primary and secondary VMs must be the same.

## SAP HANA scale-out configurations in Azure

High availability for SAP HANA scale-out configurations is relying on service healing of Azure VMs and the restart of the SAP HANA instance.

At the time of authoring this content, the highly available NFS cluster is supported with SUSE Linux only.
