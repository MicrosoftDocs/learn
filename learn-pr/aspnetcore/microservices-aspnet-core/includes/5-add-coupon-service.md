In this unit, you complete the *Coupon.API* project. You will then run a script to generate changes to the *WebSPA* HTML, as well as generate and modify Helm charts to define the kubernetes deployment.

## Design the coupon service

### Business requirement

There are many ways to implement a coupon code feature in an e-commerce app. For simplicity, the following business requirements have been provided:

* To obtain a discount, the user can apply a coupon code from the checkout page. All coupon codes are prefixed with *DISC-* and are suffixed with an unsigned integer. The integer indicates the US dollar amount to be deducted from the order total. For example, *DISC-30* deducts 30 US dollars.
* The coupon service must validate that the coupon code is available before allowing it to be used.
* Once the payment is processed, the ordering service should request validation for the coupon during the order process.
* Upon validation, the coupon should be assigned to the order and won't be available for any other order.
* If an order is canceled, the assigned coupon should be released for any other order to use.

### Domain model

**D**omain-**D**riven **D**esign (DDD) is a design pattern whereby the structure and language of your code (including class names, methods, and variables) should match the business domain. The pattern describes independent problem areas as bounded contexts and emphasizes a common language to describe these problems. Knowing where to draw the boundaries is the most important task when designing and defining a microservices-based solution. For each bounded context, you must identify and define the entities, value objects, and aggregates that model your domain. The coupon feature requirement is straightforward, so the coupon service is implemented like a CRUD service, and the boundaries are well-defined within the coupon domain.

The coupon service represents a coupon as a `Coupon` object, using the class defined at *src/Services/Coupon/Coupon.API/Infrastructure/Models/Coupon.cs*. This class encapsulates the attributes of a coupon.

|Property  |Description |
|----------|------------|
|`Id`      |The unique identifier of the coupon.|
|`Discount`|The discount amount in US dollars.|
|`Code`    |The coupon code.|
|`Consumed`|A flag indicating whether the coupon code has been used.|
|`OrderId` |The unique identifier of the associated order to which the coupon code has been applied.|

These may seem like obvious design choices, but note that the `Coupon` model is key to all of the business logic in `Coupon.API`. The coupon service:

* Only concerns itself with the domain of coupons.
* Relies on the other services to interact with other domains, such as determining whether an order is valid.

### Technology stack

Microservice architectures are technology agnostic and give the development teams the flexibility to select the technology stack of choice. The following table outlines the relevant technologies used by the coupon service.

| Technology | Description |
|-------------------|-------------|
| ASP.NET Core web API | The RESTful services for querying discounts are implemented in ASP.NET Core. A web API uses *Controllers* to handle HTTP requests. |
| MongoDB | The NoSQL database that stores the coupons and their utilization data. In a real-world scenario, it's common for services to use a managed database like [Azure Cosmos DB](https://azure.microsoft.com/services/cosmos-db) instead of running them in a container. |
| Docker | The web API project and the MongoDB database, along with their dependencies, are packaged into respective container images using Docker. |

## Add the coupon service

An ASP.NET Core project for the coupon service has been provided in the *src/Services/Coupon/Coupon.API* directory. Locate that directory in the Cloud Shell editor, and apply the following changes to the service:

1. In *Controllers/CouponController.cs*, replace the comment `/* Add the GetCouponByCodeAsync method */` with the following code:

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

1. Make the following changes in *Startup.cs*:
    1. In the `ConfigureServices` method, invoke the `AddCustomHealthCheck` method after the `AddSwagger` method call:

        [!code-csharp[](../code/src/services/coupon/coupon.api/temp-startup.cs?name=snippet_configureServices&highlight=13)]

        The preceding change adds the custom health check service to the app.

        %TODO% - Explain custom HC service, display extension method. De-magicfy.

    1. In the `Configure` method, register two health checks endpoints with the ASP.NET Core routing system:

        [!code-csharp[](../code/src/services/coupon/coupon.api/temp-startup.cs?name=snippet_configure&highlight=30-38)]

        The preceding change adds the readiness `/hc` and liveness `/liveness` endpoints for the custom health check service.

1. Run the following script in the command shell to make additional configuration changes for the coupon service:

    ```bash
    ./deploy/k8s/implementation-script.sh
    ```

    > [!TIP]
    > This module uses scripts to keep focus on the learning objectives. You may inspect the scripts in the Cloud Shell editor to better understand how resources are provisioned.

    The preceding script:

    * Uncomments HTML markup in the *WebSPA* checkout and order details views to support accepting coupon codes and displaying discount amounts, respectively.
    * Creates a Helm chart for the coupon service in *deploy/k8s/helm-simple/*. 
    * Adds the coupon service endpoints to the aggregator Helm chart in *deploy/k8s/helm-simple/webshoppingagg/templates/configmap.yaml*
    * Adds the coupon health check to the *WebStatus* Helm chart in *deploy/k8s/helm-simple/webstatus/templates/configmap.yaml*.

    When you create an object in a Kubernetes (or AKS) cluster, you must provide the object specification in a YAML file. In the next unit, you'll use the template functionality in the open-source tool Helm to generate and send the YAML files to the AKS cluster.
    
    The Helm chart for the coupon service is comprised of the following files in *deploy/k8s/helm-simple/coupon/*:

    * *Chart.yaml*
    * *templates/configmap.yaml*
    * *templates/deployment.yaml*
    * *templates/ingress.yaml*
    * *templates/service.yaml*

    The *Chart.yaml* file contains a description of the chart. The *templates* directory contains template files. When Helm evaluates the chart with the `helm install` command, it sends all of the files in the *templates* directory to the template rendering engine. It then collects the rendered YAML created by those templates and sends it to AKS.

## Build the coupon service in ACR

Container images are hosted in container registries. For many scenarios, a public container registry like Docker Hub might be appropriate. However, you'll be using your private ACR account for hosting your new coupon service container image and the modified *WebSPA* container image.

Run the following script in the command shell to build the coupon service container and the *WebSPA* container:

```bash
./deploy/k8s/build-to-acr.sh
```

The preceding script builds the container images in ACR using the `az acr build` command with the provided *Dockerfile* files for the *Coupon.API* and *WebSPA* projects. The build takes place in the cloud, and build output is displayed in the terminal. 

ACR isn't required to use AKS. AKS supports using other container registries such as Docker Hub.

> [!TIP]
> When using Visual Studio, a *Dockerfile* file such as the one used in the coupon service can be generated by right-clicking on the project in **Solution Explorer**, selecting **Add**, and selecting **Docker Support**.
