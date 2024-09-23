Our goal in this module was to move an ASP.NET web application from a company's hosting environment to Azure App Service.

Using a simulated environment, you used the Azure App Service Migration Assistant to first perform an assessment of an application to check for dependencies on lower-level services available from Windows Server and Internet Information Services (IIS). The Migration Assistant determined that nothing was preventing you from migrating the application to Azure App Service. So you supplied the Migration Assistant with details like the target resource group and the URL, and it performed the migration for you.

Without the Migration Assistant, you might have needed to manually review the web application's source code and compare against a list of known issues that might prevent an ASP.NET web application from being deployed to Azure App Service. This entire process might take days or weeks, depending on your familiarity with the code base, Windows Server, IIS, and more.

The Azure App Service Migration Assistant provides dramatic business impact, speeding your efforts in moving to the cloud.

[!INCLUDE[](../../../includes/azure-sandbox-cleanup.md)]

## Next steps

If you're using this as a guide to perform your own web application migration, think about the following steps that we didn't perform in the exercise:

- Manually moving application settings and connection strings in your web.config file to App Service application settings.
- Migrating data from an on-premises SQL Server database to an Azure SQL database.
- Setting up an TLS/SSL certificate.
- Setting up custom domain names.
- Setting up permissions in Microsoft Entra ID.

If your next step is to migrate your data from an on-premises SQL Server database to an Azure SQL database, you might find the following module useful:

[Assess and convert SQL Server Databases using the Data Migration Assistant (DMA)](/training/modules/assess-convert-sql-server-databases-using-dma/)

## Additional reading

- [Azure App Service Migration Assistant wiki](https://github.com/Azure/App-Service-Migration-Assistant/wiki/Readiness-Checks)
- [Azure App Service Hybrid Connections](/azure/app-service/app-service-hybrid-connections)
- [Overview of Data Migration Assistant](/sql/dma/dma-overview?view=sql-server-2017)
- [App Service overview](/azure/app-service/overview)
- [Assess and convert SQL Server Databases using the Data Migration Assistant (DMA)](/training/modules/assess-convert-sql-server-databases-using-dma/).
