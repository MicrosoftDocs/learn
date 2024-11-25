Before creating a volume in Azure NetApp Files, you must purchase and set up a pool for provisioned capacity. To set up a capacity pool, you must have a NetApp account. 

Watch this video to understand how storage hierarchy works in Azure NetApp Files. 

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=e9e9e134-33f3-4a83-9d3d-d1fa35d357cd]

NetApp accounts

- A NetApp account serves as an administrative grouping of the constituent capacity pools.
- A NetApp account isn't the same as your general Azure storage account.
- A NetApp account is regional in scope.
- You can have multiple NetApp accounts in a region, but each NetApp account is tied to only a single region.

## Capacity pools

- A capacity pool is measured by its provisioned capacity.
- The capacity is provisioned by the fixed SKUs that you purchased (for example, a 4-TiB capacity).
- A capacity pool can have only one service level.
- Each capacity pool can belong to only one NetApp account. However, you can have multiple capacity pools within a NetApp account. 
- You can't move a capacity pool across NetApp accounts.
- You can't delete a capacity pool until you delete all volumes within the capacity pool.
- You can configure Standard, Premium, or Ultra service-level capacity pools with the cool access option. For more information about cool access, see Azure NetApp Files storage with cool access.

## Quality of Service (QoS) types for capacity pools

The QoS type is an attribute of a capacity pool. It provides the ability to assign the capacity and throughput to the volumes in the capacity pool. 

Azure NetApp Files provides two QoS types of capacity pools: auto (default) and manual. 

### Automatic (or auto) QoS type

- When you create a capacity pool, the default QoS type is auto.
- In an auto QoS capacity pool, throughput is assigned automatically to the volumes in the pool, proportional to the size quota assigned to the volumes.
- The maximum throughput allocated to a volume depends on the service level of the capacity pool and the size quota of the volume, which are discussed in the other modules in this learning path. 

### Manual QoS type

-  When you create a capacity pool, you can specify the capacity pool to use the manual QoS type. 
- You can also change the existing capacity pool to use the manual QoS type. 
- Setting the capacity type to manual QoS is a permanent change. You can't convert a manual QoS type capacity pool to an auto QoS capacity pool. You can move volumes from a manual QoS capacity pool to an auto QoS capacity pool by dynamically changing the service level of a volume.
- In a manual QoS capacity pool, you can assign the capacity and throughput for a volume independently. 
- The total throughput of all volumes created with a manual QoS capacity pool is limited by the total throughput of the pool. Throughput is determined by the combination of the pool size and the service-level throughput. For instance, a 4-TiB capacity pool with the Ultra service level has a total throughput capacity of 512 MiB/s (4 TiB x 128 MiB/s/TiB) available for the volumes.

## Volumes

- A volume is measured by logical capacity consumption and is scalable.
- A volume's capacity consumption counts against its pool's provisioned capacity.
- A volume’s throughput consumption counts against its pool’s available throughput. See Manual QoS type.
- Each volume belongs to only one pool, but a pool can contain multiple volumes.
- Volumes contain a capacity of between 50 GiB and 100 TiB. You can create a large volume with a size between 50 TiB and 2,048 TiB.

## Large volumes

Large volumes begin at a capacity of 50 TiB and scale up to 2,048 TiB.
