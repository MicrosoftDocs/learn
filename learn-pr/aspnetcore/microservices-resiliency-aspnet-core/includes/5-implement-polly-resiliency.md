In this exercise, you'll implement a resiliency handler with Polly. The initial *:::no-loc text="eShopOnContainers":::* deployment includes a failure simulation feature when validating a coupon from the checkout basket. This feature allows you to configure the number of times a request for a specific discount code fails.

In this unit, you will:

* Update the app's code to implement failure handling using Polly.
* Create an Azure Container Registry (ACR) instance and deploy the updated app to Azure Kubernetes Service (AKS).
* Explore the system response under failure after implementing resiliency.

## Add failure handling code using Polly

You can modify the app to automatically retry a failing operation until it succeeds. If the operation continues to fail after several attempts, the UI displays an exception.

When validating a discount coupon, the HTTP request is sent to the web shopping aggregator. The web shopping aggregator is responsible for routing the request to the coupon service. This is an implementation of the [Backends For Frontends pattern](https://samnewman.io/patterns/architectural/bff) (BFF). The BFF implementation:

* Sends another HTTP request to the coupon service to get the required information.
* Handles resiliency using [IHttpClientFactory](/aspnet/core/fundamentals/http-requests) and [Polly](https://old.dotnetfoundation.org/projects/polly).

To make the coupon service resilient, implement a Retry and a Circuit Breaker policy to handle failure within the web shopping aggregator. Using Polly with `IHttpClientFactory` to add resiliency to web apps is one of the archetypical failure handling solutions. The `IHttpClientFactory` is responsible for creating instances of `HttpClient`.

The following sequence diagram shows the flow of events from an `HttpClient` instance to Polly's Retry and Circuit Breaker policies:

:::image type="content" source="../media/5-implement-polly-resiliency/policy-http-message-handlers.png" alt-text="Diagram of an HttpClient call through multiple PolicyHttpMessageHandlers." border="true" lightbox="../media/5-implement-polly-resiliency/policy-http-message-handlers.png":::

Complete the following steps to implement failure handling for the coupon service, as described previously. Use the terminal you created earlier.

1. Temporarily set your current location to the HTTP aggregator project directory by running the following command:

    ```bash
    pushd ../../src/ApiGateways/Aggregators/Web.Shopping.HttpAggregator/
    ```

    Your current location is *:::no-loc text="/workspaces/mslearn-aspnet-core/modules/microservices-resiliency-aspnet-core/src/ApiGateways/Aggregators/Web.Shopping.HttpAggregator":::*.

1. Run the following command:

    ```dotnetcli
    dotnet add package Microsoft.Extensions.Http.Polly --version 6.0.5
    ```

    The preceding command installs a NuGet package in the *:::no-loc text="Web.Shopping.HttpAggregator":::* project. The package integrates `IHttpClientFactory` with Polly and installs the actual `Polly` package as a dependency. The package is necessary to configure Polly policies to handle conditions representing transient faults when making HTTP requests. Such conditions are handled by invoking the package's `HttpPolicyExtensions.HandleTransientHttpError` method. The conditions include:

    * Network failures, as indicated by exceptions of type `HttpRequestException`
    * Server errors, as indicated by *HTTP 5xx* status codes
    * Request timeouts, as indicated by the *HTTP 408* status code

1. Apply the following changes in the *:::no-loc text="src/ApiGateways/Aggregators/Web.Shopping.HttpAggregator/Extensions/ServiceCollectionExtensions.cs":::* file:
    1. Replace the comment `// Add the GetRetryPolicy method` with the following method:

        ```csharp
        public static IAsyncPolicy<HttpResponseMessage> GetRetryPolicy()
        {
            return HttpPolicyExtensions.HandleTransientHttpError()
                .WaitAndRetryAsync(5,
                    retryAttempt => TimeSpan.FromMilliseconds(Math.Pow(1.5, retryAttempt) * 1000),
                    (_, waitingTime) =>
                    {
                        Log.Logger.Information(
                            "----- Retrying in {WaitingTime}s", $"{ waitingTime.TotalSeconds:n1}");
                    });
        }
        ```

    1. Replace the comment `// Add the GetCircuitBreakerPolicy method` with the following method:

        ```csharp
        public static IAsyncPolicy<HttpResponseMessage> GetCircuitBreakerPolicy() =>
            HttpPolicyExtensions.HandleTransientHttpError()
                .CircuitBreakerAsync(15, TimeSpan.FromSeconds(15));
        ```

    1. In the `AddApplicationServices` method, call the `AddPolicyHandler` extension method twice. Chain the method calls to the `AddHttpMessageHandler` method call for the coupon service:

        :::code language="csharp" source="../code/src/apigateways/aggregators/web.shopping.httpaggregator/extensions/5-servicecollectionextensions.cs" highlight="9-11":::

    1. Replace the comment `// Add the using statements` with the following `using` directives:

        ```csharp
        using Polly;
        using Polly.Extensions.Http;
        using System.Net.Http;
        ```

        Importing the preceding namespaces resolves member references in the `GetRetryPolicy` and `GetCircuitBreakerPolicy` methods.

1. Save the *:::no-loc text="ServiceCollectionExtensions.cs":::* file.

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-no-restore-command.md)]

