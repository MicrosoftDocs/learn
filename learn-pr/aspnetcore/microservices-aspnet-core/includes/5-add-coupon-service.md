In this unit, you complete the *Coupon.API* project. You will then run a script to generate changes to the *WebSPA* HTML, as well as generate and modify Helm charts to define the kubernetes deployment.

## Designing coupon microservice

### Business requirement

There are multiple ways of implementing a coupon feature in an e-commerce app; however, for the sake of simplicity, look at the following business requirement:

* The user shall apply a discount coupon code during the checkout (**DISC-##**, where ## is the discount amount to the order total. For $5, $10, $15, $20, $25, and $30).
* The coupon microservice must confirm that the coupon is available and return the discount amount during checkout.
* Once the payment is processed, the ordering microservice will request validation for the coupon during the order process.
* Upon validation, the coupon will be assigned to the order and won't be available for any other order.
* If an order is canceled, the assigned coupon should be released for any other order to use.

### Domain Model

Domain-driven design (DDD) advocates modeling based on the reality of business as relevant to a use case. In the context of building applications, DDD talks about problems as domains. It describes independent problem areas as bounded contexts and emphasizes a common language to talk about these problems. Where to draw the boundaries is the crucial task when designing and defining a microservice. For the domain model for each bounded context, you identify and define the entities, value objects, and aggregates that model your domain. Considering that the coupon feature requirement is straightforward, the coupon microservice is implemented more like a CRUD service, and the boundaries are well defined within the `coupon` domain.

### Technology stack

Microservice architectures are technology agnostic and give the development teams the flexibility to select the tech stack of choice. Coupon microservice uses the following:

| Technology | Description |
|-------------------|-------------|
| **ASP.NET Core Web API** |  The RESTful services for querying discounts are implemented in ASP .NET Core. A web API uses *Controllers* to handle requests. |
| **MongoDB** |  The NoSQL database that stores the coupons and their utilization data.  |
| **Containerization using Docker** | The Web API project and the MongoDB database, along with their dependencies, are packaged into respective container images using **Docker**. In a real-world scenario, it's preferred for microservices to use a managed database like **Azure Cosmos DB** instead of running them in a container |

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

    %TODO% - Explain custom HC service, display extension method. De-magic.

1. Also in *Startup.cs*, make the following changes to the `Configure` method:

    [!code-csharp[](../code/src/services/coupon/coupon.api/temp-startup.cs?name=snippet_configure&highlight=30-38)]

    The preceding change adds the readiness `/hc` and liveness `/liveness` endpoints for the custom health check service.

1. Run the following script in the command shell to make additional configuration changes for the coupon service:

    ```bash
    ./deploy/k8s/implementation-script.sh
    ```

    > [!TIP]
    > This module uses scripts to keep focus on the learning objectives. You may inspect the scripts in the Cloud Shell Editor to better understand how resources are provisioned.

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

    The *Chart.yaml* file contains a description of the chart. You can access it from within a template. The *templates* directory contains template files. When Helm evaluates a chart, it sends all of the files in the *templates* directory to the template rendering engine. It then collects the rendered YAML created by those templates and sends it to AKS.

## Build the coupon service in Azure Container Registry

Container images are hosted in container registries. For many scenarios, a public container registry like Docker Hub might be appropriate. However, you'll be using your private Azure Container Registry (ACR) account for hosting your new coupon service container image and the modified *WebSPA* container image.

Run the following script in the command shell to build the coupon service container and the *WebSPA* container:

```bash
./deploy/k8s/build-to-acr.sh
```

The preceding script compiles and builds the containers in Azure Container Registry using the `az acr build` command with the provided *Dockerfile* files. ACR isn't required to use AKS. AKS supports using other container registries such as Docker Hub. **%TODO%** - Nish, is there more to say here? 

> [!TIP]
> When using Visual Studio, a *Dockerfile* file such as the one used in the coupon service can be generated by right-clicking on the project in **Solution Explorer**, selecting **Add**, and selecting **Docker Support**.
