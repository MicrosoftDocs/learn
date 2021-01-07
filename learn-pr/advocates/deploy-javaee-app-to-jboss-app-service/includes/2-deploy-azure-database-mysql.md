## Deploy Azure Database for MySQL

`Azure Database for MySQL` is a relational database service powered by the MySQL community edition. It's a fully managed database as a service offering that can handle mission-critical workloads with predictable performance and dynamic scalability.


You can use either Single Server or Flexible Server (Preview) to host a MySQL database in Azure. 

* Single Server
* Flexible Server (Preview)

### Azure Database for MySQL Flexible Server

In this module, you will use the `Flexible Server` which is best suited for following scenario.

* Application developments requiring better control and customizations
* Zone redundant high availability
* Managed maintenance windows


### How to create Azure Database for MySQL Flexible Server

In order to create a MySQL on Azure, you need execute following steps.


1. Login to Azure
2. Craete Resource Group
3. Create MySQL DB Instance
4. Create Firewall Rule

At first, you must create a `Resource Group` for creating the MySQL Resource. After created the resource group, you can create a `Azure Database for MySQL` instnce in the resource group. Finally in order to access to the MySQL instance, you need configure the Firewall Rule for it.

In order to create the MySQL Database Instance more easily, you can create your own custom shell script. In the next exercise, you will execute a shell script to create the `Azure Database for MySQL`.