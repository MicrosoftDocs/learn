In this unit, you learn about some of the factors to consider when choosing a database technology for your data storage as well as what you will need for App Service to connect to the database. Once that is successful, you learn how to make sure that database schema changes are recognized during Azure Pipelines deployments. Then you use Azure Pipelines to provide a way for the DBA to approve the schema changes before they ar applied to the database.

The team is ready to create a database for the website but they need to work with the DBA to coordinate the work. The DBA is responsible for maintaining the integrity of the database and needs to work with the team to understand their database needs. The DBA needs to approve any changes the developers make to the database schema or its tables.

The team wants to find an automated process that meets the needs of the application developers as well as the needs of the DBA.

In this section, you:

> [!div class="checklist"]
> * Choose a database technology for your application.
> * Learn how to configure App Service to use a database connection string.
> * Understand the role of a SQL Server Data Tools project in Azure Pipelines.
> * Learn how to approve database schema changes in Azure Pipelines.

## The meeting

The team his currently deploying the webapp to a _dev_ stage where all of the development pieces come together, a _test_ stage where testing is done on the webapp, and a _staging_ stage where the webapp is available for management to approve before it moves to production. Here the team will discuss adding a database as the data storage solution for the webapp and bringing it all together in the _dev_ stage.

**Andy:** Good morning. We have all seen how Azure Pipelines brings together our development and operations processes more efficiently. Because of this, we have been able to move forward in our development and we are ready to connect the website to a real database. I think this integration can happen as early as the _Dev_ stage. By connecting the website to the database early in the pipeline, we can track changes and measure performance as changes move through the pipeline.

Our focus here is on the leaderboard. Here's what the leaderboard looks like right now.

_Andy shows the_ Space Game _site running on Azure App Service_.

![The Space Game leaderboard](../../assess-your-development-process/media/2-space-game-leaderboard.png)

After the database is in place, we can modify the website to read from it instead of from local files that contain test data.

This is a big milestone and we have a few topics to discuss. Let's start by choosing a database technology.

## Choose a database technology

When considering a data storage solution, you have several options to choose from. Here are some of the guiding factors that can help you choose:

**The type of data you're storing**

_Structured data_ is relational data that fits into tables with columns and rows. For example, point of sale systems. You might have a table for product data with columns that define what you want to use to describe your products. For example, Product Name, SKU Number, Color and so on.

_Semi-structured data_ is non-relational data that fits into hierarchies using tags. This is a good fit for data that may change in its description. In other words, you products can't all be described using the same columns as we did with structured data. Usually this data is stored in JSON or XML.

 _Unstructured data_ includes documents such as text files, photos, and videos.

**Your operational needs**

When planning your operational needs, you might ask yourself these questions:

* Will I be doing basic lookups or do I need to join queries from multiple data sets? WIth basic lookups you might consider non-relational data solutions whereas join queries will need relational data solutions.
* How often will the data change? Reporting data may only change at month-end or quarterly. This could be a candidate for a data warehouse. If the data changes throughout the day, then you need something that can handle fast transactional throughput.
* Do I always need the latest data? This goes back to how often the data changes. Maybe it changes often but you only need the month end results. Or it could be that you are stock trading and you need up-to-the-minute results.
* Do I need to run complex analytical queries? Complex analytical queries are queries that can be done on several dimensions and would be a good candidate for a data warehouse.
* How quickly do these operations need to complete? Is the consumer of this data customer-facing? If so, the operations on the data need to be fast. Perhaps the data is used to run nightly reports. Can this be a bit slower?

**Whether or not you need transactions**

Transaction are needed when your data has relationships and those relationships keep the data from getting out of sync or help you to query the data. For example, say your gym membership was upgraded to give you more privileges at the gym. If the accounting data has the upgrade in order to change you more per month, but the membership data was not changed, you cannot access the privileges you are paying for. A transaction would insure that both pieces of data are updated at the same time.

