In this exercise, you'll implement a feature flag to toggle the checkout page's discount coupon feature in real time. Feature flags allow you to toggle feature availability declaratively without including `if` statements in your code.

You'll use a .NET Standard feature flag library named *Feature Management*. This library provides helpers to implement feature flags in your app. The library supports simple use cases like conditional statements to more advanced scenarios like conditionally adding routes or action filters. Additionally, it supports feature filters, which allow you to enable features based on specific parameters. Examples of such parameters include a window time, percentages, or a subset of users.

In this unit, you will:

* Confirm the app's deployment to AKS.
* Set up feature management support with a .NET library.
* Make the discount coupon feature configurable.
* Deploy the *:::no-loc text="WebSPA":::* app to your AKS cluster.
* Disable the discount coupon feature.

> [!NOTE]
> If your Cloud Shell session disconnects due to inactivity, reconnect and run the following command to return to this directory and open the Cloud Shell editor:
>
> ```bash
> cd ~/clouddrive/aspnet-learn/src/ && \
>   code .
> ```

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

    > [!NOTE]
    > While the app is starting up, you might initially receive an HTTP 503 response from the server. Retry after a few seconds. The Seq logs, which are viewable at the **:::no-loc text="Centralized logging":::** URL, are available before the other endpoints.

1. After all the services are healthy, select the **:::no-loc text="Web SPA application":::** link in the command shell to test the *:::no-loc text="eShopOnContainers":::* web app. The following page appears:

    :::image type="content" source="../../media/microservices/eshop-spa.png" alt-text="Screenshot of the WebSPA application's products catalog page." border="true" lightbox="../../media/microservices/eshop-spa.png":::

1. Navigate to the checkout page as follows:
    1. Select the **:::no-loc text="LOGIN":::** link in the upper right to sign into the app. Sign in using the credentials provided on the page.
    1. Add the **:::no-loc text=".NET BLUE HOODIE":::** to the shopping bag by selecting the image.
    1. Select the shopping bag icon in the upper right.
    1. Select the **:::no-loc text="CHECKOUT":::** button.

1. Scroll to the bottom of the checkout page. Notice the presence of a discount coupon feature, formed by the following UI elements:
    * **:::no-loc text="See Available Coupons":::** link
    * **:::no-loc text="Coupon number":::** text box
    * **:::no-loc text="APPLY":::** button

    :::image type="content" source="../../microservices-configuration-aspnet-core/media/4-implement-feature-manager/discount-coupon-elements.png" alt-text="Screenshot of the UI elements that make up the discount coupon feature." border="true" lightbox="../../microservices-configuration-aspnet-core/media/4-implement-feature-manager/discount-coupon-elements.png":::

You've successfully verified the app was deployed to AKS. Additionally, you've seen the discount coupon feature that you're going to make configurable.

## Set up the Feature Management library

Complete the following steps to support toggling of the SPA's discount coupon feature in real time:

1. Run the following command in the command shell:

    ```dotnetcli
    pushd src/Web/WebSPA && \
        dotnet add package Microsoft.FeatureManagement.AspNetCore --version 2.2.0 && \
        popd
    ```

    The preceding command installs the NuGet package required to use the Feature Management library with ASP.NET Core. The library retrieves feature flags using .NET Core's native configuration system. You can define your app's feature flags by using any configuration provider that .NET Core supports. In this case, you'll define the configuration in the :::no-loc text="ConfigMap"::: file of the SPA's Helm chart. The library also provides a `<feature>` Tag Helper that can be registered and used in Razor views.

1. In the *:::no-loc text="deploy/k8s/helm-simple/webspa/templates/configmap.yaml":::* file, uncomment the `UseFeatureManagement` and `FeatureManagement__Coupons` lines. Save your changes.

    After the change, your file will resemble the following YAML snippet:

    :::code language="yaml" source="../code/deploy/k8s/helm-simple/webspa/templates/configmap.yaml" highlight="25-26":::

    The preceding change defines two environment variables, named `UseFeatureManagement` and `FeatureManagement__Coupons`, for the *:::no-loc text="WebSPA":::* environment in Kubernetes. The environment variables are read by the *:::no-loc text="WebSPA":::* app at runtime. If defined in *:::no-loc text="WebSPA":::*'s *:::no-loc text="appsettings.json":::* file, the environment variables override the following properties:

    ```json
    "UseFeatureManagement": true,
    "FeatureManagement": {
      "Coupons": true
    },
    ```

    Keeping the configuration in the *:::no-loc text="configmap.yaml":::* template enables clearer separation of configuration and code.

