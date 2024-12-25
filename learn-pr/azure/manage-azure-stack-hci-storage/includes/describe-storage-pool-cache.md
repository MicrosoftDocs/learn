Now that you identified the basic Azure Stack HCI storage requirements and its supported drive types, you can explore more involved configuration options. You recall that along with its drive type, the Storage Spaces Direct storage pool cache also factors into storage performance and capacity. To fully comprehend its impact, you need to begin by understanding the storage pool cache's role and behavior.

## Describe the role of cache drives in the storage pool cache

In general, Storage Spaces Direct assigns drives to one of two categories based on the drive type: capacity or cache. In clusters containing more than one drive type, cache drives are used exclusively for caching and don't contribute to the usable cluster storage capacity. Effectively, a cluster's total raw storage capacity is the sum of capacity drives on all its nodes.

Caching can apply exclusively to reads or writes, or both reads and writes. The type of caching is dependent on the drive types present in the storage pool.

## Describe cache behavior

Storage Spaces Direct automatically assigns all the fastest drive types to caching. The remaining drives are used for capacity. However, you can set caching manually in cases in which the default configuration doesn't yield the optimal performance.

The specifics of automatic caching behavior depend on the type of capacity drives. For example, if you use HDD capacity drives, caching applies to both reads and writes. On SSD capacity drives, only writes are cached. This behavior is intended to reduce wear on the cache drives, because performance gains from caching SSD reads are relatively limited. When HDD, SSD, and NVMe drives are present, NVMe provides caching for both SSDs and HDDs.

The following table summarizes the default caching configuration based on the drive type.

| **Deployment**     | **Cache drives**                    | **Capacity drives** | **Cache behavior (default)**               |
| ------------------ | ----------------------------------- | ------------------- | ------------------------------------------ |
| All NVMe drives         | None (Optional: configure manually) | NVMe                | Write-only (if configured)                 |
| All SSDs           | None (Optional: configure manually) | SSD                 | Write-only (if configured)                 |
| NVMe and SSD       | NVMe                                | SSD                 | Write-only                                 |
| NVMe and HDD       | NVMe                                | HDD                 | Read and write                             |
| SSD and HDD        | SSD                                 | HDD                 | Read and write                             |
| NVMe, SSD, and HDD | NVMe                                | SSD and HDD         | Read and write for HDD, Write-only for SSD |

### Cache configuration scenarios

Three scenarios represent the most common cache configurations.

#### Scenario 1: All flash drives, maximized for performance by automatic configuration

This scenario is the default configuration. Given the options of all NVMe drives, all SSD drives, or a combination thereof, it offers:

- The best performance of sub-millisecond latency across random reads and writes.

- High IOPS.

- High I/O throughput.

The following image illustrates three configuration options that optimize performance. Option 1 uses four NVMe drives for capacity. Option 2 uses two NVMe drives for cache and four SSDs for capacity. Option 3 uses four SSDs for capacity.

:::image type="content" source="../media/3-all-flash-automatic.png" alt-text="Diagram that shows three drive configuration options that optimize performance." border="false" lightbox="../media/3-all-flash-automatic.png":::

#### Scenario 2: Balancing performance and capacity

Less demanding workloads and higher storage capacity requirements might benefit from a hybrid configuration. This hybrid configuration consists of either NVMe drives or SSDs for cache, and strictly HDDs or a mix of HDDs and SSDs for capacity.

The following image illustrates three options that balance performance and capacity. The first option uses two NVMe drives for cache and four HDDs for capacity. The second option uses two SSDs for cache and four HDDs for capacity. The third option uses two NVMe drives for cache and a mix of SSDs and HDDs for capacity.

:::image type="content" source="../media/3-hybrid-automatic.png" alt-text="Diagram that shows three drive options that balance performance and capacity." border="false" lightbox="../media/3-hybrid-automatic.png":::

#### Scenario 3: Manual configurations containing dual-flash configurations, using slower flash drives to increase capacity

For workloads that require larger capacity but write infrequently, a few SSDs for caching together with many larger HDDs for capacity are likely to provide the optimal configuration. Examples of workloads that could benefit from this scenario are data archival or data warehouse solutions.

The following image illustrates three options that involve a dual-flash drive type and use slower flash drives to increase capacity. (These setups require manual configuration.) Option 1 uses two faster NVMe drives for cache and four slower NVMe drives for capacity. Option 2 uses two faster SSDs for cache and four slower SSDs for capacity. Option 3 uses two faster SSDs for cache along with a mix of slower SSDs and HDDs to provide capacity.

:::image type="content" source="../media/3-dual-flash-manual.png" alt-text="Diagram that shows three options that involve a dual-flash drive type and use slower flash drives to increase capacity." border="false" lightbox="../media/3-dual-flash-manual.png":::

> [!NOTE]
> Whenever drives are added or removed, the binding between cache and capacity drives is adjusted dynamically.

> [!NOTE]
> To optimize performance, you should ensure that the number of capacity drives equals a multiple of the number of cache drives.
