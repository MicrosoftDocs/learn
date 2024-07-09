When the requirements of a database surpass the capabilities of the infrastructure that supports it and you’ve hit vertical scaling limits, you need to migrate the database to a new infrastructure. The need to migrate can arise for many reasons, for example if any application’s query and data growth begin consuming too much memory or processor time. A managed cloud solution like Azure Database for MySQL provides features like replication and reduces maintenance costs as compared to a self-hosted server. There are also reasons to migrate in nonproduction use cases, such as setting up development or test databases. 

At an abstract level, database migrations are relatively simple to perform; stop one or more applications, export data from the source database, import that data to a new database, repoint one or more applications to the new database, and then restart them. In practice, however, migrations warrant various considerations, such as available downtime or the level of export/import customization that might be required.

## Example scenario

Suppose you work at an e-commerce startup, Wingtip Toys. Previously, you evaluated a cloud migration and chose to migrate to Azure Database for MySQL - Flexible Server. You also selected configuration settings and tested your application with the new database. Now, it's time to migrate the database from your on-premises MySQL server to an Azure Database for MySQL flexible server. 

Wingtip Toys will launch a holiday marketing campaign next quarter, so it's vital to complete the database migration before then. The team is familiar with managing a MySQL server but has never migrated a database to the cloud before. 

Currently, Wingtip Toys’ customers are US-centric, and there is predictable daytime traffic. You expect that this will change after the campaign launches and as the holiday nears, when people will shop later at night and new toys will attract a more international audience.

## What you will do

You'll first review the considerations for and phases for migrating a database. Then you will review available tools and select the best option for your migration. Lastly, after deciding on the approach, you will migrate a database from an on-premises server to a new Azure Database for MySQL flexible server.

## Primary goal

Your main goal is to understand how to approach and perform a database migration. You'll use this knowledge to migrate your on-premises server to a cloud database service: Azure Database for MySQL. 
