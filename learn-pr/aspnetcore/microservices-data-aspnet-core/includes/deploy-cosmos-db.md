In this exercise you will:

- Create an Azure Cosmos DB instance.
- Remove the MongoDB deployment from the cluster.
- Reconfigure the Coupon microservice to use Azure Cosmos DB.
- Redeploy the Coupon microservice.
- Inspect the Azure Cosmos DB data with the Data Explorer from the Azure portal.

## Create an Azure Cosmos DB instance

Run this script:

```bash
./deploy/k8s/create-azure-cosmos-db.sh
```

The script takes care of:

- Creating an Azure Cosmos DB account with the MongoDB API.
- Creating a MongoDB database.
- Getting the connection string.

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

The script displays some of the account and the database properties, along with the connection string.

The process will take e few minutes so you can easily execute next task while waiting.

Copy the connection string value when the script finishes to reconfigure the coupon microservice.

## Remove the MongoDB deployment from the cluster

You'll no longer need the MongoDB microservice in the cluster, so you can just delete it with the following command:

```bash
helm delete eshoplearn-nosqldata
```

The following output appears:

```console
release "eshoplearn-nosqldata" uninstalled
```

## Reconfigure the Coupon microservice to use Azure Cosmos DB

In this case, only the Coupon microservice uses MongoDB, so you just have to update one `configmap`.

In *deploy/k8s/helm-simple/coupon/templates/configmap.yaml*, Update the `ConnectionString` parameter from `mongodb://nosqldata` to the connection string displayed from the creation script, as shown in the next YAML fragment:

:::code language="yml" source="../code/deploy/k8s/helm-simple/coupon/templates/configmap.yaml" highlight="10":::

## Redeploy the Coupon microservice

You need to get the Load Balancer IP address from the initial deployment and you can get it into an environment variable by running the following command:

```bash
eval $(cat ~/clouddrive/source/deploy-application-exports.txt)
```

Then run the following script:

```bash
./deploy/k8s/deploy-application.sh --charts coupon
```

After a few minutes, when you should see all services running in the `webstatus` microservice, you can run the application just as you did before deleting the `nosqldata` microservice.

You can also apply discounts in the checkout page, as shown in the next image:

:::image type="content" source="../media/coupon.png" alt-text="Shopping basket with discount coupon DISC-15 entered" lightbox="../media/coupon.png" border="true":::

## Use the Azure Cosmos DB Data Explorer from the Azure portal

Since you're now using Cosmos DB, you can use the data explorer in the Azure portal, to inspect, and even modify, the stored documents, as shown next:

:::image type="content" source="../media/cosmos-db-data-explorer.png" alt-text="Image description follows in text." lightbox="../media/cosmos-db-data-explorer.png" border="true":::

In the preceding image, you can see the document for coupon `DISC-15`, showing it's been used.
