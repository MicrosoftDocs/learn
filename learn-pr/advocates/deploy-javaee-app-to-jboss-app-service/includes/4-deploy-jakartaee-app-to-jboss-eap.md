## Deployment Procedure

The deployment procedure is as follows.

1. Create  a Java EE (Jakarta EE) Application
2. Configure the Project for deploying by using Azure App Service Maven Plugin
3. Compile & Create Java Package for Deploy
4. Deploy Java EE App to JBoss EAP 
5. Configure DB Connection from JBoss EAP
6. Access to the Application

###  Create  a Java EE (Jakarta EE) Application

At first, you create a Java EE (Jakarta EE) application.

In this module, You will use a sample Java EE application is prepared in advance. The application is a Java EE (Jakarta EE) 8 compliant application and uses the following technologies.

- Java EE 8 (Jakarta EE 8) Application 
	- JAX-RS 2.1
	- JSON-B 1.0
	- CDI 2.0
	- JPA 2.2 

This module uses the sample application that exists on GitHub, but the deployment procedure introduced here is the same as  general Java EE (Jakarta EE) web application.

###  Configure the Project for deploying by using Azure App Service Maven Plugin

Microsoft provides 'Azure App Service Maven Plugin' to deploy Java Web Applications to Azure App Service. By using this plug-in, you can easily configure settings to configure instances of App Service.

You can configure the following items by using the Maven Plugin.

|  Items  |  Description  |
| ---- | ---- |
|  Subscription ID|  Azure Subscriptions for Deployment |
|  Resource Group |  The name of the Resource Group where Web Container is deployed |
|  AppName  |  Application Instance Name for Web Container |
|  Pricing Tier  |  VM Selection to Run |
|  Region  |  Regions to Deploy |
|  Runtime OS | Operating System to Run |
|  Runtime Java Version | JVM Version for Web Container up and running |
|  Runtime Web Container | Web Container |

In this module, You will deploy an application to the JBoss EAP environment. So please select 'Java 8' for the Java version and 'Jbosseap 7.2' for Web Container for Runtime.

###  Compile & Create Java Package for Deploy

After you configure 'Azure App Service Maven Plugin', please execute 'mvn package' command. Then it compile the Java source code and create a Java package as (.war) to deploy to JBoss EAP.   
If you want to see them work in your local environment before deploying to Azure, you can use an artifacts under the 'target' directory to deploy to your local JBoss EAP environment to verify their behavior.

###  Deploy Java EE App to JBoss EAP 

After you create an artifact, You can execute the 'deploy' command of 'Azure App Service Maven Plugin' to deploy the application to JBoss EAP.  The deployment command creates a Resource Group and an Instance of JBoss EAP based on the plug-in settings above. 
It does everything from creating instances to deploying Java Web applications with only one 'deploy' command.

###  Configure DB Connection from JBoss EAP

Now You had been deployed the Java EE application. But if you access to the Web Application at this point, You will result in an error. This is because the application is implemented in the program to connect to the database and reference data from the DB, But there is no configuration from JBoss EAP to connect to the database now. Therefore, it is necessary to make a configuration to connect to the database from JBoss EAP.

In order to connect to the Database from JBoss EAP, You need configure a `Datasource`.
A `Datasource` is a component used to connect to a Database. Through the DataSource, an Application can persist or query the data. A DataSource can configure for any Database by using JDBC Drivers.  

You will configure the `DataSource` to connect to the 'Azure Database for MySQL' created in the previous section.

###  Access to the Application

After configured the MySQL connection on JBoss EAP, You can access to the Java EE (Jakarta EE) application and you can confirm it by using a Web browser or curl command.
