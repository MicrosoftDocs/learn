Contoso's merchandising question is answerable now, and the storefront never gave up a request unit to answer it. The operational data stays in Azure Cosmos DB, a continuously replicated Delta copy lives in Fabric OneLake, and no pipeline sits between them for anyone to own or repair.
## What you learned

- Azure Cosmos DB and Cosmos DB in Microsoft Fabric run one engine under two operational models, and billing, authentication, licensing, and regional control decide which one a workload belongs to.
- Mirroring requires an API for NoSQL account with continuous backup, a permanent setting, plus a custom role granting `readAnalytics`, an action no built-in role includes.
- Replication status is read from two columns together, and a **Last completed** timestamp stops advancing on a healthy mirror whose source container has no new writes.
- Mirrored tables are the union of every document shape in a container, and nested JSON arrives as a string column that `OPENJSON` expands, differently under `CROSS APPLY` than under `OUTER APPLY`.
- Transact-SQL and Spark read the same Delta files, and the Cosmos DB Spark connector is a separate path to the account for reverse ETL, charged in request units.

## Clean up resources

If you completed the exercise and don't plan to use the resources again, delete the Fabric items first and then the Azure resource group, so the mirrored database isn't left pointing at an account that no longer exists.

## Learn more

- [Mirroring Azure Cosmos DB](/fabric/mirroring/azure-cosmos-db)
- [Tutorial: Configure a Fabric mirrored database for Azure Cosmos DB](/fabric/mirroring/azure-cosmos-db-tutorial)
- [Limitations in Fabric mirrored databases from Azure Cosmos DB](/fabric/mirroring/azure-cosmos-db-limitations)
- [Monitor Fabric mirrored database replication](/fabric/mirroring/monitor)
- [Query nested data in Fabric mirrored databases](/fabric/mirroring/azure-cosmos-db-how-to-query-nested)
- [Access mirrored data in Lakehouse and notebooks](/fabric/mirroring/azure-cosmos-db-lakehouse-notebooks)
- [What is Cosmos DB in Microsoft Fabric?](/fabric/database/cosmos-db/overview)
- [Analytics and business intelligence on Azure Cosmos DB data](/azure/cosmos-db/analytics-and-business-intelligence-overview)
