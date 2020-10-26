In this exercise, you'll implement a feature flag to enable or disable remotely the discount coupon feature in the checkout basket. You'll also be able to toggle the feature in real time.

Feature flags allow you to enable/disable features declaratively without having to write if statements explicitly in your code.

We'll use a feature flag library for ASP.NET Core named **Feature Management**. This library provides out-of-the-box helpers to implement feature flags in your application such as controller actions, MVC Views/Filters and so on. In addition, it supports Feature Filters, which allows you to enable features based on other parameters. Examples of such parameters may include a window time, percentages, or a subset of users.

In this exercise, you will:

- Review some "infrastructure" components for feature flags.
- Make the discount coupon feature configurable.
- Deploy the SPA to your AKS cluster.
- Create an App Configuration store in your Azure account.
- Wire up *eShopOnContainers* to the App Configuration store.

## Review some "infrastructure" feature flag components

To make a feature configurable, you have to make several changes to your app. Some "infrastructure" components have already been implemented for you, so we'll just review them here.

The key infrastructure components are:

- A feature flag directive for the views.
- Feature flag middleware for querying feature values.
- Configuration extensions.

In for the details now.

### 1. Feature flag directive for the views

This is implemented with three new files in the *src\Web\WebSPA\Client\src\modules\shared* directory:

- *directives\featureFlag.directive.ts*
- *models\featureFlag.model.ts*
- *services\featureFlag.service.ts*

The feature flag directive is used in any `div` element to determine whether it should be rendered, depending on the result from the feature flag service. The feature flag service queries the feature management middleware to check the feature status.

### 2. Feature Management middleware for querying values

A custom middleware, found at *src\Web\WebSPA\Infrastructure\Middlewares\FeatureManagementMiddleware.cs*, is a key component of the SPA's feature flag system. The middleware allows you to query the specific feature flag values so they can be used in the SPA:

:::code language="csharp" source="../code/src/web/webspa/infrastructure/middlewares/featuremanagementmiddleware.cs" id="snippet_Invoke" highlight="8":::

As a refresher, a middleware is just a handler for requests that sits in the ASP.NET Core's request pipeline. Think of it like a "light" controller that processes the raw `HttpContext` and returns a value by writing directly to the `Response` object. For more in-depth information, see the [ASP.NET Core Middleware](/aspnet/core/fundamentals/middleware/) document.

The Feature Management library is implemented to work on the server side. That's fine when using MVC or Razor Pages, but we need to use the configuration data in our SPA. So the directive mentioned in the previous section will query the `/features` endpoint, implemented as this middleware, to get the feature state. The middleware will just get the configuration values from the feature manager that, in turn, gets them from the ASP.NET Core configuration infrastructure.

You can think of this middleware as a proxy or broker between the SPA and the Feature Management service. You can find the middleware in the file *src\Web\WebSPA\Infrastructure\Middlewares\FeatureManagementMiddleware.cs*.

### 3. Configuration extensions

The configuration extensions take care of:

- Checking whether the Feature Management is enabled, and
- Configuring the Feature Management middleware.

You'll find the extensions in the *src\Web\WebSPA\Extensions* directory.

## Make the discount coupon feature configurable

To accomplish this, we need to:

- Set up Feature Management in the app.
- Use the feature flag directive in the views.

So let's begin with the details.

### Set up Feature Management

1. Install the NuGet package required to use the ASP.NET Core feature manager:

    ```dotnetcli
    pushd src/Web/WebSPA && \
        dotnet add package Microsoft.FeatureManagement.AspNetCore --version 2.2.0 && \
        popd
    ```

    The library gets feature flags from the framework's native configuration system. Therefore, you can define your app's feature flags by using any configuration provider that .NET Core supports. For example, the *appsettings.json* file or environment variables. In this case, we'll make the configuration in the *appsettings.json* and in the SPA Helm chart's ConfigMap file.

1. In the *WebSPA* project's *appsettings.json* file, replace the `// Add the feature management properties` comment with the following. Save your changes.

    ```json
    "UseFeatureManagement": true,
    "FeatureManagement": {
      "Coupons": true
    },
    ```

    By default, the feature manager retrieves feature flags from the `FeatureManagement` section of the configuration data. We'll also add another parameter named `UseFeatureManagement`.

    The `UseFeatureManagement` property will be our main feature toggle. It isn't something imposed by the Feature Management library. The values above will become the default ones for the SPA.

1. In the *deploy\k8s\helm-simple\webspa\templates\configmap.yaml* file, uncomment the following lines. Save your changes.

    After the change, your file will resemble the following YAML snippet:

    :::code language="yml" source="../deploy/k8s/helm-simple/webspa/templates/configmap.yaml" highlight="25-26":::

