Congratulations! You deployed a Quarkus application to Azure Container Apps.

Your company wanted to deploy a Quarkus application to the cloud. You completed these steps:

1. Created a sample Quarkus application and ran and tested it locally.

1. Created an instance of Azure Database for PostgreSQL and configured your Quarkus application to access the database. 

1. Containerized the Quarkus application.

1. Created an Azure Container Apps environment, deployed the Quarkus application container, and tested the application in the cloud.

1. Updated the firewall rules to disable external calls to the database and allow only the Quarkus application to access it.

You're now confident that you can recommend running your Quarkus application in Container Apps.

## Clean up resources

In this module, you created Azure resources in a resource group. If you don't need these resources, delete the resource group from the portal. Or run the following command:

```bash
az group delete \
    --name $AZ_RESOURCE_GROUP \
    --yes
```

This command might take a minute to run.

> [!IMPORTANT]
> Deprovision the Azure resources that you used in this module to avoid being charged for them.

## Additional resources

- [Quarkus guides](https://quarkus.io/guides)
- [Azure Container Apps](https://azure.microsoft.com/products/container-apps)
- [Azure Database for PostgreSQL documentation](/azure/postgresql/)
- [Hibernate ORM with Panache](https://quarkus.io/guides/hibernate-orm-panache)
- [Azure for Java developers](/azure/developer/java)
- [Compare Java application hosting options on Azure](/azure/architecture/guide/technology-choices/service-for-java-comparison)
