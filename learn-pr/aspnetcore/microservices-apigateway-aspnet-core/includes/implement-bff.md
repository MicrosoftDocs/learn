In this exercise you'll deploy the newly created Web Sales BFF to the existing Kubernetes cluster.

In this exercise you will:

- Enable the Web Sales Aggregator BFF.
- Review the necessary configuration.
- Create an instance of Azure Container Registry(ACR).
- Build the local images and push the changes in the container registry.
- Deploy the affected apps to the cluster.
- Verify the deployed sales aggregator.

## Enable the Web Sales Aggregator BFF

### Web.Sales.HttpAggregator - project related changes

- As mentioned in the previous unit, you'll just uncomment the code snippet of the *GetSalesOfTodayByBrand()* method in the *SalesController* class to activate this feature.

    ```csharp
    
    // [HttpGet]
    // [ProducesResponseType(typeof(SalesDto), (int)HttpStatusCode.OK)]
    // public async Task<ActionResult<List<SalesDto>>> GetSalesOfTodayByBrand()
    // {
    //     _logger.LogInformation("----- SalesController --> GetTotalSalesAsync()");

    //     try
    //     {
    //         // All catalog items
    //         var catalogItems = await _catalog.GetCatalogItemAsync();

    //         // All catalog brands
    //         var catalogBrands = await _catalog.GetCatalogBrandAsync();

    //         // All orders
    //         var orderItems = await _ordering.GetOrdersAsync();

    //         // Fetch processed sales data
    //         var salesData = await this.GetSalesData(catalogItems, catalogBrands, orderItems);

    //         return salesData;
    //     }
    //     catch (System.Exception ex)
    //     {
    //         throw ex;
    //     }
    // }

    ```

- And the *GetSalesData()* method is used to aggregate the Sales data.
- In the *Startup.cs* file you'll also see that the JWT authentication is already added using the following code.

    ```csharp

        ....
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
        ....        

    ```

- And add the Swagger UI is already enabled with the following code snippet.

    ```csharp
        ....
        app.UseSwagger().UseSwaggerUI(c =>
        {
            c.SwaggerEndpoint($"{ (!string.IsNullOrEmpty(pathBase) ? pathBase : string.Empty) }/swagger/v1/swagger.json", "Sales BFF V1");

            c.OAuthClientId("websalesaggswaggerui");
            c.OAuthClientSecret(string.Empty);
            c.OAuthRealm(string.Empty);
            c.OAuthAppName("web sales bff Swagger UI");
        });
        ...
    ```

- In the next section you'll also enable `websalesaggswaggerui` client in the `Identity.API` project.

### Identity.API - project related changes

- As mentioned above, the web sales aggregator project has been configured as `websalesaggswaggerui` client in the *Config.cs* file of the `Identity.API` project.

    ```csharp
        .....
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
        ....
    ```

- You'll also need a user with `Admin` role to access the `Sales API` exposed by WebSales Aggregators controller. So for that, the following user has been added. Because you'll not be able to access it using default `demouser@microsoft.com` user. You can take a note of that for later use.

    ```text

        EmailId : `adminuser@microsoft.com` 
        Password : `Pass@word1`

    ```

## Review the necessary configuration

### WebStatus project related configuration

- As you are adding a new project, it's better to add that in the Web Status project for monitoring like other projects. So uncomment the following health check uri configuration in the `configmap.yaml` of `webstatus` app.

    ```text
      HealthChecksUI__HealthChecks__10__Name: Web Sales Aggregator GW HTTP Check
      HealthChecksUI__HealthChecks__10__Uri: http://websalesagg/hc
    ```

The above configuration will include the health check for the `websalesagg` in the `WebStatus` app.

### Identity.API project related configuration

- Uncomment the following `WebSalesAggClient` configuration in the `configmap.yaml` file of the `identity` app.

    ```text
    WebSalesAggClient: {{ .Values.protocol }}://{{ .Values.host }}/websalesagg
    ```

The above configuration will include the url for the `websalesagg` client in the `Identity.API`.

## Create an instance of Azure Container Registry(ACR)

- You'll need a container registry to host the docker images. So, run the below command to create one.

    ```bash
    ./create-acr.sh  --resource-group eshop-learn-rg --location westus
    ```

    The script will create an instance of ACR. You should get something like this:

    ![Create ACR instance](../media/create-acr.png)

## Build the local images and push the changes in the container registry

- You need to build the image of the `identity-api` app with the latest changes.

    ```bash
    ./build-to-acr.sh --services identity-api
    ```

- You need to build the image of the `websalesagg` app with the latest changes.

    ```bash
    ./build-to-acr.sh --services websalesagg
    ```

- The above steps will be pushed the latest changes in the container registry

## Deploy the affected apps to the cluster

- Before deploying you'll also need to fetch the external ip address of existing nginx ingress load balancer. You can do that by using below command :

    ```bash
    kubectl get svc -n ingress-nginx 
    ```

    For more details, you can refer below image as well.

    ![Nginx ingress external load balancer](../media/nginx-ingress-external-ip.png)

    > [!NOTE]
    > In the next unit you'll learn more about the Kubernetes ingress controller and it's purpose.

- Replace `{nginx-ingress-ip-address}` with the external ip address of the nginx ingress controller and then run the below command to deploy the affected services to the cluster.

    ```bash
    ./deploy-affected-services.sh --ipAddress {nginx-ingress-ip-address}
    ```

The above script will deploy the following services :

- `WebStatus`
- `Identity.API`
- `WebSalesAgg`

## Verify the deployed sales aggregator

- Wait till the `websalesagg` pod is up and running. Then you'll be able to access the `websalesagg` API. But at this point, `websalesagg` is only available for the internal resources to consume and you'll not able to access the `websalesagg` outside the Kubernetes cluster yet. For that, you'll have to configure the ingress object for that and you'll explore those concepts in the next unit.

- As of now, to access the `websalesagg` API you can use the cluster IP. You can follow the below steps :
- Run the below command to fetch the pod name of the `WebSPA` app.

    ```bash
    kubectl get pods | grep `webspa`
    ```

    // TO DO - better to include one more image in here.

- Then run the below command to get into the pod. Make sure you replace `{webspa-pod-name}` with the pod name which you have noted in the previous step.

    ```bash
    kubectl exec -it {webspa-pod-name} /bin/bash
    ```

- And also take a note of the cluster ip of the `websalesagg` pod by using the below command.

    ```bash
    kubectl get pods | grep `websalesagg`
    ```

    // TO DO - Include cluster ip related image.

- Within the pod, you run the below CURL command to see if it's accessible.

    ```bash
    curl http://<clusterip-of-websalesagg-pod>//websalesagg/swagger/index.html
    ```

    ![Curl of internal websaleagg pod request](../media/curl-of-internal-pod-request.png)

In the next unit, you'll configure ingress object to access the API outside of Kubernetes cluster.