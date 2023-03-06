Congratulations! You've deployed a Quarkus application to Azure Container Apps.

Your company wanted to learn how to deploy a Quarkus application to the Cloud. You followed these steps:

1. Create a sample Quarkus application, execute and test it locally.

1. Create an Azure for PostgreSQL database, configure your Quarkus application to access the remote database, and execute it locally.

1. Containerize the Quarkus application.

1. Create an Azure Container Apps environment, deploy the Quarkus application container and test it in the cloud.

1. Update the firewall rules to disable external calls to the database and only allow the Quarkus application to access it.

You're now confident that you can recommend executing your Quarkus application to Azure Container Apps.

## Clean up resources

In this module, you created Azure resources in a resource group. If you don't need these resources later, delete the resource group from the portal. Or run the following command:

```bash
az group delete \
    --name $AZ_RESOURCE_GROUP \
    --yes
```

This command might take a minute to run.

> [!IMPORTANT]
> Deprovision the Azure resources you used in this module to avoid unwanted charges.

## Additional resources

For more information about Quarkus, see [Quarkus guides](https://quarkus.io/guides).

For more information about Azure Container Apps, [Azure Container Apps](https://azure.microsoft.com/products/container-apps).

For more information about PostgreSQL servers on Azure, see [Azure Database for PostgreSQL documentation](/azure/postgresql/).

For more information about Hibernate ORM with Panache, see [Hibernate ORM with Panache](https://quarkus.io/guides/hibernate-orm-panache).

For more information about using Azure with Java, see [Azure for Java developers](/azure/developer/java).

For more information about comparing java options on Azure, see [Compare Java application hosting options on Azure](/azure/architecture/guide/technology-choices/service-for-java-comparison).
