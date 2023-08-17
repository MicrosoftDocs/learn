The original *:::no-loc text="eShopOnContainers":::* [reference app](https://github.com/dotnet-architecture/eshoponcontainers) uses Redis in a container for the basket microservice. However, for simplicity, we've modified the basket microservice to use an in-memory cache instead.

In this unit, you will:

- Create an Azure Cache for Redis instance.
- Add Azure Cache to Redis to the basket service.
- Configure the basket service to use the new Azure Cache for Redis instance.
- Redeploy the basket service.
- Verify the deployment.

## Create an Azure Cache for Redis instance

1. In the terminal, run the following command:

    ```bash
    ./create-azure-redis.sh
    ```

    The preceding command:

    - Navigates to the directory containing the resource provisioning script.
    - Runs the script, which:
        - Starts the creation of the Azure Cache for Redis.
        - Gets the connection string.
        - Waits for the creation command to finish (it could take a few minutes).
    - Returns to the directory from which you started.

    A variation of the following output appears:

    ```console
    Retrieving Azure Cache for Redis connection string...
    
    ConnectionString: eshop-learn-20210402214407415.redis.cache.windows.net:6380,password=[password],ssl=True,abortConnect=False
    
    Done! The Azure Cache for Redis resource is provisioned, but it still has startup tasks to do. It will be a few minutes before the resource is ready.
    
    Check the status of the resource with the following:
    
     > az redis show -g eshop-learn-rg -n eshop-learn-20210402214407415 --query provisioningState
    ```

    As the message indicates, the Azure Cache for Redis instance needs time to start. Running the provided command displays "Creating" until the resource is ready. When the resource is ready, it will display "Succeeded." You can continue with the following steps while provisioning finishes.

1. Copy the connection string from the preceding command's output for use later.

## Add Azure Cache to Redis to the basket service

As implemented in the starter app, the basket service uses in-memory caching. We'll replace that with Azure Cache for Redis. Complete the following steps to remove the in-memory caching:

In the `ConfigureServices` method of *src/Services/Basket/Basket.API/Startup.cs*, apply the following changes:

1. Find the following line:

    ```csharp
    services.AddSingleton<IBasketRepository, InMemoryBasketRepository>();
    ```

    Replace it with the following:

    ```csharp
    services.AddTransient<IBasketRepository, RedisBasketRepository>();
    ```

    The preceding code replaces the in-memory data store and configures `RedisBasketRepository` for the `basket-api` service.

1. Replace the `// Add the ConnectionMultiplexer code...` comment with:

    ```csharp
    services.AddSingleton<ConnectionMultiplexer>(sp =>
    {
        var settings = sp.GetRequiredService<IOptions<BasketSettings>>().Value;
        return ConnectionMultiplexer.Connect(settings.ConnectionString);
    });  
    ```

    The preceding code sets the connection string for the Azure Redis Cache Instance in the service configuration. The actual connection string value gets passed dynamically by the `settings.ConnectionString`. The connection to the Azure Cache for Redis is managed by the `ConnectionMultiplexer` class. For more details, refer [Use Azure Cache for Redis with an ASP.NET Core web app](/azure/azure-cache-for-redis/cache-web-app-aspnet-core-howto?tabs=core5x)

1. Replace the `// Add the healthcheck code...` comment with:

    ```csharp
    hcBuilder.AddRedis(
                   configuration["ConnectionString"],
                   name: "redis-check",
                   tags: new string[] { "redis" });
    ```

    The preceding code adds a health check for the Redis cache dependency the basket microservice uses. Later in this unit, you'll verify the health of it in the **WebStatus** dashboard.

## Configure the basket service to use the new Azure Cache for Redis instance

In Kubernetes deployment, services store their configuration as [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/#configmap-object) object, so we need to update the `basket-api` config map file to point it to the newly created Azure Redis Cache instance.

Apply the following changes in the *deploy/k8s/helm-simple* directory:

1. In *basket/templates/configmap.yaml*, update the `ConnectionString` key's value from *basketdata* to the connection string from the creation script, as in the following example:

    :::code language="yaml" source="../code/deploy/k8s/helm-simple/basket/templates/configmap.yaml" highlight="10":::

1. In *signalr/templates/configmap.yaml*, update the `SignalrStoreConnectionString` key's value from *basketdata* to the connection string from the creation script, as in the following example:

    :::code language="yaml" source="../code/deploy/k8s/helm-simple/signalr/templates/configmap.yaml" highlight="10":::

    > [!NOTE]
    > We don't recommend storing connection strings as plain text in production environments. You can use [Azure Key Vault](/azure/key-vault/general/overview) to store secrets. For more details, refer [Use the Azure Key Vault Provider for Secrets Store CSI Driver in an Azure Kubernetes Service (AKS) cluster](/azure/aks/csi-secrets-store-driver).

1. Ensure you've saved all your changes, then build the app. The build should complete with no errors or warnings.

    ```bash
    dotnet build ../../src/Services/Basket/Basket.API/
    ```

At runtime, the connection string will be provided to the basket service as an environment variable. Within the code, the connection string is used in the following locations:

### *src/Services/Basket/Basket.API/Startup.cs*

:::code language="csharp" source="../code/src/services/basket/basket-api/startup.cs" id="snippet_ConfigureServices" highlight="7":::

The `ConfigureServices` method calls the `AddCustomHealthCheck` extension method:

:::code language="csharp" source="../code/src/services/basket/basket-api/startup.cs" id="snippet_AddCustomHealthCheck" highlight="8":::

### *src/Services/Basket/Basket.API/Infrastructure/Repositories/RedisBasketRepository.cs*

:::code language="csharp" source="../code/src/services/basket/basket-api/infrastructure/repositories/redisbasketrepository.cs" highlight="9,12,20":::

## Redeploy the basket service

To deploy the updated *:::no-loc text="basket":::* service, follow these steps:

1. Build and publish a new image to ACR with the following script:

    ```bash
    ./build-to-acr.sh --services basket-api
    ```

    The script starts an [ACR quick task](/azure/container-registry/container-registry-tasks-overview#quick-task) for the *:::no-loc text="basket":::* service. A variation of the following line confirms the Docker image was pushed to ACR:

    ```console
    2021/05/06 13:27:43 Successfully pushed image: eshoplearn20210506131415096.azurecr.io/basket.api:linux-latest
    ```

1. Run the following script to deploy the updated *:::no-loc text="basket":::* service to AKS:

    ```bash
    ./deploy-application.sh --charts basket
    ```

    The preceding script uses Helm to deploy the *:::no-loc text="basket":::* Docker image from your ACR instance to AKS. The script runs the `kubectl get pods` command, whose output contains entries for the pod of basket api. The `STATUS` and `AGE` column values indicate that the deployments were successful:

    ```console
    NAME                              READY  STATUS              RESTARTS   AGE    
    basket-4365c9c7fc-rwacb           0/1    Terminating          0          1s
    basket-544bc9c7fc-wtznp           0/1    ContainerCreating    0          1s
    ```

1. Run the following script to deploy the updated *:::no-loc text="Signalr":::* service to AKS:

    ```bash
    ./deploy-application.sh --charts signalr --registry eshoplearn
    ```

    The preceding script uses Helm to deploy the *:::no-loc text="signalr":::* Docker image from your eshoplearn docker registry to AKS. The script runs the `kubectl get pods` command, whose output contains entries for the `signalr` pod. The `STATUS` and `AGE` column values indicate that the deployments were successful:

    ```console
    NAME                              READY  STATUS              RESTARTS   AGE    
    signalr-4365c9c745-rwacb           0/1    Terminating          0          1s
    signalr-544bc9cdfg-wtznp           0/1    ContainerCreating    0          1s
    ```

When all the health checks return to a healthy status, sign out of the app, then refresh your browser. Test the application as before to validate your changes were successful.

## Verify the deployment

1. Navigate to the **WebStatus** URL and make sure the status of the basket service and its dependency Redis cache is healthy.

    :::image type="content" source="../media/basket-api-heath-check.png" alt-text="Screenshot of the health checks status dashboard." border="true" lightbox="../media/basket-api-heath-check.png":::

1. Browse the **:::no-loc text="Web SPA application":::** and verify that you are able to add catalog items to the shopping cart.

    :::image type="content" source="../media/eshop-spa-shopping-bag.png" alt-text="Screenshot of the shopping cart with .NET Blue Hoodie." border="true" lightbox="../media/eshop-spa-shopping-bag.png":::

In the next unit, you'll configure the coupon service to use Azure Cosmos DB.
