In this exercise, you'll deploy the newly created Web Sales BFF to the existing Kubernetes cluster. To do this, you will:

- Enable the Web Sales Aggregator BFF.
- Configure the BFF.
- Publish the affected containers to Azure Container Registry.
- Deploy the affected apps to the cluster.
- Verify the deployed sales aggregator.

## Web.Sales.HttpAggregator

You can find an ASP.NET Core project for the `Web.Sales` BFF in the *src/ApiGateways/Aggregators/Web.Sales.HttpAggregator* directory. Locate that directory in the Cloud Shell editor. Apply the following changes to the service:

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
    - Returns the Sales data as `SalesDto` object along with the HTTP 200 status code.

    > [!NOTE]
    > You can review the implementation of `CatalogService` and `OrderingService` under the *Service* directory.


1. In *Controllers/SalesController.cs*, replace `// Add the GetSalesData code` ith the following code: 

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
                        CatalogBrandName = catalogBrands.Find(catalogBrand => catalogBrand.Id == catalogItemObj.catalogBrandId).Brand, // Fetch the brand name based on it's id
                        TotalUnitOfSoldItems = eachProduct.Units
                    });
                }
            }
    
        }
        
        // Aggregate the unit of sales based on the Brand name
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

    - Filters the orders in `listOfOrders` to those from today's date with status `Paid`.
    - Fetches order details and calculates the sales of each product.
    - Retrieves catalog item and brand information
    - Aggregates the data based by brand.

    > [!NOTE]
    > The above example is not optimal when working with a large list of orders and catalog items. OLTP datastores, as used here, would not typically be used for data aggregation. It is recommended to copy data to an appropriate datastore, such as OLAP, for analytical purposes.

1. Now that you've built the controller, take note of the following code that has been added for you.
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

        - ASP.NET Core's health check service is registered in the web sales aggregator dependency injection container.
        - As the functionality of web sales aggregator also depends Ordering and Catalog API, it's important to add those necessary configuration in the `AddUrlGroup()` method.

    1. Also in *Startup.cs*, note the JWT authentication code in the `AddCustomAuthentication` method:

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

    1. Finally, in the `Configure` method, note the Swagger configuration. This will provide the UI we use for testing.

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

Some changes have been made to the *Identity.API* project to support the Web Sales Aggregator. Review them below:

1. The web sales aggregator project has been configured as `websalesaggswaggerui` client in the *Config.cs* file of the *Identity.API* project.

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

1. You'll also need a user with *Admin* privileges to access the API exposed by the controller. As such, the following user has been added. 

    ```text
    EmailId : `adminuser@microsoft.com` 
    Password : `Pass@word1`
    ```

## Review the necessary configuration

Make the following configuration changes to support the web sales aggregator code.
### WebStatus configuration

Earlier, you added health checks in the web sales aggregator's *Startup.cs*. You'll also need to configure the Web Status app to ping that health check. Uncomment the following in *deploy/k8s/helm-simple/webstatus/templates/configmap.yaml*:

```yaml
HealthChecksUI__HealthChecks__10__Name: Web Sales Aggregator GW HTTP Check
HealthChecksUI__HealthChecks__10__Uri: http://websalesagg/hc
```

### Identity.API configuration

*Identity.API* needs to be made aware of the web sales aggregator URL. Uncomment the following in *deploy/k8s/helm-simple/identity/templates/configmap.yaml*:

```yaml
WebSalesAggClient: {{ .Values.protocol }}://{{ .Values.host }}/websalesagg
```
## Build the local images and push the changes in the container registry

The setup script created an Azure Container Registry (ACR) instance for you. Push your changes to the ACR instance with the following steps:

1. Push and build the `identity-api` image.

    ```bash
    ./deploy/k8s/build-to-acr.sh --services identity-api
    ```

1. Push and build the `websalesagg` image.

    ```bash
    ./deploy/k8s/build-to-acr.sh --services websalesagg
    ```

## Deploy the affected containers to the cluster

Now that your modified images are published, you can deploy the affected containers.

1. Fetch the external IP address of the existing nginx ingress load balancer:

    ```bash
    kubectl get svc -n ingress-nginx 
    ```

    Refer to the following image.

    :::image type="content" source="../media/nginx-ingress-external-ip.png" alt-text="Nginx ingress external load balancer" lightbox="../media/nginx-ingress-external-ip.png":::

    > [!NOTE]
    > In the next unit, you'll learn more about the Kubernetes ingress controller.

1. Replace `{nginx-ingress-ip-address}` with the external IP address of the nginx ingress controller and then run the below command to deploy the affected services to the cluster.

    ```bash
    ./deploy-affected-services.sh --ipAddress {nginx-ingress-ip-address}
    ```

    The above script will deploy the following services :

    - `WebStatus`
    - `Identity.API`
    - `WebSalesAgg`

## Verify the deployed sales aggregator

Wait till the `websalesagg` pod is up and running. Then you'll be able to access the `websalesagg` API. But at this point, `websalesagg` is only available for the internal resources to consume and you'll not be able to access the `websalesagg` outside the Kubernetes cluster yet. For that, you'll have to configure the ingress object for that and you'll explore those concepts in the next unit. As of now, to access the `websalesagg` API, you can use the cluster IP. You can follow the below steps :

1. Run the below command to fetch the pod name of the `WebSPA` app. Take a note of that.

    ```bash
    kubectl get svc --selector service=webspa
    ```

    :::image type="content" source="../media/web-spa-pod-name.png" alt-text="Pod name of WebSPA" lightbox="../media/web-spa-pod-name.png":::

1. And also take a note of the cluster ip of the `websalesagg` pod by using the below command. Make a note of that IP address.

    ```bash
    kubectl get svc --selector service=websalesagg
    ```

    :::image type="content" source="../media/websalesagg-cluster-ip.png" alt-text="Cluster IP of WebSalesAgg" lightbox="../media/websalesagg-cluster-ip.png":::

1. Then run the below command to get into the pod. Make sure you replace `{webspa-pod-name}` with the pod name which you have noted in the previous step.

    ```bash
    kubectl exec -it {webspa-pod-name} /bin/bash
    ```

    :::image type="content" source="../media/webspa-container-pod-bash.png" alt-text="WebSPA inside container pod" lightbox="../media/webspa-container-pod-bash.png":::

1. Within the pod, you run the below CURL command to see if it's accessible.

    ```bash
    curl http://<clusterip-of-websalesagg-pod>/websalesagg/swagger/index.html
    ```

    :::image type="content" source="../media/curl-of-internal-pod-request.png" alt-text="Curl of internal websaleagg pod request" lightbox="../media/curl-of-internal-pod-request.png":::

In the next unit, you'll configure the ingress object to access the API outside of the Kubernetes cluster.
