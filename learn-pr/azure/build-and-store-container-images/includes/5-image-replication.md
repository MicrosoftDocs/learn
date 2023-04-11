Suppose your company has compute workloads deployed to several regions to make sure you have a local presence to serve your distributed customer base. 

Your aim is to place a container registry in each region where images are run. This strategy will allow for network-close operations, enabling fast, reliable image layer transfers.

Geo-replication enables an Azure container registry to function as a single registry, serving several regions with multi-master regional registries.

A geo-replicated registry provides the following benefits:

- Single registry/image/tag names can be used across multiple regions
- Network-close registry access from regional deployments
- No extra egress fees, as images are pulled from a local, replicated registry in the same region as your container host
- Single management of a registry across multiple regions

## Create a replicated region for an Azure Container Registry

In this exercise, you'll run the `az acr replication create` Azure CLI command to replicate your registry from one region to another.

1. Run the following command to replicate your registry to another region. In this example, we're replicating to the `japaneast` region. *$ACR_NAME* is the variable you defined earlier in the module to hold your container registry name.

    ```azurecli
    az acr replication create --registry $ACR_NAME --location japaneast
    ```

    The output from this command should be similar to the following.

    ```output
    {
      "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ContainerRegistry/registries/myACR0007/replications/japaneast",
      "location": "japaneast",
      "name": "japaneast",
      "provisioningState": "Succeeded",
       "regionEndpointEnabled": true,
       "resourceGroup": "myresourcegroup",
       "status": {
        "displayStatus": "Syncing",
        "message": null,
        "timestamp": "2021-11-02T18:47:31.471393+00:00"
      },
      "systemData": {
        "createdAt": "2021-11-02T18:47:31.471393+00:00",
        "createdBy": "username@microsoft.com",
        "createdByType": "User",
        "lastModifiedAt": "2021-11-02T18:47:31.471393+00:00",
        "lastModifiedBy": "useremailid@microsoft.com",
        "lastModifiedByType": "User"
      },
      "tags": {},
      "type": "Microsoft.ContainerRegistry/registries/replications"
      "zoneRedundancy": "Disabled"
    }
    ```

1. Retrieve all container image replicas created by running the following command.

    ```azurecli
    az acr replication list --registry $ACR_NAME --output table
    ```

    The output should look similar to the following example.

    ```output
    NAME       LOCATION    PROVISIONING STATE    STATUS
    ---------  ----------  --------------------  --------
    japaneast  japaneast   Succeeded             Ready
    westus2    westus2     Succeeded             Ready
    ```

Keep in mind that you aren't limited to the Azure CLI to list your image replicas. In the Azure portal, select your container registry and from the container registry menu, select `Replications` to display a map that details current replications. Container images can be replicated and replicated images can be deleted by selecting an icon on the map.

  ![Screenshot of Azure container registry world map showing replicated and available locations.](../media/replication-map-expanded.png)

## Summary

In this module, you learned about the Azure Container Registry. You deployed your own registry, added a custom container, and created a container image. Finally, you saw how easy it's to replicate a container registry across Azure regions.

## Clean up resources

You want to clean up the resources you created using your Azure subscription in this module so that you won't continue to be charged for them.

1. In Azure, select **Resource groups** from the left menu.

1. Find the **learn-deploy-acr-rg** resource group, or the resource group name that you used, and select it.

1. In the **Overview** tab of the resource group, select **Delete resource group**.

1. In the confirmation dialog box, type the name of the resource group again and select **Delete** to delete all of the resources you created in this module.

## Learn More

[Azure Container Registry (ACR) documentation](/azure/container-registry/)

[Docker on Azure](/azure/docker/)
