Azure provides Platform as a Service (PaaS) services to help you manage all kinds of data, from highly structured relational data to unstructured data.

Here, you learn why Azure SQL Database is a convenient, cost-effective, and secure way to host your relational databases.

## Why choose Azure SQL Database?

Your transportation-logistics application requires stored procedures that run basic CRUD (*Create*, *Read*, *Update*, and *Delete*) operations. You have experience working with SQL Server and other relational databases.

You consider two choices for your database:

- **Host SQL Server on-premises**: Your IT team runs a small in-house data center to support the finance department and a few other teams. You can work with IT to host a SQL Server deployment in their data center.
- **Host Azure SQL Database in the cloud**: Azure SQL Database is based on SQL Server, and provides the relational database functionality you need.

You've decided to build the web and application tiers for your logistics app on Azure. So, it makes sense to also host your database there. However, there are some other reasons why Azure SQL Database is a smart choice, and why it's even easier than using virtual machines.

- **Convenience**

    Setting up SQL Server on a VM or on physical hardware requires you to know about hardware and software requirements. You need to understand the latest security best practices and manage operating system and SQL Server patches on a routine basis. You also need to manage backup and data retention issues yourself.

    With Azure SQL Database, we manage the hardware, software updates, and OS patches for you. All you specify is the name of your database and a few options, and you have a running SQL database in minutes. 

    You can bring up and tear down Azure SQL Database instances at your convenience. Azure SQL Database comes up fast and is easy to configure. You can focus less on configuring software and more on making your app great.

- **Cost**

    Because we manage things for you, there are no systems for you to buy, provide power for, or otherwise maintain.

    Azure SQL Database has several pricing options. These pricing options allow you to balance performance versus cost, at a predictable cost. You can start for just a few dollars a month.

- **Scale**

    You find that the amount of transportation logistics data you must store doubles every year. When you run on-premises, how much excess capacity should you plan for?

    With Azure SQL Database, you can adjust the performance and size of your database on the fly when your needs change.

- **Security**

    Azure SQL Database comes with a firewall that's configured by default to block connections from the public internet. You control access to your data.

    You can allow access to specific IP addresses that you trust. Doing so allows you to use Visual Studio, SQL Server Management Studio, or other tools to manage your Azure SQL database.

## Planning concepts

Although you don't need to be a database administrator to use Azure SQL Database, there are a few concepts you should understand before you start. 

Your transportation company wants to set itself apart from other companies without breaking the bank. To provide the best service while controlling costs, you must have a good handle on how to set up the database.

Here, you learn what to consider when creating an Azure SQL database, including:

- How a logical server acts as an administrative container for your databases.
- The differences between purchasing models.
- How elastic pools enable you to share processing power among databases.
- How collation rules affect how data is compared and sorted.
- How to bring up Azure SQL Database from the Azure portal.
- How to add firewall rules so that your database is accessible from only trusted sources.

## One server, many databases

When you create your first Azure SQL database, you also create an _Azure SQL logical server_. Think of a logical server as an administrative container for your databases. You can control logins, firewall rules, and security policies through the logical server. You can also override these policies on each database within the logical server.

For now, you need just one database, but a logical server lets you add more at a later time and tune performance among all your databases.

## Choose performance: DTUs versus vCores

Azure SQL Database has two purchasing models: _DTU_ and _vCore_.

- **What are DTUs?**

    DTU stands for _Database Transaction Unit_, and is a combined measure of compute, storage, and I/O resources. Think of the DTU model as a simple, preconfigured purchase option.

- **What are vCores?**

    vCores stands for _Virtual cores_, which give you greater control over the compute and storage resources that you create and pay for.

    Unlike the DTU model, which provides fixed configurations for compute, storage, and I/O resources, the vCore model lets you configure each of these resources independently. For example, with the vCore model, you can increase storage capacity but keep the existing amount of compute and I/O throughput.

Your transportation and logistics prototype needs only one database. You decide to use the DTU option because it provides the best balance of compute, storage, and I/O performance. A small DTU database is less expensive to use while you build your prototype.

## What are SQL elastic pools?

When you create your Azure SQL database, you can create a _SQL elastic pool_. 

Elastic pools allow you to choose one price — one a pool of resources — for multiple databases to share. Elastic pools are a resource utilization pool, and are ideal if some of your databases have peak activity different times. Imagine if your business spans time zones, your databases are each busiest at 8am local time. Each database can use the resources they need within the pool's resource limits you set.

SQL elastic pools use eDTUs (elastic DTUs) or can be provisioned with vCores. 

For your prototype, you don't need a SQL elastic pool because you need only one SQL database.

## What is collation?

Collation refers to the rules that sort and compare data. Collation helps you define _sorting rules_ when case sensitivity, accent marks, and other language characteristics are important. Sorting rules allow you to arrange data in an ordered sequence.

Let's take a moment to consider what the default collation, **SQL_Latin1_General_CP1_CI_AS**, means:

- **Latin1_General** refers to the family of Western European languages.
- **CP1** refers to code page 1252, a popular character encoding of the Latin alphabet.
- **CI** means that comparisons are case insensitive. For example, "HELLO" compares equally to "hello".
- **AS** means that comparisons are accent sensitive. For example, "résumé" doesn't compare equally to "resume".

Because you don't have specific requirements for how data is sorted and compared, choose the default collation.
