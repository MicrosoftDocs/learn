The team has decided it’s time to connect their website to a live database but they need to work with the Tailspin DBA to coordinate the work. The DBA will be responsible for maintaining the integrity of the database. That person will need to work with the team to understand what they need and design a schema. If, at some point, the team wants to change the schema, the DBA needs to approve those changes before they can take effect. 

Now that the team understands the benefits of automation, they want to make the approval process a part of their release pipeline.

In this section, you:

> [!div class="checklist"]
> * Choose a database technology for your application.
> * Learn how to configure App Service to use a database connection string.
> * Understand the role of a SQL Server Data Tools project in Azure Pipelines.
> * Learn how to approve database schema changes in Azure Pipelines.

## The meeting

The team deploys their webapp through a series of stages. The _Dev_ stage is where all of the development pieces come together. The _Test_ stage is where QA performs tests. _Staging_ is where management can approve the app before it moves to production. 

Here the team discusses how to add a database as the data storage solution for the webapp. They're planning on integrating the database and the webapp in the _Dev_ stage.

**Andy:** Good morning. We’ve all seen how Azure Pipelines has accelerated our release process and improved the quality of what we do. Because we’ve made so much progress, I think we're ready to connect the website to a real database. I think this integration can happen as early as the Dev stage. By connecting the website to the database early in the pipeline, we can track any changes we make and measure performance all the way through the pipeline.

Our goal is for the leaderboard to pull its data from the database. Here's what the leaderboard looks like right now.

_Andy shows the_ Space Game _site running on Azure App Service_.

![The Space Game leaderboard](../../assess-your-development-process/media/2-space-game-leaderboard.png)

After the database is in place, we can modify the website to read from it instead of from local files.

This is a big milestone for us and we have a few topics to discuss. First, let's choose a database technology. There are a lot of things to consider, so bear with me.

## Choose a database technology

When considering a data storage solution, you have several options to choose from. Here are some of the guiding factors that can help you choose:

**The type of data you're storing**

There are three types of data: structured, semi-structured and unstructured.

_Structured data_ is relational data that fits into tables with columns and rows. For example, think of a point of sale system. You might have a table for product data with columns that define what you want to use to describe your products. For example, there could be columns named Product Name, SKU Number, Color and so on.

_Unstructured_ data includes documents such as text files, photos, and videos. It’s format is for quick access to the entire file and not for processing records.

_Semi-structured data_ is non-relational data that fits into hierarchies using tags. This is a good fit for data that may change in its description. In other words, your products can't all be described by using the same columns as you can with structured data. Usually, this data is stored as JSON or XML.

**Your operational needs**

When we plan our operational needs, we should ask ourselves:

* Will we be doing basic lookups or do we need to join queries from multiple data sets?

    Basic lookups will work with non-relational data but join queries require relational data.
* How often will the data change?

    Reporting data may only change at end of the month or quarterly. This could be a candidate for a data warehouse. If the data changes throughout the day, then we need something that can handle fast transactional throughput.
* Do we always need the latest data?

    This relates to how often the data changes. Perhaps the data changes often, but you only need the data at the end of each month. Or it could be that you are stock trading and you need to fetch data as quickly as possible.
* Do we need to run complex analytical queries?

    Complex analytical queries are queries that can be done on several dimensions and would be a good candidate for a data warehouse.
* How quickly do these operations need to complete?

    Do customers consume the data directly? If they do, the data operations on the data need to be fast. Perhaps the data is used to run nightly reports. In this case, these operations can run more slowly.

**Do we need transactions?**

Transactions are needed when your data has relationships and those relationships keep the data from getting out of sync or help you to query the data. For example, let's say that you upgraded your gym membership to receive added privileges. Your account has been updated to charge you more per month, but the corresponding update to your membership profile failed. This situation might cause you lose access to the privileges you are paying for. A transaction would ensure that both pieces of data are updated at the same time. If either part fails, the entire transaction is rolled back.

There are two types of transactions that your data might need. *Online Transaction Processing (OLTP)* is used for relational data. That is similar to the example above. *Online Analytical Processing (OLAP)* is used for more complex queries when your data is in a data structure called a *cube* or *data warehouse*. This is for data analysis systems that query on many dimensions of data. For example, you want to know how any blue widgets were sold in January of last year in the northeast region as compared to green widgets sold in May through June of this year in the southwest, and who were the top sales people for widgets in that region.

> [!NOTE]
> You'll find resources to help you make the right data storage choices at the end of this module.

## What does the team choose?

Let's listen in on how the _Space Game_ web team decides which data storage option to use.

**Tim:** Another thing we need to consider when we choose is geo-replication and backups. We had a good experience deploying the web application to Azure App Service. What options do we have for running a database on Azure?

**Andy:** I know that Azure SQL Database is a popular way to work with structured data. Azure Cosmos DB works with both unstructured and semi-structured data. We could also use Azure Blob Storage to manage unstructured data, like images.

