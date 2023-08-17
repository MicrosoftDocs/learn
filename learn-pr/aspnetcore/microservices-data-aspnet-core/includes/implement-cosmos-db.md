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
    ./create-azure-cosmos-db.sh
    ```

    The script:

    - Creates an Azure Cosmos DB account with the MongoDB API.
    - Creates a MongoDB database.
    - Gets the connection string.

    A variation of the following output appears:

    ```console
    Creating Azure CosmosDB account "eshop-learn-20210000" in resource group "eshop-learn-rg"...

     > az cosmosdb create --name eshop-learn-20210000 --resource-group eshop-learn-rg --kind MongoDB --output none
    
    
    Creating MongoDB database "CouponDb" in "eshop-learn-20210000"...
    
     > az cosmosdb mongodb database create --account-name eshop-learn-20210000 --name CouponDb --resource-group eshop-learn-rg --output none
    
    
    Retrieving connection string...
    
     > az cosmosdb keys list --type connection-strings --name eshop-learn-20210000 --resource-group eshop-learn-rg --query connectionStrings[0].connectionString --output tsv
    
    
    Connection String:

    mongodb://eshop-learn-20210000:<password>@eshop-learn-20210000.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@eshop-learn-20210000@
    
    ```

1. Copy the connection string value when the script finishes to reconfigure the coupon service in the subsequent steps.

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

In *deploy/k8s/helm-simple/coupon/templates/configmap.yaml*, update the `ConnectionString` key's value from `mongodb://nosqldata` to the connection string displayed from the creation script, as displayed in the following YAML fragment:

:::code language="yaml" source="../code/deploy/k8s/helm-simple/coupon/templates/configmap.yaml" highlight="10":::

## Redeploy the coupon service

Publish the existing `coupon-api` docker image from the `eshoplearn` DockerHub with the following script:

```bash
./deploy-application.sh --charts coupon --registry eshoplearn
```

As there are no code changes, so there's no need to rebuild `coupon-api` docker image. The preceding script uses Helm to deploy the existing *:::no-loc text="coupon":::* Docker image to AKS with a new configuration. The script runs the `kubectl get pods` command, whose output contains entries for the pod of basket api. The `STATUS` and `AGE` column values indicate that the deployments were successful:

```console
NAME                               READY   STATUS              RESTARTS   AGE
coupon-7474cfc46f-bcz5f            0/1     ContainerCreating   0          2s
coupon-86b5766658-qbb6h            0/1     Terminating         2          38m
```

When all the health checks return to a healthy status, sign out of run the app, then refresh your browser. Test the application as before to validate that your changes were successful. When checking out, apply a coupon code `DISC-15` and observe a $15 USD discount is applied, then place the order.

:::image type="content" source="../media/coupon.png" alt-text="Screenshot of the shopping basket with discount coupon DISC-15 entered." lightbox="../media/coupon.png" border="true":::

## Use the Azure Cosmos DB Data Explorer from the Azure portal

Upon submitting the order, the *order* service updates the status of the order to `Paid` within a few minutes, and the coupon gets marked as consumed. Wait a few minutes, then follow the steps to verify the state of the coupon in the Azure Cosmos DB data explorer:

Use the Azure portal's **Data Explorer** tab to inspect the stored documents using the following steps:

1. In another browser tab, sign into the [Azure portal](https://portal.azure.com?azure-portal=true) with the same account and directory as the Azure CLI.
1. Use the search box to find and open the CosmosDB resource prefixed with *:::no-loc text="eshoplearn":::*.
1. Select **Data explorer** from the menu on the left.
1. Expand **CouponDb**.
1. Expand **Coupon Collection**.
1. Select and review the individual coupon documents.

    :::image type="content" source="../media/cosmos-db-data-explorer.png" alt-text="Screenshot of the Data explorer showing the coupon is flagged as consumed." lightbox="../media/cosmos-db-data-explorer.png" border="true":::

    In the preceding image, you can see the document for coupon `DISC-15`, showing it's been used.

In the next unit, you'll check your knowledge of key concepts from this module.
