Premium Blob Storage leverages the capabilities of the SSD technology to deliver significantly lower and more consistent storage latency, effectively minimizing the response times for both read and write operations across a range of object sizes.

## Increase operations speed

When working with analytical workloads, you might be able to realize additional performance gains by combining Premium Blob Storage with Azure Data Lake Storage Gen2. Azure Data Lake Storage Gen2 provides support for a hierarchical file structure that tends to further increase the speed of certain operations such as directory deletes and renames.

## Reduce storage cost

In certain cases, Premium Blob Storage can not only provide consistently low latency, but also reduce the overall cost of using storage. While Premium Blob Storage has a higher pricing per GB, it offers a lower transactional cost when compared to general-purpose v2 accounts. As a result, the charges associated with running highly transactional workloads might be lower, especially if the volume of write operations is high and the amount of data stored is not very large.

In most cases, workloads with a rate of more than 35 to 40 transactions per second per terabyte (TPS/TB) benefit from the use of Azure Premium Blob Storage from a cost perspective. To determine whether this applies in your case, you can use the following approach.

### Example scenario

Assume that your workload executes 700 million read operations and 300 million write operations in a 30-day month using a storage account that contains 5 TB of data. You can then calculate the resulting TPS/TB by dividing the number of operations by the number of days multiplied by the number of hours, minutes, and seconds, as illustrated by the following forumla:

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

<!-- :::image type="content" source="../media/4-premium-performance-data-lake-storage-cost-analysis-table.png" alt-text="Table illustrating the cost-effectiveness of Premium Blob Storage." border="false"::: -->

