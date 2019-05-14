Azure SQL Data Warehouse separates computation from the underlying storage, so you can scale your computing power independently of data storage. To do this, CPU, memory, and I/O are abstracted and bundled into units of compute scale called data warehouse units (DWUs).

A DWU represents an abstract, normalized measure of compute resources and performance. By changing the service level, you alter the number of DWUs that are allocated to the system. In turn, the performance and cost of the system are adjusted. To achieve higher performance, increase the number of DWUs. This also increases associated costs. To achieve a lower cost, reduce the number of DWUs. This lowers the performance. Storage and compute costs are billed separately, so changing the number of DWUs doesn't affect storage costs.

![Architecture of the massively parallel processing (MPP) engine](../media/4-mpp-engine.png)

SQL Data Warehouse uses a node-based architecture. Applications connect and issue T-SQL commands to a control node, which is the single point of entry for the data warehouse. The control node runs the massively parallel processing (MPP) engine, which optimizes queries for parallel processing. Then, it passes operations to compute nodes to do their work in parallel. Compute nodes store all user data in Azure Storage and run parallel queries. The Data Movement Service (DMS) is a system-level internal service that moves data across nodes as necessary to run queries in parallel and return accurate results.

## Control node

The control node is the brain of the data warehouse. It's the front end that interacts with all applications and connections. The MPP engine runs on the control node to optimize and coordinate parallel queries. When you submit a T-SQL query to the SQL data warehouse, the control node transforms it into queries that run against each distribution in parallel.

## Compute nodes

The compute nodes provide the computational power. Distributions map to compute nodes for processing. As you pay for more compute resources, SQL Data Warehouse remaps the distributions to the available compute nodes. The number of compute nodes ranges from 1 to 60 and is determined by the service level for the data warehouse.

## Data Movement Service

DMS is the data transport technology that coordinates data movement between compute nodes. When SQL Data Warehouse runs a query, the work is divided into 60 smaller queries that run in parallel. Each of the 60 smaller queries runs on one of the underlying data distributions. A distribution is the basic unit of storage and processing for parallel queries that run on distributed data. Some queries require data movement across nodes to ensure that parallel queries return accurate results. When data movement is required, DMS ensures that the correct data gets to the correct location.