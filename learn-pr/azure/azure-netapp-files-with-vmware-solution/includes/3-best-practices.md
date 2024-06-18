Before you deploy Azure NetApp Files as a datastore or a guest-mounted file system, you should be aware of the prerequisites and best practices to ensure a successful deployment and to meet performance requirements.

## Prerequisites

The following resources should be created before deploying an Azure NetApp Files volume for Azure VMware Solution (AVS):

- One or more AVS private clouds
- Dedicated VNet connected via an ExpressRoute gateway configured with the UltraPerformance or `ErGw3Az` SKU with FastPath enabled
- Subnet delegated to the `Microsoft.NetApp/volumes` service
- NetApp account created in the same region as your AVS private clouds
- Azure NetApp Files capacity pool with the appropriate service level and quality of service (QoS) type

The diagram shows the logical connectivity between the AVS private cloud and the dedicated Azure NetApp Files VNet.

:::image type="content" source="../media/3-deployment-diagram.png" alt-text="Diagram of storage sample deployment." lightbox="../media/3-deployment-diagram.png":::

## Best practices

When deploying an Azure NetApp Files volume with AVS, adhere to the best practices: 

- Use the UltraPerformance or `ErGw3Az` SKU for the ExpressRoute gateway.
- Enable FastPath on the connection between your AVS private cloud and the dedicated Azure NetApp Files VNet.
- Use Standard network features to optimize network throughput between your AVS private cloud and your Azure NetApp Files volumes.
- Use zonal placement to provision the Azure NetApp Files volumes in the same availability zone (AZ) as your AVS private cloud.
- Appropriately size your Azure NetApp Files volumes to ensure performance requirements are met.

## Performance sizing

When deploying Azure NetApp Files with AVS, it's important to select the appropriate service level and volume size.

### Service levels

Azure NetApp Files includes three service levels, each delivering the same best-in-class latency at different throughput limits depending on the provisioned volume size:

- Standard: 16 MiB/s per TiB of provisioned capacity
- Premium: 64 MiB/s per TiB of provisioned capacity
- Ultra: 128 MiB/s per TiB of provisioned capacity

A single Azure NetApp Files volume can deliver up to 5,025 MiB/s of throughput at single-digit (millisecond) latencies. Multiple Azure NetApp Files volumes can be deployed to meet higher throughput demands as needed.

### Nondisruptive performance scaling

Azure NetApp Files supports nondisruptive performance scaling in two ways:

- **Increasing (or decreasing) the volume’s size:** You can nondisruptively increase (or decrease) the volume size in seconds to meet performance requirements as business needs change in near real-time.
- **Changing a volume’s service level:** You can nondisruptively change a volume’s service level by moving it to a different capacity pool. Changing a volume’s capacity pool only takes a few seconds as it doesn’t require any data copying or moving.

For more information, see [Azure VMware Solution datastore performance considerations for Azure NetApp Files](/azure/azure-netapp-files/performance-azure-vmware-solution-datastore).
