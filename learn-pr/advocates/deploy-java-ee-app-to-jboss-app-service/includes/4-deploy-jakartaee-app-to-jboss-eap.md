In this unit, we outline how to deploy our Java EE application to JBoss EAP on Azure App Service.

## Deployment Procedure

To deploy your Java EE application and connect to your database, the deployment procedure is as follows:

1. Create your Java EE (Jakarta EE) Application
2. Configure your application project for deploying to Azure using Maven
3. Build your WAR package
4. Deploy your Java EE App to JBoss EAP
5. Configure a DB Connection from JBoss EAP
6. Access your application

### Create  a Java EE (Jakarta EE) Application

In this module, you'll use a sample Java EE application that's prepared in advance and uses the following technologies:

- Java EE 8 (Jakarta EE 8) Application
  - JAX-RS 2.1
  - JSON-B 1.0
  - CDI 2.0
  - JPA 2.2

> [!TIP]
> The deployment procedure introduced here's is similar with most Java EE (Jakarta EE) web application.

### Configure the application project for deploying to Azure using Maven

Microsoft provides the `Maven Plugin for Azure App Service` to deploy your Java web applications to Azure App Service. By using this Maven plug-in, you can easily configure settings to create and configure an App Service instance.

You can configure the following items by using the Maven Plugin:

|  Items  |  Description  |
| ---- | ---- |
|  Subscription ID|  Azure Subscriptions for Deployment |
|  Resource Group |  The name of the Resource Group where Web Container is deployed |
|  AppName  |  Application Instance Name for Web Container |
|  Pricing Tier  |  VM Selection to Run |
|  Region  |  Regions to Deploy (Same Location as MySQL install location)|
|  Runtime OS | Operating System to Run [Linux]|
|  Runtime Java Version | JVM Version for Web Container up and running [Java 8]|
|  Runtime Web Container | Web Container [JBoss EAP 7]|

In this module, you'll deploy an application to the JBoss EAP environment. Select `Java 8` for the Java version and `Jbosseap 7.2` Web Container for Runtime.

### Build the WAR package

You can use `./mvnw package` command to build a WAR package.

> [!NOTE]
> Optionally, you can test the package by deploying to a local JBoss EAP environment.

### Deploy Java EE App to JBoss EAP

After you create your Maven artifact, you can execute the `deploy` command of `Maven Plugin for Azure App Service` to deploy the application to JBoss EAP.
The deployment command creates an Azure Resource Group and an instance of JBoss EAP based on the plug-in settings above.
It does everything from creating instances to deploying the Java web application with only one `deploy` command.

### Database connection using a DataSource and JNDI

Your application will require a binding to a data source.
We'll configure it to use the MySQL database that we created in the previous units.

To connect to the database from JBoss EAP, you need configure a `Datasource` Object.
A `Datasource` is a component used to connect to a database. Through a data source configuration in JBoss EAP, an application can connect to the database.

You'll configure the `DataSource` to connect to the `Azure Database for MySQL` created in the previous section with the following information.

| DataSource Configuration | value |
| --- | --- |
| DataSource Name | JPAWorldDataSourceDS  |
| JNDI Name | java:jboss/datasources/JPAWorldDataSource |
| Connection URL| ${MYSQL_CONNECTION_URL} |
| JDBC Driver Name| $PACKAGE_NAME.war_com.mysql.cj.jdbc.Driver_8_0 |
| User Name | ${MYSQL_USER} |
| Password | ${MYSQL_PASSWORD}|
| Minimum Pool Size | 5 |
| Maximum Pool Size | 20 |
| JDBC Class Name| com.mysql.cj.jdbc.Driver |

We created a `JNDI Name` as `java:jboss/datasources/JPAWorldDataSource` for the `DataSource`.
JNDI is useful in multiple environments to change to a different database without code changes.

### Access the Application

After configuring the MySQL data source connection in JBoss EAP, you can access the Java EE application using a Web browser or `curl` command.

In the next unit, we'll deploy our sample app using the deployment procedure outlined above.
