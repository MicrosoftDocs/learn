In this exercise, you'll deploy the newly created Web Sales aggregator BFF to the existing Kubernetes cluster. You will:

- Enable the Web Sales aggregator BFF.
- Configure the BFF.
- Publish the affected containers to Azure Container Registry.
- Deploy the affected apps to the cluster.
- Verify the deployed sales aggregator.

## Web.Sales.HttpAggregator

You can find an ASP.NET Core project for the `Web.Sales` BFF in the *src/ApiGateways/Aggregators/Web.Sales.HttpAggregator* directory. Locate that directory in the Azure Cloud Shell editor. Apply the following changes to the service:

1. In *Controllers/SalesController*, replace `// Add the GetSalesOfTodayByBrand code` with the following code:

    ```csharp
    
    [HttpGet]
    [ProducesResponseType(typeof(SalesDto), (int)HttpStatusCode.OK)]
    public async Task<ActionResult<List<SalesDto>>> GetSalesOfTodayByBrand()
    {
        _logger.LogInformation("----- SalesController --> GetTotalSalesAsync()");

        try
        {
            // All catalog items
            var catalogItems = await _catalog.GetCatalogItemAsync();

            // All catalog brands
            var catalogBrands = await _catalog.GetCatalogBrandAsync();

            // All orders
            var orderItems = await _ordering.GetOrdersAsync();

            // Fetch processed sales data
            var salesData = await this.GetSalesData(catalogItems, catalogBrands, orderItems);

            return salesData;
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
    }

    ```

    The preceding asynchronous action method:

    - Fetches and stores all the catalog items in a `catalogItems` variable.
    - Fetches and stores the catalog brand and order information in `catalogBrands` and `orderItems`, respectively.
    - Calls the `GetSalesData()` method with those variables to process and generate aggregated sales data.
    - Returns the sales data as `SalesDto` object along with the HTTP 200 status code.

    > [!NOTE]
    > You can review the implementation of `CatalogService` and `OrderingService` under the *Service* directory.


1. In *Controllers/SalesController.cs*, replace `// Add the GetSalesData code` with the following code: 

    ```csharp
    
    private async Task<List<SalesDto>> GetSalesData(List<CatalogItem> catalogItems, List<CatalogBrand> catalogBrands, List<Order> listOfOrders)
    {
        _logger.LogInformation("----- Processing sales data <-- GetSalesData() ");
    
        var salesDataItem = new List<SalesData>();
    
        // Filter all the orders based on the present day and which are processed
        var allOrdersOfPresentDay = listOfOrders.Where(o => o.date.Day == DateTime.Today.Day && o.status == "Paid");
    
        _logger.LogInformation($"----- allOrdersOfPresentDay : {JsonConvert.SerializeObject(allOrdersOfPresentDay)}");
    
        foreach (var eachOrder in allOrdersOfPresentDay)
        {
            // Fetch each order details based on order number
            var specificOrderItem = await _ordering.GetOrderDetailsAsync(eachOrder.ordernumber);
    
            if (specificOrderItem != null &&
                specificOrderItem.OrderItems != null && specificOrderItem.OrderItems.Count() > 0)
            {
                // Calculate each product unit of sale
                foreach (var eachProduct in specificOrderItem.OrderItems)
                {
                    // Filter catalog item
                    var catalogItemObj = catalogItems.Find(catalogItem => catalogItem.name == eachProduct.ProductName);
    
                    // Populate sales data
                    salesDataItem.Add(new SalesData()   
                    {
                        CatalogBrandId = catalogItemObj.catalogBrandId,
                        CatalogBrandName = catalogBrands.Find(catalogBrand => catalogBrand.Id == catalogItemObj.catalogBrandId).Brand, // Fetch the brand name based on its ID
                        TotalUnitOfSoldItems = eachProduct.Units
                    });
                }
            }
    
        }
        
        // Aggregate the unit of sales based on the brand name
        var groupedSalesData = salesDataItem.GroupBy(catalogBrand => catalogBrand.CatalogBrandName)
                                            .Select(
                                                catalogBrand => new SalesDto() {      
                                                    BrandName = catalogBrand.Key,                                                                                                
                                                    TotalSales = catalogBrand.Sum(unit => unit.TotalUnitOfSoldItems),
                                                }).ToList();
    
        _logger.LogInformation($"----- groupedSalesData : {JsonConvert.SerializeObject(groupedSalesData)}");
    
        return groupedSalesData;
    }
    
    ```

    The preceding action method:

    - Filters the orders in `listOfOrders` to only the orders with today's date and status `Paid`.
    - Fetches order details and calculates the sales of each product.
    - Retrieves catalog item and brand information.
    - Aggregates the data based on brand.

    > [!NOTE]
    > The preceding example is not optimal when you're working with a large list of orders and catalog items. Online transaction processing (OLTP) datastores, as used here, would not typically be used for data aggregation. We recommend that you copy data to an appropriate datastore, such as online analytical processing (OLAP), for analytical purposes.

