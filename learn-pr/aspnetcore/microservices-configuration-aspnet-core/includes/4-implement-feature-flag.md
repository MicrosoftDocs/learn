In this exercise, you'll implement a feature flag to toggle the checkout page's discount coupon feature in real time. Feature flags allow you to toggle feature availability declaratively without including `if` statements in your code.

You'll use a feature flag library for ASP.NET Core named **Feature Management**. This library provides helpers to implement feature flags in your app such as controller actions, MVC views/filters, and so on. In addition, it supports Feature Filters, which allows you to enable features based on other parameters. Examples of such parameters may include a window time, percentages, or a subset of users.

In this exercise, you will:

* Make the discount coupon feature configurable.
* Deploy the SPA to your AKS cluster.
* Create an App Configuration store in your Azure account.
* Connect *eShopOnContainers* to the App Configuration store.

## Verify the deployment to AKS

Even though the app has been deployed, it might take a few minutes to come online. Verify that the app is deployed and online with the following steps:

1. Run the following command to display the various app URLs:

    ```bash
    cat ~/clouddrive/aspnet-learn/deployment-urls.txt
    ```

    A variation of the following output appears:

    ```console
    The eShop-Learn application has been deployed to "http://203.0.113.55" (IP: 203.0.113.55).

    You can begin exploring these services (when ready):
    - Centralized logging       : http://203.0.113.55/seq/#/events?autorefresh (See transient failures during startup)
    - General application status: http://203.0.113.55/webstatus/ (See overall service status)
    - Web SPA application       : http://203.0.113.55/
    ```

1. Select the **:::no-loc text="General application status":::** link in the command shell to view the *:::no-loc text="WebStatus":::* health checks dashboard. The resulting page displays the status of each microservice in the deployment. A green checkmark icon denotes a healthy service. The page refreshes automatically, every 10 seconds.

1. After all the services are healthy, select the **:::no-loc text="Web SPA application":::** link in the command shell to test the *:::no-loc text="eShopOnContainers":::* web app. The following page appears:

    :::image type="content" source="../../media/microservices/eshop-spa.png" alt-text="eShop single page app" border="true" lightbox="../../media/microservices/eshop-spa.png":::

1. Navigate to the checkout page as follows:
    1. Select the **:::no-loc text="LOGIN":::** link in the upper right to sign into the app. Sign in using the credentials provided on the page.
    1. Add the **:::no-loc text=".NET BLUE HOODIE":::** to the shopping bag by selecting the image.
    1. Select the shopping bag icon in the upper right.
    1. Select the **:::no-loc text="CHECKOUT":::** button.

1. Scroll to the bottom of the checkout page. Notice the presence of a discount coupon feature comprised of the following components:
    * **HAVE A DISCOUNT CODE?** label
    * **Coupon number** text box
    * **APPLY** button

You've successfully verified that the app was deployed to AKS. Additionally, you've seen that the discount coupon feature is enabled.

## Make the discount coupon feature configurable

Complete the following steps to support toggling of the SPA's discount coupon feature in real time.

### Set up Feature Management

1. Install the NuGet package required to use the feature manager library:

    ```dotnetcli
    pushd src/Web/WebSPA && \
        dotnet add package Microsoft.FeatureManagement --version 2.2.0 && \
        popd
    ```

    The library retrieves feature flags from the .NET Core's native configuration system. Therefore, you can define your app's feature flags by using any configuration provider that .NET Core supports. For example, the *appsettings.json* file or environment variables. In this case, you'll make the configuration in *appsettings.json* and in the SPA Helm chart's ConfigMap file.

1. In the *WebSPA* project's *appsettings.json* file, replace the `// Add the feature management properties` comment with the following. Save your changes.

    ```json
    "UseFeatureManagement": true,
    "FeatureManagement": {
      "Coupons": true
    },
    ```

    By convention, the feature manager retrieves feature flags from the `FeatureManagement` section of the configuration file. The `UseFeatureManagement` property is the feature flag. It isn't something imposed by the Feature Management library. The values above will become the default ones for the SPA.

1. In the *deploy\k8s\helm-simple\webspa\templates\configmap.yaml* file, uncomment the `UseFeatureManagement` and `FeatureManagement__Coupons` lines. Save your changes.

    After the change, your file will resemble the following YAML snippet:

    :::code language="yaml" source="../code/deploy/k8s/helm-simple/webspa/templates/configmap.yaml" highlight="25-26":::

