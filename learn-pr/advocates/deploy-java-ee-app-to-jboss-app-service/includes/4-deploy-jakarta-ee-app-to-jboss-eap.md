The steps in this unit illustrate how to deploy your Jakarta EE application to Red Hat JBoss Enterprise Application Platform (JBoss EAP) on Azure App Service, and how to connect to the database. You execute these steps in the next unit.

## Create a Jakarta EE application

In this module, you use a sample Jakarta EE application that uses the following technologies:

- Jakarta EE 10
- JAX-RS 3.1
- JSON-B 3.0
- CDI 4.0
- JPA 3.1

> [!TIP]
> The deployment procedure introduced here is similar to the procedure used for most Jakarta EE web applications.

## Configure the application project for deploying to Azure by using Maven

Microsoft provides the Maven Plugin for Azure App Service to deploy your Java web applications to Azure App Service. By using this Maven plug-in, you can configure the following settings for your App Service instance:

| Setting                    | Description                                                         |
|--------------------------|---------------------------------------------------------------------|
| `subscriptionID`         | Azure subscription for deployment                                   |
| `resourceGroup`          | Name of the resource group where the web container is deployed      |
| `appName`                | Application instance name for the web container                     |
| `pricingTier`            | Virtual machine selection to use                                    |
| `region`                 | Region to deploy (same location as the MySQL installation location) |
| `runtime`, `OS`           | Operating system to use (Linux)                                     |
| `runtime`, `javaVersion`  | Java virtual machine version for the web container (Java 17)        |
| `runtime`, `webContainer` | Web container (JBoss EAP 8)                                         |

In this module, you deploy an application to the JBoss EAP environment. Select `Java 17` for the Java version and `Red Hat JBoss EAP 8` for the runtime web container.

## Build the WAR package

You can use the `./mvnw package` command to build a Web Application Archive (WAR) package.

> [!NOTE]
> Optionally, you can test the package by deploying to a local JBoss EAP environment.

## Deploy the Jakarta EE app to JBoss EAP

After you create your Maven artifact, you can use the `deploy` command in the Maven Plugin for Azure App Service to deploy the application to JBoss EAP. This command creates an Azure resource group and an instance of JBoss EAP based on the preceding plug-in settings. This one command does everything from creating instances to deploying the Java web application.

 All of the Azure Maven plug-ins share a common set of configurations. For the complete list of configurations, see the plug-in reference documentation. For more information, see [Common Configuration](https://github.com/microsoft/azure-maven-plugins/wiki/Common-Configuration). For more information about configurations specific to App Service, see [Azure Web App: Configuration Details](https://github.com/microsoft/azure-maven-plugins/wiki/Azure-Web-App:-Configuration-Details).

## Configure a database connection by using a data source and JNDI

Your application requires a binding to a data source. In the next unit, you configure the application to use the MySQL database that we created in the previous units. To connect to the database from JBoss EAP, you need to configure a `DataSource` object, which enables an application to connect to the database.

You configure `DataSource` to connect to the Azure Database for MySQL instance that you created earlier by using the following settings:

| Data source configuration | value                                            |
|---------------------------|--------------------------------------------------|
| `DataSource Name`         | `JPAWorldDataSourceDS`                           |
| `JNDI Name`               | `java:jboss/datasources/JPAWorldDataSource`      |
| `Connection URL`          | `${MYSQL_CONNECTION_URL}`                        |
| `JDBC Driver Name`        | `$PACKAGE_NAME.war_com.mysql.cj.jdbc.Driver_9_2` |
| `Minimum Pool Size`       | `5`                                              |
| `Maximum Pool Size`       | `20`                                             |
| `JDBC Class Name`         | `com.mysql.cj.jdbc.Driver`                       |

You used a Java Naming and Directory Interface (JNDI) name of `java:jboss/datasources/JPAWorldDataSource` for the data source. JNDI is useful in multiple environments to change to a different database without code changes.

## Access the application

After you configure the MySQL data source connection in JBoss EAP, you can access the Jakarta EE application by using a web browser or the `curl` command.

In the next unit, you deploy the sample app by using the procedure outlined here.
