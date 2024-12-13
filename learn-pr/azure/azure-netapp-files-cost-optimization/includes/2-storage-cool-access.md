Using Azure NetApp Files storage with cool access, you can configure inactive data to move from Azure NetApp Files Standard, Premium, or Ultra service-level storage (the hot tier) to an Azure storage account (the cool tier). Enabling cool access moves inactive data blocks from the volume and the volume's snapshots to the cool tier, resulting in cost savings.

Azure NetApp Files supports three service levels that can be configured at capacity pool level (Standard, Premium and Ultra). Cool access is an additional service available at all service levels.

Cold means untouched per the Coolness period. Coolness period is user configurable: 2-183 days

Cool access saves costs by transparently moving cold data to a lower cost Azure storage. The feature retains transparent access to data for all users. Users don't see differences in the way data is presented and continue to have access to all files and folders transparently. 

The following diagram illustrates an application with a volume enabled for cool access.

:::image type="content" source="../media/2-cool-access.png" alt-text="Diagram of cool access." lightbox="../media/2-cool-access.png":::

* Data blocks are written with temperature value: hot (red squares).
* Temperature scan monitors the activity of each block and decreases the temperature value of un-accessed blocks during every scan until it becomes cold (charcoal squares).
    The default cooling period is 31 days (2-183 days).
* The tiering scan collects cold blocks (orange squares) and packages them into 4-MB objects.
* Objects are moved to Azure storage transparently.
    To apps and users, cold blocks appear as present in the live system.
* When an application or user access a cool data block, the block is recalled automatically and marked as hot. The block is again subjected to the cooling period. Note that large sequential reads are served directly from the cool tier. 

## Effects of cool access on data

This shows an example scenario of a dataset where 100% of the data is in the cool tier and how it warms over time. Randomly accessed data starts as part of a working set. As data loses relevance, it becomes "cool" and is eventually tiered off to the cool tier. Cool data might become hot again.

### 4K random read test

This section describes a 4K random-read test across 160 files totaling 10 TB of data. The following chart shows a test that ran over 2.5 days on the 10-TB working dataset. The dataset was completely cooled, and the buffers were cleared. This present an absolute worst-case of aged data.

:::image type="content" source="../media/2-cool-access-graph.png" alt-text="Graph showing cool access read I/OPs." lightbox="../media/2-cool-access-graph.png":::

### 64K sequential read test

Sequentially read blocks aren't rewarmed to the hot tier. This test provides the following data points:

- 100% hot tier dataset
- 100% cool tier dataset

The following table summarizes the test results that ran for 30 minutes to obtain a stable performance number.

| 64-k sequential | Read throughput |
| --- | ---- |
| Hot data	| 1683 MB/s |
| Cool data	| 899 MB/s |

#### Conclusion

If the working set is predictable, you can save cost by moving infrequently accessed data blocks to the cool tier. The 2-30 days wait range for cooling provides a large window for working sets that are rarely accessed after they're dormant or don't require the hot-tier speeds when they're accessed.

## Billing 

You can enable tiering at the volume level for a newly created capacity pool that uses the Standard, Premium, and Ultra service level. Billing is determined by:

- The capacity in the Standard, Premium, or Ultra service level.
- Unallocated capacity within the capacity pool.
- The capacity in the cool tier (by enabling tiering for volumes in a capacity pool).
- Network transfer between the hot tier and the cool tier at the rate that is determined by the markup on top of the transaction cost (GET and PUT requests) on blob storage and private link transfer in either direction between the hot tiers.

When you enable tiering for volumes, the capacity in the cool tier is at the rate of the cool tier. The remaining capacity is at the rate of the hot tier. The rate of the cool tier is lower than the hot tier's rate.

To learn more about billing, see [Azure NetApp Files storage with cool access](/azure/azure-netapp-files/cool-access-introduction).