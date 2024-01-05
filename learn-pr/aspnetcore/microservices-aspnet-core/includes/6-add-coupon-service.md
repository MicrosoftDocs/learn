In this unit, you complete the code for the *Coupon.API* project. You then run a script to generate changes to the *WebSPA* HTML, and generate and modify Helm charts to define the Azure Kubernetes Service (AKS) deployment.

## Add the GetCouponByCodeAsync method

In the asynchronous `GetCouponByCodeAsync` method:

- The `CouponRepository` class `FindCouponByCodeAsync` method retrieves the coupon corresponding to the provided `code` parameter value from a MongoDB database.
- If the coupon returned is `null` or has already been used, an HTTP 404 status code is returned.
- If the coupon returned isn't `null` and hasn't already been used, the `Coupon` object is converted to a `CouponDto` Data Transfer Object (DTO). An HTTP 200 status code returns along with the DTO.

To add the `GetCouponByCodeAsync` method to the coupon service:

1. In the Visual Studio Code **Explorer** pane, find the ASP.NET Core project for the coupon service in the *:::no-loc text="src/Services/Coupon/Coupon.API":::* directory.

1. In the *:::no-loc text="Controllers/CouponController.cs":::* file, replace the comment `// Add the GetCouponByCodeAsync method` with the following code:

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

## Add health checking

To add real-time HTTP health checking to the coupon service, apply the following changes in the *Startup.cs* file in the *:::no-loc text="src/Services/Coupon/Coupon.API":::* directory.

