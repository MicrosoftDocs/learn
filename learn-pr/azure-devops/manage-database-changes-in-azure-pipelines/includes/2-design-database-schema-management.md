In this part, you follow the Tailspin web team as they define their next steps for the _Space Game_ web site.

The team is ready to create a database for the web site but they will need to work with the database administrator to get it coordinated. The database administrator is responsible for maintaining the integrity of the database and will need to work with the team to understand their database needs. Any changes to tables or other database schema will need to be approved by the database administrator.

The team wants to find an automated process that meets the needs of the application developers as well as the database administrator.

In this section, you'll:

> [!div class="checklist"]
> * Choose a database technology
> * Learn how to configure the App Service to use the database connection string
> * Understand a SQL Server Data Tools database project's role in Azure Pipelines
> * Learn how database schema changes can be approved using Azure Pipelines

## The meeting

**Andy:** Good morning team. With our Azure DevOps pipeline bringing our development and operations together in a more efficient way, we are ready to stop using the sample data files and add a development database to our _dev_, _test_, and _staging_ App Services. This will allow us to better code with the production web site in mind.

This is a big milestone and we have a lot to talk about. Let's start with choosing a database technology.

### Choose a database technology

You have several choices when considering data storage solutions. The guiding factors to help you determine which choice to make are:

* The type of data you are storing
  * Structured data - relational data that fits into tables with columns and rows
  * Semi-structured data - non-relational data that fits into hierarchies using tags
  * Unstructured data - files, photos, and videos
* Your operational needs
  * Will you be doing simple lookups or do you need to query one or more fields?
  * Do you expect to change the data often?
  * Do you need to run complex analytical queries?
  * How quickly do these operations need to complete?
* Whether or not you will need to use transactions
  * OLAP - Online Transaction Processing
  * OLTP - Online Analytical Processing

The _SpaceGame_ web site data is relational. Profiles, scores and achievements all relate to one another. The web site will need to query this data for different fields often, and the data will be changing as players play the game. This data is for a customer-facing web site, so quick retrieval of data is important.

A link to more information on data storage choices and how to make the right choice is provided in the summary of this module. 

Let's listen in on how the _SpaceGame_ web team decides what data storage to use.

**Tim:** It has been nice setting up infrastructure for your web site in the cloud, and it has proven to be cost effective. I would like to continue this experiment and set up the database server in the cloud as well.

