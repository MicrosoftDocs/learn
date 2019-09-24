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

**Andy:** Good morning team. With our Azure DevOps pipeline bringing our development and operations together in a more efficient way, we can now stop using the sample data files and add a development database to our _dev_, _test_, and _staging_ App Services. This will allow us to better code with the production web site in mind.

Let's start with choosing a database technology.

...

- What database technology are we going to use?
- On-prem or in the cloud?
- How do we make sure we don't add the sensitive connection string data to source control?
- How can we keep the database administrator happy if we need to change the database schema during development?

## The plan

**Andy:** So if we are all in agreement, here is the plan moving forward.

_Andy moves to the whiteboard to draw the plan_