1. In the *:::no-loc text="src/Web/WebSPA/Startup.cs":::* file, apply the following changes:
    1. In the `ConfigureServices` method, replace the comment `// Add the AddFeatureManagement code` with the following code:

        ```csharp
        if (Configuration.GetValue<bool>("UseFeatureManagement"))
        {
            services.AddFeatureManagement();
        }
        ```

        The preceding code enables the Feature Management services to read the state of features in the `FeatureManagement` configuration section. `Coupons` is the feature in this case.

    1. Uncomment the `//using Microsoft.FeatureManagement;` line at the top of the file.

        The preceding code resolves the call to `AddFeatureManagement`.

        As mentioned before, for the SPA to query the coupon's feature state, you need to expose an endpoint. That endpoint is exposed in the next step.

    1. In the `Configure` method, replace the comment `// Add the MapFeatureManagement code` with the following code. Save your changes.

        ```csharp
        if (Configuration.GetValue<bool>("UseFeatureManagement"))
        {
            endpoints.MapFeatureManagement();
        }
        ```

        `MapFeatureManagement` is a custom extension method that's provided for you in *:::no-loc text="src/Web/WebSPA/Extensions/EndpointRouteBuilderExtensions.cs":::*. It defines an endpoint at `/features` that responds to HTTP GET requests from the client-side code. Those requests are delegated to a custom middleware class named `FeatureManagementMiddleware`.

        :::code language="csharp" source="../code/src/web/webspa/extensions/endpointroutebuilderextensions.cs" id="snippet_MapFeatureManagement":::

## Use the feature flag in an Angular view

To add the `featureFlag` directive to the Angular views, run the following script:

```bash
deploy/implement-directive.sh
```

The preceding script uses the Linux `sed` command to modify two Angular views. The `*featureFlag="'coupons'"` attribute is added to the subtotal and discount code `div` elements in the *:::no-loc text="src/Web/WebSPA/Client/src/modules/orders":::* directory's *:::no-loc text="orders-detail/orders-detail.component.html":::* and *:::no-loc text="orders-new/orders-new.component.html":::* files. The relevant portions of *:::no-loc text="orders-detail.component.html":::* are highlighted below.

:::code language="html" source="../code/src/web/webspa/client/src/modules/orders/orders-detail/orders-detail-component.html" highlight="1,6":::

> [!NOTE]
> The implementation of Angular-specific functionality in this module has been scripted to maintain focus on .NET details.

## Use the feature flag in a Razor view

When selected, the **:::no-loc text="See Available Coupons":::** link renders an ASP.NET Core MVC view. The view displays coupon codes that haven't yet been consumed.

Apply the following changes to the file *:::no-loc text="src/Web/WebSPA/Views/CouponStatus/Index.cshtml":::*:

1. Replace the `@* Add the addTagHelper directive *@` comment with the following code:

    ```cshtml
    @addTagHelper *, Microsoft.FeatureManagement.AspNetCore
    ```

    The preceding code makes the `Microsoft.FeatureManagement.AspNetCore` assembly's Tag Helpers available inside the view.

1. Replace the following ASP.NET Core `<partial>` Tag Helper:

    ```cshtml
    <partial name="_AvailableCoupons" model="allAvailableCoupons" />
    ```

    with the following markup:

    ```cshtml
    <feature name="Coupons" negate="true">
        <div class="feature-heading-text-display">You're not subscribed to this feature.</div>
    </feature>
    <feature name="Coupons">
        <partial name="_AvailableCoupons" model="allAvailableCoupons" />
    </feature>
    ```

