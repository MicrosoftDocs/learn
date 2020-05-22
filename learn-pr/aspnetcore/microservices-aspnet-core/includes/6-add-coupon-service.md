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

Container images are hosted in container registries. For many scenarios, a public container registry like Docker Hub might be appropriate. All of the container images used when the solution was initially deployed to AKS were from a public Docker Hub registry.

The coupon service isn't the only container image that needs to be hosted in ACR. The implementation script modified the *WebSPA* web app on your behalf. The modified *WebSPA* isn't available as a container image on the public Docker Hub registry. Accordingly, you must host both the new coupon service container image and the modified *WebSPA* web app container image on your private ACR.

> [!NOTE]
> The `helm install` command used in the next unit specifies which container registry to use when the charts are installed to Kubernetes/AKS.

Run the following script in the command shell to build the coupon service and *WebSPA* web app container images:

```bash
./deploy/k8s/build-to-acr.sh
```

The preceding script builds the container images in ACR using the `az acr build` command with the provided *Dockerfile* files for the *Coupon.API* and *WebSPA* projects. 

Note the solution isn't being built in your cloud shell instance at all. The build takes place in the cloud when the container image is sent to ACR, and build output is displayed in the terminal. The `az acr build` commands used by the script are echoed to the console with the correct parameters, and look similar to this:

```azcli

```

In the preceding example:

* Some
* stuff
* happens

In the next unit, you'll update the AKS deployment with your modifications.



