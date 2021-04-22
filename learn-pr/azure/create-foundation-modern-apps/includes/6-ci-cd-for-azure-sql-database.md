<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-exercise-unit-introduction-format)
-->
[What is DevOps?](https://azure.microsoft.com/en-us/overview/what-is-devops/) A compound of development (Dev) and operations (Ops), DevOps is the union of people, process, and technology to continually provide value to customers. Teams that adopt DevOps culture, practices, and tools become high-performing, building better products faster for greater customer satisfaction. 

As database is one of the main parts of a solution, ability to have it part of such practices is a key point of a modern and agile application.

With Azure SQL, there are several ways in which the database can be included in the DevOps process. A [CI/CD](https://en.wikipedia.org/wiki/CI/CD) pipeline is the backbone of a DevOps environment, and Azure SQL can be fully integrated with any CI/CD tool you may want to choose. Two of the most common and widely used in Azure are [GitHub Actions](https://github.com/features/actions) or [Azure DevOps](https://azure.microsoft.com/solutions/devops/).

## CI/CD for databases

Having the database part of a CI/CD pipeline means that you want to deploy to create or update the structure - and maybe even some of the data - of your database as a fully automated, reproducible, and determinist manner, so that you can do this process anytime you need - even many times per day - and get consistent results.

To achieve that, there are usually three main approaches:

- Desired State
- Code First Migrations
- Custom Scripts

The most important details on those three options will be discussed later, but if you want - and you should! - go in detail of the Data DevOps topic, you should check out these two videos:

- [Getting Started with DevOps for Azure SQL](https://www.youtube.com/watch?v=j7OnxOz7YDY&list=PLlrxD0HtieHieV7Jls72yFPSKyGqycbZR&index=30)
- [Using Azure Pipelines for Azure SQL Deployments](https://www.youtube.com/watch?v=G7H6HbzwAfs&list=PLlrxD0HtieHieV7Jls72yFPSKyGqycbZR&index=28)

There is also a great article by Arvind Shyamsundar, Azure SQL PM, here: [DevOps for Azure SQL](https://devblogs.microsoft.com/azure-sql/devops-for-azure-sql/).

### Desired State

With this approach you take a snapshot of the structure - the desired state - of a reference database, for example the one you are working on in your local development machine, and then you use that snapshot to synchronize another target database - usually the test and the production database - to the desired state. A tool like [SqlPackage.exe](https://docs.microsoft.com/sql/tools/sqlpackage/sqlpackage?view=sql-server-ver15) can be used to take the snapshot into a `.dacpac` file, and to apply it to the target database, automatically finding the differences, generating the correct script and applying them to sync the target schema with the one captured in the snapshot.

This is the approach you'll be using in this tutorial as is probably the easiest and the simplest of the three.

### Code First Migrations

Another option, is when you don't actually write T-SQL code, but use C# or Python or Node and the entities defined in your solution (for example: a Book, a Customer) to automatically generate the database for you. Using a specific tool, that usually comes with the platform or the framework you are using, you can make sure that every time you change any of the used entities - for example you add a new field, or even a new entity altogether - their new structure will be reflected to the database. Here's some reference to well know languages, tools, and frameworks that support a Code-First approach:

- [.NET Core - Entity Framework](https://docs.microsoft.com/ef/core/managing-schemas/migrations/?tabs=dotnet-core-cli)
- [Node - Sequelize](https://sequelize.org/master/manual/migrations.html)
- [Node - Prisma](https://www.prisma.io/migrate/)
- [Python - Django](https://docs.djangoproject.com/en/3.2/topics/migrations/)
- [Python - SQLAlchemy Alembic](https://pypi.org/project/alembic/)

### Manual Scripts

With this approach, the developer takes care of writing and maintaining all the scripts needed to create and change the database over time. After a script has been deployed in production, it is never changed and a new one is created. Each script contains the code needed to evolve the database to the new schema. In those cases where a database needs to be deployed from scratch, all scripts must be executed in the correct sequence to make sure database is created and the evolved correctly. Tools like [DbUp](https://dbup.github.io/) help in making sure that once a script has been deployed, is not applied again to the same database in subsequent executions.

## Azure DevOps

Azure DevOps is a suite of products that provides full support to all DevOps aspects, including a CI/CD pipeline. A pipeline is composed of Tasks, that are used to define the steps of the pipeline. A Task can be almost [anything](https://docs.microsoft.com/azure/devops/pipelines/tasks/?view=azure-devops), from the execution of an executable to the build of a .NET solution. A specific task named [Azure SQL Database Deployment Task](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/sql-azure-dacpac-deployment?view=azure-devops) can be used to deploy a `.dacpac` file or execute a .sql script.

## GitHub Actions

GitHub Actions allow the definition of a CI/CD pipeline via the usage of Actions, which are used to create the steps of the pipeline. An [Action](https://docs.github.com/en/actions/learn-github-actions/introduction-to-github-actions) can be used to execute processes of almost [any type](https://github.com/marketplace?type=actions). The Action [Azure SQL Deploy](https://github.com/marketplace/actions/azure-sql-deploy) allows you to deploy a `.dacpac` file.

This is what you'll be using in the next part of this tutorial.

## Other Resources

A sample of a full featured end-to-end solution that shows how to use the Manual Script approach along with database unit testing options is available here: [Modern development: creating a REST API, via CI/CD and back](https://devblogs.microsoft.com/azure-sql/modern-development-creating-a-rest-api-via-ci-cd-and-back/)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
<!-- Do not add a unit summary or references/links -->