1. Now that you've built the controller, take note of the following code that has been added for you:
    1. In *Startup.cs*, note how real-time HTTP health checking is configured in `ConfigureServices`.

        ```csharp
        public void ConfigureServices(IServiceCollection services)
        {
            var healthCheckBuilder = services.AddHealthChecks()
                .AddCheck("self", () => HealthCheckResult.Healthy())
                .AddUrlGroup(new Uri(Configuration["CatalogUrlHC"]), name: "catalogapi-check", tags: new string[] { "catalogapi" })
                .AddUrlGroup(new Uri(Configuration["OrderingUrlHC"]), name: "orderingapi-check", tags: new string[] { "orderingapi" })
                .AddUrlGroup(new Uri(Configuration["IdentityUrlHC"]), name: "identityapi-check", tags: new string[] { "identityapi" });            

                // Content removed for brevity
        }
        ```

        In the preceding code:

        - Health check services are registered in the dependency injection container.
        - Because the functionality of the Web Sales aggregator also depends on the Ordering and Catalog APIs, it's a good idea to add them too.

    1. Also in *Startup.cs*, note the JSON Web Token (JWT) authentication code in the `AddCustomAuthentication` method:

        ```csharp
        services.AddAuthentication(options =>
        {
            options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
            options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;

        })
        .AddJwtBearer(options =>
        {
            options.Authority = identityUrl;
            options.RequireHttpsMetadata = false;
            options.Audience = "websalesagg";                
        });    
        ```

    1. Finally, in the `Configure` method, note the Swagger configuration. Swagger provides the UI that you'll use for testing.

        ```csharp
        app.UseSwagger().UseSwaggerUI(c =>
        {
            c.SwaggerEndpoint($"{ (!string.IsNullOrEmpty(pathBase) ? pathBase : string.Empty) }/swagger/v1/swagger.json", "Sales BFF V1");

            c.OAuthClientId("websalesaggswaggerui");
            c.OAuthClientSecret(string.Empty);
            c.OAuthRealm(string.Empty);
            c.OAuthAppName("web sales bff Swagger UI");
        });
        ```

### Identity.API

Some changes have been made to the *src/Services/Identity/Identity.API* project to support the Web Sales aggregator. Review them:

1. The Web Sales aggregator project has been configured as the `websalesaggswaggerui` client in the *Config.cs* file of the *Identity.API* project.

    ```csharp
    // code snipped for brevity

    new Client
    {
        ClientId = "websalesaggswaggerui",
        ClientName = "Web Sales Aggregator Swagger UI",
        AllowedGrantTypes = GrantTypes.Implicit,
        AllowAccessTokensViaBrowser = true,

        RedirectUris = { $"{clientsUrl["WebSalesAgg"]}/swagger/oauth2-redirect.html" },
        PostLogoutRedirectUris = { $"{clientsUrl["WebSalesAgg"]}/swagger/" },

        ....
    },
    
    // code snipped for brevity 
    ```

1. You also need a user with admin privileges to access the API that the controller exposes. The following user has been added: 

    ```text
    EmailId : `adminuser@microsoft.com` 
    Password : `Pass@word1`
    ```

## Configuration changes

Make the following configuration changes to support the Web Sales aggregator code.

### WebStatus configuration

Earlier, you added health checks in the Web Sales aggregator's *Startup.cs* file. You also need to configure the *Web Status* app to ping that health check. Uncomment the following YAML in *deploy/k8s/helm-simple/webstatus/templates/configmap.yaml*:

```yaml
HealthChecksUI__HealthChecks__10__Name: Web Sales Aggregator GW HTTP Check
HealthChecksUI__HealthChecks__10__Uri: http://websalesagg/hc
```

### Identity.API configuration

Configure *Identity.API*  with the Web Sales aggregator URL. Uncomment the following YAML in *deploy/k8s/helm-simple/identity/templates/configmap.yaml*:

```yaml
WebSalesAggClient: {{ .Values.protocol }}://{{ .Values.host }}/websalesagg
```
## Build the local images and push the changes to Azure Container Registry