**Andy:** Good thinking Tim. I already went through the Microsoft Learn Module [Choose a data storage approach in Azure](https://docs.microsoft.com/learn/modules/choose-storage-approach-in-azure/?azure-portal=True) with that in mind. It seems we should either use CosmosDB or Azure SQL.

**Tim:** I have had a few conversations about CosmosDB with our database administrator. They are wanting a chance to try it out, but I don't think we have the time to spend ramping up on this project. They have a new project coming up next month that will be a good candidate for CosmosDB. This project is using relational data and the overall shape of the data shouldn't change much. It would be easier to set up as an Azure SQL database.

**Mara:** That sounds good. I have used [SQL Server Data Tools](https://docs.microsoft.com/sql/ssdt/sql-server-data-tools?view=sql-server-2017&azure-portal=true) in the past to make a database project. I will add that to our solution. It will have the SQL scripts to create the tables and we can use it to make sure changes to the database schema are being tracked.

**Andy:** Great. That will be your action item.

This brings up another question. If we create the database and connect to it from our web site code, how do we keep the database connection string secure? I don't want to publish it in our appSettings.json because that will become part of our GitHub repo.

### Configure the App Service to use the database connection string

TODO: (How much of this do I show?)

To change the web site code over to using the database, Mara has created another implementation of the data access interface that will connect to and get the data from the Azure SQL database. This code gets the connection string from the web site configuration.

TODO: (screenshot)

The connection string uses _SQL Authentication_ which has a username and password entry. Storing this information in plain text in the appSettings.json file would mean that the username and password would be readable by anyone that has access to the file. Instead, Mara has used the _Secret Manager_ tool in Visual Studio to store this string in a file that will not be uploaded to GitHub. Let's listen in as she explains this to the team.

**Mara:** Locally, we can use a secrets.json file that doesn't get pushed to GitHub. Visual Studio can set that up for us using the _Secret Manager_ tool. But when the actual web site needs it, it can be added as a setting right in the Azure App Service and we won't need to add it to our appSettings.json file. Another advantage to using App Service. Since we are using Azure DevOps, we'll create an encrypted pipeline variable and use that to set the App Service setting.

**Andy:** Good idea Mara. Now we are getting somewhere.

**Tim:** Don't start celebrating yet. We need to make sure we have a plan for when the database schema changes. Mara mentioned that might happen. How do we make sure the database administrator is happy with the changes and that they get applied in a timely way?

### SQL Server Data Tools database project's role in Azure Pipelines

TODO: (Again, how much do I show)

_SQL Server Data Tools_ provides a project type that developers can use to define the database schema from within Visual Studio on Windows. The output from building this type of project is a file with the _.dacpac_ extension called a dacpac file. If you unpacked this file you would see the SQL scripts for creating the database schema, for example, a CREATE TABLE script for each table defined in the database project. Azure SQL can unpack that file and apply the schema changes.

TODO: (Screenshots of database project and the .dacpac file)

Let's go back to the team discussion and see how they handle the changes to their database schema.

**Mara:** That SQL Server Data Tools project that I mentioned can help. It creates a file called a _dacpac_ that will have the current schema as defined by the project. This is the file used to deploy the schema. Let's see if we can find a way for the pipeline to make a file that shows the differences between what the database schema is now and what the _dacpac_ is proposing. Then the database administrator can look at that file and approve it. We just got pipeline approvals working. I think we can take advantage of that here and automate as much as possible.

**Andy:** I found an Azure Pipelines task we can use. The [SqlAzureDacpacDeployment@1](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/sql-azure-dacpac-deployment?view=azure-devops&azyre-portal=true) task auto generates a file with the schema differences between the current database schema and the _dacpac_. We would just set the `DeploymentAction:` parameter to `Script`.

### Approve database schema changes using Azure Pipelines

Once database change file is generated, a powershell script can write it to the pipeline output where is can be checked by the database administrator.
TODO: (Do we send an email or something?)

    ```yml
      - task: PowerShell@2
        displayName: Show Auto Generated SQL Script - check for schema changes
        inputs:
          targetType: 'inline'
          script: | 
            Write-Host "Auto Generated SQL Update Script:"
            Get-Content d:\a\1\s\GeneratedOutputFiles\$(databasename)_Script.sql | foreach {Write-Output $_}
    ```
You can pause the pipeline at the stage where the changes would be applied using the technique you used in the last module. You create an Azure Pipelines environment that specifies the database administrator as the person that can approve running that stage. Then if the DBA approves the changes, the pipeline continues and the changes get applied to the database.

(Screenshot of approval?)

Let's listen in to the team.

**Tim:** I can make a PowerShell script that reads that file and outputs it for approval for the database administrator.

**Andy:** Then after it is approved, we use [SqlAzureDacpacDeployment@1](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/sql-azure-dacpac-deployment?view=azure-devops&azure-portal=true) again to apply the changes. We just set the `DeploymentAction:` parameter to `Publish` this time.

**Mara:** I think we have a good place to start.

## The plan

**Andy:** So if we are all in agreement, here is the plan moving forward.

_Andy moves to the whiteboard to draw the plan_

![Whiteboard image of the pipeline with the two database stages added](../media/2-whiteboard-pipeline.png)

**Andy:** So here is what we need to build. First, we add another job to the _Build_ stage that builds the new database project. ![Callout 1](../../shared/media/callout-01.png) This will produce another artifact that is the _.dacpac_ file.

We add a stage that ![Callout 2](../../shared/media/callout-02.png) scripts the database changes so that the ![Callout 3](../../shared/media/callout-03.png) DBA can check the changes before they get applied.

We add an ![Callout 4](../../shared/media/callout-04.png) approval to another stage that ![Callout 5](../../shared/media/callout-05.png) applies the database changes. And then we ![Callout 6](../../shared/media/callout-06.png) deploy to _dev_, _test_, and _production_ just like we did before.

**Tim:** I'll get started on the PowerShell script.

**Mara:** I'll make the database project and update the web site to use the database.

**Andy:** I'll get with our database administrator to get the database set up. But first, more coffee.
