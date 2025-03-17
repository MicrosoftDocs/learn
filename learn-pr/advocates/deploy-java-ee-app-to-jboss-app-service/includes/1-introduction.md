Many enterprises, such as purchase management, manufacturing, and customer relationship management, use Jakarta EE applications.

Take the example of a freight-delivery service with the following capabilities:

- Your service receives a package, captures the shipping address information, and registers the delivery address.
- Your service queries and updates data from a relational database.

In this module, you explore a similar scenario. First, you create a database on Azure Database for MySQL. Then, you create a Jakarta EE application to interact with the database, and you deploy it to JBoss EAP on Azure App Service. Finally, you learn how to manage your application's life cycle.

## Learning objectives

By the end of this module, you'll be able to complete the following tasks:

- Create and manage an Azure Database for MySQL Flexible Server instance.
- Deploy a Jakarta EE app to JBoss EAP on Azure App Service.
- Create a data source and bind your Jakarta EE app to MySQL.
- Access and manage the Jakarta EE app on JBoss.

## Prerequisites

- An Azure subscription. [Create one for free.](https://azure.microsoft.com/free/)
- [Azure CLI](/cli/azure/install-azure-cli)
- [Java SE 17 or later](/java/openjdk/download#openjdk-17)
- [Git](https://git-scm.com/downloads)
- [MySQL shell](https://dev.mysql.com/downloads/shell/)
- [jq](https://stedolan.github.io/jq/)
