Suppose your company has compute workloads deployed to several regions to make sure you have a local presence to serve your distributed customer base. 

Your aim is to place a container registry in each region where images are run. This strategy will allow for network-close operations, enabling fast, reliable image layer transfers. 

Geo-replication enables an Azure container registry to function as a single registry, serving several regions with multi-master regional registries.

A geo-replicated registry provides the following benefits:

- Single registry/image/tag names can be used across multiple regions
- Network-close registry access from regional deployments
- No additional egress fees, as images are pulled from a local, replicated registry in the same region as your container host
- Single management of a registry across multiple regions

## Replicate a registry to multiple locations

In this exercise, you'll use the `az acr replication create` Azure CLI command to replicate your registry from one region to another. 

1. Run the following command to replicate your registry to another region. In this example, we are replicating to the `japaneast` region. *$ACR_NAME* is the variable you defined earlier in the module to hold your container registry name.

    ```azurecli
    az acr replication create --registry $ACR_NAME --location japaneast
    ```

    Here's an example of what the output from this command looks like:
    
    ```output
    {
      "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ContainerRegistry/registries/myACR0007/replications/japaneast",
      "location": "japaneast",
      "name": "japaneast",
      "provisioningState": "Succeeded",
      "resourceGroup": "myresourcegroup",
      "status": {
        "displayStatus": "Syncing",
        "message": null,
        "timestamp": "2018-08-15T20:22:09.275792+00:00"
      },
      "tags": {},
      "type": "Microsoft.ContainerRegistry/registries/replications"
    }
    ```

1. As a final step,  retrieve all container image replicas created by running the following command. 

    ```azurecli
    az acr replication list --registry $ACR_NAME --output table
    ```

    The output should look similar to the following:
    
    ```console
    NAME       LOCATION    PROVISIONING STATE    STATUS
    ---------  ----------  --------------------  --------
    japaneast  japaneast   Succeeded             Ready
    eastus     eastus      Succeeded             Ready
    ```

Keep in mind that you are not limited to the Azure CLI to list your image replicas. From within the Azure portal, selecting `Replications` for an Azure Container Registry displays a map that details current replications. Container images can be replicated to additional regions by selecting the regions on the map.

![Container replication map as seen in the Azure portal](../media/replication-map.png)

<!-- Cleanup sandbox -->
[!include[](../../../includes/azure-sandbox-cleanup.md)]
 

## Summary

You've now successfully replicated a container image to multiple Azure datacenters using the Azure CLI. 