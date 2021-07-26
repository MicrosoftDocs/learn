# Introducing Azure Arc-enabled PostgreSQL 
PostgreSQL is a mature, open-source Relational Database Management System (RDBMS), and when combined with Azure Arc-enabled deployments, it can scale queries horizontally across multiple machines. The PostgreSQL query engine parallelizes incoming SQL queries across servers for faster responses on large datasets. 
Azure Arc enabled data services PostgreSQL Hyperscale is powered by the open-source Citus extension that enables a hyperscale operations on a PostgreSQL deployment. Using a "shared-nothing" architecture of multiple nodes, the data is sharded across multiple systems. PostgreSQL Hyperscale is especially well-suited to multi-tenant and real-time applications that benefit from large-scale data that has good candidates for a single distribution column. 
A PostgreSQL Hyperscale deployment needs three or more instances, consisting of a single coordinator node and two or more worker nodes. One node serving both roles is possible for testing and development. Data commands are sent to the coordinator node, which forwards them on to the worker nodes. The nodes store data in tables one of three modes: 
- Distributed tables: Data that appear as a single table, horizontally partitioned across nodes in fragment tables called "shards". A single column called the Distribution column determines this layout and is an important design consideration for an application. 
- Reference tables: smaller tables that store data relevant to a particular purpose that an application uses for reference, these tables are stored on every worker node and not sharded. This allows for faster performance for lookup or other more static data.
- Local tables: Tables that store non-sharded data in a standard PostgreSQL database on the coordinator node. This data is often used for security or other constructs, not often used in join queries. 
There are two important considerations for designing a solution that uses PostgreSQL Hyperscale: Defining the Storage Classes in your Kubernetes environment, and determining the application type that will use the solution.
## Storage Class considerations
It's important to consider the Storage classes in a Kubernetes deployment for the data, logs, and backups for a PostgreSQL Hyperscale deployment. Storage Classes are defined when you deploy a server group and cannot be changed after the deployment. Data and logs are stored in separate types of Storage Classes, and backup files can be stored on either a Storage Class or a Volume Claim, depending on whether there will be full, or point-in-time restore operations. 
## Application type considerations
Data Design is an integral part of configuration of a deployment, and it's important to thoroughly understand the application that will use the data. Two types of applications benefit from a scale-out PostgreSQL Hyperscale deployment: 
- Multi-tenant applications: Organizations that host multiple applications that are often dedicated to a single client or location, with many tables and schemas that service On-Line Transaction Processing 
- (OLTP) or On-Line Analytical Processing (OLAP) workloads benefit from a well-designed layout of a scale-out architecture.
- Real-time applications: These applications use a smaller number of tables with aggregated analytic queries, ingesting a large set of mostly immutable data benefit from a scale-out architecture using PostgreSQL Hyperscale. 
## Comparison of features
Azure Arc enabled data services PostgreSQL Hyperscale differs from a standard installation of PostgreSQL in the following ways:
- Databases: Deployments are limited to one database per server group.
- Backups: Point-in Time restore operations need to be applied to a second server group. A full-restore operation to the same server group is available for PostgreSQL version 12 and higher.
-  Security: Users and Roles are limited to the postgres standard user.
PostgreSQL can also be deployed in a Hyperscale format using Microsoft Azure as a service. Azure Arc enabled data services PostgreSQL Hyperscale differs from Azure PostgreSQL Hyperscale service in that with Azure Arc enabled data services you are responsible for the Kubernetes platform and the PostgreSQL deployment, and in Microsoft Azure you are only responsible for the PostgreSQL deployment. Azure Arc enabled data services enables a PostgreSQL Hyperscale deployment anywhere that runs Kubernetes, given the proper sizing and other requirements. 
## Comparison of management capabilities
There are two primary interfaces for monitoring and managing an Azure Arc enabled data services PostgreSQL Hyperscale deployment: Command-Line Interfaces (CLI) and Graphical User Interfaces (GUI). In general, you will use the graphical tools for discovery and exploration, and the command-line tools for standardization and automation. 
- pgcli 
- psql
- pgAdmin
- Portal
- ADS
- az 
- Kubernetes Native
- Azure Arc-enabled PostgreSQL Hyperscale interfaces
- Standard API calls: https://docs.microsoft.com/en-us/azure/azure-arc/data/get-connection-endpoints-and-connection-strings-postgres-hyperscale 
