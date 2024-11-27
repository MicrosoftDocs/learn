Service levels are an attribute of a capacity pool. Service levels are defined and differentiated by the allowed maximum throughput for a volume in the capacity pool based on the quota that is assigned to the volume. 

>[!NOTE]
>Throughput is a combination of read and write speeds.

## Service levels

Azure NetApp Files supports three service levels: Ultra, Premium, and Standard.

- **Standard storage:** The Standard service level provides up to 16 MiB/s of throughput per 1 TiB of capacity provisioned.
- **Premium storage:** The Premium service level provides up to 64 MiB/s of throughput per 1 TiB of capacity provisioned.
- **Ultra storage:** The Ultra service level provides up to 128 MiB/s of throughput per 1 TiB of capacity provisioned.

>[!NOTE]
>All three service levels (Standard, Premium, and Ultra) support a cool access options that tiers infrequently accessed data from a hot tier to a cool tier. With cool access enabled, the same level of service is provided, though it may differ when data that resides in the cool tier is accessed.

## Throughput limits

The throughput limit for a volume is determined by the combination of the following factors:

- The service level of the capacity pool to which the volume belongs.
- The quota assigned to the volume.
- The QoS type (auto or manual) of the capacity pool.

### Throughput limit scenarios of volumes in an auto QoS capacity pool

This diagram shows throughput limit examples of volumes in an auto QoS capacity pool:

:::image type="content" source="../media/2-throughput-calculation.png" alt-text="Diagram showing throughput calculations of available service level throughput per TiB multiplied by quota size.":::

* In Example 1, a volume from an auto QoS capacity pool with the Premium storage tier assigned 2 TiB of quota has a throughput limit of 128 MiB/s (2 TiB * 64 MiB/s). This scenario applies regardless of the capacity pool size or the actual volume consumption.
* In Example 2, a volume from an auto QoS capacity pool with the Premium storage tier assigned 100 GiB of quota is assigned a throughput limit of 6.25 MiB/s (0.09765625 TiB * 64 MiB/s). This scenario applies regardless of the capacity pool size or the actual volume consumption.

### Throughput limit examples of volumes in a manual QoS capacity pool

When you use a manual QoS capacity pool, you can assign the capacity and throughput for a volume independently while creating the volume. The total throughput assigned to volumes in a manual QoS capacity pool depends on the size of the pool and the service level.

For example, for an SAP HANA system, this capacity pool can be used to create the following volumes. Each volume provides the individual size and throughput to meet your application requirements:

- SAP HANA data volume: Size 4 TiB with up to 704 MiB/s
- SAP HANA log volume: Size 0.5 TiB with up to 256 MiB/s
- SAP HANA shared volume: Size 1 TiB with up to 64 MiB/s
= SAP HANA backup volume: Size 4.5 TiB with up to 256 MiB/s

The following diagram illustrates the scenarios for the SAP HANA volumes:

:::image type="content" source="../media/2-manual-qos-throughput.png" alt-text="Diagram showing how manual QoS throughput.":::

