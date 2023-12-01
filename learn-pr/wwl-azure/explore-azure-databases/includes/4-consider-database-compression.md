In configurations where I/O bandwidth can become a limiting factor, every measure that reduces IOPS might help to stretch the workload one can run in IaaS scenarios. Applying SQL Server PAGE compression is recommended by both SAP and Microsoft before uploading an existing SAP database to Azure.

The recommendation for database compression before uploading to Azure is provided for the following reasons:

- The amount of data to be uploaded is lower.
- The duration of the compression execution is shorter assuming that one can use stronger hardware with more CPUs or higher I/O bandwidth or less I/O latency on-premises.
- Smaller database sizes might lead to less costs for disk allocation.
