On Azure, hosting and using PostgreSQL is simple. You can develop your application with the open-source tools and platform of your choice, and let Azure take care of managing virtual machines and infrastructure.

Azure Database for PostgreSQL runs the open-source, community edition of PostgreSQL. You can still leverage the decades of development by the postgres community, while relying on Azure to make hosting a secure database easy.

### Postgres on Azure

Azure Database for PostgreSQL is a hosted Platform as a Service (PaaS), with Azure managing maintenance and security obligations.

PostgreSQL Server workloads can also run as Infrastructure as a Service (IaaS) on Azure, or on-premises servers. These options offer full control over the database engine. However, this control comes at the cost of added responsibility for many database administration (DBA) tasks, including:

* Database management
* Applying patches
* Making backups
* Managing virtual machines

With PaaS, you can assign these operations to Azure. Additionally, setting up your database to ensure high availability to another datacenter requires very little hands-on configuration or administration.

### More control with flexible server

For situations where more granular control is required, Azure Database for PostgreSQL can be deployed with a flexible server option. A flexible server gives developers more control, while retaining the automation benefits of Azure Database for PostgreSQL, without the complex operational requirements of IaaS.

In this scenario, you work for Woodgrove Bank, and you’ve been asked to develop a new contactless payment app that works from six feet away. Your proof-of-concept app currently uses a relational database, hosted on an on-premises server. Development continues, with plans to trial the app in a small city.

The trial will bring many new users and high volumes of new data. The on-premises server could become overloaded, causing poor transaction times. The database solution must be scaled, both for capacity, and performance. It’s also better to host data in more than one location, requiring a move away from the current on-premises database server, without compromising security.

In this module, we will set up an Azure Database for PostgreSQL instance and connect it to a Django app for development. We will go through the concepts behind how this happens, and why.

## Prerequisites

* Basic knowledge of relational databases

## Learning objectives

In this module, you will:

* Create an Azure Database for PostgreSQL instance using the CLI
* Query the Azure Database for PostgreSQL instance using pgsql
* Use a Django app to connect to the PostgreSQL database
