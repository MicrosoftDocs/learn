PostgreSQL is a mature, open-source Relational Database Management System (RDBMS). When you combine it with Azure Arc-enabled deployments, it can scale queries across multiple machines. Using the Hyperscale model, the PostgreSQL query engine parallelizes incoming SQL queries across servers for faster responses on large datasets. 
Azure Arc-enabled data services PostgreSQL Hyperscale is powered by the open-source Citus extension. The Citus extension enables hyperscale operations on a PostgreSQL deployment. Using a "shared-nothing" architecture of multiple nodes, the data is sharded across multiple systems. PostgreSQL Hyperscale is especially well suited to multi-tenant and real-time applications. It also works well for applications that have large-scale data with good candidates for a single distribution column. 
A PostgreSQL Hyperscale deployment requires three or more instances. The instances include a single *coordinator* node and two or more *worker* nodes. You can use a single node for testing and development. 
Data commands are sent to the coordinator node, which forwards them on to the worker nodes. The nodes store data in tables in one of three modes: 

- Distributed tables: Data that appears as a single table, horizontally partitioned across nodes in fragment tables called "shards". A single column called the *Distribution column* determines this layout and is an important design consideration for an application. 
- Reference tables: smaller tables that store data relevant to a particular purpose that an application uses for reference. Reference tables are stored on every worker node and not sharded. Reference tables have faster performance for lookup or other static data.
- Local tables: non-sharded data stored in a database on the coordinator node. This data is often used for security or other static uses and is rarely used in join queries. 

There are two important considerations for designing a solution that uses PostgreSQL Hyperscale: the Storage Classes in Kubernetes, and the application type.

## Storage Class considerations
Storage Classes are defined when you deploy a server group and cannot be changed after the deployment. Data and logs are stored in separate types of Storage Classes. Backup files can be stored on either a Storage Class or a Volume Claim. The choice depends on whether you need full, or point-in-time restore operations. 

## Application type considerations
The following types of applications benefit from a scale-out PostgreSQL Hyperscale deployment: 

- Organizations that host multiple applications that are often dedicated to a single client or location work well with a scale-out PostgreSQL Hyperscale. 
- Applications with many tables and schemas that service On-Line Transaction Processing (OLTP) or On-Line Analytical Processing (OLAP) workloads benefit from a scale-out architecture.
- Real-time applications that use a smaller number of tables with aggregated analytic queries.
- Applications that ingest a large set of mostly immutable data. 

## Comparison of features
Azure Arc-enabled data services PostgreSQL Hyperscale differs from a standard installation of PostgreSQL in the following ways:

- Databases: Deployments are limited to one database per server group.
- Backups: Point-in-time restore operations need to be applied to a second server group. A full-restore operation to the same server group is available for PostgreSQL version 12 and higher.
-  Security: Users and Roles are limited to the *postgres* standard user.

Azure Arc-enabled data services enables a PostgreSQL Hyperscale deployment anywhere that runs Kubernetes, given the proper sizing and other requirements. 
PostgreSQL can also be deployed in a Hyperscale format using Microsoft Azure as a service. In Azure Arc-enabled data services you’re responsible for the Kubernetes platform and the PostgreSQL deployment.  In Microsoft Azure deployments, you are only responsible for the PostgreSQL deployment. 

## Comparison of management capabilities
There are two primary interfaces for monitoring and managing an Azure Arc-enabled data services PostgreSQL Hyperscale deployment: Command-Line Interfaces (CLI) and Graphical User Interfaces (GUI). 

### Tools and utilities
In general, you can use graphical tools for discovery and exploration, and command-line tools for standardization and automation. These tools include:

- [The PostgreSQL *pgcli* utility](https://www.pgcli.com/)
- [The PostgreSQL *psql* utility](https://www.postgresql.org/docs/9.2/app-psql.html)
- [The PostgreSQL *pgAdmin* tool](https://www.pgadmin.org/)
- [The Azure portal interface](https://azure.microsoft.com/features/azure-portal/)
- [Azure Data Studio](https://azure.microsoft.com/services/developer-tools/data-studio/#overview)
- [The Microsoft Azure *az* command utility](/cli/azure)
- [Kubernetes native tools](https://kubernetes.io/docs/concepts/cluster-administration/)
- [Azure Arc-enabled PostgreSQL Hyperscale interfaces](/azure/azure-arc/data/using-extensions-in-postgresql-hyperscale-server-group)
- [Standard API calls to documented Microsoft Azure and Microsoft Azure Arc-enabled PostgreSQL](/azure/azure-arc/data/connectivity)

### Deployment model
Your deployment for your Azure Arc-enabled PostgreSQL environment is based on the management you need. You can use your own infrastructure for more control over security, hardware, and backups. Using an Azure infrastructure gives you more automated patching, higher availability and disaster recover, and a complete Service Level Agreement. 