1. Apply the following changes in the *Startup.cs* file:
    1. In the `ConfigureServices` method, replace the comment `// Add the AddFeatureManagement code` with the following code:

        ```csharp
        if (Configuration.GetValue<bool>("UseFeatureManagement"))
        {
            services.AddFeatureManagement();
        }
        ```

        The preceding code enables the Feature Management services to read the state of features in the `FeatureManagement` configuration section. *Coupons* in our case.

    1. Uncomment the `//using Microsoft.FeatureManagement;` line at the top of the file. Save your changes.

        The preceding code resolves the call to `AddFeatureManagement`.

        As mentioned before, for the SPA to query the coupon's feature state, you need to expose an endpoint.

    1. In the `Configure` method, replace the comment `// Add the MapFeatureManagement code` with the following code:

        ```csharp
        if (Configuration.GetValue<bool>("UseFeatureManagement"))
        {
            endpoints.MapFeatureManagement(pattern: "features");
        }
        ```

1. To add the `featureFlag` directive to the views, run the following script:

    ```bash
    deploy/k8s/implement-directive.sh
    ```

    The preceding script uses the Linux `sed` command to modify two Angular views. The `*featureFlag="'coupons'"` attribute is added to the subtotal and discount code `div` elements in *orders-detail.component.html* and *orders-new.component.html* in *~/clouddrive/aspnet-learn/src/src/Web/WebSPA/Client/src/modules/orders*. The relevant portions of *orders-new.component.html* are highlighted below.

    :::code language="html" source="../code/src/web/webspa/client/src/modules/orders/orders-new/orders-new.component.html" highlight="1,6":::

    > [!NOTE]
    > The implementation of Angular-specific functionality in this module has been scripted to maintain focus on .NET details.

## Deploy the SPA to your AKS cluster

