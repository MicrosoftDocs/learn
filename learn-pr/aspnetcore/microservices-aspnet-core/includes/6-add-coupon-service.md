In this unit, you complete the *Coupon.API* project. You'll then run a script to generate changes to the *WebSPA* HTML, and generate and modify Helm charts to define the Kubernetes deployment.

## Add the coupon service

You can find an ASP.NET Core project for the coupon service in the *:::no-loc text="src/Services/Coupon/Coupon.API":::* directory. Locate that directory in the Cloud Shell editor. Apply the following changes to the service:

1. In *:::no-loc text="Controllers/CouponController.cs":::*, replace the comment `// Add the GetCouponByCodeAsync method` with the following code:

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
    * If the coupon returned isn't `null` and hasn't already been used, the `Coupon` object is converted to a `CouponDto` Data Transfer Object (DTO). Finally, an HTTP 200 status code is returned along with the DTO.

1. Add real-time HTTP health checking to the coupon service by applying the following changes in *Startup.cs*:
    1. In the `ConfigureServices` method, invoke the custom `AddCustomHealthCheck` extension method immediately after the `AddSwagger` method call:

        :::code language="csharp" source="../code/src/services/coupon/coupon.api/Startup.cs" id="snippet_ConfigureServicesMethod" highlight="13":::

        With the preceding change:

        * ASP.NET Core's health check service is registered in the coupon service's dependency injection container. ASP.NET Core provides middleware that runs when you request a health check endpoint.
        * The `AddCustomHealthCheck` extension method (implemented in *:::no-loc text="Extensions/IServiceCollectionExtensions.cs":::*), tests external service dependencies to confirm availability and normal operation. An example of such an external dependency is MongoDB.

            ```csharp
            public static IServiceCollection AddCustomHealthCheck(
              this IServiceCollection services,
              IConfiguration configuration)
            {
                // code omitted for brevity

                var hcBuilder = services.AddHealthChecks();
                hcBuilder.AddCheck("self", () => HealthCheckResult.Healthy())
                    .AddMongoDb(
                        configuration["ConnectionString"],
                        name: "CouponCollection-check",
                        tags: new string[] { "couponcollection" });
            ```

        The preceding code adds:

        * A health check named `self`, which returns an HTTP success status code for each request to the coupon service's health endpoint.
        * A check for its MongoDB dependency by using the `AddMongoDb` extension method. The `AddMongoDb` method is implemented in the [AspNetCore.HealthChecks.MongoDb](https://www.nuget.org/packages/AspNetCore.HealthChecks.MongoDb) NuGet package.

        > [!TIP]
        > The open-source project [AspNetCore.Diagnostics.HealthChecks](https://github.com/Xabaril/AspNetCore.Diagnostics.HealthChecks) provides various custom health check implementations for ASP.NET Core projects. The MongoDB implementation used in this step is just one example.

    1. In the `Configure` method, replace the `// Add the endpoints.MapHealthChecks code` comment with the highlighted code:

        :::code language="csharp" source="../code/src/services/coupon/coupon.api/Startup.cs" id="snippet_ConfigureMethod" highlight="29-37":::

        The preceding change registers two HTTP health check endpoints with the ASP.NET Core routing system:

        * `/liveness`: A *liveness* endpoint that Kubernetes queries periodically to check for failures. Kubernetes provides liveness probes to detect applications that are failing, and restarts them when they don't return success codes. When the coupon service starts up for the first time, there might be time-consuming tasks, like setting up seed data in the database or awaiting RabbitMQ to start up. To avoid restarts during this time, the liveness check filters the checks with the `self` tag, which returns the HTTP status code 200 for every request.
        * `/hc`: A *readiness* endpoint that Kubernetes queries to know when a service is ready to start accepting traffic. It returns the HTTP status code 200 when all registered checks are successful. The same endpoint is also queried by an external health monitoring system, like the *:::no-loc text="WebStatus":::* app. *:::no-loc text="WebStatus":::* provides a dashboard to visualize configured health checks and the status of each. You use the [AspNetCore.HealthChecks.UI.Client](https://www.nuget.org/packages/AspNetCore.HealthChecks.UI) NuGet package to generate the dashboard.

        In the following Kubernetes deployment configuration file, the liveness and readiness probes use HTTP GET requests to the health endpoints mentioned previously, to determine their status codes. Any HTTP status code greater than or equal to 200, and less than 400, indicates success. Any other code indicates failure.

        ```yml
        kind: Deployment
        apiVersion: apps/v1
        metadata:
          name: coupon
          labels:
            app: eshop
            service: coupon
        spec:
          replicas: 1
          selector:
            matchLabels:
              service: coupon
          template:
            metadata:
              labels:
                app: eshop
                service: coupon
            spec:
              containers:
                - name: coupon-api
                  image: {{ .Values.registry }}/coupon.api:linux-latest
                  imagePullPolicy: Always
                  ports:
                    - containerPort: 80
                      protocol: TCP
                    - containerPort: 81
                      protocol: TCP
                  livenessProbe:
                    httpGet:
                      port: 80
                      path: /liveness
                    initialDelaySeconds: 10
                    periodSeconds: 15
                  readinessProbe:
                    httpGet:
                      port: 80
                      path: /hc
                    initialDelaySeconds: 90
                    periodSeconds: 60
                    timeoutSeconds: 5
                  envFrom:
                    - configMapRef:
                        name: coupon-cm
        ```

1. Run the following command to build the coupon service project:

    ```dotnetcli
    dotnet build src/Services/Coupon/Coupon.API/
    ```

    The build succeeds with no warnings. If the build fails, check the output for troubleshooting information.

1. Open *:::no-loc text="src/Services/Coupon/Coupon.API/Dockerfile":::* in the Azure Cloud Shell editor. Notice the following things in this *:::no-loc text="Dockerfile":::*:

    * The ASP.NET Core runtime image is used as the base image of the multistage build.
    * The .NET Core SDK image is acquired to support the running of the following .NET Core CLI commands against the *:::no-loc text="Coupon.API":::* project:
        * `dotnet restore`: Restores the project's NuGet packages.
        * `dotnet build`: Builds the project in release mode. The build artifacts are written to the *:::no-loc text="app/build/":::* directory of an intermediate image.
        * `dotnet publish`: Publishes the project in release mode. The published bundle is written to the *:::no-loc text="app/publish/":::* directory of the final image.
    * The final image contains the ASP.NET Core runtime and the published coupon service artifacts.
    * When you start a container from the final image, you start the coupon service by running `dotnet Coupon.API.dll`.

1. Run the following script in the command shell to make additional configuration changes for the coupon service:

    ```bash
    ./deploy/k8s/implementation-script.sh
    ```

    > [!TIP]
    > This unit uses scripts to keep focus on the learning objectives. You can inspect the scripts in the Cloud Shell editor to better understand the commands used.

    The preceding script:

    * Uncomments HTML markup in the *:::no-loc text="WebSPA":::* checkout and order details Angular components. This supports accepting coupon codes and displaying discount amounts, respectively. The following HTML markup in the *:::no-loc text="Web/WebSPA/Client/src/modules/orders":::* directory is uncommented:

        *:::no-loc text="orders-detail/orders-detail.component.html":::*:

        :::code language="html" source="../code/src/Web/WebSPA/Client/src/modules/orders/orders-detail/orders-detail.component.html":::

        *:::no-loc text="orders-new/orders-new.component.html":::*:

        :::code language="html" source="../code/src/Web/WebSPA/Client/src/modules/orders/orders-new/orders-new.component.html":::

    * Creates a Helm chart for the coupon service in *:::no-loc text="deploy/k8s/helm-simple/coupon":::*.
    * Adds the coupon service endpoints to the aggregator Helm chart in *:::no-loc text="deploy/k8s/helm-simple/webshoppingagg/templates/configmap.yaml":::*.
    * Adds the coupon health check to the *WebStatus* Helm chart in *:::no-loc text="deploy/k8s/helm-simple/webstatus/templates/configmap.yaml":::*.

    To create an object in a Kubernetes cluster, you must provide the object specification in a YAML file. Helm's template functionality generates and sends the YAML to the cluster.

    The Helm chart for the coupon service is composed of the following files in the *:::no-loc text="deploy/k8s/helm-simple/coupon":::* directory:

    * *:::no-loc text="Chart.yaml":::*
    * *:::no-loc text="templates/configmap.yaml":::*
    * *:::no-loc text="templates/deployment.yaml":::*
    * *:::no-loc text="templates/ingress.yaml":::*
    * *:::no-loc text="templates/service.yaml":::*

    The *:::no-loc text="Chart.yaml":::* file contains a description of the chart. The *:::no-loc text="templates":::* directory contains template files. When Helm evaluates the chart with the `helm install` command, it sends all of the files in the *:::no-loc text="templates":::* directory to the template rendering engine. It then collects the rendered YAML created by those templates, and sends it to AKS.

## Container images in Azure Container Registry

Host container images in container registries. Often, a public container registry like Docker Hub might be appropriate. Private container registries, such as Azure Container Registry, can be more appropriate for enterprise scenarios. Only your team and services have access to a private registry. All of the container images used when the solution was initially deployed to AKS are from one of the endpoints of Container Registry.

The following diagram depicts the relationships among Docker container images, container registries such as Container Registry, and Kubernetes or AKS deployments.

:::image type="content" source="../media/6-add-coupon-service/acr-aks.png" alt-text="A container image is created by a developer, sent to Container Registry, and retrieved by AKS" border="true" lightbox="../media/6-add-coupon-service/acr-aks.png":::

In the preceding diagram:

1. The developer sends the container image to Container Registry.
1. The developer sends Kubernetes YAML configuration files to AKS. The configuration specifies which container images are required.
1. AKS retrieves the images from Container Registry, and uses the images to build and run the containers.

You don't have permissions to make changes to the Container Registry of Microsoft. Consequently, you must host the coupon service container image and the modified *:::no-loc text="WebSPA":::* app container image on your private Container Registry.

> [!NOTE]
> The `helm install` command used later in the module specifies which container registry to use when you install the charts to Kubernetes or AKS.

## Build the coupon service in Container Registry

Run the following script in the command shell. This builds the coupon service and *:::no-loc text="WebSPA":::* app container images, and hosts them in Container Registry:

```bash
./deploy/k8s/build-to-acr.sh
```

The preceding script builds the container images in Container Registry by using the `az acr build` command, with the provided *:::no-loc text="Dockerfile":::* files for the *:::no-loc text="Coupon.API":::* and *:::no-loc text="WebSPA":::* projects.

Note that the solution isn't being built in your Cloud Shell instance. The build occurs in the cloud when the container image is sent to Container Registry. You can see build output shown in the command shell. The `az acr build` command used by the script is shown in the command shell, with the correct parameters. The command resembles the following example:

```azurecli
az acr build --registry eshoplearn \
     --image eshoplearn.azurecr.io/coupon.api:linux-latest \
     --file src/Services/Coupon/Coupon.API/Dockerfile \
     .
```

In the preceding example:

* The `--registry` parameter specifies the name of the container registry to use.
* The `--image` parameter specifies the name and tag of the image, in the format `<repo url>/<name>:<tag>`.
* The `--file` parameter specifies the relative path of *:::no-loc text="Dockerfile":::*.
* The final parameter, which is positional and not indicated by a command-line flag, specifies the location of the local source code directory. In this case, the script uses the directory in which it's currently running, indicated by `.`.

In the next unit, you'll update the AKS deployment with your modifications.
