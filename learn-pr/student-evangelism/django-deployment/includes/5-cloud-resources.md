When you deploy an application to production in the cloud, you have a few considerations. You need to determine how to deploy the application and what database to use. You also need to ensure the production environment is ready.

## Deployment options

You can deploy to Azure in several ways. One of the most convenient ways is to use one of these extensions for Visual Studio Code: 
* [Azure Databases](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-cosmosdb&azure-portal=true) 
* [Azure App Service](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureappservice&azure-portal=true) 

Azure Databases allows you to create the database server and database. Azure App Service allows you to create, configure, and deploy to the web host.

## Database considerations

Django is designed for data-driven web applications. So every Django project usually includes a database. During development, you typically use SQLite, which is a file-based database engine.

SQLite is a perfect solution for development because it requires no special installation or services. But the requirements for production typically include scaling, performance, and reliability. SQLite isn't designed to manage these production requirements.

Django natively supports many databases, including MySQL, PostgreSQL, and MariaDB. You can also find providers to enable support for SQL Server, MongoDB, and many other databases.

When you created the production settings file, you configured the environment for PostgreSQL. PostgreSQL is one of the most popular databases for Django. It's also supported by Azure.

## Create the database schema

Django manages the database schema through migrations. Django can generate the SQL to create, or it can update the schema. Or you can use the `makemigrations` command to make Django update the database directly. 

To run migrations on the database, you can secure-shell (or *SSH*) into App Service. This method allows you to run commands on the web host the way you run them locally.
