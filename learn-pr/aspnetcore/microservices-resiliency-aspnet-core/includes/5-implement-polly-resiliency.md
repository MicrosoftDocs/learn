In this exercise, you'll implement a resiliency handler with Polly. The initial *eShopOnContainers* deployment includes a failure simulation feature when validating a coupon from the checkout basket. This feature allows you to configure how many times a request for a specific discount coupon code should fail.

In this exercise, you will:

- Update the app's code to implement failure handling using Polly.
- Create an ACR instance and deploy the updated app to AKS.
- Explore the system response under failure after implementing resiliency.

## Add failure handling code using Polly

The basic idea is to have the app automatically handle retrying the operation until it succeeds, or give up because it looks like a severe failure. When validating a discount coupon, the HTTP request goes to the web shopping aggregator, as the implementation of the [Backends For Frontends pattern](https://samnewman.io/patterns/architectural/bff) (BFF). The BFF implementation:

- Sends another HTTP request to the coupon service to get the required information.
- Handles resiliency using [IHttpClientFactory](/aspnet/core/fundamentals/http-requests) and [Polly](http://www.thepollyproject.org).

To make the coupon service resilient, you'll implement a Retry and a Circuit Breaker policy to handle failure. Using Polly with `IHttpClientFactory` to add resiliency to web apps is one of the archetypical failure handling solutions. The `IHttpClientFactory` is responsible for creating instances of `HttpClient`.

The following sequence diagram depicts the flow of events from an `HttpClient` instance to Polly's Retry and Circuit Breaker policies:

:::image type="content" source="../media/5-implement-polly-resiliency/policy-http-message-handlers.png" alt-text="An HttpClient call through multiple PolicyHttpMessageHandlers" border="true" lightbox="../media/5-implement-polly-resiliency/policy-http-message-handlers.png":::

Complete the following steps to implement failure handling for the coupon service as described above:

1. Set your current location to the HTTP aggregator project directory by running the following command:

    ```bash
    pushd src/ApiGateways/Aggregators/Web.Shopping.HttpAggregator/
    ```

    Your current location is *:::no-loc text="~/clouddrive/aspnet-learn/src/src/ApiGateways/Aggregators/Web.Shopping.HttpAggregator":::*.

1. Run the following command:

    ```dotnetcli
    dotnet add package Microsoft.Extensions.Http.Polly
    ```

    The preceding command installs a NuGet package in the *Web.Shopping.HttpAggregator* project. The package integrates Polly and `IHttpClientFactory` and installs the actual `Polly` package as a dependency. The package is necessary to configure Polly policies to handle conditions representing transient faults when making HTTP requests. Such conditions are handled by invoking the package's `HttpPolicyExtensions.HandleTransientHttpError` method. The conditions include:

    - Network failures, as indicated by exceptions of type `HttpRequestException`
    - Server errors, as indicated by HTTP 5xx status codes
    - Request timeouts, as indicated by the HTTP 408 status code

1. Apply the following changes in the *src/ApiGateways/Aggregators/Web.Shopping.HttpAggregator/Extensions/ServiceCollectionExtensions.cs* file:
    1. Replace the comment `// Add the GetRetryPolicy method` with the following method:

        ```csharp
        public static IAsyncPolicy<HttpResponseMessage> GetRetryPolicy()
        {
            return HttpPolicyExtensions.HandleTransientHttpError()
                .WaitAndRetryAsync(5, retryAttempt =>
                    TimeSpan.FromMilliseconds(Math.Pow(1.5, retryAttempt) * 1000), (_, waitingTime) =>
                {
                    Log.Logger.Information(
                        "----- Retrying in {WaitingTime}s", $"{ waitingTime.TotalSeconds:n1}");
                });
        }
        ```

        The preceding method configures a Retry policy with an exponential back-off that increases the retry time as a power of 1.5 seconds. This value is typically a power of 2 seconds in most samples. To decrease wait times for this exercise, 1.5 seconds is used instead. This policy's premise is that faults are transient and may self-correct after a short delay.

    1. Replace the comment `// Add the GetCircuitBreakerPolicy method` with the following method:

        ```csharp
        public static IAsyncPolicy<HttpResponseMessage> GetCircuitBreakerPolicy() =>
            HttpPolicyExtensions.HandleTransientHttpError()
                .CircuitBreakerAsync(15, TimeSpan.FromSeconds(15));
        ```

        The preceding method configures a Circuit Breaker policy that "opens the breaker" for 15 seconds, after 15 continuous failures. This policy's premise is that protecting the coupon service from overload can help it recover.

    1. In the `AddApplicationServices` method, call the `AddPolicyHandler` extension method twice. Chain the method calls to the `AddHttpMessageHandler` method call for the coupon service:

        :::code language="csharp" source="../code/src/apigateways/aggregators/web.shopping.httpaggregator/extensions/5-servicecollectionextensions.cs" highlight="7-8":::

        With the preceding changes, the `HttpClient` instance used by the coupon service has been configured to apply a Retry and a Circuit Breaker policy. This particular `HttpClient` instance is provided to the `CouponService` class via constructor injection:

        :::code language="csharp" source="../code/src/apigateways/services/5-couponservice.cs" highlight="8":::

        The `AddApplicationServices` extension method is invoked from the `ConfigureServices` method in the project's *Startup.cs* file:

        :::code language="csharp" source="../code/src/apigateways/aggregators/web.shopping.httpaggregator/5-startup.cs" highlight="7":::

    1. Replace the comment `// Add the using statements` with the following `using` directives:

        ```csharp
        using Polly;
        using Polly.Extensions.Http;
        using System.Net.Http;
        ```

        Importing the preceding namespaces resolves member references in the `GetRetryPolicy` and `GetCircuitBreakerPolicy` methods.

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-no-restore-command.md)]

