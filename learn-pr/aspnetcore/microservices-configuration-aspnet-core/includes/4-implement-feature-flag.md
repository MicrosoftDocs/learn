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

This is one of the key components of the feature flag system implemented here, as it allows you to query the specific feature flag values so they can be used in the SPA.

As a refresher, a middleware is just a handler for requests that sits in the ASP.NET Core's request pipeline. Think of it like a "light" controller that processes the raw `HttpContext` and returns a value by writing directly to the `Response` object. For more in-depth information, see the [ASP.NET Core Middleware](/aspnet/core/fundamentals/middleware/) document.

The Feature Management library is implemented to work on the server side. That's fine when using MVC or Razor Pages, but we need to use the configuration data in our SPA. So the directive mentioned in the previous section will query the `/features` endpoint, implemented as this middleware, to get the feature state. The middleware will just get the configuration values from the feature manager that, in turn, gets them from the ASP.NET Core configuration infrastructure.

You can think of this middleware as a proxy or broker between the SPA and the Feature Management service.

You can find the middleware in the file *src\Web\WebSPA\Infrastructure\Middlewares\FeatureManagementMiddleware.cs*.

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

### 1. Set up Feature Management

1. Add a reference to the `Microsoft.FeatureManagement` NuGet package to use the .NET Core feature manager.

    ```dotnetcli
    pushd src/Web/Web.SPA && \
        dotnet add package Microsoft.FeatureManagement --version 2.2.0 && \
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

1. Add the following values to the *deploy\k8s\helm-simple\webspa\templates\configmap.yaml* file:

    ```yaml
    UseFeatureManagement: "True"
    FeatureManagement__Coupons: "True"
    ```

1. Apply the following changes in the *Startup.cs* file:
    1. In the `ConfigureServices` method, replace the comment `// Add the AddFeatureManagement code` with the following code:

        ```csharp
        if (Configuration.UseFeatureManagement())
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
        if (Configuration.UseFeatureManagement())
        {
            endpoints.MapFeatureManagement(pattern: "features");
        }
        ```

### 2. Use the featureFlag directive in the views

Using the directive makes it clear and easy-to-use it in the views, as shown in the next HTML fragment:

File: *src\Web\WebSPA\Client\src\modules\orders\orders-new\orders-new.component.html*:

```html
<div class="container">
    .../...
    <form [formGroup]="newOrderForm" (ngSubmit)="submitForm(newOrderForm.value)">
        <section class="u-background-brightest p-5">
            <h2 class="mb-4">Shipping Address</h2>
            .../...
            <div *featureFlag="'coupons'" class="d-flex align-items-center justify-content-end mt-4 mb-4 text-uppercase">
                <div>Subtotal</div>
                <div class="ml-3">${{order.total | number:'.2-2'}}</div>
            </div>

            <div *featureFlag="'coupons'" class="d-flex flex-nowrap justify-content-between align-items-center mb-3 mt-3">
                <div>
                    .../...
                </div>
                .../...
            </div>
            .../...
        </section>
    </form>
</div>
```

In the preceding view fragment, you can easily identify the `div` elements with the `*featureFlag="'coupons'"` directive that will have them rendered or not depending on the `coupons` value.

Something similar occurs in the *src\Web\WebSPA\Client\src\modules\orders\orders-detail\orders-detail.component.html* file:

```html
<div class="esh-orders_detail">
    <div class="container">
        <h1 class="mb-4 mt-5">[ Order List Detail ]</h1>
        <div class="u-background-brightest p-5">
            .../...
            <div *featureFlag="'coupons'" class="d-flex align-items-center justify-content-end mt-4 mb-4 text-uppercase">
                <div>Subtotal</div>
                <div class="ml-3">${{order.subtotal | number:'.2-2'}}</div>
            </div>

            <div *featureFlag="'coupons'" class="d-flex align-items-center justify-content-end mt-4 mb-4 text-uppercase">
                <div>{{order.coupon}}</div>
                <div class="ml-3">- ${{order.discount | number:'.2-2'}}</div>
            </div>
            .../...
        </div>
    </div>
</div>
```

## Deploy the SPA to your AKS cluster

1. To deploy the updated SPA, build and publish a new image to ACR, with this script:

    ```bash
    ./build-to-acr.sh --services webspa
    ```

    The process will take a few minutes and it should begin with something like this:

    :::image type="content" source="../media/4-implement-feature-flag/build-to-acr.png" alt-text="Initial output from the build-to-acr script" border="true" lightbox="../media/4-implement-feature-flag/build-to-acr.png":::

    And should end with something like this:

    :::image type="content" source="../media/4-implement-feature-flag/build-to-acr-end.png" alt-text="Final output from the build-to-acr script, highlighting that the webspa image has been pushed" border="true" lightbox="../media/4-implement-feature-flag/build-to-acr-end.png":::

    And now you just need to deploy the updated chart to AKS.

1. Run the following command to set the environment variables set to the appropriate values:

    ```bash
    eval $(cat ~/clouddrive/source/create-acr-exports.txt)
    ```

1. And then run this script to deploy to AKS:

    ```bash
    ./deploy-application.sh --charts webspa
    ```

    After a few seconds, you should be able to use the app as usual. You won't see any difference now, because the coupon feature is configured as enabled by default.

