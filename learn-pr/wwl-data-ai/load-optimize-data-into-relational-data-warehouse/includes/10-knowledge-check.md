

## Multiple Choice
Which is the default distribution used for a table in Synapse Analytics?
() HASH. {{Incorrect. Hash distributions are explicitly defined and require a hashing columns to be defined for the distribution function. Hash distributions are best used for larger Fact tables.}}
(x) Round-Robin. {{Correct. Round-Robin is the default distribution created for a table and delivers fast performance when used for loading data but may negatively impact larger queries.}}
() Replicated Table. {{Incorrect. Replicated tables are explicitly defined and result in a copy of the table being made on each compute node.}}

## Multiple Choice
Which Index Type offers the highest compression? 
(x) Columnstore. {{Correct. This is the default index type created for a table. It works on segments of rows that get compressed and optimized by column.}}
( ) Rowstore. {{Incorrect. Rowstore indexes write multiple data types and values per row of data and so compression functions are less likely to be able to reduce the size through pattern matching and offsets.}}
( ) Heap. {{Incorrect. Heaps offer a fast method of writing since not additional operations need to  be performed on the data, they do not perform well for queries as the are unsorted and generally uncompressed.}}

## Multiple Choice
How do column statistics improve query performance?
( ) By keeping track of which columns are being queried. {{Incorrect. There is no function that tracks which columns are participating in a query.}}
(x) By keeping track of how much data exists between ranges in columns. {{Correct. It tracks cardinality and range density to determine which data access paths return the fewest rows for speed.}}
( ) By caching column values for queries. {{{{Incorrect. This is similar to but exactly describing Result-set caching.}}

## Multiple Choice
How does splitting source files help maintain good performance when loading into Synapse Analytics?
() optimized processing of smaller file sizes. {{Incorrect. SQL Pools can process large files more efficiently than smaller ones. }}
(x) Compute node to storage segment alignment. {{Correct. SQL Pools have 60 storage segments. Compute can also scale to 60 nodes and so optimizing for alignment of these 2 resources can dramatically decrease load times.}}
() Reduced possibility of data corruptions. {{Incorrect. Data corruptions have an impact on success, not speed. Splitting files should affect probability of corruptions.}}

## Multiple Choice
Which Workload Management capability manages minimum and maximum resource allocations during peak periods? 
(x) Workload Isolation. {{Correct. Workload Isolation assigns maximum and minimum usage values for varying resources under load. These adjustments can be done live without having to take the SQL Pool offline.}}
( ) Workload Importance. {{Incorrect. Workload Importance allows higher priority queries to receive resources immediately regardless of queue length.}}
( ) Workload Containment. {{Incorrect. Workload Containment refers to limiting the amount of resources a workload group can consume.}}

## Multiple Choice
Which T-SQL Statement loads data directly from Azure Storage?
( ) LOAD DATA. {{Incorrect. LOAD DATA is a databricks command that loads data into a Hive table from a directory or file.}}
(x) COPY. {{Correct. The T-SQL COPY Statement reads data from Azure Blob Storage or the Azure Data Lake and inserts it into a table within the SQL Pool.}}
( ) INSERT FROM FILE. {{{{Incorrect. Insert from file is not a valid T-SQL Statement.}}