The setup script created an Azure Container Registry instance for you. Push your changes to the Container Registry instance by using the following steps:

1. Push and build the `identity-api` image:

    ```bash
    ./deploy/k8s/build-to-acr.sh --services identity-api
    ```

    The script starts a [Container Registry quick task](/azure/container-registry/container-registry-tasks-overview#quick-task) for the *:::no-loc text="Identity":::* app. A variation of the following line confirms that the Docker image was pushed to Container Registry:

    ```console
    2020/10/26 21:57:23 Successfully pushed image: eshoplearn202109999999999.azurecr.io/identity.api:linux-latest
    ```

    > [!IMPORTANT]
    > The *:::no-loc text="WebSPA":::* project is built in Container Registry, rather than being local to Cloud Shell, to take advantage of robust build hosts in Container Registry. If the Container Registry quick task fails, inspect the output for troubleshooting information. Run the preceding script again to try more builds.

1. Push and build the *:::no-loc text="websalesagg":::* image:

    ```bash
    ./deploy/k8s/build-to-acr.sh --services websalesagg
    ```

    As with the previous step, a Container Registry quick task builds the *:::no-loc text="websalesagg":::* image.

## Deploy the affected containers to the cluster

Now that your modified images are published, you can deploy the affected containers.

1. Fetch the external IP address of the existing NGINX ingress load balancer:

    ```bash
    kubectl get svc -n ingress-nginx 
    ```

    The following image shows an example.

    :::image type="content" source="../media/nginx-ingress-external-ip.png" alt-text="Screenshot that shows the NGINX ingress external load balancer." lightbox="../media/nginx-ingress-external-ip.png":::

    > [!NOTE]
    > In the next unit, you'll learn more about the ingress controllers in Kubernetes.

1. Replace `{nginx-ingress-ip-address}` with the external IP address of the NGINX ingress controller. Then run the following command to deploy the affected services to the cluster:

    ```bash
    ./deploy/k8s/deploy-affected-services.sh --ipAddress {nginx-ingress-ip-address}
    ```

    The preceding script redeploys the following services:

    - *WebStatus*
    - *Identity.API*
    - *WebSalesAgg*

## Verify the deployed aggregator

After you deploy the changes and wait a while, the *:::no-loc text="WebStatus":::* dashboard shows that all the services are healthy. There's a new *:::no-loc text="websalesagg":::* service, as denoted by the health check titled **Web Shopping Aggregator GW HTTP Check**. Although the *:::no-loc text="websalesagg":::* service is healthy, it can't yet be accessed from outside the cluster.

To verify the *:::no-loc text="websalesagg":::* service from within the cluster, complete the following steps:

1. Retrieve the pod name of the *:::no-loc text="WebSPA":::* app:

    ```bash
    kubectl get pods --selector service=webspa
    ```

    The pod name is highlighted in the following example.

    :::image type="content" source="../media/web-spa-pod-name.png" alt-text="Screenshot that shows the pod name of WebSPA." lightbox="../media/web-spa-pod-name.png":::

1. Retrieve the cluster IP address of the *:::no-loc text="websalesagg":::* pod:

    ```bash
    kubectl get svc --selector service=websalesagg
    ```

    The cluster IP address is highlighted in the following example.

    :::image type="content" source="../media/websalesagg-cluster-ip.png" alt-text="Screenshot that shows the cluster I P address of WebSalesAgg." lightbox="../media/websalesagg-cluster-ip.png":::

1. Open a shell inside the pod. Replace `{webspa-pod-name}` with the pod name that you retrieved earlier.

    ```bash
    kubectl exec -it {webspa-pod-name} /bin/bash
    ```

    The following screenshot shows an example.

    :::image type="content" source="../media/webspa-container-pod-bash.png" alt-text="Screenshot that shows WebSPA inside a container pod." lightbox="../media/webspa-container-pod-bash.png":::

1. Within the pod, use cURL to verify that the service is listening. Use the IP address that you retrieved earlier.

    ```bash
    curl http://<clusterip-of-websalesagg-pod>/websalesagg/swagger/index.html
    ```

    We don't care about the contents of the response. We only care that the service is listening on port 80.

    :::image type="content" source="../media/curl-of-internal-pod-request.png" alt-text="Screenshot that shows cURL for the internal websalesagg pod request." lightbox="../media/curl-of-internal-pod-request.png":::

1. Use the following command to close the shell:

    ```bash
    exit
    ```

In the next unit, you'll learn about configuring ingress into the Kubernetes cluster.