1. Return to your previous location by running the following command:

    ```bash
    popd
    ```

With the preceding changes:

* A Retry policy was defined that retries up to five times with an exponentially increasing delay between attempts. This policy's premise is that faults are transient and might self-correct after a short delay. The policy's delay:
  * Increases as a power of 1.5 seconds after each attempt.
  * Is a power of 2 seconds by default. To decrease wait times for this exercise, 1.5 seconds is used instead.
* A Circuit Breaker policy was defined which enforces a 15-second pause after 15 consecutive failures. This policy's premise is that protecting the service from overload can help it recover.
* The `HttpClient` instance used by the coupon service was configured to apply the Retry and Circuit Breaker policies. This particular `HttpClient` instance is provided to the `CouponService` class in the *CouponService.cs* file via constructor injection:

    :::code language="csharp" source="../code/src/apigateways/services/5-couponservice.cs" highlight="8":::

    The `AddApplicationServices` extension method is invoked from the `ConfigureServices` method in the project's *:::no-loc text="Startup.cs":::* file:

    :::code language="csharp" source="../code/src/apigateways/aggregators/web.shopping.httpaggregator/5-startup.cs" highlight="7":::

## Deploy the updated microservice

Complete the following steps to deploy the changes that you've implemented:

1. Run the following script to publish the aggregator's updated Docker image to ACR:

    ```bash
    ./build-to-acr.sh --services webshoppingagg
    ```

    The preceding script builds and publishes the updated image to the ACR instance. An [ACR quick task](/azure/container-registry/container-registry-tasks-overview#quick-task) is used to build and publish the `webshoppingagg` image to the ACR instance. A variation of the following output appears:

    ```console
    Building and publishing docker images to eshoplearn20220712195024315.azurecr.io
 

    Building image "webshoppingagg" for service "webshoppingagg" with "src/ApiGateways/Aggregators/Web.Shopping.HttpAggregator/Dockerfile.acr"...

    > az acr build -r eshoplearn20220712195024315 -t eshoplearn20220712195024315.azurecr.io/webshoppingagg:linux-net6-coupon -f src/ApiGateways/Aggregators/Web.Shopping.HttpAggregator/Dockerfile.acr .

    Packing source code into tar to upload...
    Excluding '.gitignore' based on default ignore rules
    Uploading archived source code from '/tmp/build_archive_9255326b2fec4abb8c38d0f245918034.tar.gz'...
    Sending context (7.875 MiB) to registry: eshoplearn20220712195024315...
    Queued a build with ID: cj1
    Waiting for an agent...
    2022/07/12 21:40:22 Downloading source code...
    2022/07/12 21:40:24 Finished downloading source code
    2022/07/12 21:40:24 Using acb_vol_408e7673-c944-4209-9261-763c2329ccf2 as the home volume
    2022/07/12 21:40:24 Setting up Docker configuration...
    2022/07/12 21:40:25 Successfully set up Docker configuration
    2022/07/12 21:40:25 Logging in to registry: eshoplearn20220712195024315.azurecr.io
    2022/07/12 21:40:26 Successfully logged into eshoplearn20220712195024315.azurecr.io
    2022/07/12 21:40:26 Executing step ID: build. Timeout(sec): 28800, Working directory: '', Network: ''
    2022/07/12 21:40:26 Scanning for dependencies...
    2022/07/12 21:40:26 Successfully scanned dependencies
    2022/07/12 21:40:26 Launching container with name: build
    ```

    And this particular line once the image has been published to ACR:

    ```console
    2020/07/29 17:04:57 Successfully pushed image: eshoplearn20200729161705092.azurecr.io/webshoppingagg:linux-net6-coupon
    ```

1. Run the following command to verify the URL of your ACR instance:

    ```bash
    eval $(cat ../../create-acr-exports.txt) && \
        echo $ESHOP_REGISTRY
    ```

    The setup script saved some environment variable declarations in a text file. The preceding command evaluates the text file to set the environment variables. A variation of the following output appears:

    ```console
    eshoplearn2020072900000000.azurecr.io
    ```

1. Run the following script to deploy the updated image in ACR to AKS:

    ```bash
    ./deploy-application.sh --registry $ESHOP_REGISTRY --charts webshoppingagg
    ```

    The preceding script uninstalls the old `webshoppingagg` Helm chart and installs it again. The AKS cluster uses the new image from the ACR instance. A variation of the following output appears:

    ```console
    Uninstalling chart webshoppingagg...
    release "eshoplearn-webshoppingagg" uninstalled

    Deploying Helm charts from registry "eshoplearn20200731194920286.azurecr.io" to "http://13.87.153.177"...
    ---------------------

    Installing chart "webshoppingagg"...
    NAME: eshoplearn-webshoppingagg
    LAST DEPLOYED: Fri Jul 31 20:38:05 2020
    NAMESPACE: default
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None

    Helm charts deployed!
    ```

## Test the app again

The Polly Retry and Circuit Breaker policies have been deployed. It's time to test the app's behavior.

[!INCLUDE[Wait for healthy services](../../includes/microservices/wait-for-healthy-services.md)]

### Retry policy

Complete the following steps to test the Retry policy:

1. Place an item in the shopping bag and begin the checkout procedure.

1. Enter the discount code *:::no-loc text="FAIL 2 DISC-10":::* and select **:::no-loc text="APPLY":::**.

    You receive the following confirmation message with the number of failures configured for the code: **:::no-loc text="CONFIG: 2 failure(s) configured for code \"DISC-10\"!!":::**.
1. Replace the existing discount code with *:::no-loc text="DISC-10":::* and select **:::no-loc text="APPLY":::**.

    The operation appears to be successful on the first try after a brief wait. The resilient BFF handles retries transparently from the user's perspective. Notice that the 10 USD discount was applied.
1. Return to the **:::no-loc text="Centralized logging":::** page.

1. Check the log traces. A variation of the following output appears:

    :::image type="content" source="../media/5-implement-polly-resiliency/configure-and-retry-logs.png" alt-text="log traces." border="true" lightbox="../media/5-implement-polly-resiliency/configure-and-retry-logs.png":::

    In the preceding image, you can see:

    * The log traces when configuring the simulated failures, labeled as "1".
    * Three retries until the aggregator could finally get the value, labeled as "2".
1. Complete the checkout procedure and select **:::no-loc text="CONTINUE SHOPPING":::**.

### Circuit Breaker policy

To test the Circuit Breaker policy, configure the code for 20 failures by using the discount code *:::no-loc text="FAIL 20 DISC-10":::*:

:::image type="content" source="../media/5-implement-polly-resiliency/configure-severe-failure.png" alt-text="configure a severe failure." border="true" lightbox="../media/5-implement-polly-resiliency/configure-severe-failure.png":::

1. Place an item in the shopping bag and begin the checkout procedure.
1. Enter the discount code *:::no-loc text="FAIL 20 DISC-10":::* and select **:::no-loc text="APPLY":::**.

    You receive the following confirmation message with the number of failures configured for the code: **:::no-loc text="CONFIG: 20 failure(s) configured for code \"DISC-10\"!!":::**.
1. Enter the discount code *:::no-loc text="DISC-10":::* again and select **:::no-loc text="APPLY":::**.
1. Wait about 20 seconds. An HTTP 500 error message appears.
1. Select **:::no-loc text="APPLY":::** again. The error message is received again in about 20 seconds.
1. Select **:::no-loc text="APPLY":::** again. The HTTP 500 error message comes in faster because of the Circuit Breaker policy.
1. Select **:::no-loc text="APPLY":::** again.

    The error message is received immediately. You can see this error clearly in the log traces:

    :::image type="content" source="../media/5-implement-polly-resiliency/severe-failure-logs.png" alt-text="Screenshot of severe failures in log traces." border="true" lightbox="../media/5-implement-polly-resiliency/severe-failure-logs.png":::

    In the preceding image, notice that:

    * After waiting for 7.6 seconds, labeled as "1", you received the HTTP 500 error message with the Retry policy, labeled as "2".
    * On the next try, you validate the code. You receive the HTTP 500 error message after waiting only 3.4 seconds, labeled as "3". You don't see the **Get coupon...** trace, meaning it failed without going to the server.
    * If you check the details on this last trace, you should see a variation of the following output:

        :::image type="content" source="../media/5-implement-polly-resiliency/severe-failure-log-detail.png" alt-text="Screenshot of severe failure log detail." border="true" lightbox="../media/5-implement-polly-resiliency/severe-failure-log-detail.png":::

        Notice that the last trace has the **The circuit is now open...** message.

In this unit, you added code-based resiliency by using Polly. Next, you'll implement infrastructure-based resiliency by using Linkerd.
