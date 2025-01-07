Azure NetApp Files is billed on provisioned storage capacity, which is allocated by creating capacity pools. Capacity pools are billed monthly based on a set cost per allocated GiB per hour. 

- Capacity pool allocation is measured hourly.
- Capacity pools must be at least 1 TiB and can be increased or decreased in 1-TiB intervals. 
- Capacity pools contain volumes that range in size from a minimum of 50 GiB to a maximum of 100 TiB. 
- Volumes are assigned quotas that are subtracted from the capacity pool’s provisioned size. 
- For an active volume, capacity consumption against the quota is based on logical (effective) capacity, being active filesystem data or snapshot data.

## Capacity consumption of snapshots

The capacity consumption of snapshots in Azure NetApp Files is charged against the quota of the parent volume. As a result, it shares the same billing rate as the capacity pool to which the volume belongs.

Snapshot consumption is measured based on the incremental capacity consumed. Azure NetApp Files snapshots are differential in nature. Depending on the change rate of the data, the snapshots often consume much less capacity than the logical capacity of the active volume. For example, assume that you have a snapshot of a 500-GiB volume that only contains 10 GiB of differential data. The capacity consumption counted towards the volume quota for the active filesystem and snapshot would be 510 GiB, not 1000 GiB. The diagram illustrates the concepts.

:::image type="content" source="../media/1-capacity-pool.png" alt-text="Diagram of capacity pool sizing." lightbox="../media/1-capacity-pool.png":::

- Assume a capacity pool with 10 TiB of provisioned capacity. The pool contains three volumes:
- Volume 1 is assigned a quota of 5 TiB and has 3.5 TiB (3 TiB active, 500 GiB snapshots) of consumption.
- Volume 2 is assigned a quota of 900 GiB and has 400 GiB of consumption.
- Volume 3 is assigned a quota of 4 TiB but is full, with 4 TiB (3.5 TiB active, 500 GiB snapshots) of consumption.
- The capacity pool is metered (and billed) for 10 TiB of capacity (the provisioned amount):
- 9.9 TiB of capacity is allocated (5 TiB, 900 GiB, and 4 TiB of quota from Volumes 1, 2, and 3).
- 7.9 TiB of capacity is used (3.5 TiB, 400 GiB, 4 TiB in Volumes 1, 2, and 3).
- The capacity pool has a remaining 100 GiB of un-provisioned capacity.

To learn more about Azure NetApp Files pricing examples, see [Azure NetApp Files cost model](/azure/azure-netapp-files/azure-netapp-files-cost-model#calculation-of-capacity-consumption).

