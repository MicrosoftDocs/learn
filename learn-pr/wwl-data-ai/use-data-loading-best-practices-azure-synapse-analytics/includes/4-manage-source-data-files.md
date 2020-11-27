When loading data into Azure Synapse Analytics on a scheduled basis it’s important to try to reduce the time taken not perform the data load, and to minimize the resources needed as much as possible to maintain good performance, in a cost effective way

Strategies for managing source data files include:

## Maintain a well-engineered data lake structure

Maintaining a well-engineered Data Lake structure allows you to know that the data your loading on a recurring basis is consistent with the data requirements for your system. This is less important if your load is a once off or exploratory rather than analytical. Some strategies include folder hierarchies based on source system, and date/time or file format and focus.

In general, having well defined “zones” established for the data coming into the Data Lake and cleansing and transformation tasks that land the data you need in a curated and optimized state.

## Compress and optimize files

When loading large datasets, it’s best to leverage the compression capabilities of the file format. It ensures that less time is spent on the process of data transfers, leveraging instead the power of Azure Synapse’ Massively Parallel Processing (MPP) compute capabilities for decompression

It is fairly standard to maintain curated source files in columnar compressed file formats such as RC, Gzip, Parquet, and ORC, which is all supported import formats.

## Split source files

One of the key architectural components within Azure Synapse Analytics dedicated SQL pools is the decoupled storage that is segmented into 60 parts. You should maintain alignment to multiples of this number as much as possible depending on the file sizes that you are loading, and the number of compute nodes you have provisioned. Since there are 60 storage segments and a maximum of 60 MPP compute nodes within the highest performance configuration of SQL Pools, a 1:1 file to compute node to storage segment may be viable for ultra-high workloads, reducing the load times to the minimum possible. 
