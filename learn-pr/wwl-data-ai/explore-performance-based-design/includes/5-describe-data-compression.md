As mentioned above, one of the key benefits to columnstore indexes is the ability to compress your data. In addition to columnstore compression, SQL Server offers a few other options for compressing data. While SQL Server still stores compressed data on 8 KB pages, when the data is compressed, more rows of data can be stored on a given page, which allows the query to read fewer pages. Reading fewer pages has a twofold benefit: it reduces the amount of physical IO performed and it allows more rows to be stored in the buffer pool, making more efficient use of memory. The tradeoffs to compression are that it does require a small amount of CPU overhead, however in most cases the storage IO benefits far outweigh any additional processor usage.

:::image type="content" source="../media/module-55-optimize-queries-final-16.png" alt-text="Query against non-compressed and page compressed table":::

The image above shows this performance benefit. These tables have same underlying indexes; the only difference is that the clustered and nonclustered indexes on the Production.TransactionHistory_Page table are page compressed. The query against the page compressed object performs 72% fewer logical reads than the query that uses the uncompressed objects.

Compression is implemented in SQL Server at the object level. Each index or table can be compressed individually, and you have the option of compressing partitions within a partitioned table or index. You can evaluate how much space you will save by using the sp_estimate_data_compression_savings system stored procedure. Prior to SQL Server 2019, this procedure did not support columnstore indexes, or columnstore archival compression.

## Row compression

Row compression is fairly basic and does not incur much overhead; however, it does not offer the same amount of compression (measured by the percentage reduction in storage space required) that page compression may offer. Row compression basically stores each value in each column in a row in the minimum amount of space needed to store that value. It uses a variable-length storage format for numeric data types like integer, float, and decimal, and it stores fixed-length character strings using variable length format.

## Page compression

Page compression is a superset of row compression, as all pages will initially be row compressed prior to applying the page compression. Then a combination of techniques called prefix and dictionary compression are applied to the data. Prefix compression eliminates redundant data in a single column, storing pointers back to the page header. After that step, dictionary compression searches for repeated values on a page and replaces them with pointers, further reducing storage. The more redundancy in your data, the greater the space savings when you compress your data.

## Columnstore archival compression

Columnstore objects are always compressed, however, they can be further compressed using archival compression, which uses the Microsoft XPRESS compression algorithm on the data. This type of compression is best used for data that is infrequently read, but needs to be retained for regulatory or business reasons. While this data is further compressed, the CPU cost of decompression tends to outweigh any performance gains from IO reduction.
