Congratulations! You've deployed a Quarkus application to Azure Red Hat OpenShift.

Your company wanted to learn how to deploy a Quarkus application to the Azure Red Hat OpenShift with Azure PostgreSQL. You followed these steps:

1. Create a sample Quarkus application, execute and test it locally using Quarkus Dev Services and Dev mode.

1. Build and package the Quarkus application to create a JAR file. Run it locally with a standload PostgreSQL database locally.

1. Create an Azure for PostgreSQL database, and create a TODO table in the database. 

1. Install a new Azure Red Hat OpenShift cluster and Configure the Quarkus application to connect to the Azure PostgreSQL database.

1. Deploy the Quarkus application container.

1. Install OpenShift serverless and configure the native serverless function deployment with Quarkus.

You're now confident that you can recommend executing your Quarkus application to Azure Red Hat OpenShift.

## Clean up resources

If you don't need these resources later, delete the resources from the Azure portal.

### Delete Azure Red Hat OpenShift cluster

* [Tutorial: Delete an Azure Red Hat OpenShift 4 cluster](https://docs.microsoft.com/en-us/azure/openshift/tutorial-delete-cluster)

### Delete resource group

```shell
az group delete --name YOUR_RESOURCE_GROUP --yes
```

This command might take a minute to run.

## Additional resources

For more information about Quarkus, see [Quarkus guides](https://quarkus.io/guides).

For more information about[Azure Red Hat OpenShift](https://azure.microsoft.com/en-us/products/openshift).

For more information about PostgreSQL servers on Azure, see [Azure Database for PostgreSQL documentation](/azure/postgresql/).

For more information about Hibernate ORM with Panache, see [Hibernate ORM with Panache](https://quarkus.io/guides/hibernate-orm-panache).

For more information about using Azure with Java, see [Azure for Java developers](/azure/developer/java).

For more information about Quarkus Azure extensions, see [Quarkus Azure extensions](https://quarkus.io/extensions/?search-regex=azure).