The preceding markup applies conditional logic against the feature flag by using the Feature Management library's `<feature>` Tag Helper. The Tag Helper's `name` property represents the feature flag name&mdash;*Coupons* in this case. The `negate` property is used to display alternate content when the *Coupons* feature flag is disabled. When the discount coupon feature is:

* Disabled, a **:::no-loc text="You're not subscribed to this feature.":::** message displays.
* Enabled, a list of coupon codes that haven't been redeemed displays.

## Deploy the updated app to AKS

1. To deploy the updated *:::no-loc text="WebSPA":::* app, build and publish a new image to ACR with the following script:

    ```bash
    deploy/k8s/build-to-acr.sh --services webspa
    ```

    The script starts an [ACR quick task](/azure/container-registry/container-registry-tasks-overview#quick-task) for the *:::no-loc text="WebSPA":::* app. A variation of the following line confirms the Docker image was pushed to ACR:

    ```console
    2020/10/26 21:57:23 Successfully pushed image: eshoplearn20201026212601002.azurecr.io/webspa:linux-latest
    ```

    > [!IMPORTANT]
    > The *:::no-loc text="WebSPA":::* project is built in ACR, rather than local to Cloud Shell, to take advantage of robust build hosts in ACR. If the ACR quick task fails, inspect the output for troubleshooting information. Run the above script again to attempt additional builds.

1. Run the following script to deploy the updated *:::no-loc text="WebSPA":::* app to AKS:

    ```bash
    deploy/k8s/deploy-application.sh --charts webspa
    ```

    The preceding script uses Helm to deploy the *:::no-loc text="WebSPA":::* Docker image from your ACR instance to AKS. The script runs the `kubectl get pods` command, whose output contains entries for the SPA's pods. The `STATUS` and `AGE` column values indicate that the deployments were successful:

    ```console
    NAME                              READY   STATUS              RESTARTS   AGE
    webspa-64786f994f-5fz7m           0/1     Terminating         0          22m
    webspa-84fb8f987-df8hk            0/1     ContainerCreating   0          1s
    ```

1. After a few seconds, test the configuration change as follows:
    1. In the browser tab containing the *:::no-loc text="WebSPA":::* app, refresh the page. Sign out and back in, if needed.

        :::image type="content" source="../media/4-implement-feature-manager/webspa-log-out.png" alt-text="Screenshot of the sign out option from a menu in the WebSPA app." border="true" lightbox="../media/4-implement-feature-manager/webspa-log-out.png":::

    1. Select the shopping bag icon in the upper right.
    1. Select the **:::no-loc text="CHECKOUT":::** button.
    1. Notice the discount coupon elements are still present.

1. Verify the middleware is functioning as intended as follows:
    1. In another browser tab, navigate to `<your app's IP address>/features?featureName=coupons`:

        :::image type="content" source="../media/4-implement-feature-manager/feature-middleware-response.png" alt-text="Screenshot of the JSON response from the custom middleware." border="true" lightbox="../media/4-implement-feature-manager/feature-middleware-response.png":::

    1. Notice the JSON data indicates the discount coupon feature is enabled.

## Disable the discount coupon feature

Complete the following steps to disable the discount coupon feature:

1. In the *:::no-loc text="deploy\/k8s\/helm-simple\/webspa\/templates\/configmap.yaml":::* file, set the `FeatureManagement__Coupons` environment variable to `"False"`. Save your changes.

    The `FeatureManagement__Coupons` line will now resemble the following YAML:

    ```yaml
    FeatureManagement__Coupons: "False"
    ```

1. Redeploy the app to apply the configuration change:

    ```bash
    deploy/k8s/deploy-application.sh --charts webspa
    ```

1. Refresh the browser tab displaying the `/features` endpoint. Notice the value of the discount coupon feature's `enabled` property is now `false`.

1. After a few seconds, test the configuration change as follows:
    1. In the browser tab containing the *:::no-loc text="WebSPA":::* app, refresh the page. Sign out and back in, if needed.
    1. Select the shopping bag icon.
    1. Select the **:::no-loc text="CHECKOUT":::** button.
    1. Notice the discount coupon elements are no longer present.

In this unit, you made the discount coupon feature configurable and deployed the updated app. Next, you'll modify the app to use values stored in Azure App Configuration.
