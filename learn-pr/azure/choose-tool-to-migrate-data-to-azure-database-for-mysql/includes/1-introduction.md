Data migrations are needed for many reasons, such as when an application's query and data growth consume too much memory or processor time. When the requirements of a database surpass the capabilities of the infrastructure that supports it, and you've reached vertical scaling limits, you need to migrate the database to a new infrastructure. Database migrations are relatively simple: stop one or more applications, export data from the source database, import that data to a new database, re-point one or more applications to the new database, and restart them. However, there are considerations, such as available downtime or the required export/import customization level, during migrations. Azure Database for MySQL is a managed cloud solution that provides features like replication and reduces maintenance costs compared to a self-hosted server. 

## Example scenario

Suppose you work at an e-commerce startup, Wingtip Toys. Previously, you evaluated a cloud migration and chose to migrate to Azure Database for MySQL - Flexible Server. You also selected configuration settings and tested your application with the new database. It's time to migrate the database from your on-premises MySQL server to an Azure Database for MySQL flexible server.

Wingtip Toys will launch a holiday marketing campaign next quarter, so it's vital to complete the database migration before then. The team is familiar with managing a MySQL server but has never migrated a database to the cloud.

Currently, Wingtip Toys' customers are US-centric, and there's predictable daytime traffic. You expect this will change after the campaign launches and as the holiday nears, when people shop later at night, new toys will attract a more international audience.

## What you will do

You'll first review the considerations and phases of migrating a database. Then, you'll review available tools and select the best option for your migration. Lastly, after deciding on the approach, you'll migrate a database from an on-premises server to a new Azure Database for MySQL flexible server.

## What is the main goal?

By the end of this module, you'll understand how to approach and perform a database migration. You'll use this knowledge to migrate your on-premises server to a cloud database service: Azure Database for MySQL.
 