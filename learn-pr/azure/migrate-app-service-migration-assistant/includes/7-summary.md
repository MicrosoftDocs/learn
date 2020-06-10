Our goal in this module was to move an ASP.NET web application from our company's hosting environment to Azure App Service.

Using a simulated environment, you used the Azure App Service Migration Assistant to first perform an assessment of our application to check for dependencies on lower-level services available from Windows Server and Internet Information Services. The Azure App Service Migration Assistant determined that there was nothing preventing you from migrating the application  to Azure App Service, so you supplied the Migration Assistant with details like the target Resource Group, the URL, and so on and it performed the migration for you.

Without the Azure App Service Migration Assistant, you may have needed to manually review the web application's source code and compare against a list of known issues that might prevent a legacy ASP.NET web application from being deployed to Azure App Service.  This entire process could take days or weeks, depending on your familiarity with the code base, Windows Server, Internet Information Services, and more.

The Azure App Service Migration Wizard provides dramatic business impact, speeding your efforts in moving to the cloud.

## Next steps

If you are using this as a guide to perform your own web application migration, you will definitely want to think about those steps we did not perform in the exercise, namely:

- manually moving application settings and connection strings in your web.config file to App Service Application Settings
- migrating data from an on-premises SQL server to an Azure SQL database
- setting up an SSL certificate
- setting up custom domain names
- setting up permissions in Azure Active Directory

If your next step is to migrate your data from an on-premises SQL Server to an Azure SQL database, you may find the following module useful:

[Assess and convert SQL Server Databases using the Data Migration Assistant (DMA)](https://docs.microsoft.com/learn/modules/assess-convert-sql-server-databases-using-dma/)

## Additional reading

[Azure App Service Migration Assistant wiki](https://github.com/Azure/App-Service-Migration-Assistant/wiki/Readiness-Checks?azure-portal=true)

[Azure App Service Hybrid Connections](https://docs.microsoft.com/azure/app-service/app-service-hybrid-connections?azure-portal=true)

[Overview of Data Migration Assistant](https://docs.microsoft.com/sql/dma/dma-overview?view=sql-server-2017)

[App Service overview](https://docs.microsoft.com/azure/app-service/overview?azure-portal=true)

[Assess and convert SQL Server Databases using the Data Migration Assistant (DMA)](https://docs.microsoft.com/learn/modules/assess-convert-sql-server-databases-using-dma/)
