### Pre-deployment planning

Before you start deploying things in Azure, it's important to understand what your requirements are and how they map to offerings in Azure SQL. Using what you learned in Module 1, it's time to make a plan. You need to determine the following:  

* Deployment method: GUI or unattended?
* Deployment option: VM, DB, Elastic Pool, MI, or Instance Pool?
* Purchasing model: DTU or vCore?
* Service tier (SLO): General purpose, business critical, or hyperscale?
* Hardware: Gen4, Gen5, or something new?
* Sizing: number of vCores and data max size?  
> The Data Migration Assistant tool (DMA) has a [SKU Recommender](https://docs.microsoft.com/sql/dma/dma-sku-recommend-sql-db?view=sql-server-ver15) that can help you determine the number of vCores and size if you are migrating.  

TODO -- add a bit more explanation here, leverage the slides.

### Deploy and verify  

Once you've completed your pre-deployment planning, it's time to deploy and verify that deployment. In this stage, you'll deploy Azure SQL (using the Azure portal or command-line), determine network configuration and how to connect, and run some queries that verify your deployment configuration.  

The next exercise will go through all the details involved in deploying an Azure SQL Database or an Azure SQL Managed Instance, and you will leverage the sandbox environment to deploy Azure SQL Database. After deployment, you'll get to leverage various deployment queries and pre-run SQL Notebooks in Azure Data Studio to compare SQL Database, SQL Managed Instance, and SQL Server 2019.  