<table style="border-collapse:collapse; border:1px solid #999;">
	<tr>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">&nbsp;</th>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">30K</th>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">100K</th>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">500K</th>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">10M</th>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">50M</th>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">70M</th>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">80M</th>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">90M</th>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">100M</th>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">200M</th>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">500M</th>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">1B</th>
	</tr>
	<tr>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">0%</th>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-723%</td>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-704%</td>
		<td style="background:#f88;text-align:right;padding:5px;color:#000;border:1px solid #999;">-612%</td>
		<td style="background:#fcc;text-align:right;padding:5px;color:#000;border:1px solid #999;">-111%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">22%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">34%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">38%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">41%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">43%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">54%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">60%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">63%</td>
	</tr>
	<tr>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">10%</th>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-723%</td>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-706%</td>
		<td style="background:#f88;text-align:right;padding:5px;color:#000;border:1px solid #999;">-621%</td>
		<td style="background:#fcc;text-align:right;padding:5px;color:#000;border:1px solid #999;">-125%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">18%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">31%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">35%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">38%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">41%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">53%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">60%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">62%</td>
	</tr>
	<tr>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">20%</th>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-724%</td>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-709%</td>
		<td style="background:#f88;text-align:right;padding:5px;color:#000;border:1px solid #999;">-631%</td>
		<td style="background:#fcc;text-align:right;padding:5px;color:#000;border:1px solid #999;">-141%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">13%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">27%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">32%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">35%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">38%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">51%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">59%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">62%</td>
	</tr>
	<tr>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">30%</th>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-725%</td>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-711%</td>
		<td style="background:#f88;text-align:right;padding:5px;color:#000;border:1px solid #999;">-641%</td>
		<td style="background:#fcc;text-align:right;padding:5px;color:#000;border:1px solid #999;">-160%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">7%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">23%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">28%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">32%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">35%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">50%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">59%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">62%</td>
	</tr>
	<tr>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">40%</th>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-726%</td>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-714%</td>
		<td style="background:#f88;text-align:right;padding:5px;color:#000;border:1px solid #999;">-651%</td>
		<td style="background:#fcc;text-align:right;padding:5px;color:#000;border:1px solid #999;">-182%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">-1%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">17%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">23%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">27%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">31%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">47%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">58%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">61%</td>
	</tr>
	<tr>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">50%</th>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-727%</td>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-716%</td>
		<td style="background:#f88;text-align:right;padding:5px;color:#000;border:1px solid #999;">-662%</td>
		<td style="background:#faa;text-align:right;padding:5px;color:#000;border:1px solid #999;">-210%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">-11%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">9%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">16%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">21%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">25%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">45%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">57%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">60%</td>
	</tr>
	<tr>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">60%</th>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-727%</td>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-719%</td>
		<td style="background:#f88;text-align:right;padding:5px;color:#000;border:1px solid #999;">-673%</td>
		<td style="background:#faa;text-align:right;padding:5px;color:#000;border:1px solid #999;">-244%</td>
		<td style="background:#fee;text-align:right;padding:5px;color:#000;border:1px solid #999;">-25%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">-1%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">6%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">12%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">17%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">40%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">55%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">59%</td>
	</tr>
	<tr>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">70%</th>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-728%</td>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-721%</td>
		<td style="background:#f88;text-align:right;padding:5px;color:#000;border:1px solid #999;">-684%</td>
		<td style="background:#faa;text-align:right;padding:5px;color:#000;border:1px solid #999;">-289%</td>
		<td style="background:#fee;text-align:right;padding:5px;color:#000;border:1px solid #999;">-45%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">-17%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">-7%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">0%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">6%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">34%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">52%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">59%</td>
	</tr>
	<tr>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">80%</th>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-729%</td>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-724%</td>
		<td style="background:#f88;text-align:right;padding:5px;color:#000;border:1px solid #999;">-696%</td>
		<td style="background:#faa;text-align:right;padding:5px;color:#000;border:1px solid #999;">-348%</td>
		<td style="background:#fee;text-align:right;padding:5px;color:#000;border:1px solid #999;">-76%</td>
		<td style="background:#fee;text-align:right;padding:5px;color:#000;border:1px solid #999;">-41%</td>
		<td style="background:#fee;text-align:right;padding:5px;color:#000;border:1px solid #999;">-30%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">-20%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">-12%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">24%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">48%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">56%</td>
	</tr>
	<tr>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">90%</th>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-730%</td>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-726%</td>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-708%</td>
		<td style="background:#faa;text-align:right;padding:5px;color:#000;border:1px solid #999;">-431%</td>
		<td style="background:#fcc;text-align:right;padding:5px;color:#000;border:1px solid #999;">-133%</td>
		<td style="background:#fee;text-align:right;padding:5px;color:#000;border:1px solid #999;">-87%</td>
		<td style="background:#fee;text-align:right;padding:5px;color:#000;border:1px solid #999;">-71%</td>
		<td style="background:#fee;text-align:right;padding:5px;color:#000;border:1px solid #999;">-59%</td>
		<td style="background:#fee;text-align:right;padding:5px;color:#000;border:1px solid #999;">-48%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">4%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">39%</td>
		<td style="background:#6c8;text-align:right;padding:5px;color:#000;border:1px solid #999;">52%</td>
	</tr>
	<tr>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">100%</th>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-730%</td>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-729%</td>
		<td style="background:#f66;text-align:right;padding:5px;color:#000;border:1px solid #999;">-720%</td>
		<td style="background:#f88;text-align:right;padding:5px;color:#000;border:1px solid #999;">-556%</td>
		<td style="background:#faa;text-align:right;padding:5px;color:#000;border:1px solid #999;">-266%</td>
		<td style="background:#faa;text-align:right;padding:5px;color:#000;border:1px solid #999;">-203%</td>
		<td style="background:#fcc;text-align:right;padding:5px;color:#000;border:1px solid #999;">-180%</td>
		<td style="background:#fcc;text-align:right;padding:5px;color:#000;border:1px solid #999;">-160%</td>
		<td style="background:#fcc;text-align:right;padding:5px;color:#000;border:1px solid #999;">-144%</td>
		<td style="background:#fee;text-align:right;padding:5px;color:#000;border:1px solid #999;">-55%</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">12%</td>
		<td style="background:#9da;text-align:right;padding:5px;color:#000;border:1px solid #999;">38%</td>
	</tr>
	<tr>
		<th style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">TPS/TB</th>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">0.01</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">0.04</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">0.19</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">3.86</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">19.29</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">27.01</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">30.86</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">34.72</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">38.58</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">77.2</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">192.9</td>
		<td style="background:#fff;text-align:right;padding:5px;color:#000;border:1px solid #999;">385.8</td>
	</tr>
</table>

The table data is based on measurements derived from a Premium Blob Storage account with the Azure Data Lake Storage Gen2 hierarchical namespace enabled. Individual columns represent the total number of transactions per month and individual rows represent the percentage of read transactions for the corresponding total. Each cell in the table displays the percentage of cost reduction associated with a read transaction percentage.

For example, if the number of transactions exceeds 90M, and 70% of them are read transactions, using Azure Premium Blob Storage becomes more cost-effective.

If you prefer to evaluate cost effectiveness based on the number of transactions per second for each TB of data, then refer to the numbers that display in the row labeled TPS/TB at the bottom of the table.

Premium Blob Storage is available with locally redundant storage (LRS) and zone-redundant storage (ZRS) within an Azure region. You should deploy your application to compute instances in the same Azure region as the storage account to realize low latency end-to-end.