1. Update the *deploy\k8s\helm-simple\webspa\templates\configmap.yaml* file to disable the coupons feature like this:

    ```yaml
    UseFeatureManagement: "True"
    FeatureManagement__Coupons: "False"
    ```

1. Redeploy the app again. There's no need to rebuild the image. Just run:

    ```bash
    ./deploy-application.sh --charts webspa
    ```

If you place an item in the basket and go to check out, you should now see something like this:

:::image type="content" source="../media/4-implement-feature-flag/hidden-discount-coupon.png" alt-text="TODO" border="true" lightbox="../media/4-implement-feature-flag/hidden-discount-coupon.png":::

You can see there's no discount coupon input box now. Even if you check with the browser's developer tools, you'll see that the div isn't even being rendered, so you're sure the feature flag is working as intended.

You can also query the features endpoint with `/features?featureName=coupons` to get the feature toggle value as a json, with the property `enabled` set to `false`, as shown in the next image:

:::image type="content" source="../media/4-implement-feature-flag/feature-flag-query.png" alt-text="JSON output from the /features endpoint, showing the coupons feature is not enabled" border="true" lightbox="../media/4-implement-feature-flag/feature-flag-query.png":::

## Create an App Configuration store instance

1. Run the following script to create an App Configuration store:

    ```bash
    ./create-app-config.sh
    ```

    You should get something like this:

    :::image type="content" source="../media/4-implement-feature-flag/create-app-configuration.png" alt-text="Output from the create-app-config script" border="true" lightbox="../media/4-implement-feature-flag/create-app-configuration.png":::

1. Copy the connection string. You'll use it in a moment.

## Connect your app to App Configuration

To connect your app to the new App Configuration store:

- Add the App Configuration connection string to the SPA ConfigMap.
- Add a sentinel key for the App Configuration.
- Add the feature flag for coupons.
- Connect your app to the App Configuration instance.

Let's get on with the details.

### 1. Add the App Configuration connection string to the ConfigMap

Add another line to the *deploy\k8s\helm-simple\webspa\templates\configmap.yaml* file to configure the App Configuration connection string as shown next:

```yaml
AppConfig__Endpoint: "Endpoint=https://eshoplearn20200630195254680.azconfig.io;Id=...;Secret=..."
```

### 2. Add a sentinel key for the App Configuration

This is a special key used to signal when configuration has changed. Your app monitors the sentinel key for changes to now when to refresh the values from the App Configuration store.

To create the sentinel key:

1. Browse to the resource group in the Azure portal.
1. Open the App Configuration previously created.
1. Select **Configuration Explorer** > **Create** > **Key-value**.
1. Enter the following values:
    - Key: `AppConfig:Sentinel`
    - Value: `1`

You should have something like this:

:::image type="content" source="../media/4-implement-feature-flag/create-app-configuration-sentinel-key.png" alt-text="Configuration explorer view for the process described above" border="true" lightbox="../media/4-implement-feature-flag/create-app-configuration-sentinel-key.png":::

### 3. Add the feature flag for Coupons

In a similar fashion, go to the **Feature manager** section. Add a new feature named *Coupons* and enable it. You should get something like the next image:

:::image type="content" source="../media/4-implement-feature-flag/appconfig-feature.png" alt-text="Feature manager view for the Coupons flag, with state changed to 'On'" border="true" lightbox="../media/4-implement-feature-flag/appconfig-feature.png":::

### 4. Connect your app to the App Configuration store

Apply the following changes to your ASP.NET Core project:

### 1. Install the configuration provider package for App Configuration

Run the following command from the *src/Web/WebSPA* directory:

```dotnetcli
dotnet add . package Microsoft.Azure.AppConfiguration.AspNetCore
```

The preceding command installs a NuGet package containing the .NET Core configuration provider for the App Configuration service.

### 2. Register App Configuration as a configuration provider

Update the *src/Web/WebSPA/Program.cs* file's `BuildWebHost` method to include the following highlighted code:

:::code language="csharp" source="../code/src/web/webspa/program.cs" highlight="8-22":::

The `ConfigureRefresh` method specifies the settings to update the configuration data with the App Configuration store when a refresh operation is triggered.

### 3. Add the Azure App Configuration middleware to the request pipeline

In the `Configure` method of *Startup.cs*, replace the comment `// Add the UseAzureAppConfiguration code` with the following code:

```csharp
if (Configuration.UseFeatureManagement())
{
    app.UseAzureAppConfiguration();
}
```

The App Configuration middleware triggers a refresh operation for the Feature Management parameters for every incoming request. Then it's up to the `AzureAppConfiguration` provider to decide, based on the refresh settings configured in the previous step, when to actually connect to the store to get the values.

## Redeploy the app

So all that's left for you to do is redeploy the SPA and check out if this works as intended.

Just as you did before, begin by building the `webspa` service with the following script:

```bash
./build-to-acr.sh --services webspa
```

When the build process finishes, run the following command to set some needed environment variables:

```bash
eval $(cat ~/clouddrive/source/create-acr-exports.txt)
```

And then run this script to deploy to AKS:

```bash
./deploy-application.sh --charts webspa
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