There are two types of transactions that your data might need. *Online Transaction Processing (OLTP)* is used for relational data. That is similar to the example above. *Online Analytical Processing (OLAP)* is used for more complex queries when your data is in a data structure called a *cube* or *data warehouse*. This is for data analysis systems that query on many dimensions of data. For example, you want to know how any blue widgets were sold in January last year in the northeast region as compared to green widgets sold in May through June of this year in the southwest, and who were the top sales people for widgets in that region.

> [!NOTE]
> You'll find resources to help you make the right data storage choices at the end of this module.

## What does the team choose?

Let's listen in on how the _Space Game_ web team decides which data storage option to use.

**Tim:** When choosing a database, geo-replication and backups are also important to me. We had a good experience deploying the web application to Azure App Service. What options do we have for running a database on Azure?

**Andy:** I know that Azure SQL Database is a popular way to work with structured data. Azure Cosmos DB works with both unstructured and semi-structured data. We could also use Azure Blob Storage to manage unstructured data, like images.

**Mara:** The _Space Game_ leaderboard data is relational. Profiles, scores, and achievements all relate to one another. The web application queries this data each time a user loads the home page, so quick retrieval of data is important.

**Amita:** The data will change constantly as people play the game. Players want to see their positions on the leaderboard as quickly as possible, before they get outranked by others. We also talked about adding a feature that polls the leaderboard for updates in real time.

**Tim:** I've had a few conversations about Cosmos DB with our DBA. They want to try it out, but I don't think we have the time to spend ramping up for this project. They have a new project coming up next month that will be a good candidate for Cosmos DB. This project is using relational data and the overall shape of the data shouldn't change much. It also needs to be fast. It would be better to set up Azure SQL Database for our data needs.

**Mara:** That sounds good. I've used SQL Server Data Tools in the past to create a database project. I will add that to our solution. It will have the SQL scripts to create the tables and we can use it to make sure changes to the database schema in the project are checked against the current database schema.

**Andy:** Great. That will be your action item.

This brings up another question. If we create the database and connect to it from our website code, how do we keep the database connection string secure? I don't want to publish it through our *appsettings.json* file because that file will become part of our GitHub repository.

## Configure the webapp to use a database connection string

The _Space Game_ web application currently reads leaderboard data from JSON files. The team plans to convert the application to read leaderboard data from a database.

Recall that the _Space Game_ web application uses ASP.NET Core and is written in C#. The source code defines the `IDocumentDBRepository` interface to fetch leaderboard data. The `LocalDocumentDBRepository` class implements `IDocumentDBRepository` to read from local JSON files.

To update the code to read from a database, instead of from files, Mara creates another implementation of `IDocumentDBRepository` that connects to Azure SQL Database. This code gets the connection string from the website configuration.

  ```C#
    public class RemoteDBRepository : IDocumentDBRepository
    {
        private readonly IConfiguration configuration;
        private readonly string connectionString;

        public RemoteDBRepository(IConfiguration config)
        {
            configuration = config;
            connectionString = configuration.GetConnectionString("DefaultConnection");
        }
  ```

The connection string uses _SQL Authentication_, which includes the username and password. Storing this information in plain text in the *appsettings.json* would mean that the username and password would be readable by anyone who can access this file. Instead, Mara uses the _Secret Manager_ tool in Visual Studio to store this string in a file that is not maintained in source control. Let's listen in as she explains this to the team.

**Mara:** When developing the app locally, we can use a file that's named *secrets.json*, which doesn't get pushed to GitHub. Visual Studio can set that up for us using the _Secret Manager_ tool. But when the deployed webapp needs this information, it will be in Azure App Service *appsettings.json* file. App Service will have strict limited permissions as to who can see the files there. We can provide this information to our App Service instance through Azure Pipelines. Therefore, we won't need to add it to our local *appsettings.json*.

**Andy:** Good idea, Mara. Now we are getting somewhere.

**Tim:** Don't start celebrating yet. We need to make sure we have a plan for when the database schema changes. Mara mentioned that might happen. How do we make sure that the database administrator is happy with the changes and that the changes are applied at the right time?

