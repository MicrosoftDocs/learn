In this unit, you complete the *Coupon.API* project. You will then run a script to generate changes to the *WebSPA* HTML, as well as generate and modify Helm charts to define the kubernetes deployment.

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

1. Add real-time HTTP health checking to the coupon service by applying the following changes in *Startup.cs*:
    1. In the `ConfigureServices` method, invoke the custom `AddCustomHealthCheck` extension method immediately after the `AddSwagger` method call:

        [!code-csharp[](../code/src/services/coupon/coupon.api/temp-startup.cs?name=snippet_configureServices&highlight=13)]

        With the preceding change:
        
        * ASP.NET Core's health check service is registered in the coupon service's dependency injection container. ASP.NET Core provides health checks middleware that executes when a health check endpoint is requested.
        * A health check named `self` is created. Its purpose is to verify connectivity to the supporting MongoDB database. When a connection to the database can be established, the health check returns an HTTP 200 status code.

    1. In the `Configure` method, register the health checks endpoints with the ASP.NET Core routing system:

        [!code-csharp[](../code/src/services/coupon/coupon.api/temp-startup.cs?name=snippet_configure&highlight=30-38)]

        The preceding change registers two HTTP health check endpoints with the ASP.NET Core routing system:
        
        * `/hc`&ndash;A "readiness" endpoint that provides a dashboard to visualize configured health checks and the status of each. The [AspNetCore.HealthChecks.UI.Client](https://www.nuget.org/packages/AspNetCore.HealthChecks.UI) NuGet package is used to generate the dashboard.
        * `/liveness`&ndash;A "liveness" endpoint that tests connectivity to the MongoDB database.

        Using separate "readiness" and "liveness" checks is useful when using AKS. The coupon service performs time-consuming startup work before accepting HTTP requests, such as testing connectivity to the underlying MongoDB database. Using separate checks allows the orchestrator to determine whether the service is functioning but not yet ready or if the service has failed to start.

1. Run the following script in the command shell to make additional configuration changes for the coupon service:

    ```bash
    ./deploy/k8s/implementation-script.sh
    ```

    > [!TIP]
    > This unit uses scripts to keep focus on the learning objectives. You may inspect the scripts in the Cloud Shell editor to better understand the commands used.

    The preceding script:

    * Uncomments HTML markup in the *WebSPA* checkout and order details views to support accepting coupon codes and displaying discount amounts, respectively.
    * Creates a Helm chart for the coupon service in *deploy/k8s/helm-simple/*. 
    * Adds the coupon service endpoints to the aggregator Helm chart in *deploy/k8s/helm-simple/webshoppingagg/templates/configmap.yaml*
    * Adds the coupon health check to the *WebStatus* Helm chart in *deploy/k8s/helm-simple/webstatus/templates/configmap.yaml*.

    When you create an object in a Kubernetes (or AKS) cluster, you must provide the object specification in a YAML file. You'll use the template functionality in the open-source tool Helm to generate and send the YAML files to the AKS cluster.
    
    The Helm chart for the coupon service is comprised of the following files in *deploy/k8s/helm-simple/coupon/*:

    * *Chart.yaml*
    * *templates/configmap.yaml*
    * *templates/deployment.yaml*
    * *templates/ingress.yaml*
    * *templates/service.yaml*

    The *Chart.yaml* file contains a description of the chart. The *templates* directory contains template files. When Helm evaluates the chart with the `helm install` command, it sends all of the files in the *templates* directory to the template rendering engine. It then collects the rendered YAML created by those templates and sends it to AKS.

## Build the coupon service in ACR

Container images are hosted in container registries. For many scenarios, a public container registry like Docker Hub might be appropriate. Private container registries, such as ACR, are often more appropriate for enterprise scenarios. Only your team and services have access to a private registry. All of the container images used when the solution was initially deployed to AKS were from one of Microsoft's ACR endpoints.

The following diagram depicts the relationships between Docker container images, container registries such as ACR, and Kubernetes/AKS deployments.

![Diagram indicating the flow of a container image in ACR to a container in AKS](../media/temp/image-acr-aks.png)

In the preceding diagram:

1. The developer sends the container image to ACR.
2. The developer sends Kubernetes YAML configuration files to AKS. The configuration specifies which container images are required.
3. AKS retrieves the images from ACR and uses the images to build and run the containers.

The coupon service uses a new container image you're creating. The image needs to be hosted in a container registry, and for that you'll use your own ACR instance. The coupon service isn't the only container image that needs to be hosted on your ACR. The *implementation-script.sh* script modified the *WebSPA* app on your behalf. The modified *WebSPA* app isn't available as a container image on Microsoft's ACR. Accordingly, you must host both the new coupon service container image and the modified *WebSPA* app container image on your private ACR.

> [!NOTE]
> The `helm install` command used later in the module specifies which container registry to use when the charts are installed to Kubernetes/AKS.

Run the following script in the command shell to build the coupon service and *WebSPA* web app container images and host them in ACR:

```bash
./deploy/k8s/build-to-acr.sh
```

The preceding script builds the container images in ACR using the `az acr build` command with the provided *Dockerfile* files for the *Coupon.API* and *WebSPA* projects. 

Note the solution isn't being built in your Cloud Shell instance at all. The build takes place in the cloud when the container image is sent to ACR. Build output is displayed in the console. The `az acr build` commands used by the script are displayed in the console with the correct parameters. The output resembles this:

```azurecli
%todo%
```

In the preceding example:

* Some
* stuff
* happens

> [!NOTE]
> If any of the code changes you made to the *Coupon.API* project were incorrect, the build in ACR might fail. In the event of build errors, use the build output in the console to troubleshoot the error and re-run `./deploy/k8s/build-to-acr.sh`.

In the next unit, you'll update the AKS deployment with your modifications.