**Mara:** The _Space Game_ leaderboard data is relational. Profiles, scores, and achievements all relate to one another. The web application queries this data each time a user loads the home page, so quick retrieval of data is important. Those two qualities should help us narrow down the field.

**Amita:** The data changes constantly as people play the game. Players want to see their positions on the leaderboard as quickly as possible, before they get outranked by other players.

**Tim:** I've had a few conversations about Cosmos DB with our DBAs. They want to try it out, but I don't think we have the time to spend ramping up for this project. We know that our website uses relational data and the overall shape of the data shouldn't change much. We also need fast retrieval times. I think Azure SQL Database is the right choice.

**Mara:** That sounds good. I've used SQL Server Data Tools in the past to create a database project. I will add a database project to our *Tailspin.SpaceGame.Web* solution. It will have the SQL scripts to create the tables and we can use it to make sure changes to the database schema in the project are checked against the current database schema.

**Andy:** Great. That will be your action item.

This brings up another question. If we create the database and connect to it from our website code, how do we keep the database connection string secure? I don't want to keep it in our *appsettings.json* file because that file will become part of our GitHub repository.

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

The connection string uses SQL Authentication, which includes the username and password. Storing this information in plain text in *appsettings.json* would mean that the username and password would be readable by anyone who can access this file. Instead, Mara uses the Secret Manager tool in Visual Studio to store this string in a file that is not maintained in source control. Let's listen in as she explains this to the team.

**Mara:** When developing the app locally, we can use a file that's named *secrets.json*, which doesn't get pushed to GitHub. Visual Studio can set that up for us using the Secret Manager tool. But when the deployed webapp needs this information, it will be in Azure App Service *appsettings.json* file. App Service has strict limited permissions about who can see the files there. We can provide this information to App Service  through Azure Pipelines. That means we won't need to add it to our local *appsettings.json*.

**Andy:** Good idea, Mara. We're making progress.

**Tim:** Don't start celebrating yet. We need to make sure we have a plan for when the database schema changes. Mara mentioned that might happen. How do we make sure that the DBA is happy with the changes and that the changes are applied at the right time?

In this short video, Abel Wang, Cloud Advocate at Microsoft, explains the concept of database changes in Azure Pipelines.

**Ask Abel**

> [!VIDEO https://channel9.msdn.com/Blogs/One-Dev-Minute/How-do-you-handle-databases-in-a-DevOps-world--One-Dev-Question/player?format=ny]

## The role of the SQL Server Data Tools database project in Azure Pipelines

SQL Server Data Tools, which runs on Windows, provides a project type that you can use to define a database schema from Visual Studio. This kind of project produces what's called a _dacpac_ file. When you unpack this file, you see the SQL scripts for creating the database schema. For example, you might see a `CREATE TABLE` script for each table that's defined in the database project. SQL Database can unpack that file and apply the schema changes.

![The database project in Visual Studio on Windows](../media/2-database-project.png)

Let's go back to the team discussion and see how they plan to handle any changes to their database schema.

**Mara:** The SQL Server Data Tools project that I mentioned can help. It creates a file, called a _dacpac_, that contains the current schema. This is the file that we use to deploy the schema. Let's see if we can find a way for Azure Pipelines to create a file that shows the differences between what the database schema is now and what changes the _dacpac_ is proposing. Then, the DBA can look at the changes and approve them. We just got release approvals working. I think we can take advantage of that here so that we can automate as much as possible.

*Andy types on his laptop.*

**Andy:** I found an Azure Pipelines task that we can use. The [SqlAzureDacpacDeployment@1](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/sql-azure-dacpac-deployment?view=azure-devops&azure-portal=true) task generates a file with the schema differences between the current database schema and the _dacpac_.

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

**Andy:** After the change is approved, we use `SqlAzureDacpacDeployment@1` again to apply the changes.

**Mara:** I think we have a good place to start.

## The plan

**Andy:** So if we are all in agreement, here is the plan moving forward.

_Andy moves to the whiteboard and sketches out the plan._

![Whiteboard image of the pipeline with the two database stages added](../media/2-whiteboard-pipeline.png)

**Andy:** Here's is what we need to build. First, we add a job to the _Build_ stage that builds the database project. ![Callout 1](../../shared/media/callout-01.png) This produces a _.dacpac_ file that we treat as a build artifact.

We then add a stage that ![Callout 2](../../shared/media/callout-02.png) scripts the database changes so that the ![Callout 3](../../shared/media/callout-03.png) DBA can verify the changes before the changes are applied.

We add an ![Callout 4](../../shared/media/callout-04.png) approval to another stage that ![Callout 5](../../shared/media/callout-05.png) applies the database changes. And then we ![Callout 6](../../shared/media/callout-06.png) deploy to _Dev_, _Test_, and _Staging_ just like we did before.

**Tim:** I'll get started on the PowerShell script.

**Mara:** I'll make the database project and update the website to use the database.

**Andy:** I'll get with our DBA to get the database set up. But first, more coffee.