Nice job! Your pipeline is developing into a very useful part of your process. You and the Tailspin team now have a pipeline that includes consideration for database schema changes. You used Azure SQL Database here, but you could have used any database technology.

In this module, you learned about the considerations that are needed when you add a database to a web app and ultimately to Azure Pipelines.

You learned:

- How to access an Azure SQL Database from Azure App Service.
- How to add database schema changes to Azure Pipelines approvals.
- How to make sure an approval is needed only where there are actual schema changes.

The team successfully designed and built a pipeline that manages the database changes as well as the application changes.

Although the team is making steps towards improving their release cadence, there's room for additional improvements. For example, Amita from QA must manually test and approve builds before the team can present new features to management. In the next module, you'll work with the Tailspin team as they automate additional testing so that changes can move through the pipeline even faster.

## Learn more

The team decided to use Azure SQL Database as the data storage technology. The data storage technology you use depends on the type of data you are storing. Here are some resources to help you decide what data storage technology to use for your projects:

- [Choose a data storage approach in Azure](https://docs.microsoft.com/learn/modules/choose-storage-approach-in-azure/?azure-portal=true)
- [SQL Server Data Tools](https://docs.microsoft.com/sql/ssdt/sql-server-data-tools?view=sql-server-2017&azure-portal=true)

In this module, you worked with ASP.NET Core, SQL Server Data Tools, Azure SQL Database, Azure Pipelines variables across stages, and configuring App Service. Here are some additional resources you can use to learn more:

- [Safe storage of app secrets in development in ASP.NET Core](https://docs.microsoft.com/aspnet/core/security/app-secrets?view=aspnetcore-3.0&tabs=windows&azure-portal=true)
- [Azure SQL Database Deployment task](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/sql-azure-dacpac-deployment?view=azure-devops&azure-portal=true)
- [Configure an App Service app in the Azure portal](https://docs.microsoft.com/azure/app-service/configure-common?azure-portal=true)
- [Passing a variable from stage to stage in Azure DevOps](http://donovanbrown.com/post/Passing-variables-from-stage-to-stage-in-Azure-DevOps-release?azure-portal=true)
- [Azure DevOps Services REST API](https://docs.microsoft.com/rest/api/azure/devops/search/?view=azure-devops-rest-5.1&azure-portal=true)

Here are the Microsoft Learn modules mentioned in this module:

- [Develop and configure an ASP.NET application that queries an Azure SQL database](https://docs.microsoft.com/learn/modules/develop-app-that-queries-azure-sql/?azure-portal=true)
- [Choose a data storage approach in Azure](https://docs.microsoft.com/learn/modules/choose-storage-approach-in-azure/?azure-portal=true)

You learned to use _.dacpac_ and _.bacpac_ files. Here is a link to more information on those files and Data-tier Applications:

- [Data-tier Applications](https://docs.microsoft.com/sql/relational-databases/data-tier-applications/data-tier-applications?view=sql-server-ver15&azure-portal=true)

You needed a blob storage container to hold your _bacpac_ file. Here are Microsoft Learn modules where you can learn more about working with storage on Azure.

- [Create an Azure Storage account](/learn/modules/create-azure-storage-account/?azure-portal=true)
- [Secure your Azure Storage account](/learn/modules/secure-azure-storage-account/?azure-portal=true)
