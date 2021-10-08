Congratulations! You've containerized and deployed a Java application to Azure Kubernetes Service

You wanted to learn how to containerize and deploy a Java app to Azure. You followed these steps:

1. Containerize a Java application using Docker

2. Build a Docker image for the Java application

3. Run the Docker image locally

4. Push the Docker image to Azure Container Registry

5. Deploy the Docker image to Azure Kubernetes Service

You're now confident that you can containerize and deploy a Java app to Azure.

## Enable diagnostic logging

Learn how Azure provides [built-in diagnostics to help with debugging](/azure/app-service/troubleshoot-diagnostic-logs/?WT.mc_id=java-10785-ropreddy&azure-portal=true).

## Clean up resources

In this module, you created Azure resources in a resource group. If you won't need these resources later, delete the resource group from the portal. Or run the following command in Azure Cloud Shell.

```bash
az group delete --name $AZ_RESOURCE_GROUP --yes
```

This command might take a minute to run.

> [!IMPORTANT]
> Deprovision the Azure resources you used in this module to avoid unwanted charges.

## Additional resources