## The role of the SQL Server Data Tools database project in Azure Pipelines

_SQL Server Data Tools_, which runs on Windows, provides a project type that you can use to define the database schema from Visual Studio. This kind of project produces what's called a _dacpac_ file. When you unpack this file, you see the SQL scripts for creating the database schema. For example, you might see a `CREATE TABLE` script for each table that's defined in the database project. SQL Database can unpack that file and apply the schema changes.

![The database project in Visual Studio on Windows](../media/2-database-project.png)

Let's go back to the team discussion and see how they handle the changes to their database schema.

**Mara:** The SQL Server Data Tools project that I mentioned can help. It creates a file, called a _dacpac_, that contains the current schema. This is the file that we use to deploy the schema. Let's see if we can find a way for Azure Pipelines to create a file that shows the differences between what the database schema is now and what changes the _dacpac_ is proposing. Then, the DBA can look at the changes and approve them. We just got pipeline approvals working. I think we can take advantage of that here so that we can automate as much as possible.

*Andy types on his laptop.*

**Andy:** I found an Azure Pipelines task that we can use. The [SqlAzureDacpacDeployment@1](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/sql-azure-dacpac-deployment?view=azure-devops&azyre-portal=true) task generates a file with the schema differences between the current database schema and the _dacpac_.

## Approve database schema changes in Azure Pipelines

After you create the database change file, you can use PowerShell to write its contents to the pipeline so that the DBA can see the changes. Here's an example:

```yml
- task: PowerShell@2
  displayName: Show auto-generated SQL Script - check for schema changes
  inputs:
    targetType: 'inline'
    script: |
      Write-Host "Auto Generated SQL Update Script:"
      Get-Content d:\a\1\s\GeneratedOutputFiles\$(databasename)_Script.sql | foreach {Write-Output $_}
```

You can use a manual approval to pause the pipeline at the stage where the changes would be applied, just as you did in the [Create a multi-stage pipeline with Azure Pipelines](/learn/modules/create-multi-stage-pipeline?azure-portal=true) module. You create an Azure Pipelines environment that specifies the DBA as the approver. If the DBA approves the changes, the pipeline continues and the changes are applied to the database. If the DBA rejects the changes, the pipeline is halted. From there, you can discuss the proposed change with the DBA and plan some other approach.

Let's listen in on the team's discussion.

**Tim:** I can create a PowerShell script that reads that file and outputs its contents so that the DBA can review and approve the changes.

**Andy:** After the change is approved, we use [SqlAzureDacpacDeployment@1](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/sql-azure-dacpac-deployment?view=azure-devops&azure-portal=true) again to apply the changes.

**Mara:** I think we have a good place to start.

## The plan

**Andy:** So if we are all in agreement, here is the plan moving forward.

_Andy moves to the whiteboard and sketches out the plan._

![Whiteboard image of the pipeline with the two database stages added](../media/2-whiteboard-pipeline.png)

**Andy:** So here is what we need to build. First, we add a job to the _Build_ stage that builds the database project. ![Callout 1](../../shared/media/callout-01.png) This produces a _.dacpac_ file that we treat as a build artifact.

We then add a stage that ![Callout 2](../../shared/media/callout-02.png) scripts the database changes so that the ![Callout 3](../../shared/media/callout-03.png) DBA can verify the changes before the changes are applied.

We add an ![Callout 4](../../shared/media/callout-04.png) approval to another stage that ![Callout 5](../../shared/media/callout-05.png) applies the database changes. And then we ![Callout 6](../../shared/media/callout-06.png) deploy to _Dev_, _Test_, and _Staging_ just like we did before.

**Tim:** I'll get started on the PowerShell script.

**Mara:** I'll make the database project and update the website to use the database.

**Andy:** I'll get with our DBA to get the database set up. But first, more coffee.

**TODO**: Calling out a few knowledge check issues for you to address.
