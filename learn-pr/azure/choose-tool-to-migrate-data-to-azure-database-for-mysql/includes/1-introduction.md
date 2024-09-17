 When a database requires more than its infrastructure can support, you need to migrate to a new infrastructure. The database migration process is relatively simple. Begin by stopping one or more apps, then export data from the source database. Next, import that data to a new database, repoint one or more apps to the new database, and then restart the apps. Note, however, that there are factors to consider like available downtime or the required export/import customization level. Azure Database for MySQL is a managed cloud solution that provides features such as replication and that reduces maintenance costs compared to a self-hosted server.

## Example scenario

Suppose that you work at an e-commerce startup, Wingtip Toys. You evaluated a cloud migration and chose to migrate to Azure Database for MySQL - Flexible Server. You also selected configuration settings and tested your application with the new database. It's time to migrate the database from your on-premises MySQL server to an Azure Database for MySQL flexible server.

Wingtip Toys will launch a holiday marketing campaign next quarter, so it's vital to complete the database migration before then. The team is familiar with managing a MySQL server but has never migrated a database to the cloud.

Currently, Wingtip Toys' customers are US-centric, and there's predictable daytime traffic. You expect this pattern to change after the campaign launches and as the holiday nears, when people shop later at night, and new toys will attract a more international audience.

## What you will do

You'll first review the considerations and phases of migrating a database. Then, you'll review available tools and select the best option for your migration. Lastly, after deciding on the approach, you'll migrate a database from an on-premises server to a new Azure Database for MySQL flexible server.

## Primary goal

By the end of this module, you'll understand how to approach and perform a database migration. You'll use this knowledge to migrate your on-premises server to a cloud database service: Azure Database for MySQL.
