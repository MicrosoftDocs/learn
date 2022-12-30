Developers can deploy to Azure directly from Eclipse, IntelliJ, or Maven. In the previous exercise, you created a to-do example Java web application and tested it locally. By adding Maven Plugin for Azure Container Apps to your project, you can deploy your application to Azure Container Apps.

In this unit, you'll see how to add and configure `azure-webapp-maven-plugin` for your Maven project.

## Add Maven Plugin for Azure Container Apps to your project

> [!NOTE]
> For information about the latest version of Maven Plugin, check the [Maven Plugin for Azure Container Apps documentation](https://github.com/microsoft/azure-maven-plugins/wiki/Azure-Web-App) or the [Maven central repository](https://search.maven.org/artifact/com.microsoft.azure/azure-webapp-maven-plugin/).

In the next exercise, you run the following command to set up the plug-in interactively.

```bash
mvn com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:config
```

The plug-in will prompt you for information to configure the App Service plan. After you confirm your choices, the plug-in adds the required settings to your project's *pom.xml* file to configure your web application to run in Azure Container Apps.

## Deploy

Maven creates the App Service plan interactively. In the next exercise, you'll use the following Maven command to deploy your application code to Azure Container Apps.

```bash
mvn package com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:deploy
```

### Configure Quarkus to use Azure Database for PostgreSQL

Open the *src/main/resources/application.properties* file and add some properties. Be sure to replace the two `$AZ_DATABASE_NAME` variables and the `$AZ_POSTGRES_PASSWORD` variable with the values that you set up earlier.

```properties
logging.level.org.hibernate.SQL=DEBUG

spring.datasource.url=jdbc:mysql://$AZ_DATABASE_NAME.mysql.database.azure.com:3306/demo?serverTimezone=UTC
spring.datasource.username=spring@$AZ_DATABASE_NAME
spring.datasource.password=$AZ_MYSQL_PASSWORD

spring.jpa.show-sql=true
spring.jpa.hibernate.ddl-auto=create-drop
```

> [!WARNING]
> The configuration property `spring.jpa.hibernate.ddl-auto=create-drop` means that Quarkus will automatically create a database schema at application start-up and will try to delete the database schema when it shuts down. This property is great for testing, but it shouldn't be used in production!

> [!NOTE]
> You append `?serverTimezone=UTC` to the configuration property `spring.datasource.url`. This setup tells the Java Database Connectivity (JDBC) driver to use the Coordinated Universal Time (UTC) date format when you connect to the database. Otherwise, your Java server won't use the same date format as the database, which will result in an error.

Now start your application by using the provided Maven wrapper:

```bash
./mvnw spring-boot:run
```

This screenshot shows the application running for the first time:

![Screenshot showing the running application.](../media/3-spring-boot-01.png)

