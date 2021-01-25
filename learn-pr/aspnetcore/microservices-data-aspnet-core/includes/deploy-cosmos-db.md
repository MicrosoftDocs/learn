In this exercise, you will:

- Create an Azure Cosmos DB instance.
- Remove the MongoDB deployment from the cluster.
- Reconfigure the coupon service to use Azure Cosmos DB.
- Redeploy the coupon service.
- Inspect the Azure Cosmos DB data with the **Data Explorer** from the Azure portal.

## Create an Azure Cosmos DB instance

Run the following script:

```bash
./deploy/k8s/create-azure-cosmos-db.sh
```

The script:

- Creates an Azure Cosmos DB account with the MongoDB API.
- Creates a MongoDB database.
- Gets the connection string.

A variation of the following output appears:

```console
Creating an Azure Cosmos DB instance
====================================

Creating Azure Cosmos DB account eshop-learn-20210120180516594 in RG eshop-learn-rg
--------------------------------
{
  "DocumentEndpoint": "https://eshop-learn-20210120180516594.documents.azure.com:443/",
  "Kind": "MongoDB",
  "Location": "West US",
  "Name": "eshop-learn-20210120180516594"
}

Creating MongoDB database  in RG eshop-learn-rg
-------------------------
{- Finished ..
  "Name": "CouponDb",
  "ResourceGroup": "eshop-learn-rg"
}

Retrieving Azure Cosmos DB connection string
--------------------------------------------

ConnectionString: mongodb://eshop-learn-20210120180516594:B2ZpcheCnOeM5KWXkBGztLHF5Vrg2LggF42e4bl4RfLVdoO5DyYGIqxLCfcV70AQrhpB9D9BRWlLQ2spp1g5ng==@eshop-learn-20210120180516594.documents.azure.com:10255/?ssl=true&replicaSet=globaldb


Environment variables
---------------------
export ESHOP_COSMOSACCTNAME=eshop-learn-20210120180516594
export ESHOP_COSMOSDBCONNSTRING=mongodb://eshop-learn-20210120180516594:B2ZpcheCnOeM5KWXkBGztLHF5Vrg2LggF42e4bl4RfLVdoO5DyYGIqxLCfcV70AQrhpB9D9BRWlLQ2spp1g5ng==@eshop-learn-20210120180516594.documents.azure.com:10255/?ssl=true&replicaSet=globaldb
export ESHOP_IDTAG=20210120180516594

Run the following command to update the environment
eval $(cat ~/clouddrive/aspnet-learn/create-azure-cosmosdb-exports.txt)
```

The script displays some of the account and the database properties, along with the connection string. The process will take a few minutes. Execute the next task while waiting.

Copy the connection string value when the script finishes to reconfigure the coupon service.

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

In this case, only the coupon service uses MongoDB. Update the service's ConfigMap file as follows.

In *deploy/k8s/helm-simple/coupon/templates/configmap.yaml*, update the `ConnectionString` parameter from `mongodb://nosqldata` to the connection string displayed from the creation script, as shown in the next YAML fragment:

:::code language="yml" source="../code/deploy/k8s/helm-simple/coupon/templates/configmap.yaml" highlight="10":::

## Redeploy the coupon service

You need to get the load balancer's IP address from the initial deployment. You can save it to an environment variable by running the following command:

```bash
eval $(cat ~/clouddrive/source/deploy-application-exports.txt)
```

Then run the following script:

```bash
./deploy/k8s/deploy-application.sh --charts coupon
```

After a few minutes, when you see all services running in the *WebStatus* health checks dashboard, you can run the app as you did before deleting the `nosqldata` service.

You can also apply discounts in the checkout page, as shown in the next image:

:::image type="content" source="../media/coupon.png" alt-text="Shopping basket with discount coupon DISC-15 entered" lightbox="../media/coupon.png" border="true":::

## Use the Azure Cosmos DB Data Explorer from the Azure portal

Since you're now using Cosmos DB, you can use the Azure portal's **Data Explorer** tab to inspect, and even modify, the stored documents. For example:

:::image type="content" source="../media/cosmos-db-data-explorer.png" alt-text="Image description follows in text." lightbox="../media/cosmos-db-data-explorer.png" border="true":::

In the preceding image, you can see the document for coupon `DISC-15`, showing it's been used.
