Azure Database for PostgreSQL is a managed database solution that provides highly available, massively scalable PostgreSQL in the cloud. The solution is made up of two tightly integrated layers: PostgreSQL, and specialized Azure services. You’re provided with all the features of the community edition of PostgreSQL, with the security, reliability, and performance you expect from Azure.

## The PostgreSQL layer

The PostgreSQL layer is based on the popular open-source PostgreSQL Community Edition, giving you access to a wide range of extensions. PostgreSQL is designed to handle a range of workloads, from single machines to data warehouses or Web services with many concurrent users.

![Extensions examples are Azure data studio extension, visual studio code extension, citus community extension, PLV8, PostGIS, and more. Languages include Python, PostGreSQL, Java, and php.](../media/2a-extensions-languages.png)

PostgreSQL has its own query language called pgsql. This language is a variant of the standard relational query language, SQL, with features that enable you to write stored procedures that run inside the database. However, Azure Database for PostgreSQL allows you to work with popular frameworks and languages such as Ruby on Rails, Python with Django, Java with Spring Boot, .NET, and Node.js.

## The Azure layer

Azure Database for PostgreSQL is available in three deployment modes, with each deployment mode allowing different levels of customization and scale.

**Single Server** deployments are suitable for most applications that don’t require high levels of customization or low latency performance across multiple regions. Single server deployments can be scaled down to only cost a few dollars per month. Workloads could include servers used for development and enterprise applications.

**Flexible Server** is an option that is in public preview. Designed to provide more control over database management and configuration settings, Flexible Servers provide better cost optimization controls. Ideal for workloads that don't need full compute capacity continuously.

:::row:::
:::column span="3":::

**Hyperscale (Citus)** delivers scale across multiple machines. It serves applications that require greater scale and performance, generally workloads that are approaching--or already exceed--100 GB of data. Hyperscale can also be deployed and managed on-premises, on the edge, or on multi-cloud environments using Azure Arc.

The Azure layer gives each deployment option four noticeable benefits:

* High availability, with an SLA of up to 99.99% uptime
* AI-powered performance optimization
* Automated hardware and software maintenance
* Advanced data and server security

They are constantly working behind the scenes, automated actions that can help your business reduce administration costs, as well as complexity.

:::column-end:::
:::column span="2":::
> [!NOTE]
> **Added benefits:**
>
> * High availability
> * Data protection
> * Automated maintenance
> * Predictable performance and pricing
> * Elastic scaling within seconds
> * Enterprise grade security
> * Best-in-class compliance
> * Monitoring and automation
> * Industry-leading support experience

:::column-end:::
:::row-end:::

### Data protection and security benefits

Data is automatically encrypted and backed up. Options such as Advanced Threat Protection make it simple to address potential threats without the need to be a security expert or manage advanced security monitoring systems.

Using our example of a contactless payment app, having a simple and reliable way to back up your database means you can focus on developing your app. Also, Advanced Threat Protection means it will be easier for you to mitigate threats if they arise during a trial, without having to rely on expert security personnel.

### Lower administrative complexity and cost

For many businesses, the decision to transition to a cloud service is as much about offloading the complexity of administration as it is about cost. Azure helps to lower administrative costs in three key ways. Firstly, options such as Hyperscale can optimize performance for you. Secondly, Azure automates maintenance and updates for the underlying hardware, operating system, and the database engine (minor versions). Thirdly, Azure provides automated management and analytics for monitoring of large-scale deployments. Together, these capabilities can allow for significant cost savings, especially when many databases need to be supported.

Using PostgreSQL on Azure for your Woodgrove Bank app would help you to structure your mobile app to accommodate its future growth. Once your app has proven its success, you can focus on building new features, and less on day-to-day operations.