1. Return to your previous location by running the following command:

    ```bash
    popd
    ```

## Deploy the updated microservice

Complete the following steps to deploy the changes that you've implemented:

1. Run the following script to publish the updated image to ACR:

    ```bash
    ./deploy/k8s/build-to-acr.sh --services webshoppingagg
    ```

    The preceding script builds and publishes the updated image to the ACR instance. An [ACR quick task](/azure/container-registry/container-registry-tasks-overview#quick-task) is used to build the `webshoppingagg` image and push it to the ACR instance. You'll see a variation of the following output:

    ```console
    Building images to ACR
    ======================
    ~/clouddrive/aspnet-learn/src/deploy/k8s ~/clouddrive/aspnet-learn/src

    Building and publishing docker images to eshoplearn20200729161705092.azurecr.io
    ~/clouddrive/aspnet-learn/src ~/clouddrive/aspnet-learn/src/deploy/k8s ~/clouddrive/aspnet-learn/src

    Building image "webshoppingagg" for service "webshoppingagg" with "src/ApiGateways/Aggregators/Web.Shopping.HttpAggregator/Dockerfile.acr"...

     > az acr build -r eshoplearn20200729161705092 -t eshoplearn20200729161705092.azurecr.io/webshoppingagg:linux-latest -f src/ApiGateways/Aggregators/Web.Shopping.HttpAggregator/Dockerfile.acr .

    Packing source code into tar to upload...
    Excluding '.gitignore' based on default ignore rules
    Uploading archived source code from '/tmp/build_archive_1a826ecd8db64f8c846d796af13d6318.tar.gz'...
    Sending context (7.838 MiB) to registry: eshoplearn20200729161705092...
    Queued a build with ID: cf2
    Waiting for an agent...
    2020/07/29 17:03:19 Downloading source code...
    2020/07/29 17:03:21 Finished downloading source code
    2020/07/29 17:03:22 Using acb_vol_faae1c90-bbea-4ea6-89e9-daa0ab059f5a as the home volume
    2020/07/29 17:03:22 Setting up Docker configuration...
    2020/07/29 17:03:23 Successfully set up Docker configuration
    2020/07/29 17:03:23 Logging in to registry: eshoplearn20200729161705092.azurecr.io
    2020/07/29 17:03:24 Successfully logged into eshoplearn20200729161705092.azurecr.io
    2020/07/29 17:03:24 Executing step ID: build. Timeout(sec): 28800, Working directory: '', Network: ''
    2020/07/29 17:03:24 Scanning for dependencies...
    2020/07/29 17:03:25 Successfully scanned dependencies
    2020/07/29 17:03:25 Launching container with name: build
    ```

    And this particular line once the image has been published to ACR:

    ```console
    2020/07/29 17:04:57 Successfully pushed image: eshoplearn20200729161705092.azurecr.io/webshoppingagg:linux-latest
    ```

1. Run the following command to verify the URL of your ACR instance:

    ```bash
    echo $ESHOP_REGISTRY
    ```

    You'll see a variation of the following output:

    ```console
    eshoplearn2020072900000000.azurecr.io
    ```

    > [!IMPORTANT]
    > If the output is blank, this is because the variable isn't defined. Run the following command to set the variable using output from the setup script and then run the `echo` command again to verify:
    >
    > ```bash
    > eval $(cat ~/clouddrive/aspnet-learn/create-acr-exports.txt)
    > ```

1. Run the following script to deploy the updated image in ACR to AKS:

    ```bash
    ./deploy/k8s/deploy-application.sh --charts webshoppingagg 
    ```

    The preceding script uninstalls the old `webshoppingagg` Helm chart and installs it again. The AKS cluster uses the new image from the ACR instance. You should get a result like this:

    ```console
    ~/clouddrive/aspnet-learn ~/clouddrive/aspnet-learn/src/deploy/k8s
    ~/clouddrive/aspnet-learn/src/deploy/k8s

    Uninstalling chart webshoppingagg...
    release "eshoplearn-webshoppingagg" uninstalled

    Deploying Helm charts from registry "eshopdev" to "http://20.189.128.128"...
    ---------------------

    Installing chart "webshoppingagg"...
    NAME: eshoplearn-webshoppingagg
    LAST DEPLOYED: Tue Jul 28 22:05:13 2020
    NAMESPACE: default
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None

    Helm charts deployed!
    ```

## Explore the system response when implementing resiliency

### Simple retries

You're going to repeat what was done in the initial exploration, only you've already deployed the resilient BFF.

Consider the situation in which you configure the same two coupon failures with the code *:::no-loc text="FAIL 3 DISC-10":::*. When you enter the *:::no-loc text="DISC-10":::* code, it will take a few seconds to get the response back. Fortunately, you won't have to deal with the retrying.

1. Run the following command to view the logging page URL. Select the **Centralized logging** link.

    ```bash
    cat ../deployment-urls.txt
    ```

1. Check the log traces. You'll see a variation of the following output:

    :::image type="content" source="../media/5-implement-polly-resiliency/configure-and-retry-logs.png" alt-text="log traces" border="true" lightbox="../media/5-implement-polly-resiliency/configure-and-retry-logs.png":::

    In the preceding image, you can see:

    - The log traces when configuring the simulated failures (#1) and
    - Three retries until the aggregator could finally get the value (#2).

### Circuit breaker

For this case, you'll configure the code for 20 failures, using *:::no-loc text="FAIL 20 DISC-10":::*:

:::image type="content" source="../media/5-implement-polly-resiliency/configure-severe-failure.png" alt-text="configure a severe failure" border="true" lightbox="../media/5-implement-polly-resiliency/configure-severe-failure.png":::

Complete the following steps:

1. In the **HAVE A DISCOUNT CODE?** text box, enter the code *:::no-loc text="DISC-10":::* again and select **APPLY**.
1. Wait about 20 seconds to get the HTTP 500 error message. When you do, select **APPLY** again.
1. After the second failure, select **APPLY** for the third time.

    On the third try, notice that the HTTP 500 error message came in much faster. That's because the circuit breaker was activated.

1. Select **APPLY** once again.

    Notice that you receive the error message immediately. You'll see this error clearly in the log traces:

    :::image type="content" source="../media/5-implement-polly-resiliency/severe-failure-logs.png" alt-text="severe failures in log traces" border="true" lightbox="../media/5-implement-polly-resiliency/severe-failure-logs.png":::

    In the preceding image, notice that:

    - After waiting for 7.6 seconds (#1), you get the HTTP 500 error message with the retry policy (#2) but
    - The next time you try, you validate the code, you get the HTTP 500 error message after waiting only 3.4 seconds (#3) and you don't see the "Get coupon..." trace, meaning it failed without going to the server.
    - If you check the details on this last trace, you should see a variation of the following output:

        :::image type="content" source="../media/5-implement-polly-resiliency/severe-failure-log-detail.png" alt-text="severe failure log detail" border="true" lightbox="../media/5-implement-polly-resiliency/severe-failure-log-detail.png":::

        Notice that the last trace has the "The circuit is now open..." message.

Let's move on to the deployment of Linkerd in the next unit.
