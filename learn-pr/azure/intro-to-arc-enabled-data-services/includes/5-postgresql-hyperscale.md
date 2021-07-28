# Introducing Azure Arc-enabled PostgreSQL 
PostgreSQL is a mature, open-source Relational Database Management System (RDBMS). When combined with Azure Arc-enabled deployments, it can scale queries horizontally across multiple machines. Using the Hyperscale model, the PostgreSQL query engine parallelizes incoming SQL queries across servers for faster responses on large datasets. 
Azure Arc enabled data services PostgreSQL Hyperscale is powered by the open-source Citus extension. The Citus extension enables hyperscale operations on a PostgreSQL deployment. Using a "shared-nothing" architecture of multiple nodes, the data is sharded across multiple systems. PostgreSQL Hyperscale is especially well suited to multi-tenant and real-time applications. It also works well for applications that have large-scale data with good candidates for a single distribution column. 
A PostgreSQL Hyperscale deployment needs three or more instances, consisting of a single coordinator node and two or more worker nodes. A single node is possible for testing and development. 
Data commands are sent to the coordinator node, which forwards them on to the worker nodes. The nodes store data in tables one of three modes: 
- Distributed tables: Data that appears as a single table, horizontally partitioned across nodes in fragment tables called "shards". A single column called the *Distribution column* determines this layout and is an important design consideration for an application. 
- Reference tables: smaller tables that store data relevant to a particular purpose that an application uses for reference. Reference tables are stored on every worker node and not sharded. Reference tables have faster performance for lookup or other static data.
- Local tables: Tables that store non-sharded data in a standard PostgreSQL database on the coordinator node. This data is often used for security or other constructs, not often used in join queries. 
There are two important considerations for designing a solution that uses PostgreSQL Hyperscale: Defining the Storage Classes in your Kubernetes environment, and determining the application type that will use the solution.
## Storage Class considerations
It's important to consider the Storage classes in a Kubernetes deployment for the data, logs, and backups for a PostgreSQL Hyperscale deployment. Storage Classes are defined when you deploy a server group and cannot be changed after the deployment. Data and logs are stored in separate types of Storage Classes. Backup files can be stored on either a Storage Class or a Volume Claim, depending on whether there will be full, or point-in-time restore operations. 
## Application type considerations
Data Design is an integral part of configuration of a deployment, and it's important to thoroughly understand the application that will use the data. Two types of applications benefit from a scale-out PostgreSQL Hyperscale deployment: 
- Multi-tenant applications: Organizations that host multiple applications that are often dedicated to a single client or location work well with a scale-out PostgreSQL Hyperscale. 
- Applications with many tables and schemas that service On-Line Transaction Processing (OLTP) or On-Line Analytical Processing (OLAP) workloads benefit from a scale-out architecture.
- Real-time applications: These applications use a smaller number of tables with aggregated analytic queries. Applications that ingest a large set of mostly immutable data benefits from a scale-out architecture using PostgreSQL Hyperscale. 
## Comparison of features
Azure Arc enabled data services PostgreSQL Hyperscale differs from a standard installation of PostgreSQL in the following ways:
- Databases: Deployments are limited to one database per server group.
- Backups: Point-in Time restore operations need to be applied to a second server group. A full-restore operation to the same server group is available for PostgreSQL version 12 and higher.
-  Security: Users and Roles are limited to the postgres standard user.
Azure Arc enabled data services enables a PostgreSQL Hyperscale deployment anywhere that runs Kubernetes, given the proper sizing and other requirements. 
PostgreSQL can also be deployed in a Hyperscale format using Microsoft Azure as a service. In Azure Arc enabled data services you are responsible for the Kubernetes platform and the PostgreSQL deployment.  In Microsoft Azure deployments you are only responsible for the PostgreSQL deployment. 
## Comparison of management capabilities
There are two primary interfaces for monitoring and managing an Azure Arc enabled data services PostgreSQL Hyperscale deployment: Command-Line Interfaces (CLI) and Graphical User Interfaces (GUI). 
### Tools and Utilities
In general, you will use the graphical tools for discovery and exploration, and the command-line tools for standardization and automation. These tools include:
- The PostgreSQL *pgcli* utility
- The PostgreSQL *psql* utility
- The PostgreSQL *pgAdmin* tool
- The Microsoft Azure Portal interface
- Azure Data Studio
- The Microsoft Azure *az* command utility
- Kubernetes native tools
- Azure Arc-enabled PostgreSQL Hyperscale interfaces
- Standard API calls to documented Microsoft Azure and Microsoft Azure Arc-enabled PostgreSQL

### Deployment Model
Your deployment for your Azure Arc-enabled PostgreSQL environment is based on the level of management you need. For more control over security, hardware, and backups, your own infrastructure is a good choice. For more automated patching, higher availability and disaster recover, and a Service Level Agreement, using the Azure infrastructure is a better choice. 
