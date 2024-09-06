The steps in this unit illustrate how to deploy your Java EE application to JBoss EAP on Azure App Service, and how to connect to the database. You'll actually execute these steps in the next unit.

## Create a Java EE (Jakarta EE) application

In this module, you'll use a sample Java EE application that's prepared in advance and uses the following technologies:

- Java EE 8 (Jakarta EE 8)
- JAX-RS 2.1
- JSON-B 1.0
- CDI 2.0
- JPA 2.2

> [!TIP]
> The deployment procedure introduced here is similar for most Java EE (Jakarta EE) web applications.

## Configure the application project for deploying to Azure by using Maven

Microsoft provides the Maven Plugin for Azure App Service to deploy your Java web applications to Azure App Service. By using this Maven plug-in, you can easily configure the following settings for your App Service instance:

|  Items  |  Description  |
| ---- | ---- |
|  `subscriptionID`|  Azure subscription for deployment |
|  `resourceGroup` |  Name of the resource group where the web container is deployed |
|  `appName`  |  Application instance name for the web container |
|  `pricingTier`  | Virtual machine selection to run |
|  `region`  |  Region to deploy (same location as the MySQL installation location)|
|  `runtime` `OS` | Operating system to run (Linux)|
|  `runtime` `javaVersion` | Java virtual machine version for the web container (Java 8)|
|  `runtime` `webContainer` | Web container (JBoss EAP 7)|

In this module, you deploy an application to the JBoss EAP environment. Select `Java 8` for the Java version and `Jbosseap 7.4` for the runtime web container.

## Build the WAR package

You can use the `./mvnw package` command to build a Web Application Archive (WAR) package.

> [!NOTE]
> Optionally, you can test the package by deploying to a local JBoss EAP environment.

## Deploy the Java EE app to JBoss EAP

After you create your Maven artifact, you can run the `deploy` command in the Maven Plugin for Azure App Service to deploy the application to JBoss EAP.

The `deploy` command creates an Azure resource group and an instance of JBoss EAP based on the preceding plug-in settings. This one command does everything from creating instances to deploying the Java web application.

For the complete list of configurations, see the plugin reference documentation. All the Azure Maven Plugins share a common set of configurations. For these configurations see [Common Configurations](https://github.com/microsoft/azure-maven-plugins/wiki/Common-Configuration). For configurations specific to App Service, see [Azure Web App: Configuration Details](https://github.com/microsoft/azure-maven-plugins/wiki/Azure-Web-App:-Configuration-Details).

## Configure a database connection by using a data source and JNDI

Your application will require a binding to a data source. We'll configure the application to use the MySQL database that we created in the previous units.

To connect to the database from JBoss EAP, you need configure a `DataSource` object. When you configure a `DataSource` object, an application can connect to the database.

You'll configure `DataSource` to connect to the Azure Database for MySQL instance that you created earlier with the following information:

| Data source configuration | value |
| --- | --- |
| `DataSource Name` | `JPAWorldDataSourceDS`  |
| `JNDI Name` | `java:jboss/datasources/JPAWorldDataSource` |
| `Connection URL`| `${MYSQL_CONNECTION_URL}` |
| `JDBC Driver Name`| `$PACKAGE_NAME.war_com.mysql.cj.jdbc.Driver_8_0` |
| `User Name` | `${MYSQL_USER}` |
| `Password` | `${MYSQL_PASSWORD}`|
| `Minimum Pool Size` | `5` |
| `Maximum Pool Size` | `20` |
| `JDBC Class Name`| `com.mysql.cj.jdbc.Driver` |

We used a Java Naming and Directory Interface (JNDI) name of `java:jboss/datasources/JPAWorldDataSource` for the data source. JNDI is useful in multiple environments to change to a different database without code changes.

## Access the application

After you configure the MySQL data source connection in JBoss EAP, you can access the Java EE application by using a web browser or the `curl` command.

In the next unit, you'll deploy the sample app by using the procedure outlined here.