1. In the `ConfigureServices` method, invoke the custom `AddCustomHealthCheck` extension method immediately after the `AddSwagger` method call, as follows:

   :::code language="csharp" source="../code/src/services/coupon/coupon.api/Startup.cs" id="snippet_ConfigureServicesMethod" highlight="12-13":::

   The preceding change:

   - Registers the ASP.NET Core health check service in the coupon service dependency injection container. ASP.NET Core provides middleware that runs when you request a health check endpoint.
   - Uses the `AddCustomHealthCheck` extension method implemented in *:::no-loc text="Extensions/IServiceCollectionExtensions.cs":::* to test external service dependencies for availability and normal operation. The following example shows the code for the MongoDB external dependency.

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

     The preceding `AddCustomHealthCheck` code:

     - Adds a health check named `self` that returns an HTTP success status code for each request to the coupon service's health endpoint.
     - Adds a check for the MongoDB dependency by using the `AddMongoDb` extension method implemented in the [AspNetCore.HealthChecks.MongoDb](https://www.nuget.org/packages/AspNetCore.HealthChecks.MongoDb) NuGet package.

     > [!TIP]
     > The open-source project [AspNetCore.Diagnostics.HealthChecks](https://github.com/Xabaril/AspNetCore.Diagnostics.HealthChecks) provides various custom health check implementations for ASP.NET Core projects. This MongoDB implementation is just one example.

1. In the `Configure` method in *Startup.cs*, replace the `// Add the endpoints.MapHealthChecks code` comment with the following highlighted code:

   :::code language="csharp" source="../code/src/services/coupon/coupon.api/Startup.cs" id="snippet_ConfigureMethod" highlight="29-37":::

   The preceding change registers the following HTTP health check endpoints with the ASP.NET Core routing system:

   - A *liveness* endpoint that AKS queries periodically to check for failures.

     AKS provides liveness probes to detect failing applications, and restarts the apps when they don't return success codes. When the coupon service starts up for the first time, there might be time-consuming tasks, like setting up seed data in the database or awaiting RabbitMQ startup. To avoid restarts during this time, the liveness check filters the checks with the `self` tag, which returns the HTTP status code 200 for every request.

   - An `/hc` *readiness* endpoint that AKS queries to find out when a service is ready to start accepting traffic.

     The `/hc` endpoint returns the HTTP status code 200 when all registered checks are successful. External health monitoring systems like the *:::no-loc text="WebStatus":::* app query the same endpoint. *:::no-loc text="WebStatus":::* provides a dashboard to visualize the status of configured health checks. You use the [AspNetCore.HealthChecks.UI.Client](https://www.nuget.org/packages/AspNetCore.HealthChecks.UI) NuGet package to generate the dashboard.

   In the following AKS deployment configuration file, the liveness and readiness probes use HTTP `GET` requests to the health endpoints to determine their status codes. Any HTTP status code greater than or equal to `200`, and less than `400`, indicates success. Any other code indicates failure.

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
          image: {{ .Values.registry }}/coupon.api:linux-net6-initial
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

## Build the project

Save your changes to the *CouponController.cs* and *Startup.cs* files. In the terminal pane, run the following command to build the coupon service project:

```dotnetcli
dotnet build ../../src/Services/Coupon/Coupon.API/
```

The build should succeed with no warnings. If the build fails, check the output for troubleshooting information.

Observe the following features in the *:::no-loc text="src/Services/Coupon/Coupon.API/Dockerfile":::* for the project:

- The Dockerfile uses the ASP.NET Core runtime image as the base image of the multistage build.
- The Dockerfile acquires the .NET SDK image to support running the following .NET Core CLI commands against the *:::no-loc text="Coupon.API":::* project:
  - `dotnet restore` restores the project's NuGet packages.
  - `dotnet build` builds the project in release mode, and writes the build artifacts to the *:::no-loc text="app/build/":::* directory of an intermediate image.
  - `dotnet publish` publishes the project in release mode and writes the published bundle to the *:::no-loc text="app/publish/":::* directory of the final image.
- The final image contains the ASP.NET Core runtime and the published coupon service artifacts.
- When you start a container from the final image, you start the coupon service by running `dotnet Coupon.API.dll`.

## Apply more configuration changes

To make other configuration changes for the coupon service, run the following script in the terminal:

```bash
./implementation-script.sh
```

To create an object in a Kubernetes cluster, you must provide the object specification in a YAML file. The preceding script uses Helm template functionality to generate the YAML and send it to the cluster.

The script creates a Helm chart for the coupon service in the *:::no-loc text="deploy/k8s/helm-simple/coupon":::* directory, composed of the following files:

- *:::no-loc text="Chart.yaml":::*
- *:::no-loc text="templates/configmap.yaml":::*
- *:::no-loc text="templates/deployment.yaml":::*
- *:::no-loc text="templates/ingress.yaml":::*
- *:::no-loc text="templates/service.yaml":::*

The *:::no-loc text="Chart.yaml":::* file contains a description of the chart. The *:::no-loc text="templates":::* directory contains template files. When Helm evaluates the chart with the `helm install` command, it sends all the files in the *:::no-loc text="templates":::* directory to the template rendering engine. Helm then collects the rendered YAML created by those templates and sends it to AKS.

The preceding implementation script also:

- Adds the coupon service endpoints to the aggregator Helm chart in *:::no-loc text="deploy/k8s/helm-simple/webshoppingagg/templates/configmap.yaml":::*.
- Adds the coupon health check to the *WebStatus* Helm chart in *:::no-loc text="deploy/k8s/helm-simple/webstatus/templates/configmap.yaml":::*.
- Uncomments HTML markup in the *:::no-loc text="WebSPA":::* checkout and order details Angular components to support accepting coupon codes and displaying discount amounts, respectively. The script uncomments the following HTML markup in the *:::no-loc text="Web/WebSPA/Client/src/modules/orders":::* directory:

  - In *:::no-loc text="orders-detail/orders-detail.component.html":::*:

    :::code language="html" source="../code/src/Web/WebSPA/Client/src/modules/orders/orders-detail/orders-detail.component.html":::

  - In *:::no-loc text="orders-new/orders-new.component.html":::*:

    :::code language="html" source="../code/src/Web/WebSPA/Client/src/modules/orders/orders-new/orders-new.component.html":::

In the next unit, you build and host the container images in Azure Container Registry, and then deploy the images to AKS.

