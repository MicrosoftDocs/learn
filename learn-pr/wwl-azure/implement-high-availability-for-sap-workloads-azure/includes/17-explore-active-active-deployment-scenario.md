The deployment architecture is called active/active because you deploy your active SAP application servers across two or three zones. The SAP Central Services instance that uses enqueue replication is deployed between two zones. The same is true for the DBMS layer, which is deployed across the same zones as SAP Central Service.

When considering the active/active configuration, you need to find the two Availability Zones in your region that offer cross-zone network latency that's acceptable for your workload and your synchronous DBMS replication. You want a small delta between network latency within the zones you selected, and the cross-zone network. You don't want large variations in the running times of your business processes or batch jobs depending on whether a job runs in-zone with the DBMS server or across zones. Small latency reduces the batch job run time variation between zones.

Consider the basic layout of the active/active architecture:

:::image type="content" source="../media/active-active-zones-deployment.png" alt-text="Diagram illustrating Active/Active zone deployment.":::

The following considerations apply for this configuration:

- Not using Azure Proximity Placement Group, you treat the Azure Availability Zones as fault domains for all the VMs because availability sets can't be deployed in Azure Availability Zones.
- If you want to combine zonal deployments for the DBMS layer and central services, but want to use Azure availability sets for the application layer, you need to use Azure proximity groups.
- For the load balancers of the failover clusters of SAP Central Services and the DBMS layer, you need to use the Standard SKU Azure Load Balancer. The Basic Load Balancer doesn't work across zones.
- The Azure virtual network that you deployed to host the SAP system, together with its subnets, is stretched across zones. You don't need separate virtual networks and subnets for each zone.
- For all virtual machines you deploy, you need to use Azure Managed Disks. Unmanaged disks aren't supported for zonal deployments.
- Azure Premium Storage, Ultra SSD storage, or ANF don't support any type of storage replication across zones. For DBMS deployments, we rely on database methods to replicate data across zones
- For SMB and NFS shares based on Azure Premium Files, zonal redundancy with synchronous replication is offered. The usage of zonal replicated NFS and SMB shares is fully supported with SAP application layer deployments and high availability failover clusters for SAP NetWeaver or SAP S/4HANA centrals services.
- The third zone is used to host the SBD device if you build a SUSE Linux Pacemaker cluster and use SBD devices instead of the Azure Fencing Agent.
- To achieve run time consistency for critical business processes, you can try to direct certain batch jobs and users to application instances that are in-zone with the active DBMS instance by using SAP batch server groups, SAP logon groups, or RFC groups. However, in zonal failover process, you would need to manually move these groups to instances running on VMs that are in-zone with the active DB VM.  
- You might want to deploy dormant dialog instances in each of the zones.

> [!IMPORTANT]
> In this active/active scenario charges for cross zone traffic apply. The data transfer between the SAP application layer and SAP DBMS layer is quite intensive. Therefore the active/active scenario can contribute to costs.
