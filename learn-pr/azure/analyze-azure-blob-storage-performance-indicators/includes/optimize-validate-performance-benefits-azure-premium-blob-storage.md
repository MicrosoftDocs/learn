Premium Blob Storage leverages the capabilities of the SSD technology to deliver significantly lower and more consistent storage latency, effectively minimizing the response times for both read and write operations across a range of object sizes.

## Increase operations speed

When working with analytical workloads, you might be able to realize additional performance gains by combining Premium Blob Storage with Azure Data Lake Storage Gen2. Azure Data Lake Storage Gen2 provides support for a hierarchical file structure that tends to further increase the speed of certain operations such as directory deletes and renames.

## Reduce storage cost

In certain cases, Premium Blob Storage can not only provide consistently low latency, but also reduce the overall cost of using storage. While Premium Blob Storage has a higher pricing per GB, it offers a lower transactional cost when compared to general-purpose v2 accounts. As a result, the charges associated with running highly transactional workloads might be lower, especially if the volume of write operations is high and the amount of data stored is not very large.

In most cases, workloads with a rate of more than 35 to 40 transactions per second per terabyte (TPS/TB) benefit from the use of Azure Premium Blob Storage from a cost perspective. To determine whether this applies in your case, you can use the following approach.

### Example scenario

Assume that your workload executes 700 million read operations and 300 million write operations in a 30-day month using a storage account that contains 5 TB of data. You can then calculate the resulting TPS/TB by dividing the number of operations by the number of days multiplied by the number of hours, minutes, and seconds, as illustrated by the following formula:

$${o = \frac{ n }{ d\ \times\ h\ \times\ m\ \times\ s }}$$

Where the variables are defined as follows:

- **o** = Operations per second
- **n** = Number of operations
- **d** = Days
- **h** = Hours
- **m** = Minutes
- **s** = Seconds

Using that formula, we can calculate the total transactions per second in the following examples:

- Write transactions per second = 300,000,000 / (30 x 24 x 60 x 60) = **116** (rounded to the nearest whole number)

- Read transactions per second = 700,000,000 / (30 x 24 x 60 x 60) = **270** (rounded to the nearest whole number)

- Total transactions per second = **270** + **116** = **386**

- With **5 TB** of data, this corresponds to **386 / 5** = **77** **TPS/TB**.

The following table illustrates the cost-effectiveness of Premium Blob Storage.

:::image type="content" source="../media/4-premium-performance-data-lake-storage-cost-analysis-table.png" alt-text="Table illustrating the cost-effectiveness of Premium Blob Storage." border="false":::

The table data is based on measurements derived from a Premium Blob Storage account with the Azure Data Lake Storage Gen2 hierarchical namespace enabled. Individual columns represent the total number of transactions per month and individual rows represent the percentage of read transactions for the corresponding total. Each cell in the table displays the percentage of cost reduction associated with a read transaction percentage.

For example, if the number of transactions exceeds 90M, and 70% of them are read transactions, using Azure Premium Blob Storage becomes more cost-effective.

If you prefer to evaluate cost effectiveness based on the number of transactions per second for each TB of data, then refer to the numbers that display in the row labeled TPS/TB at the bottom of the table.

Premium Blob Storage is available with locally redundant storage (LRS) and zone-redundant storage (ZRS) within an Azure region. You should deploy your application to compute instances in the same Azure region as the storage account to realize low latency end-to-end.
