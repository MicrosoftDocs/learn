Let's say you have compute workloads deployed to several regions. You can use Azure Container Registry to place a container registry in each region where images run. This strategy allows for network-close operations and enables fast and reliable image layer transfers.

Geo-replication enables a container registry to function as a single registry that serves several regions with multi-master regional registries.

A geo-replicated registry provides the following benefits:

- Use single registry/image/tag names across multiple regions.
- Network-close registry access from regional deployments.
- No extra egress fees, as images are pulled from a local, replicated registry in the same region as the container host.
- Single management of a registry across multiple regions.

## Create a replicated region for an Azure Container Registry

1. Replicate your registry to another region using the `az acr replication create` command. In this example, we replicate to the `japaneast` region.

    ```azurecli-interactive
    az acr replication create --registry $ACR_NAME --location japaneast
    ```

    Your output should look similar to the following condensed example output:

    ```output
    {
      ...
      resourceGroups/learn-acr-rg/providers/Microsoft.ContainerRegistry/registries/myuniqueacrname/replications/japaneast",
      "location": "japaneast",
      "name": "japaneast",
      "provisioningState": "Succeeded",
       "regionEndpointEnabled": true,
       "resourceGroup": "learn-acr-rg",
      ...
    }
    ```

2. View all the container image replicas using the `az acr replication list` command.

    ```azurecli-interactive
    az acr replication list --registry $ACR_NAME --output table
    ```

    Your output should look similar to the following example output:

    ```output
    NAME       LOCATION    PROVISIONING STATE    STATUS    REGION ENDPOINT ENABLED
    ---------  ----------  -------------------   -------   ------------------------
    japaneast  japaneast   Succeeded             Ready     True
    eastus     eastus      Succeeded             Ready     True
    ```

You can also use the Azure portal to view your container images by navigating to your container registry and selecting `Replications`:

  ![Screenshot of Azure container registry world map showing replicated and available locations.](../media/replication-map-expanded.png)

## Clean up resources

Remove the resources you created in this module to avoid incurring charges. Deleting the resource group also deletes all its associated resources.

1. Navigate to the [Azure Cloud Shell](https://shell.azure.com/bash).
2. Delete the resource group using the `az group delete` command.

    ```azurecli-interactive
    az group delete --name learn-acr-rg --yes --no-wait 
    ```

## Learn more

Learn more about Azure Container Registry and Docker on Azure with the following resources:

- [Azure Container Registry (ACR) documentation](/azure/container-registry/)
- [Docker on Azure](/azure/docker/)
