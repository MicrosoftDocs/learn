In Azure, hosting and using PostgreSQL is simple. Develop your application with your choice of open-source tools and frameworks, and let Azure take care of managing virtual machines and infrastructure.

Azure Database for PostgreSQL runs the open-source, community edition of PostgreSQL. This approach means you can apply decades of development by the Postgres community, and rely on Azure to make hosting a secure database easy.

### PostgreSQL on Azure

Azure Database for PostgreSQL is a fully managed Platform as a Service (PaaS). The main benefit of this configuration is that Azure manages maintenance and security obligations.

Alternatively, you can also run PostgreSQL Server workloads as Infrastructure as a Service (IaaS) on either Azure or on-premises servers. These options offer full control over the database engine. However, this control comes at the cost of added responsibility for many database administration tasks, including:

* Database management
* Applying patches
* Making backups
* Managing virtual machines

With PaaS, you can pass these responsibilities to Azure. Additionally, setting up your database to ensure high availability requires very little hands-on configuration or administration.

#### More control with a Flexible Server

Some situations require more granular server control. In these cases, Azure Database for PostgreSQL can be deployed with a Flexible Server option. Flexible Server gives developers more control. This option retains the automation benefits of Azure Database for PostgreSQL without the complex operational requirements of IaaS.

### Scenario: A new kind of payment app

This module uses an example scenario to explain key PostgreSQL concepts and processes.

In this scenario, you work for Woodgrove Bank. You've been asked to develop a new contactless payment app that works from six feet away. You've already created a proof-of-concept app that uses a relational database, hosted on an on-premises server. Development continues, with plans for a trial of the app in a small city.

You realize the trial can bring many new users and high volumes of new data. The on-premises server could become overloaded, causing slow transaction times or timeout errors. You understand that the database solution must be scaled, both for capacity and performance. For maximum utility and data redundancy, it's also better to host data in more than one location. This approach requires a move away from the current on-premises database server without compromising security.

With this scenario in mind, over the course of this module, you set up an Azure Database for PostgreSQL instance and connect it to an ASP.NET app for development. Learn about the concepts that underlie how this task.

## Prerequisites

* Basic familiarity with relational databases

## Learning objectives

In this module:

* Create an Azure Database for PostgreSQL instance using the Azure portal
* Develop and query the database in the Azure Cloud Shell using `psql`
* Query the PostgreSQL database from an ASP.NET app
