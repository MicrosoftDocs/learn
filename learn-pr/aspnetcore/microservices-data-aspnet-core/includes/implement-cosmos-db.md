As discussed in previous units, the coupon service uses MongoDB to store coupon data. This unit explores replacing the cluster's MongoDB deployment with a cloud-based MongoDB service.

In this unit, you will:

- Create an Azure Cosmos DB instance.
- Remove the MongoDB deployment from the cluster.
- Reconfigure the coupon service to use Azure Cosmos DB.
- Redeploy the coupon service.
- Inspect the Azure Cosmos DB data with the **Data Explorer** from the Azure portal.

## Create an Azure Cosmos DB instance

1. Run the following script:

    ```bash
    deploy/k8s/create-azure-cosmos-db.sh
    ```

    The script:

    - Creates an Azure Cosmos DB account with the MongoDB API.
    - Creates a MongoDB database.
    - Gets the connection string.

    A variation of the following output appears:

    ```console

    ```

    The script displays some of the account and the database properties, along with the connection string. The process will take a few minutes. Execute the next task while 

1. Copy the connection string value when the script finishes to reconfigure the coupon service.

## Remove the MongoDB deployment from the cluster

You'll no longer need the MongoDB service in the cluster. Delete it with the following command:

```bash
helm delete eshoplearn-nosqldata
```

The following output appears:

```console
release "eshoplearn-nosqldata" uninstalled
```

## Reconfigure the coupon service to use Azure Cosmos DB

The coupon service's ConfigMap file needs to be updated with the connection string for the Azure-managed database.

In *deploy/k8s/helm-simple/coupon/templates/configmap.yaml*, update the `ConnectionString` key's value from `mongodb://nosqldata` to the connection string displayed from the creation script, as shown in the next YAML fragment:

:::code language="yaml" source="../code/deploy/k8s/helm-simple/coupon/templates/configmap.yaml" highlight="10":::

## Redeploy the coupon service

1. Build and publish a new image to ACR with the following script:

    ```bash
    deploy/k8s/build-to-acr.sh --services coupon-api
    ```

1. Run the following script:

    ```bash
    deploy/k8s/deploy-application.sh --charts coupon
    ```

The preceding script uses Helm to deploy the *:::no-loc text="coupon":::* Docker image from your ACR instance to AKS. The script runs the `kubectl get pods` command, whose output contains entries for the pod of basket api. The `STATUS` and `AGE` column values indicate that the deployments were successful:

```console
NAME                               READY   STATUS              RESTARTS   AGE
coupon-7474cfc46f-bcz5f            0/1     ContainerCreating   0          2s
coupon-86b5766658-qbb6h            0/1     Terminating         2          38m
```

When all the health checks return to a healthy status, sign out of run the app, then refresh your browser. Test the application as before to validate your changes were successful. When checking out, apply a coupon code `DISC-15` and observe a $15 USD discount is applied.

:::image type="content" source="../media/coupon.png" alt-text="Shopping basket with discount coupon DISC-15 entered" lightbox="../media/coupon.png" border="true":::

## Use the Azure Cosmos DB Data Explorer from the Azure portal

Use the Azure portal's **Data Explorer** tab to inspect the stored documents using the following steps:

1. In another browser tab, sign into the [Azure portal](https://portal.azure.com?azure-portal=true) with the same account and directory as the Cloud Shell.
1. Use the search box to find and open the CosmosDB resource prefixed with *:::no-loc text="eshoplearn":::*.
1. 

:::image type="content" source="../media/cosmos-db-data-explorer.png" alt-text="Image description follows in text." lightbox="../media/cosmos-db-data-explorer.png" border="true":::

In the preceding image, you can see the document for coupon `DISC-15`, showing it's been used.
