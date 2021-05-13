Nice job! Your pipeline is becoming a useful part of your process. You and the Tailspin team now have a pipeline that includes consideration for database schema changes. You used Azure SQL Database here, but you could have used any database technology.

In this module, you learned what to consider when you add a database to a web app and ultimately to Azure Pipelines. You learned:

- How to access an Azure SQL Database from Azure App Service.
- How to add database schema changes to Azure Pipelines approvals.
- How to make sure that an approval is required only when the schema changes.

The team successfully designed and built a pipeline that manages the database changes as well as the application changes.

Although the team is improving their release cadence, there's room for more improvements. For example, Amita from QA must manually test and approve builds before the team can present new features to management. In the next module, you'll work with the Tailspin team to automate additional testing so that changes can move through the pipeline even faster.

## Learn more

The team decided to use Azure SQL Database as the data storage technology. The data storage technology you use depends on the type of data you store. Check out these resources to choose a data storage technology for your projects:

- [Choose a data storage approach in Azure](https://docs.microsoft.com/learn/modules/choose-storage-approach-in-azure/?azure-portal=true)
- [SQL Server Data Tools](https://docs.microsoft.com/sql/ssdt/sql-server-data-tools?azure-portal=true)

In this module, you worked with ASP.NET Core, SQL Server Data Tools, and Azure SQL Database. You passed Azure Pipelines variables between stages and configured App Service. Use the following resources to learn more:

- [Safe storage of app secrets in development in ASP.NET Core](https://docs.microsoft.com/aspnet/core/security/app-secrets?azure-portal=true)
- [The Azure SQL Database Deployment task](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/sql-azure-dacpac-deployment?azure-portal=true)
- [Configure an App Service app in the Azure portal](https://docs.microsoft.com/azure/app-service/configure-common?azure-portal=true)
- [Pass a variable from stage to stage in Azure DevOps](http://donovanbrown.com/post/Passing-variables-from-stage-to-stage-in-Azure-DevOps-release?azure-portal=true) (This link leads to an external website.)
- [REST APIs for Azure DevOps Services](https://docs.microsoft.com/rest/api/azure/devops/search/?azure-portal=true)

This module mentions the following Microsoft Learn modules:

- [Develop and configure an ASP.NET application that queries an Azure SQL database](https://docs.microsoft.com/learn/modules/develop-app-that-queries-azure-sql/?azure-portal=true)
- [Choose a data storage approach in Azure](https://docs.microsoft.com/learn/modules/choose-storage-approach-in-azure/?azure-portal=true)

You learned to use _dacpac_ and _bacpac_ files in this module. For more information about those files and data-tier applications, see [Data-tier applications](https://docs.microsoft.com/sql/relational-databases/data-tier-applications/data-tier-applications?azure-portal=true).

You needed a blob storage container to hold your _bacpac_ file. These Microsoft Learn modules provide more information about working with storage on Azure:

- [Create an Azure Storage account](/learn/modules/create-azure-storage-account/?azure-portal=true)
- [Secure your Azure Storage account](/learn/modules/secure-azure-storage-account/?azure-portal=true)
