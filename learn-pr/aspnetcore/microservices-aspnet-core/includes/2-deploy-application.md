# Unit 2: Exercise - Deploy application

In this unit, you'll use a script to deploy the existing eShopOnContainers app to AKS.

# Run deployment script

Run the following command in the command shell. Be patient, as setup can take a few minutes to complete.

```bash
. <(wget -q -O - https://aka.ms/microservices-aspnet-core-setup)
```

[!INCLUDE[OS-specific keyboard shortcuts](../../../includes/azure-cloudshell-copy-paste-tip.md)]

The preceding command retrieves and runs a setup script from a GitHub repository. The script completes the following steps:

* Clones the eShop project from a GitHub repository.
* Provisions an AKS and Azure Container Registry (ACR) resource.
* Launches the Cloud Shell Editor to view the code.
* Deploys the containers to AKS.
* Displays connection information upon completion

> [!NOTE]
> Non-blocking warnings are expected in the deployment process.

The app the script deploys is a smaller, modified version of the larger [eShop on Containers reference app](https://github.com/dotnet-architecture/eshoponcontainers). While the script is running, proceed to the next unit to review the eShopOnContainers architecture.

# Unit 3: eShopOnContainers architecture

In this module, you'll gain an understanding of the eShopOnContainers app and the microservices architecture used.

## eShopOnContainers architecture

**TODO**: The below image has to be modified. Better representation of API Gateway needed.

![eShop application architecture](../media/temp/eshop-architecture.png)

The eShopOnContainers app is an online store that sells various physical products like pins, t-shirts, and coffee mugs. The store includes the following functionality:

* Catalog management
* Shopping basket
* User management
* Order management
* Payments

These functions are broken up into several distinct microservices. Each microservice is autonomous, independently deployable, and responsible for its own data. This enables each microservice to implement the data store that is best optimized for its workload, storage needs, and read/write patterns. Possible choices include relational, document, key-value, and even graph-based data stores. As shown in the above figure, the *catalog* microservice stores its data in a **SQL Server on Linux**, the *basket* microservice uses a **Redis cache** for storage, and so on. Note that there's no single master data store with which all services interact. Instead, inter-service communication is are done on an as-needed basis, either via synchronous API calls or asynchronously through messaging. This data isolation gives every microservice the autonomy to independently perform data schema updates without breaking any other service in production.

The event bus is used for asynchronous messaging and event-driven communication. The above implementation uses RabbitMQ in a container deployed in AKS, but a service such as Azure Service Bus would also be appropriate.

These microservices are accessible to clients via the API gateway. API gateways offer several advantages, such as decoupling back-end services from individual front-end clients and providing enhanced security. The eShopOnContainers storefront WebSPA is an ASP.NET Core app that is accessible via a public IP address. The requests from the WebSPA app to the microservices are routed through the API gateway, which is an implemention of the **B**ackends-**F**or-**F**rontends pattern. Basic routing configurations are implemented using the NGINX reverse proxy and the Gateway Aggregation pattern is implemented using the ASP.NET Core Web API called `Web.Shopping.HttpAggregator`. For real-world scenarios, use of managed API gateway services like [Azure API Management](https://azure.microsoft.com/services/api-management/) is recommended.

Typically, microservices are small enough for a feature team to independently build, test, and deploy them in production multiple times a day without affecting other systems. Next, you'll create a new microservice called `Coupon.API` and deploy it to the existing eShopOnContainers application in production. While doing so, you'll also learn about designing microservices using Domain Driven Design, containerizing them using Docker, publishing them to a container registry, and deploying them to an existing kubernetes cluster.

# Unit 4: Exercise - Review code and test deployment

Soon after launching the setup script, the [Azure Cloud Shell editor](/azure/cloud-shell/using-cloud-shell-editor) opens the starter solution to the *~/clouddrive/source/eShop-Learn/* directory. If the script is still running, you may investigate the solution while the script continues to deploy the Docker containers to AKS. 

## Review code

The following directories in *src/* contain .NET Core projects, each of which is containerized and deployed to AKS:

| Project directory | Description |
|-------------------|-------------|
| *Aggregators/* | Services to aggregate across multiple microservices for certain cross-service operations. This is implemented by the *ApiGateways/Aggregators/Web.Shopping.HttpAggregator* project. |
| *BuildingBlocks/* | Services that provide cross-cutting functionality, such as the app's event bus used for inter-service events. |
| *Services/* | These projects implement the business logic of the app. Each microservice is autonomous with its own data store. They showcase different software patterns, including **C**reate-**R**ead-**U**pdate-**D**elete (CRUD), **D**omain-**D**riven **D**esign (DDD), and **C**ommand and **Q**uery **R**esponsibility **S**egregation (CQRS). The new **Coupon.API** project has been provided, but it is incomplete. |
| *Web/* | ASP.NET Core apps that implement user interfaces:<br>*WebSPA* is a storefront UI built with Angular.<br>*WebStatus* is the health checks dashboard for monitoring the operational status of each service. |

## Test deployment

Once the app has deployed to AKS, you'll see a variation of the following message in the Azure Cloud Shell:

```
The eShop-Learn application has been deployed.

You can begin exploring these services (when available):
- Centralized logging       : http://13.83.97.100/seq/#/events?autorefresh (See transient failures during startup)
- General application status: http://13.83.97.100/webstatus/ (See overall service status)
- Web SPA application       : http://13.83.97.100/
```

1. Select the **General application status** link. The resulting health check page displays the status of each microservice in the deployment.

    ![Health check page](../media/temp/health-check.png)

    > [!NOTE]
    > While the app is warming up, you may receive an HTTP 50x response from the server. You may retry after a few seconds. The Seq logs viewable at the **Centralized logging** URL will be available before the other endpoints. 

1. Once all the services are healthy, select the **Web SPA application** link to test the eShopOnContainers web app.

    ![eShop SPA](../media/temp/eshop-spa.png)

1. Log in to the app (the credentials are provided on the login page) and then browse the shop. Add some items to the cart, and then complete the purchase.

# Unit 5: Exercise - Add the coupon service

In this unit, you complete the **Coupon.API** project. You then run a script to generate changes to the WebSPA HTML, as well as generate and modify Helm charts to define the kubernetes deployment.

## Add the coupon service

An ASP.NET Core project for the coupon service has been provided in *src/Services/Coupon*.

1. Open *src/Services/Coupon/Coupon.API/Controllers/CouponController.cs*.
1. Replace the comment `/* Add the GetCouponByCodeAsync method */` with the following code:

    ```csharp
    [HttpGet("{code}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<ActionResult<CouponDto>> GetCouponByCodeAsync(string code)
    {
        var coupon = await _couponRepository.FindCouponByCodeAsync(code);

        if (coupon is null || coupon.Consumed)
        {
            return NotFound();
        }

        var couponDto = _mapper.Translate(coupon);

        return couponDto;
    }
    ```

    In the preceding asynchronous action method:

    * The `CouponRepository` class' `FindCouponByCodeAsync` method retrieves the coupon corresponding to the provided `code` parameter value. The coupon is retrieved from a MongoDB database.
    * If the coupon returned is `null` or has already been used, an HTTP 404 status code is returned.
    * If the coupon returned isn't `null` and hasn't already been used, the `Coupon` object is converted to a `CouponDto` **D**ata **T**ransfer **O**bject (DTO). Finally, an HTTP 200 status code is returned along with the DTO.

1. Make the following changes to the `ConfigureServices` method in *src/Services/Coupon/Coupon.API/Startup.cs*

    [!code-csharp[](../code/src/services/coupon/coupon.api/temp-startup.cs?name=snippet_configureServices&highlight=13)]

    The preceding change adds the custom health check service to the app.

1. Also in *Startup.cs*, make following changes to the `Configure` method:

    [!code-csharp[](../code/src/services/coupon/coupon.api/temp-startup.cs?name=snippet_configure&highlight=30-38)]

    The preceding change adds the readiness `/hc` and liveness `/liveness` endpoints for the custom health check service.

1. Run the following script in the command shell to make additional configuration changes for the coupon service:

    ```bash
    ./deploy/k8s/implementation-script.sh
    ```

    The preceding script:

    * Uncomments HTML markup in the WebSPA checkout and order details views to support accepting coupon codes and displaying discount amounts, respectively.
    * Creates a Helm chart for the coupon service in *deploy/k8s/helm-simple/*. 
    * Adds the coupon service endpoints to the aggregator Helm chart in *deploy/k8s/helm-simple/webshoppingagg/templates/configmap.yaml*
    * Adds the coupon health check to the WebStatus Helm chart in *deploy/k8s/helm-simple/webstatus/templates/configmap.yaml*.

    The Helm chart for the coupon service is comprised of five files in *deploy/k8s/helm-simple/coupon/*:

    | File | Description |
    |------|-------------|
    | *Chart.yaml* | %TODO% - Nish |
    | *templates/deployment.yaml* | %TODO% - Nish |
    | *templates/service.yaml* | %TODO% - Nish |
    | *templates/configmap.yaml* | %TODO% - Nish |
    | *templates/ingress.yaml* | %TODO% - Nish |

## Build the coupon service in Azure Container Registy

Run the following script in the command shell to build the coupon service container and the WebSPA container:

```bash
./deploy/k8s/build-to-acr.sh
```

The preceding script compiles and builds the containers in Azure Container Registry using the `az acr build` command with the provided `Dockerfile` files. ACR is not required to use AKS. Other public container repositories, such as Docker Hub, are supported. **%TODO%** - Nish, is there more to say here? 

> [!TIP]
> When using Visual Studio, a `Dockerfile` file such as the one used in the coupon service can be generated by right-clicking on the project in Solution Explorer, selecting **Add**, and selecting **Docker Support**.

# Unit 6: Exercise - Update the AKS deployment

In this unit, you'll run a script to deploy the **Coupon.API** microservice and other configuration changes to the existing app. You'll then verify the changes were successful. 

## Deploy changes

Run the following script in the command shell to update the existing AKS cluster with the new configuration:

```bash
./deploy/k8s/update-aks.sh
```

The preceding script:

* Uninstalls and reinstalls the WebStatus, WebSPA, and aggregator Helm charts.
* Installs...  **%TODO%** -- Nish, we don't quite understand what's going on in update-aks.sh. Miguel has two comments, `# Install reconfigured charts` and `# Install charts for new and updated applications`, but the loop for the two tasks looks to do exactly the same thing. Why are there two loops with two sets of charts?   

## Verify changes

1. Navigate to the WebStatus page. Observe the services stopping and redeploying.

1. After the app deploys, navigate to the WebSPA URL and perform the following steps:
    1. Add items to the cart.
    1. Navigate to the cart and select **Check out**.
    1. Add the coupon code *DISC-15*.
    1. Select **Apply**. 

%TODO% (Cam or Scott) - Screenshot of cart with coupon box

# Unit 7: Knowledge Check

1. Need
2. Some
3. Questions (and possible answers! 😊)


# Unit 8: Summary

In this module you: 

* Deployed and examined an existing ASP.NET Core microservice running in Azure Kubernetes Service (AKS).
* Created an ASP.NET Core microservice.
* Deployed the microservice to the existing application in AKS.

## Clean up Azure resources

> [!IMPORTANT]
> It is very important you deallocate the Azure resources used in this module so that you do not accrue unwanted charges.

To de-provision all of the resources created in this module, run the following command:

```azurecli
az group delete --name eshop-learn-rg --yes
```

The preceding command deletes the resource group containing the AKS and ACR resources. Additionally, another resource group containing infrastructure resources (such as IP addresses) was previously created on behalf of the AKS resource. This group and all resources contained within are also deleted.

%TODO% -- Cam (Me): Also explain how to remove the service principal. Can that be done easily from a script?