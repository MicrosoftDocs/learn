In this unit, you will:

- Create an Azure Cache for Redis instance.
- Remove the Redis cache deployment from the cluster.
- Reconfigure the affected projects to use the new Azure Cache for Redis instance.
- Redeploy the affected projects.

> [!NOTE]
> If your Cloud Shell session disconnects due to inactivity, reconnect and run the following command to return to this directory and open the Cloud Shell editor:
>
> ```bash
> cd ~/clouddrive/aspnet-learn/src/ && \
>   code .
> ```

## Verify the deployment to AKS

Even though the app has been deployed, it might take a few minutes to come online. Verify that the app is deployed and online with the following steps:

1. Run the following command to display the various app URLs:

    ```bash
    cat ~/clouddrive/aspnet-learn/deployment-urls.txt
    ```

    A variation of the following output appears:

    ```console
    The eShop-Learn application has been deployed to "http://203.0.113.55" (IP: 203.0.113.55).

    You can begin exploring these services (when ready):
    - Centralized logging       : http://203.0.113.55/seq/#/events?autorefresh (See transient failures during startup)
    - General application status: http://203.0.113.55/webstatus/ (See overall service status)
    - Web SPA application       : http://203.0.113.55/
    ```

1. Select the **:::no-loc text="General application status":::** link in the command shell to view the *:::no-loc text="WebStatus":::* health checks dashboard. The resulting page displays the status of each microservice in the deployment. A green checkmark icon denotes a healthy service. The page refreshes automatically, every 10 seconds.

    > [!NOTE]
    > While the app is starting up, you might initially receive an HTTP 503 response from the server. Retry after a few seconds. The Seq logs, which are viewable at the **:::no-loc text="Centralized logging":::** URL, are available before the other endpoints.

1. After all the services are healthy, select the **:::no-loc text="Web SPA application":::** link in the command shell to test the *:::no-loc text="eShopOnContainers":::* web app. The following page appears:

    :::image type="content" source="../../media/microservices/eshop-spa.png" alt-text="Screenshot of the WebSPA application's products catalog page." border="true" lightbox="../../media/microservices/eshop-spa.png":::

1. Navigate to the checkout page as follows:
    1. Select the **:::no-loc text="LOGIN":::** link in the upper right to sign into the app. Sign in using the credentials provided on the page.
    1. Add the **:::no-loc text=".NET BLUE HOODIE":::** to the shopping bag by selecting the image.
    1. Select the shopping bag icon in the upper right.
    1. Select the **:::no-loc text="CHECKOUT":::** button.

1. Scroll to the bottom of the checkout page. Notice the presence of a discount coupon feature, formed by the following UI elements:
    * **:::no-loc text="See Available Coupons":::** link
    * **:::no-loc text="Coupon number":::** text box
    * **:::no-loc text="APPLY":::** button

    :::image type="content" source="../../microservices-configuration-aspnet-core/media/4-implement-feature-manager/discount-coupon-elements.png" alt-text="Screenshot of the UI elements that make up the discount coupon feature." border="true" lightbox="../../microservices-configuration-aspnet-core/media/4-implement-feature-manager/discount-coupon-elements.png":::

You've successfully verified the app was deployed to AKS. Additionally, you've seen the discount coupon feature that you're going to make configurable.
## Create an Azure Cache for Redis instance

1. Run the following command:

    ```bash
    pushd ./deploy/k8s && \
        ./create-azure-redis.sh && \
        popd
    ```

    The preceding command:

    - Navigates to the directory containing the resource provisioning script.
    - Runs the script, which:
        - Starts the creation of the Azure Cache for Redis.
        - Gets the connection string.
        - Waits for the creation command to finish (it could take a few minutes).
    - Returns to the directory you started from.

    A variation of the following output appears:

    ```console
    Retrieving Azure Cache for Redis connection string...
    
    ConnectionString: eshop-learn-20210402214407415.redis.cache.windows.net:6380,password=o0E0a90ObQOmrbT0ZbvJuoyt6+OxlByRDibrYPc3CQ8=,ssl=True,abortConnect=False
    
    Done! The Azure Cache for Redis resource is provisioned, but it still has startup tasks to do. It will be a few minutes before the resource is ready.
    
    Check the status of the resource with the following:
    
     > az redis show -g eshop-learn-rg -n eshop-learn-20210402214407415 --query provisioningState
    ```

    As the message implies, the Azure Cache for Redis instance needs time to start. Running the provided command displays "Creating" until the resource is ready. When the resource is ready, it will display "Succeeded." You may continue with the following steps while provisioning finishes.

1. Copy the connection string from the preceding command's output for use later.

## Remove the Redis microservice from the cluster

Run the command:

```bash
helm delete eshoplearn-basketdata
```

The following output appears:

```console
release "eshoplearn-basketdata" uninstalled
```

To verify the basket service is no longer functional, run the following command:

