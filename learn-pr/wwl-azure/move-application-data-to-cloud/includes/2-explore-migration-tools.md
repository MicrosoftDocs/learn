Moving data from an on-premises data source to the cloud can be intimidating. We tend to worry about data loss or migrating from one database type to a different one. Our data is essential to the work we do so getting a migration right is a non-negotiable. In this unit, we'll look at resources that may help put your mind at ease and make the transition smoother.

## The guides

Before getting starting with migration tools, it can be helpful to explore the [migration guides](https://learn.microsoft.com/data-migration/) Microsoft has put together. These guides explain how to move from a variety of sources to various destinations. For example, the guides provide instructions on moving your data from the following sources and destinations (this is just a small sample):

| Source | Destination |
| - | - |
| SQL Server | SQL Server upgrade, Azure SQL Database, SQL Server on Azure VMs |
| Oracle | SQL Server, Azure SQL Database, Azure SQL Managed Instance |
| MySQL | Azure Database for MySQL, SQL Server, Azure SQL Database |
| NoSQL | Relational to Azure Cosmos DB, MongoDB to Azure Cosmos DB, Cassandra to Azure Cosmos DB |

There are many other guides to explore as well. Familiarizing yourself with the information in these guides should help make your migration path clearer.

## Azure Migrate

Azure Migrate is a tool designed to assist moving servers, databases, and web apps to Azure. Azure Migrate is actually a collection of tools that can assist with assessing your migration and actually performing the migration itself.

To get started with Azure Migrate, you set up a project. A project is used to store the discovery, assessment and migration metadata reported by your on-premises environment.

Azure Migrate includes a tool called *Data Migration Assistant*. This stand-alone tool evaluates your on-premises SQL Server and can point to problems before you migrate. Common issues that may block a successful migration will show up in the tool. It will let you know if a feature you're using in your existing environment isn't supported on the cloud.
