Let's assume that you're currently using an on-premises PostgreSQL relational database using flexible data types and geospatial support. Your company is looking at expanding, which requires the database to scale. As an alternative to investing in additional hardware, you're tasked with finding an optimal cloud-hosted database offering. You've decided to use an Azure Database for PostgreSQL server.

## What is an Azure Database for PostgreSQL server?

The PostgreSQL server is a central administration point for one or more databases. The PostgreSQL service in Azure is a managed resource that provides performance guarantees, and provides access and features at the server level.

An **Azure Database for PostgreSQL** server is the parent _resource_ for a database. A _resource_ is a manageable item that's available through Azure. Creating this resource allows you to configure your server instance.

### What is an Azure Database for PostgreSQL server resource?

An Azure Database for PostgreSQL server resource is a container with strong lifetime implications for your server and databases. If the server resource is deleted, all databases are also deleted. Keep in mind that all resources belonging to the parent are hosted in the same region.

The server resource name is used to define the server endpoint name. For example, if the resource name is **mypgsqlserver**, then the server name becomes **mypgsqlserver.postgres.database.azure.com**.

The server resource also provides the __connection scope__ for management policies that apply to its database. For example: login, firewall, users, roles, and configuration.

Just like the open-source version of PostgreSQL, the server is available in several versions and allows for the installation of extensions. You'll choose which server version to install.

> [!NOTE]
> Extensions allow for bundling multiple SQL objects together in a single package that can be loaded or removed with a single command. An example of an extension is `chkpass`, which provides a data type for auto-encrypted passwords.

## Pricing tiers

Azure Database for PostgreSQL provides you with the option to choose pricing tiers based on parameters like compute power and storage. For more details, see [Azure Database for PostgreSQL pricing tiers](https://docs.microsoft.com/azure/postgresql/concepts-pricing-tiers?azure-portal=true).

## Steps to create an Azure Database for PostgreSQL server

You'll typically create an Azure Database for PostgreSQL server using the Azure portal. Let's look at the steps you'd take. This is not an exercise, but serves to familiarize you with the steps if you choose to use the Azure portal.

First, you'll sign in to the Azure portal, and then you'll click **Create a resource**.

You'll select **Databases** and **Azure Database for PostgreSQL**. You can also use the **Search** functionality to find this category.

The portal will display a PostgreSQL server configuration screen, also called a blade, and you make your selection.

You'll need to give a value to all the items in the blade, so let's have a look at each.

### Server name

Earlier we mentioned that you'll create a server resource. The server name is the item that specifies this resource. As a result, you'll have to choose a unique name for the server. The server name must be all lowercase and can have numbers and hyphens.

Let's say you want to name the server _Adventure Works Tracking_. You would then set up the name as `adventure-works-tracking`. If you try to create a server with a name that already exists, you'll get an error to that effect.

### Subscription

The subscription field is used for billing. You'll pick a specific subscription in case you have more than one subscription available.

### Resource group

You'll use a resource group to manage all the resources related to your server. You can create a new resource group or reuse an existing resource group.

### Source

You can create a server either from scratch by choosing the _Blank_ default option or from an existing backup. The **Backup** option will give you the opportunity restore a geo-backup of an existing Azure Database for PostgreSQL server.

### Server admin login name

You create the server admin user. Choose a login name to use as an administrator login for the new server. The admin login name can't be azure_superuser, azure_pg_admin, admin, administrator, root, guest, or public. It can't start with pg_. Remember or write down this name for future use.

### Password

You choose a password to use with the above administrator login name. Your password must include characters from three of the following categories:

- English uppercase letters
- English lowercase letters
- Numbers (0 through 9)
- Non-alphanumeric characters (!, $, #, %, and so on)

Remember or write down this password for future use.

### Confirm password

Retype the password to confirmation.

### Location

The location option allows you to specify where the server is created physically. Choose the geographic location closest to you. In a real-world scenario, the location should be the location closest to the majority of your users.

### Version

You can specify the version of PostgreSQL to use. Microsoft aims to support the current version and two previous versions of PostgreSQL. You'll choose a version that matches your production environment.

> [!NOTE]
> For more information, see the following sources:
> - [Supported PostgreSQL database versions](https://docs.microsoft.com/azure/postgresql/concepts-supported-versions?azure-portal=true)
> - [Versioning policy](https://www.postgresql.org/support/versioning/?azure-portal=true)

### Pricing tier

You'll choose a pricing tier that will support your server's workload. Recall that you have different tiers to choose from. As we saw earlier, each of these tiers allows you to configure the compute and storage options. 

All that's left now is to review the values that you entered, make any notes you may need for later, and click **Create** to create the server.

Deploying the server takes a couple of minutes. You'll receive a notification when the deployment is complete. From the notification, you can navigate to the newly created server.

