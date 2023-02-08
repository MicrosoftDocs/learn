You're going to code a Java Web application, using Spring Boot, that connects to a database.

For security reasons, you'll need to secure that database access in the future. But first let's create the
application infrastructure, and then configure the Java application to use.

## Create the application infrastructure

In this exercise, you'll use Azure CLI to create the following resources:

- An Azure resource group, that will contain all the resources for your application.
- A PostgreSQL database server.
- An Azure Spring Apps cluster, and a Spring Boot application running inside this cluster.

You need to provide some environment variables at the beginning of the script, that should be unique across Azure.
We recommend you use your username and some random characters to avoid naming conflicts.

You also need to provide your local IP address to access the database from your local computer. This IP address should
be an IPv4 Address. If you don't know your local IP address, you can go to the following website: https://www.whatismyip.com/

Set the following environment variables:

```bash
AZ_RESOURCE_GROUP=<YOUR_UNIQUE_RESOURCE_GROUP_NAME>
AZ_DATABASE_USERNAME=<YOUR_POSTGRESQL_USERNAME>
AZ_DATABASE_PASSWORD=<YOUR_POSTGRESQL_PASSWORD>
AZ_LOCAL_IP_ADDRESS=<YOUR_LOCAL_IP_ADDRESS>
```

Once those environment variables are set, you can run the following command to create the resources:

```bash

AZ_LOCATION=eastus
AZ_SPRING_CLOUD=spring-${AZ_RESOURCE_GROUP}
AZ_DATABASE_NAME=pgsql-${AZ_RESOURCE_GROUP}
AZ_DATABASE_USERNAME=${AZ_DATABASE_USERNAME}

az group create \
    --name $AZ_RESOURCE_GROUP \
    --location $AZ_LOCATION

az postgres server create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name $AZ_DATABASE_NAME \
    --location $AZ_LOCATION \
    --sku-name B_Gen5_1 \
    --storage-size 5120 \
    --admin-user $AZ_DATABASE_USERNAME \
    --admin-password $AZ_DATABASE_PASSWORD
az postgres server firewall-rule create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name $AZ_DATABASE_NAME-database-allow-local-ip \
    --server $AZ_DATABASE_NAME \
    --start-ip-address $AZ_LOCAL_IP_ADDRESS \
    --end-ip-address $AZ_LOCAL_IP_ADDRESS
az postgres server firewall-rule create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name $AZ_DATABASE_NAME-database-allow-azure-ip \
    --server $AZ_DATABASE_NAME \
    --start-ip-address 0.0.0.0 \
    --end-ip-address 0.0.0.0
az postgres db create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name demo \
    --server-name $AZ_DATABASE_NAME

az extension add --name spring-cloud
az spring-cloud create \
   --name $AZ_SPRING_CLOUD \
   --resource-group $AZ_RESOURCE_GROUP \
   --location $AZ_LOCATION \
   --sku Basic
az spring-cloud app create \
   --resource-group $AZ_RESOURCE_GROUP \
   --service $AZ_SPRING_CLOUD \
   --name application \
   --runtime-version Java_11 \
   --assign-endpoint true
```

This script will take some time to run, so you can keep it in the background and start coding the application in the meantime.

## Configure the Java application

Get the application skeleton from the https://github.com/Azure-Samples/manage-secrets-in-java-applications GitHub repository, using the `git clone` command:

```bash
git clone https://github.com/Azure-Samples/manage-secrets-in-java-applications.git
```

This application uses Spring Data JPA to access the database, you can look at the CRUD Repository interface:

```java
package com.example.demo;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ItemRepository extends CrudRepository<Item, Integer> {
}
```

Data being stored in the database is then exposed to the Web, using a Spring MVC REST Controller:

```java
package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ItemController {

    private final ItemRepository itemRepository;

    public ItemController(ItemRepository itemRepository) {
        this.itemRepository = itemRepository;
    }

    @GetMapping("/")
    String welcome() {
        return "Here are all the database items: " + itemRepository.findAll();
    }
}
```

This data is inserted in the database at startup time, using the `src/main/resources/data.sql` file:

```sql
insert into item (details) values ('This is a item from the database');
```

You can add more lines to this file if you want more data, or if you want to customize it.

To access the database, you'll need to configure the `src/main/resources/application.properties` file:

```properties
logging.level.org.springframework.jdbc.core=DEBUG

spring.datasource.url=jdbc:postgresql://${azureDatabaseName}.postgres.database.azure.com:5432/demo
spring.datasource.username=${azureDatabaseUsername}@${azureDatabaseName}
spring.datasource.password=${azureDatabasePassword}

spring.sql.init.mode=always
```

This configuration file has three variables that need to be configured:

- `${azureDatabaseName}` is the name of the PostgreSQL database that was configured earlier in the `AZ_DATABASE_NAME` environment variable. Type `echo $AZ_DATABASE_NAME` to see it.
- `${azureDatabaseUsername}` is the name of the database username that was configured earlier in the `AZ_DATABASE_USERNAME` environment variable. Type `echo $AZ_DATABASE_USERNAME` to see it.
- `${azureDatabasePassword}` is the name of the database password that was configured earlier in the `AZ_DATABASE_PASSWORD` environment variable. Type `echo $AZ_DATABASE_PASSWORD` to see it.

As we've seen in the previous unit, it's a bad practice to hard-code those values in the application
source code. But to test the application, you can write them temporarily and run the application:

```bash
./mvnw spring-boot:run
```

You can read the database content by accessing the Spring MVC Controller using the
following command, or using a Web browser:

```bash
curl http://localhost:8080
```

## Deploy the Java application to Azure

To deploy the application, you'll first need to package it as a Jar file:

```bash
./mvnw clean package
```

This command will produce an executable Jar file in the `target` directory, that you'll deploy using
the Azure CLI:

```bash
az spring-cloud app deploy \
   --resource-group $AZ_RESOURCE_GROUP \
   --service $AZ_SPRING_CLOUD \
   --name application \
   --jar-path target/*.jar
```

If anything goes bad, you can look at the application logs by typing the following command:

```bash
az spring-cloud app logs \
   --resource-group $AZ_RESOURCE_GROUP \
   --service $AZ_SPRING_CLOUD \
   --name application
```

The application will then be available in the cloud, and you can access its data using a cURL
command:

```bash
curl https://$AZ_SPRING_CLOUD-application.azuremicroservices.io
```

Congratulations, you've successfully created a Java application that connects to a database! Now
you'll need to secure the database credentials in the next units.
