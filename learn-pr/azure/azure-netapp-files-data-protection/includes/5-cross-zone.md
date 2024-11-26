Before discussing cross-zone replication, let’s learn about availability zones zonal placement for application high availability.  

## Availability zones 

Azure availability zones are physically separate locations within each supporting Azure region that are tolerant to local failures. Azure availability zones are highly available, fault tolerant, and more scalable than traditional single or multiple data center infrastructures. 

Before using an availability zone, understand the following concepts: 

- **Zonal placement:** Resources are pinned to a specific availability zone. You can combine multiple zonal deployments across different zones to meet high reliability requirements. If an outage occurs in a single availability zone, you're responsible for failover to another availability zone. 
- **Zone redundancy:** Resources are spread across multiple availability zones. Microsoft manages spreading requests across zones and the replication of data across zones. If an outage occurs in a single availability zone, Microsoft manages failover automatically. 

## Azure NetApp Files zonal placements  

Azure NetApp Files' availability zone volume placement feature lets you deploy each volume in the specific availability zone of your choice, in alignment with Azure compute and other services in the same zone. 

:::image type="content" alt-text="Diagram of three availability zones in one Azure region." source="../media/availability-zone-diagram.png":::

In the diagram, all virtual machines (VMs) within the region in (peered) virtual networks can access all Azure NetApp Files resources (blue arrows). VMs accessing Azure NetApp Files volumes in the same zone (green arrows) share the availability zone failure domain. Note there's no replication between the different volumes at the platform level. 

## Cross-zone replication 

The cross-zone replication capability provides data protection between volumes in different availability zones. You can asynchronously replicate data from an Azure NetApp Files volume (source) in one availability zone to another Azure NetApp Files volume (destination) in another availability zone. 

### Cost model for cross-zone replication 

Replicated volumes are hosted on a capacity pool. As such, the cost for cross-zone replication is based on the provisioned capacity pool size and tier as normal. There's no additional cost for data replication. 

### Azure Application Consistent Snapshot tool

Apart from the aforementioned protection and disaster recovery features, Azure NetApp Files uses Azure Application Consistent Snapshot tool (AzAcSnap) that enables data protection for third-party databases. 

For more information about AzAcSnap, see [What is the Azure Application Consistent Snapshot tool?](/azure/azure-netapp-files/azacsnap-introduction)