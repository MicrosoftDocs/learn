In this exercise you will:

- Create an Azure Cosmos DB instance.
- Remove the MongoDB deployment from the cluster.
- Reconfigure the Coupon microservice to use Azure Cosmos DB.
- Redeploy the Coupon microservice.
- Inspect the Azure Cosmos DB data with the Data Explorer from the Azure portal.

## Create an Azure Cosmos DB instance

Run this script:

```bash
./create-azure-cosmos-db.sh
```

The script takes care of:

- Creating an Azure Cosmos DB account with the MongoDB API.
- Creating a MongoDB database.
- Getting the connection string.

You should get something like this:

![Image description follows in text.](media/create-azure-cosmos-db.png)

The script displays some of the account and the database properties, along with the connection string.

The process will take e few minutes so you can easily execute next task while waiting.

Copy the connection string value when the script finishes to reconfigure the coupon microservice.

## Remove the MongoDB deployment from the cluster

You'll no longer need the MongoDB microservice in the cluster, so you can just delete it with the following command:

```bash
helm delete eshoplearn-nosqldata
```

You should get something like this:

![Displays: release "eshoplearn-nosqldata" uninstalled.](media/delete-mongodb.png)

## Reconfigure the Coupon microservice to use Azure Cosmos DB

In this case only the Coupon microservice uses MongoDB, so you just have to update one `configmap`.

Update the `ConnectionString` parameter from `coupon` to the connection string displayed from the creation script, as shown in the next `.yaml` fragment:

- `deploy/k8s/helm-simple/coupon/templates/configmap.yaml`<br><br>

    ```yml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: coupon-cm
      labels:
        app: eshop
        service: coupon
    data:
      #...
      ConnectionString: mongodb://eshop-learn-###...#:PASSWORD...@eshop-learn-###...#.documents.azure.com:10255/?ssl=true&replicaSet=globaldb
      #...
    ```

## Redeploy the Coupon microservice

You need to get the Load Balancer IP address from the initial deployment and you can get it into an environment variable by running the following command:

```bash
eval $(cat ~/clouddrive/source/deploy-application-exports.txt)
```

Then just run the following script from the `deploy/k8s` folder:

```bash
./deploy-application.sh --charts coupon
```

After a few minutes, when you should see all services running in the `webstatus` microservice, you should be able to run the application just as you did before deleting the `nosqldata` microservice.

You should also be able to apply discounts in the checkout page, as shown in the next image:

![Shopping basket with discount coupon DISC-15 entered](media/coupon.png)

## Use the Azure Cosmos DB Data Explorer from the Azure portal

Since you're now using Cosmos DB, you can use the data explorer in the Azure portal, to inspect, and even modify, the stored documents, as shown next:

![Image description follows in text.](media/cosmos-db-data-explorer.png)

In the image above you can see the document for coupon `DISC-15`, showing it's been used.
