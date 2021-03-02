When you deploy an application to production on the cloud, there are a few considerations and steps which need to be managed. We need to determine how to deploy our application, what database to use, and ensure all setup is completed on our production environment.

## Deployment options

You have several options available to you for deploying to Azure. One of the most convenient is to use extensions for Visual Studio Code: [Azure Databases](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-cosmosdb/?azure-portal=true) and [Azure App Service](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureappservice/?azure-portal=true). Azure Databases will allow us to create our database server and database, while Azure App Service will allow us to create, configure and deploy to our web host.

## Database considerations

Django is designed for data driven web applications. As a result, you will always have a database as part of a Django project. During development, you typically use SQLite, which is a file based database. SQLite is a perfect solution for development because it doesn't require any special installation or services. However, the requirements for production typically include scaling, performance, and reliability which SQLite isn't designed to manage.

Django natively supports numerous databases including MySQL, PostgreSQL and MariaDB. You can also find providers to enable support for SQL Server, MongoDB, and many others.

When creating our production settings file, we noticed we configured our environment for PostgreSQL. PostgreSQL is one of the most popular databases for Django, and is also supported by Azure.

## Creating the database schema

Django manages the database schema through migrations. You can either have Django generate the SQL to create or update the schema, or you can use the **makemigrations** command to have Django update the database directly. To run migrations on our database, we can secure shell (or SSH) into App Services. This will allow us to run commands on our web host in a similar fashion to us running them locally.
