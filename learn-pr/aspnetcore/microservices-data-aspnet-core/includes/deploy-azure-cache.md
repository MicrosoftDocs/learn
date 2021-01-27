In this unit, you will:

- Create an Azure Redis Cache instance.
- Remove the Redis cache deployment from the cluster.
- Reconfigure the affected projects to use the new Azure Redis Cache instance.
- Redeploy the affected projects.

## Create an Azure Redis Cache instance

1. Run the following script:

    ```bash
    cd ./deploy/k8s && \
        ./create-azure-redis.sh
    ```

    The preceding script:

    - Navigates to the directory containing the resource provisioning script.
    - Starts the creation of the Azure Cache for Redis.
    - Gets the connection string.
    - Waits for the creation command to finish (it could take a few minutes).

    A variation of the following output appears:

    ```console
    Creating an Azure Cache for Redis instance
    ==========================================
    
    Creating Azure Cache for Redis eshop-learn-20210120180516594 in RG eshop-learn-rg
    ------------------------------
    {- Finished ..
      "HotsName": "eshop-learn-20210120180516594.redis.cache.windows.net",
      "Location": "West US",
      "Name": "eshop-learn-20210120180516594",
      "ProvisioningState": "Creating",
      "RedisVersion": "4.0.14"
    }
    
    Retrieving Azure Cache for Redis connection string
    --------------------------------------------------
    
    ConnectionString: eshop-learn-20210120180516594.redis.cache.windows.net:6380,password=ofiCJafSxzsxGgwYTKryxgM+ErwT+ViaSQa1PsHZaBM=,ssl=True,abortConnect=False
    
    Waiting for the Azure Cache for Redis creation to finish (Creating) - Ctrl+C to cancel...
    
    Environment variables
    ---------------------
    export ESHOP_REDISNAME=eshop-learn-20210120180516594
    export ESHOP_REDISPRIMARYKEY=ofiCJafSxzsxGgwYTKryxgM+ErwT+ViaSQa1PsHZaBM=
    export ESHOP_REDISCONNSTRING=eshop-learn-20210120180516594.redis.cache.windows.net:6380,password=ofiCJafSxzsxGgwYTKryxgM+ErwT+ViaSQa1PsHZaBM=,ssl=True,abortConnect=False
    export ESHOP_IDTAG=20210120180516594
    
    Run the following command to update the environment
    eval $(cat ~/clouddrive/aspnet-learn/create-azure-redis-exports.txt)
    ```

    In the preceding output, you can see that the creation command returns rather quickly, but with status "Creating". Then the connection string is displayed and a loop begins with the message "Waiting for the Azure Cache for Redis creation to finish...". You'll get the resulting environment variables when the creation finishes.

1. Copy the connection string in the preceding command's output.

You can begin the next step while waiting for the script to finish.

## Remove the Redis microservice from the cluster

Run the command:

```bash
helm delete eshoplearn-basketdata
```

The following output appears:

```console
release "eshoplearn-basketdata" uninstalled
```

If you checked the *WebStatus* dashboard, you should see the HTTP aggregator and basket service failing. Although it could take a little while to show.

## Reconfigure the affected projects

Update the ConfigMap files for the following projects that are using Redis:

- Basket service
- Identity service
- SignalR service
- WebSPA app

In the [Cloud Shell editor](/azure/cloud-shell/using-cloud-shell-editor), apply the following changes in the *deploy/k8s/helm-simple* directory.

### Reconfigure the basket service

In *basket/templates/configmap.yaml*, update the `ConnectionString` key's value from `basketdata` to the connection string from the creation script:

:::code language="yaml" source="../code/deploy/k8s/helm-simple/basket/templates/configmap.yaml" highlight="10":::

The connection string is used in the following locations:

*src/Services/Basket/Basket.API/Startup.cs*

:::code language="csharp" source="../code/src/services/basket/basket-api/startup.cs" id="snippet_ConfigureServices" highlight="8":::

*src/Services/Basket/Basket.API/Infrastructure/Repositories/RedisBasketRepository.cs*

:::code language="csharp" source="../code/src/services/basket/basket-api/infrastructure/repositories/redisbasketrepository.cs" highlight="9,12,20":::

*src/Services/Basket/Basket.API/Startup.cs*&mdash;The `ConfigureServices` method calls the `AddCustomHealthCheck` extension method:

:::code language="csharp" source="../code/src/services/basket/basket-api/startup.cs" id="snippet_AddCustomHealthCheck" highlight="8":::

### Reconfigure the identity service

In *identity/templates/configmap.yaml*, update the `ConnectionString` key's value to the connection string:

:::code language="yaml" source="../code/deploy/k8s/helm-simple/identity/templates/configmap.yaml" highlight="10":::

The connection string is used in the `ConfigureServices` method of *src/Services/Identity/Identity.Api/Startup.cs*:

:::code language="csharp" source="../code/src/services/identity/identity-api/startup.cs" highlight="12":::

### Reconfigure the SignalR service

In *signalr/templates/configmap.yaml*, update the `SignalrStoreConnectionString` key's value to the connection string:

:::code language="yaml" source="../code/deploy/k8s/helm-simple/signalr/templates/configmap.yaml" highlight="10":::

The connection string is used in the `ConfigureServices` method of *src/Services/Ordering/Ordering.SignalrHub/Startup.cs*:

:::code language="csharp" source="../code/src/services/ordering/ordering-signalrhub/startup.cs" highlight="9":::

### Reconfigure the WebSPA app

In *webspa/templates/configmap.yaml*, update the `DPConnectionString` key's value to the connection string:

:::code language="yaml" source="../code/deploy/k8s/helm-simple/webspa/templates/configmap.yaml" highlight="10":::

The connection string is used in the `ConfigureServices` method of *src/Web/WebSPA/Startup.cs*:

:::code language="csharp" source="../code/src/web/webspa/startup.cs" highlight="12":::

## Redeploy the affected microservices

You need to get the load balancer's IP address from the initial deployment. You can save it to an environment variable by running the following command:

```bash
eval $(cat ~/clouddrive/aspnet-learn/deploy-application-exports.txt)
```

Then just run the following script:

```bash
./deploy-application.sh --charts basket,identity,signalr,webspa
```

After a few minutes, when you see all services running in the *WebStatus* dashboard, run the app as you did before deleting the `basketdata` service to confirm it's working.