```bash
kubectl get pods
```

A variation of the following output appears:

```console
NAME                               READY   STATUS    RESTARTS   AGE
backgroundtasks-7f9698944d-gt229   1/1     Running   1          39m
basket-79dc747b57-dtf9f            0/1     Running   1          39m
catalog-66fccd7459-t4qjq           1/1     Running   3          39m
coupon-67685b6cd9-7h865            1/1     Running   2          39m
identity-5d749857fb-tlhzq          1/1     Running   2          38m
nosqldata-7dc8bc5b69-8nrgw         1/1     Running   0          38m
ordering-df5b7f6d5-nt6lh           1/1     Running   3          38m
payment-8484d98c5c-r4klj           1/1     Running   1          38m
rabbitmq-59b4b7cb67-kd96m          1/1     Running   0          38m
seq-f499759dd-pwq6f                1/1     Running   0          38m
signalr-5fbffd8ff4-q5xxl           1/1     Running   0          38m
sqldata-5659946c-cvv8r             1/1     Running   0          38m
webshoppingagg-7894bb8545-6c2f5    0/1     Running   0          38m
webspa-796c77dd7-gxc94             1/1     Running   0          38m
webstatus-575699d85-xp2m5          1/1     Running   0          38m
```

Note that the services beginning with `basket-` and `webshoppingagg-` are no longer in a "ready" state.

## Remove in-memory caching from basket service

The in-memory caching currently used in the basket service will be replaced with Azure Cache for Redis. Complete the following steps to remove the in-memory caching:

In the `ConfigureServices` method of *src/Services/Basket/Basket.API/Startup.cs*, apply the following changes:

1. Delete the following line (use <kbd>Ctrl</kbd>+<kbd>f</kbd> to search):

    ```csharp
    services.AddSingleton<IBasketRepository, InMemoryBasketRepository>();
    ```

<!-- TODO: finish writing these steps -->


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

Save your changes.

At runtime, the connection string will be provided to the basket service as an environment variable. Within the code, the connection string is used by code in the following locations:

*src/Services/Basket/Basket.API/Startup.cs*

:::code language="csharp" source="../code/src/services/basket/basket-api/startup.cs" id="snippet_ConfigureServices" highlight="7":::

*src/Services/Basket/Basket.API/Infrastructure/Repositories/RedisBasketRepository.cs*

:::code language="csharp" source="../code/src/services/basket/basket-api/infrastructure/repositories/redisbasketrepository.cs" highlight="9,12,20":::

*src/Services/Basket/Basket.API/Startup.cs*&mdash;The `ConfigureServices` method calls the `AddCustomHealthCheck` extension method:

:::code language="csharp" source="../code/src/services/basket/basket-api/startup.cs" id="snippet_AddCustomHealthCheck" highlight="8":::

### Reconfigure the identity service

In *identity/templates/configmap.yaml*, update the `DPConnectionString` key's value to the connection string:

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

To deploy the updated *:::no-loc text="basket":::* service, build and publish a new image to ACR with the following script:

    ```bash
    deploy/k8s/build-to-acr.sh --services basket-api
    ```

    The script starts an [ACR quick task](/azure/container-registry/container-registry-tasks-overview#quick-task) for the *:::no-loc text="basket":::* service. A variation of the following line confirms the Docker image was pushed to ACR:

    ```console
    2020/10/26 21:57:23 Successfully pushed image: eshoplearn20201026212601002.azurecr.io/webspa:linux-latest
    ```

    > [!IMPORTANT]
    > The *:::no-loc text="WebSPA":::* project is built in ACR, rather than local to Cloud Shell, to take advantage of robust build hosts in ACR. If the ACR quick task fails, inspect the output for troubleshooting information. Run the above script again to attempt additional builds.

1. Run the following script to deploy the updated *:::no-loc text="WebSPA":::* app to AKS:

    ```bash
    deploy/k8s/deploy-application.sh --charts webspa
    ```

    The preceding script uses Helm to deploy the *:::no-loc text="WebSPA":::* Docker image from your ACR instance to AKS. The script runs the `kubectl get pods` command, whose output contains entries for the SPA's pods. The `STATUS` and `AGE` column values indicate that the deployments were successful:

    ```console
    NAME                              READY   STATUS              RESTARTS   AGE
    webspa-64786f994f-5fz7m           0/1     Terminating         0          22m
    webspa-84fb8f987-df8hk            0/1     ContainerCreating   0          1s
    ```
You need to get the load balancer's IP address from the initial deployment. You can save it to an environment variable by running the following command:

```bash
eval $(cat ~/clouddrive/aspnet-learn/deploy-application-exports.txt)
```

Then just run the following script:

```bash
./deploy-application.sh --charts basket,identity,signalr,webspa
```

After a few minutes, when you see all services running in the *WebStatus* dashboard, run the app as you did before deleting the `basketdata` service to confirm it's working.