1. Apply the following changes in the *Startup.cs* file:
    1. In the `ConfigureServices` method, replace the comment `// Add the AddFeatureManagement code` with the following code:

        ```csharp
        if (Configuration.GetValue<bool>("UseFeatureManagement"))
        {
            services.AddFeatureManagement();
        }
        ```

        The preceding code enables the Feature Management services to read the state of features in the `FeatureManagement` configuration section. `Coupons` in our case.

    1. Uncomment the `//using Microsoft.FeatureManagement;` line at the top of the file.

        The preceding code resolves the call to `AddFeatureManagement`.

        As mentioned before, for the SPA to query the coupon's feature state, you need to expose an endpoint.

    1. In the `Configure` method, replace the comment `// Add the MapFeatureManagement code` with the following code. Save your changes.

        ```csharp
        if (Configuration.GetValue<bool>("UseFeatureManagement"))
        {
            endpoints.MapFeatureManagement();
        }
        ```

        `MapFeatureManagement` is a custom extension method that's provided for you. It defines an endpoint at `features` that responds to HTTP GET requests. Those requests are delegated to a custom middleware class named `FeatureManagementMiddleware`.

        :::code language="csharp" source="../code/src/web/webspa/extensions/endpointroutebuilderextensions.cs" id="snippet_MapFeatureManagement":::

1. To add the `featureFlag` directive to the Angular views, run the following script:

    ```bash
    deploy/implement-directive.sh
    ```

    The preceding script uses the Linux `sed` command to modify two Angular views. The `*featureFlag="'coupons'"` attribute is added to the subtotal and discount code `div` elements in *orders-detail/orders-detail.component.html* and *orders-new/orders-new.component.html* in *~/clouddrive/aspnet-learn/src/src/Web/WebSPA/Client/src/modules/orders*. The relevant portions of *orders-detail.component.html* are highlighted below.

    :::code language="html" source="../code/src/web/webspa/client/src/modules/orders/orders-detail/orders-detail.component.html" highlight="1,6":::

    > [!NOTE]
    > The implementation of Angular-specific functionality in this module has been scripted to maintain focus on .NET details.

## Deploy the SPA to your AKS cluster

1. To deploy the updated SPA, build and publish a new image to ACR, with the following script:

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

    The preceding script uses Helm to deploy the WebSPA Docker image from your ACR instance to AKS. The script runs the `kubectl get pods` command, whose output contains entries for the SPA's pods. The `STATUS` and `AGE` column values indicate that the deployments were successful:

    ```console
    NAME                              READY   STATUS              RESTARTS   AGE
    webspa-64786f994f-5fz7m           0/1     Terminating         0          22m
    webspa-84fb8f987-df8hk            0/1     ContainerCreating   0          1s
    ```

1. Refresh the browser tab containing the *:::no-loc text="eShopOnContainers":::* app to force a reload of the SPA.
1. Start a purchase as follows:
    1. Select the **:::no-loc text="LOGIN":::** link in the upper right to sign into the app. Sign in using the credentials provided on the page.
    1. Add the **:::no-loc text=".NET BLUE HOODIE":::** to the shopping bag by selecting the image.
    1. Select the shopping bag icon in the upper right.
    1. Select the **:::no-loc text="CHECKOUT":::** button.

    Notice the presence of the **:::no-loc text="HAVE A DISCOUNT CODE?":::** field. This is expected because the coupons feature is enabled.

## Disable the feature

Complete the following steps to disable the coupons feature.

1. In the *deploy\k8s\helm-simple\webspa\templates\configmap.yaml* file, set `FeatureManagement__Coupons` to `"False"`. Save your changes.

    The `FeatureManagement__Coupons` line will resemble the following YAML:

    ```yaml
    FeatureManagement__Coupons: "False"
    ```

1. Redeploy the app to apply the configuration change:

    ```bash
    deploy/k8s/deploy-application.sh --charts webspa
    ```

1. After a few seconds, test the configuration change as follows:
    1. In the app, refresh the page. The SPA reloads.
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
    .ConfigureAppConfiguration((_, configBuilder) =>
    {
        var settings = configBuilder.Build();

        if (settings.GetValue<bool>("UseFeatureManagement") &&
            !string.IsNullOrEmpty(settings["AppConfig:Endpoint"]))
        {
            configBuilder.AddAzureAppConfiguration(options =>
                options.Connect(settings["AppConfig:Endpoint"])
                       .UseFeatureFlags());
        }
    })
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

You must redeploy the SPA before you can confirm that it works as intended.

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

    The preceding command executes `kubectl get pods`. The following excerpt confirms that the SPA's deployment was successful:

    ```console
    NAME                              READY   STATUS              RESTARTS   AGE
    webspa-777655c48d-kv982           0/1     Terminating         0          118m
    webspa-777655c48d-r9469           0/1     ContainerCreating   0          1s
    ```

## Test the feature flag

To verify the feature flag works as expected, start a purchase as follows:

1. In the app, refresh the page. The WebSPA reloads.
1. Select the shopping bag icon in the upper right.
1. Select the **:::no-loc text="CHECKOUT":::** button.

Notice the **:::no-loc text="HAVE A DISCOUNT CODE?":::** field isn't present. This is expected because the coupons feature is disabled.
