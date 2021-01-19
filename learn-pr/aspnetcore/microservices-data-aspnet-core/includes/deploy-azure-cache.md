In this exercise you will:

- Create an Azure Redis Cache instance.
- Remove the redis cache deployment from the cluster.
- Reconfigure the affected microservices to use the new Azure Redis Cache instance.
- Redeploy the affected microservices.

## Create an Azure Redis Cache instance

Run this script from the `deploy/k8s` folder:

```bash
./create-azure-redis.sh
```

The preceding script:

- Starts the creation of the Azure Cache for Redis
- Gets the connection string
- Waits for the creation command to finish (It could take a few minutes)

You should get something like this:

:::image type="content" source="../media/create-azure-redis.png" alt-text="Image description follows in text." lightbox="../media/create-azure-redis.png" border="true":::

In the above image you can see that the creation command returns rather quickly, but with status "Creating". Then the connection string is displayed and a loop begins with the message "Waiting for the Azure Cache for Redis creation to finish...". You'll get the resulting environment variables when the creation finishes.

You can begin the next step while waiting for the script to finish.

## Remove the redis microservice from the cluster

Run the command:

```bash
helm delete eshoplearn-basketdata
```

You should get something like this:

:::image type="content" source="../media/delete-basketdata.png" alt-text="basketdata microservice delete confirmation from Helm" lightbox="../media/delete-basketdata.png" border="true":::

If you checked the `webstatus` microservice you should see Aggregator and the Basket microservice failing. Although it could take a little while to show.

## Reconfigure the affected microservices

Now you have to update the `configmaps` for the microservices that are using Redis:

- Basket
- Identity
- SignalR
- WebSPA

You must update the ConnectionString (or similar) parameter from `basketdata` to the connection string displayed from the creation script, as shown in the next `.yaml` fragments:

- `deploy/k8s/helm-simple/basket/templates/configmap.yaml`<br><br>

    ```yml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: basket-cm
      labels:
        app: eshop
        service: basket
    data:
      #...
      ConnectionString: eshop-learn-###...#.redis.cache.windows.net:6380,password=XXX...,ssl=True,abortConnect=False
      #...
    ```

- `deploy/k8s/helm-simple/identity/templates/configmap.yaml`<br><br>

    ```yml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: identity-cm
      labels:
        app: eshop
        service: identity
    data:
      #...
      DPConnectionString: eshop-learn-###...#.redis.cache.windows.net:6380,password=XXX...,ssl=True,abortConnect=False
      #...
    ```

- `deploy/k8s/helm-simple/signalr/templates/configmap.yaml`<br><br>

    ```yml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: signalr-cm
      labels:
        app: eshop
        service: signalr
    data:
      #...
      SignalrStoreConnectionString: eshop-learn-###...#.redis.cache.windows.net:6380,password=XXX...,ssl=True,abortConnect=False
    ```

- `deploy/k8s/helm-simple/webspa/templates/configmap.yaml`<br><br>

    ```yml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: webspa-cm
      labels:
        app: eshop
        service: webspa
    data:
      #...
      DPConnectionString: eshop-learn-###...#.redis.cache.windows.net:6380,password=XXX...,ssl=True,abortConnect=False
      #...
    ```

## Redeploy the affected microservices

You need to get the Load Balancer IP address from the initial deployment and you can get it into an environment variable by running the following command:

```bash
eval $(cat ~/clouddrive/source/deploy-application-exports.txt)
```

Then just run the following script from the `deploy/k8s` folder:

```bash
./deploy-application.sh --charts basket,identity,signalr,webspa
```

After a few minutes, when you should see all services running in the `webstatus` microservice, you should be able to run the application just as you did before deleting the `basketdata` microservice to check it's working as before.
