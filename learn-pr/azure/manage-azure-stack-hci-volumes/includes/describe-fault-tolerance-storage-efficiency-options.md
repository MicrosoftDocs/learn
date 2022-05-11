Before you choose the optimal volume configuration for your Azure Stack HCI deployment, you first need to explore the fault tolerance options available in Azure Stack HCI. Each of these options has a direct impact on resiliency, but also affects capacity and performance.

## Describe mirroring

Two-way mirroring keeps two copies of all data, distributed across drives on different cluster nodes. Its storage efficiency is 50 percent. Volumes with two-way mirroring can withstand one hardware failure at a time (one server or drive).

With three nodes in a cluster, it becomes possible to implement three-way mirroring. This maximizes fault tolerance and performance, although it also results in a decrease in storage efficiency (down to 33 percent), because the cluster needs to maintain three copies of all data, distributed across drives on different cluster nodes.

## Describe parity

With three or more servers, it becomes possible to implement parity. Parity provides fault tolerance by using bitwise arithmetic. In somewhat simplified terms, parity involves:

1. Performing calculations that generate parity bits by using data being written into one set of drives.
1. Storing the resulting parity bits on another set of drives.

The parity bits can then be used to reconstruct the data on the first set of drives in case any of them fails.

Azure Stack HCI Storage Spaces supports two types of parity:

- *Single* *parity* maintains only one bitwise parity set, limiting fault tolerance to one failure at a time. Implementing single parity requires at least three servers.

   > [!NOTE]
   > Three-way mirroring offers higher fault tolerance with three servers, so the use of single-parity is, in general, discouraged.

- *Dual* *parity* maintains two bitwise parity sets, effectively providing the same fault tolerance as three-way mirroring, but with better storage efficiency.

   > [!NOTE]
   > Implementing dual parity requires at least four servers. With four servers, its storage efficiency is 50 percent. This increases to 66.7 percent with seven servers and continues the upward trend as you increase the number of servers to 16, where it reaches 80 percent.

## Describe mirror-accelerated parity


With mirror-accelerated parity, an individual Storage Spaces Direct volume combines mirroring and parity. Writes take place in the mirrored portion of the volume and are moved automatically to the parity portion at a later time and in a gradual manner. This accelerates ingestion and reduces resource utilization when large writes arrive, by allowing the compute-intensive parity encoding to happen over a longer period of time.

Implementing mirror-accelerated parity requires at least four servers. The storage efficiency of mirror-accelerated parity is within the range identified: on one end, by the efficiency provided by three-way mirroring (33 percent) and, on the other, the efficiency of double parity. The actual efficiency is determined by the ratio between the mirror to the parity portion, which you specify when creating a volume.

## Describe nested resiliency

Nested resiliency is an innovative approach only available on two-node clusters. It improves resiliency of two-way mirrors by first applying two-way mirroring across both nodes, and then adding an extra layer of resiliency across different drives within each server by using either two-way mirroring or single parity. This provides drive-level resiliency if one server is restarting or unavailable. When using nested two-way mirroring, the storage efficiency is 25 percent. With nested mirror-accelerated parity, storage efficiency ranges between 35 and 40 percent, depending on the number of capacity drives per node and the mirror-to-parity ratio per volume.
