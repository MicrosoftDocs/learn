Nice job! Your pipeline is developing into a very useful part of your process. You and the Tailspin team now have a pipeline that includes consideration for database schema changes. You used an Azure SQL database here, but you could have used any database technology.

In this module, you learned about the considerations that are needed when you add a database to a web app and ultimately to an Azure Pipeline.

You learned:

- How to access an Azure SQL database securely from your App Service
- How to add database schema changes to Azure pipeline approvals
- How to make sure approval is needed only where there are actual schema changes

The team successfully designed and built a pipeline that manages the database changes as well as the application changes.

Although the team is making steps towards improving their release cadence, there's room for additional improvements. For example, Amita from QA must manually test and approve builds before the team can present new features to management. In the next module, you'll work with the Tailspin team as they automate additional testing so that changes can move through the pipeline even faster.

## Learn more

In this module, you worked with ASP.net Core, SQL Server Data Tools, Azure SQL, Pipeline variables across stages, and configuring the App Service. Here are some additional resources you can use to learn more:

- [Safe storage of app secrets in development in ASP.NET Core](https://docs.microsoft.com/aspnet/core/security/app-secrets?view=aspnetcore-3.0&tabs=windows&azure-portal=true)
- [Azure SQL Database Deployment task](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/sql-azure-dacpac-deployment?view=azure-devops&azure-portal=true)
- [Configure an App Service app in the Azure portal](https://docs.microsoft.com/azure/app-service/configure-common?azure-portal=true)
- [Passing a variable from stage to stage in Azure DevOps](http://donovanbrown.com/post/Passing-variables-from-stage-to-stage-in-Azure-DevOps-release?azure-portal=true)

Here are the Microsoft Learn modules mention in this module:

- [Develop and configure an ASP.NET application that queries an Azure SQL database](https://docs.microsoft.com/en-us/learn/modules/develop-app-that-queries-azure-sql/?azure-portal=true)
- [Choose a data storage approach in Azure](https://docs.microsoft.com/learn/modules/choose-storage-approach-in-azure/?azure-portal=True)
