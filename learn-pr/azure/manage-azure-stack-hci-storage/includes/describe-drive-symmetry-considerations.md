With your newly acquired knowledge about drive types and storage pool cache, you’ve started reviewing the sizing requirements necessary to accommodate production workload testing in your proof-of-concept environment. However, you’re also beginning to realize that an optimal storage configuration must account for the drive symmetry requirements as well. 

## Describe drive symmetry 

Storage Spaces Direct utilizes storage capacity in the optimal manner when every server has the exact same number and type of drives. This type of configuration is referred to as *drive symmetry*. To have drive symmetry:

- All servers must have the same types of drives.

- All servers must have the same number of drives of each type.

- All drives should have the same model and firmware version, whenever possible. If that's not possible, drives should have matching performance and endurance characteristics.

- All drives of the same type should have the same size, whenever possible. Using capacity drives of different sizes might result in some unusable capacity. Using cache drives of different sizes might minimize their positive performance impact.

> [!IMPORTANT]
> Drive symmetry rules and the resulting considerations apply to the Azure Stack HCI cluster that’s operating under normal conditions. Storage Spaces Direct automatically remediates recovery scenarios in which the number of drives temporarily differs following a hardware failure.

## Describe capacity imbalance

Storage Spaces Direct can help minimize capacity imbalance across drives and servers. However, such a configuration could limit the amount of usable capacity. To understand why this happens, you must understand the concept of *stranded capacity*. In the following illustration, each box represents one copy of three-way mirrored data. For example, the boxes marked B, B', and B'' are three copies of the same data. To satisfy fault tolerance requirements, these copies must be stored in different servers. However, Servers 1 and 2 (10 terabytes (TB) each) are full. While Server 3 has larger drives with a total capacity of 15 TB, storing more three-way mirrored data on Server 3 would require replicas on Server 1 and Server 2 as well, and these servers are already full. Effectively, the remaining 5 TB capacity on Server 3 can't be used, which is why the capacity is considered "stranded."

:::image type="content" source="../media/4-stranded-capacity.png" alt-text="Diagram that shows three servers are represented: two with two 5 TB drives, and the third with three 5 TB drives. The third 5 TB drive of the third server can't be used, and therefore is stranded."border="false":::

However, with four servers of 10 TB, 10 TB, 10 TB, and 15 TB capacity, and with three-way mirror resiliency, it's possible to distribute replicas in a way that uses all the available capacity, as in the following example.

:::image type="content" source="../media/4-optimal-placement.png" alt-text="Diagram that shows four servers are represented and optimal capacity is retained when they are set up in a three-way mirror."border="false":::

Whenever possible, Storage Spaces Direct will identify and implement the optimal placement, leaving no stranded capacity. 

The extent of stranded capacity is dependent on several factors, including the number of servers, resiliency, and severity of the capacity imbalance. When performing capacity planning, operate under the assumption that maximizing raw storage use should involve implementing drive symmetry.

## Describe cache imbalance

Similarly, using cache drives of differing sizes might result in suboptimal and unpredictable caching behavior. Storage Spaces Direct distributes IO evenly across bindings regardless of the cache-to-capacity ratio, so it’s possible that only IO-to-drive bindings with larger cache drives might experience improved performance.
