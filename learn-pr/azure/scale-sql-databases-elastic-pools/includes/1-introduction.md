Azure SQL Database elastic pools are a cost-effective service that can manage and scale multiple Azure SQL databases that have varying and unpredictable resource requirements. 

Imagine you work for an innovative fitness company that uses Azure AI services to visually analyze hundreds of physical attributes and metrics of your customers. Customers come to your location to work out, and you use the intelligent systems to track their fitness progress and make health recommendations every time they visit. You designed your system to store customer data in an Azure SQL database.

As the business became successful and grew, franchises were sold globally, and there are now thousands of locations. However, your company continues to develop, maintain, and run the intelligent systems. What started as a gym has become a software as a service (SaaS) company. You now need to maintain and scale separate Azure SQL databases for each location. However, the data-resource requirements for each location are unique; some serve larger areas than others, and they run promotions at different times of the year.

Azure SQL Database elastic pools can help you manage fluctuating demand peaks. One of the best use cases for elastic pools are a pool of databases around the world that peak at different times of day, due to time zones. Elastic pools allow SQL databases currently peaking to have access to the majority of the pool's resources, as peak times move with the sunrise. Alternatively, some demand is seasonal. For example, gym memberships in the Northern hemisphere spike in January but dip in November and December. You could scale up or down the entire elastic pool as peak capacity needs change.

In this module, you'll learn how to use SQL elastic pools to scale, manage performance, and manage costs for collections of Azure SQL databases.

## Learning objectives

In this module, you will:

- Create an elastic pool.
- Add databases to an elastic pool.
- Configure database performance in an elastic pool.

## Prerequisites

- Basic knowledge of the Azure portal
- Basic knowledge of Azure SQL Server
