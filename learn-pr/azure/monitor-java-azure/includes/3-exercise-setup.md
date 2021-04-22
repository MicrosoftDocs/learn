In this exercise, you'll configure a Sample Application to be ready for monitoring.

## Enable the Java in-process monitoring agent with Azure Spring Cloud

In this module, you'll use APM with Azure Spring Cloud as it offers in-depth performance monitoring without requiring code changes, recompiling, retesting, or redeployment.
APM provides Visibility into all your applications with the following features:

- Logs, exceptions, and metrics in the context of call paths offer meaningful insights and actionable information to speed root cause analysis.
- Insights into application dependencies – SQL Database, MySQL, PostgreSQL, MariaDB, JDBC, MongoDB, Cassandra, Redis, JMS, Kafka, Netty / WebFlux and so on.
- Performance data for every call into operations exposed by applications, including data-like request counts, response times, CPU usage, and memory.
- Custom metrics, allowing you to publish custom performance indicators or business-specific metrics and visualize deeper application and business insights.
- Ability to browse, query, and alert on application metrics and logs.

We'll illustrate APM by using a distributed reference application.
In the upcoming exercise, we'll activate APM on creation of our Azure Spring Cloud instance with the "--enable-java-agent" CLI option:

```bash
az spring-cloud create --name ${SPRING_CLOUD_SERVICE} \
--sku standard --enable-java-agent \
--resource-group ${RESOURCE_GROUP} \
--location ${REGION}
```

## Access the sample application

In this exercise, you'll clone a GitHub repository that contains all the code for Monitoring.

1. On GitHub, clone the below repository:

   ```html
   https://github.com/roryp/azure-spring-cloud-reference-architecture.git
   ```

## Setup and run the Setup script

Edit the deployPetClinicApp.sh and customize the below parameters for your environment

| Variable | Description |
|-|-|
| project_directory| local directory that will be used to clone the repository and build/deploy the application |
| subscription | Your Azure Subscription ID. To find your Subscription ID, Sign in to the Microsoft Azure portal. In the left-hand menu, select "All Services". In the General section, select "Subscriptions". Copy the Subscription ID for the applicable subscription |
| resource_group | Provide a new or existing resource group name |
| region | The Azure region you'll use. You can use `westeurope` by default, but we recommend that you use a region close to where you live. To see the full list of available regions, enter `az account list-locations` |
| spring_cloud_service | Name of your Azure Spring Cloud instance |
| mysql_server_name | The name of your MySQL server. It should be unique across Azure |
| mysql_server_admin_name | Username for the MySQL Administrator. The admin name can't be "azure_superuser", "admin", "administrator", "root", "guest, or "public" |
| mysql_server_admin_password | A new password for the server admin user. The password must be 8 to 128 characters long and contain a combination of uppercase or lowercase letters, numbers, and non-alphanumeric characters (!, $, #, %, and so on).|

## Run the setup script

```bash
cd petclinic
az login
sh deployPetClinicApp.sh
```

## Test the application

Navigate to the URL provided by the previous command to open the Pet Clinic microservice application.

![Real-time metrics](../media/4-petclinic.jpg)

## Next steps

In the next exercise, you'll set up your sample application for Monitoring
