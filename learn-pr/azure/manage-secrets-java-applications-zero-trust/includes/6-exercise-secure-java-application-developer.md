In this unit, you configure the existing Spring Boot application to use the secrets stored in Azure Key Vault.

You take the role of a Java developer, who configures their project to read those secrets.

## Configuring the Java project

The Azure Spring Boot starter for Key Vault automates the usage of the Key Vault Java SDK for
Spring Boot developers.

In the previous section, we added two environment variables using the Azure CLI: `AZURE_KEYVAULT_ENABLED`, and `AZURE_KEYVAULT_URI`.
Spring Boot reads these environment variables and uses them to authenticate to Azure Key Vault,
using underneath the Java SDK for Key Vault.

To add support for the Azure Spring Boot starter for Key Vault, add the following dependency in
the application's `pom.xml` file:

```xml
<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot-starter-keyvault-secrets</artifactId>
</dependency>
```

When we created the Java project, we hard-coded the database name and password into the `src/main/resources/application.properties` file. Be sure to revert it to this version, which uses
variables provided by Azure Key Vault:

```properties
logging.level.org.springframework.jdbc.core=DEBUG

spring.datasource.url=jdbc:postgresql://${azureDatabaseName}.postgres.database.azure.com:5432/demo
spring.datasource.username=${azureDatabaseUsername}@${azureDatabaseName}
spring.datasource.password=${azureDatabasePassword}

spring.sql.init.mode=always
```

With that change, your application source code doesn't contain any secrets, and it gets them from the Azure Key Vault instance we configured in the previous section.

## Deploy the Java application to Azure

As in the previous unit, to deploy the application, you first need to package it as a Jar file:

```bash
./mvnw clean package
```

Then deploy it using the Azure CLI. This command can take several minutes to run.

```bash
az spring app deploy \
   --resource-group $AZ_RESOURCE_GROUP \
   --service $AZ_SPRING_CLOUD \
   --name application \
   --artifact-path target/*.jar
```

If you encounter failures, you can look at the application logs by typing the following command:

```bash
az spring app logs \
   --resource-group $AZ_RESOURCE_GROUP \
   --service $AZ_SPRING_CLOUD \
   --name application
```

The application is now available in the cloud, and you can access its data using a cURL
command:

```bash
curl https://$AZ_SPRING_CLOUD-application.azuremicroservices.io
```

Congratulations, you successfully created a Zero Trust Java application that uses Azure Key Vault to store secrets.