1. To deploy the updated SPA, build and publish a new image to ACR, with this script:

    ```bash
    deploy/k8s/build-to-acr.sh --services webspa
    ```

    The script starts an [ACR quick task](/azure/container-registry/container-registry-tasks-overview#quick-task) for the WebSPA service. A variation of the following line confirms that the WebSPA Docker image was pushed to ACR:

    ```console
    2020/10/26 21:57:23 Successfully pushed image: eshoplearn20201026212601002.azurecr.io/webspa:linux-latest
    ```

1. Run the following script to deploy the updated WebSPA to AKS:

    ```bash
    deploy/k8s/deploy-application.sh --charts webspa
    ```

    The preceding script uses Helm to deploy the WebSPA Docker image from your ACR instance to AKS.

1. Start a purchase as follows:
    1. Select the **:::no-loc text="LOGIN":::** link in the upper right to sign into the app. Sign in using the credentials provided on the page.
    1. Add the **:::no-loc text=".NET BLUE HOODIE":::** to the shopping bag by selecting the image.
    1. Select the shopping bag icon in the upper right.
    1. Select the **:::no-loc text="CHECKOUT":::** button.

    Notice the presence of the **:::no-loc text="HAVE A DISCOUNT CODE?":::** field. This is expected because the coupons feature is enabled.

1. Update the *deploy\k8s\helm-simple\webspa\templates\configmap.yaml* file to disable the coupons feature. Save your changes.

    The `FeatureManagement__Coupons` line will resemble the following YAML:

    ```yaml
    FeatureManagement__Coupons: "False"
    ```

1. Redeploy the app to apply the configuration change:

    ```bash
    deploy/k8s/deploy-application.sh --charts webspa
    ```

1. After a few seconds, test the configuration change as follows:
    1. In the app, refresh the page. The WebSPA reloads.
    1. Select the shopping bag icon in the upper right.
    1. Select the **:::no-loc text="CHECKOUT":::** button.

    Notice the **:::no-loc text="HAVE A DISCOUNT CODE?":::** field is no longer present.

## Create an App Configuration store instance

1. Run the following script to create an App Configuration store:

    ```bash
    deploy/k8s/create-app-config.sh
    ```

    A variation of the following output appears:

    ```console
    Creating App Configuration eshoplearn20201026204439872 in resource group eshop-learn-rg...


     > az appconfig create --resource-group eshop-learn-rg --name eshoplearn20201026204439872 --location westus --sku Standard --output none

    Done!

    Retrieving App Configuration connection string...


     > az appconfig credential list  --resource-group eshop-learn-rg --name eshoplearn20201026204439872 --query [0].connectionString --output tsv

    Endpoint=https://eshoplearn20201026204439872.azconfig.io;Id=4oTq-l1-s0:bweLwBPttsvIttKnuQDm;Secret=Q8ab+HY65YEgqSTBv6wiCVeoW/G0IwZ9jlEUxYC78Pc=
    ```

    In the preceding output, the string prefixed with "Endpoint=" represents the App Configuration store's connection string.

1. Copy the connection string. You'll use it in a moment.

## Connect your app to App Configuration

In the *deploy\k8s\helm-simple\webspa\templates\configmap.yaml* file, uncomment the `AppConfig__Endpoint` line. Replace the `<connection-string>` placeholder with the connection string on your clipboard. Save your changes.

The `AppConfig__Endpoint` line will resemble the following YAML:

<!--TODO: should we store this connection string in Key Vault instead?-->

```yaml
AppConfig__Endpoint: "Endpoint=https://eshoplearn20200630195254680.azconfig.io;Id=...;Secret=..."
```

## Add a sentinel key for the App Configuration

This is a special key used to signal when configuration has changed. Your app monitors the sentinel key for changes to know when to refresh the values from the App Configuration store.

To create the sentinel key:

1. Use the Azure portal's search box to find and open the App Configuration resource prefixed with *:::no-loc text="eshoplearn":::*.
1. Select **Configuration explorer** > **Create** > **Key-value**.
1. Enter the following values:
    - Key: `AppConfig:Sentinel`
    - Value: `1`

    You should have something like this:

    :::image type="content" source="../media/4-implement-feature-flag/create-app-configuration-sentinel-key.png" alt-text="Configuration explorer view for the process described above" border="true" lightbox="../media/4-implement-feature-flag/create-app-configuration-sentinel-key.png":::

1. Select the **Apply** button.

## Add the feature flag for Coupons

1. In a similar fashion, go to the **Feature manager** section and select **Add**.
1. Select the **Enable feature flag** check box, enter *Coupons* in the **Feature flag name** text box, and select the **Apply** button.

## Connect your app to the App Configuration store

Apply the following changes to your ASP.NET Core project:

1. Run the following command:

    ```dotnetcli
    pushd src/Web/WebSPA && \
        dotnet add package Microsoft.Azure.AppConfiguration.AspNetCore --version 4.0.0 && \
        popd
    ```

    The preceding command installs a NuGet package containing the .NET Core configuration provider for the App Configuration service.

1. In the `CreateHostBuilder` method of *src/Web/WebSPA/Program.cs*, replace the comment `// Add the AddAzureAppConfiguration code` with the following code:

    ```csharp
    var settings = configBuilder.Build();

    if (settings.GetValue<bool>("UseFeatureManagement") &&
        !string.IsNullOrEmpty(settings["AppConfig:Endpoint"]))
    {
        configBuilder.AddAzureAppConfiguration(options =>
        {
            options.Connect(settings["AppConfig:Endpoint"])
                .UseFeatureFlags()
                .ConfigureRefresh(refresh =>
                {
                    refresh.Register("AppConfig:Sentinel", refreshAll: true)
                        .SetCacheExpiration(new TimeSpan(0, 0, 10));
                });
        });
    }
    ```

    The `ConfigureRefresh` method specifies the settings to update the configuration data with the App Configuration store. These settings are used when a refresh operation is triggered.

1. In the `Configure` method of *src/Web/WebSPA/Startup.cs*, replace the comment `// Add the UseAzureAppConfiguration code` with the following code:

    ```csharp
    if (Configuration.GetValue<bool>("UseFeatureManagement"))
    {
        app.UseAzureAppConfiguration();
    }
    ```

    The preceding code adds the App Configuration middleware to the request pipeline. The middleware triggers a refresh operation for the Feature Management parameters for every incoming request. Then it's up to the `AzureAppConfiguration` provider to decide, based on the refresh settings configured in the previous step, when to actually connect to the store to get the values.

## Redeploy the app

So all that's left for you to do is redeploy the SPA and check out if this works as intended.

1. Just as you did before, begin by building the `webspa` service with the following script:

    ```bash
    deploy/k8s/build-to-acr.sh --services webspa
    ```

    The following excerpt from the command's output confirms that the image was pushed to ACR:

    ```console
    2020/10/26 23:26:50 Successfully pushed image: eshoplearn20201026204439872.azurecr.io/webspa:linux-latest
    ```

1. Run the following script to deploy to AKS:

    ```bash
    deploy/k8s/deploy-application.sh --charts webspa
    ```

    The preceding command executes `kubectl get pods`. The following excerpt confirms that the *WebSPA* app's container is starting:

    ```console
    NAME                              READY   STATUS              RESTARTS   AGE
    webspa-777655c48d-kv982           0/1     Terminating         0          118m
    webspa-777655c48d-r9469           0/1     ContainerCreating   0          1s
    ```

## Test the feature toggle

At this point, everything should be set. Complete the following steps:

1. Sign out of the SPA and refresh the browser, to ensure you get the latest version.
1. Sign in and buy some items. Go to checkout.
1. You should now see the discount coupon input, because the toggle was created as "On" in the portal.
1. Toggle the feature "Off" in the App Configuration store.
1. Go back to the SPA and select the basket icon in the top right.
1. Wait for 10 seconds (the refresh time set for the configuration provider).
1. Select the **CHECKOUT** button.
1. Now you shouldn't see the discount coupon input.

So this is finally what we wanted to get.
