The Feature Management library has been installed and configured. Now it's time to implement a cloud-hosted, centralized configuration store in which the feature flag will be stored. For that job, Azure App Configuration will be used. You can then toggle the discount coupon feature on or off without the need to redeploy the *:::no-loc text="WebSPA":::* app.

In this unit, you will:

* Create an App Configuration instance in your Azure subscription.
* Store the App Configuration service connection string.
* Add a feature flag to the App Configuration store.
* Connect the *:::no-loc text="WebSPA":::* app to the App Configuration store.
* Redeploy the *:::no-loc text="WebSPA":::* app to AKS.
* Test the newly created feature flag.

## Provision an App Configuration instance

Complete the following steps to create an App Configuration instance in your Azure subscription:

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

    Endpoint=https://eshoplearn20201026204439872.azconfig.io;Id=<id>;Secret=<secret>
    ```

    In the preceding output, the string prefixed with `Endpoint=` represents the App Configuration store's connection string.

1. Copy the connection string. You'll use it in a moment.

## Store the App Configuration connection string

In the *:::no-loc text="deploy/k8s/helm-simple/webspa/templates/configmap.yaml":::* file, uncomment the `AppConfig__Endpoint` line. Replace the `<connection-string>` placeholder with the connection string on your clipboard. Save your changes.

The `AppConfig__Endpoint` line will resemble the following YAML:

```yaml
AppConfig__Endpoint: "Endpoint=https://eshoplearn20200630195254680.azconfig.io;Id=<id>;Secret=<secret>"
```

The preceding line represents a key-value pair, in which `AppConfig__Endpoint` is an environment variable name. In the *:::no-loc text="WebSPA":::* project, the environment variables configuration provider will read its value.

> [!TIP]
> Your Azure App Configuration connection string contains a plain-text secret. In real world apps, consider integrating App Configuration with Azure Key Vault for secure storage of secrets. Key Vault is out of scope for this module, but guidance can be found at [Tutorial: Use Key Vault references in an ASP.NET Core app](/azure/azure-app-configuration/use-key-vault-references-dotnet-core).

## Add the feature flag to the App Configuration store

In Azure App Configuration, create and enable a key-value pair to be treated as a feature flag. Complete the following steps:

1. In another browser tab, sign into the [Azure portal](https://portal.azure.com?azure-portal=true) with the same account and directory as the Cloud Shell.
1. Use the search box to find and open the App Configuration resource prefixed with *:::no-loc text="eshoplearn":::*.

    :::image type="content" source="../media/5-implement-app-configuration/app-configuration-resource.png" alt-text="Screenshot of Azure portal search results showing the App Configuration resource prefixed with 'eshoplearn'." border="true" lightbox="../media/5-implement-app-configuration/app-configuration-resource.png":::

1. In the **Operations** section, select **Feature manager** > **Add**.
1. Select the **Enable feature flag** check box, enter *Coupons* in the **Feature flag name** text box, and select the **Apply** button.

Now that the feature flag exists in the App Configuration store, the *:::no-loc text="WebSPA":::* project requires some changes to read it.

## Connect your app to the App Configuration store

To access values from the App Configuration store in an ASP.NET Core app, the configuration provider for App Configuration is needed. A key in the App Configuration store overrides the same key in the :::no-loc text="ConfigMap":::. That's because the :::no-loc text="ConfigMap":::'s `data` field is read by the environment variables provider. Recall that the environment variables provider was registered earlier than the App Configuration provider.

Apply the following changes to your *:::no-loc text="WebSPA":::* project:

1. Run the following command to install a NuGet package containing the .NET Core configuration provider for the App Configuration service:

    ```dotnetcli
    pushd src/Web/WebSPA && \
        dotnet add package Microsoft.Azure.AppConfiguration.AspNetCore --version 4.0.0 && \
        popd
    ```

1. In the `CreateHostBuilder` method of *:::no-loc text="src/Web/WebSPA/Program.cs":::*, replace the comment `// Add the AddAzureAppConfiguration code` with the following code. Save your changes.

    ```csharp
    .ConfigureAppConfiguration((_, configBuilder) =>
    {
        var settings = configBuilder.Build();

        if (settings.GetValue<bool>("UseFeatureManagement") &&
            !string.IsNullOrEmpty(settings["AppConfig:Endpoint"]))
        {
            configBuilder.AddAzureAppConfiguration(options =>
            {
                var cacheTime = TimeSpan.FromSeconds(5);

                options.Connect(settings["AppConfig:Endpoint"])
                    .UseFeatureFlags(flagOptions =>
                    {
                        flagOptions.CacheExpirationInterval = cacheTime;
                    })
                    .ConfigureRefresh(refreshOptions =>
                    {
                        refreshOptions.Register("FeatureManagement:Coupons", refreshAll: true)
                                      .SetCacheExpiration(cacheTime);
                    });
            });
        }
    })
    ```

    In the preceding code snippet:

    * The `Connect` method authenticates to the App Configuration store. Recall that the connection string is stored in *:::no-loc text="deploy/k8s/helm-simple/webspa/templates/configmap.yaml":::* as an environment variable with the key `AppConfig__Endpoint`. The environment variables configuration provider replaces the double underscore (`__`) with a colon (`:`).
    * The `UseFeatureFlags` method defines a cache expiration policy of five seconds for the feature flags. The default value is 30 seconds. Once five seconds have elapsed, the cache is refreshed with updated feature flag values.
    * The `ConfigureRefresh` method defines a cache expiration policy of five seconds for the `FeatureManagement:Coupons` key in the App Configuration store. The default value is 30 seconds. Once five seconds have elapsed, the cache is refreshed with an updated value for the `FeatureManagement:Coupons` key.

1. Apply the following changes in *:::no-loc text="src/Web/WebSPA/Startup.cs":::*:
    1. In the `Configure` method, replace the comment `// Add the UseAzureAppConfiguration code` with the following code:

        ```csharp
        if (Configuration.GetValue<bool>("UseFeatureManagement"))
        {
            app.UseAzureAppConfiguration();
        }
        ```

        The preceding code adds the App Configuration middleware to the request pipeline. The middleware triggers a refresh operation for the Feature Management parameters for every incoming request. Then it's up to the `AzureAppConfiguration` provider to decide, based on the refresh settings configured in the previous step, when to actually connect to the store to get the values.

    1. In the `ConfigureServices` method, add a call to `AddAzureAppConfiguration` beneath the call to `AddFeatureManagement`. Save your changes.

        Your code will resemble the following snippet:

        :::code language="csharp" source="../code/src/web/webspa/startup.cs" id="snippet_ConfigureServices" highlight="6":::

## Redeploy the app to AKS

Redeploy the *:::no-loc text="WebSPA":::* app to confirm that it works as intended:

1. As you did before, begin by building the *:::no-loc text="WebSPA":::* app with the following script:

    ```bash
    deploy/k8s/build-to-acr.sh --services webspa
    ```

1. Run the following script to deploy the app to AKS:

    ```bash
    deploy/k8s/deploy-application.sh --charts webspa
    ```

## Test the feature flag

To verify the feature flag works as expected, start a purchase as follows:

1. In the browser tab containing the *:::no-loc text="WebSPA":::* app, refresh the page. Sign out and back in, if needed.
1. Select the shopping bag icon.
1. Select the **:::no-loc text="CHECKOUT":::** button.
1. Notice the discount coupon elements are present because the *coupons* feature is enabled in the Azure portal.
1. In the Azure portal, clear the *Coupons* feature's **Enabled** check box.
1. Refresh the browser tab displaying the `/features` endpoint. Notice the value of the *coupons* feature's `enabled` property is now `false`.
1. In the browser tab containing the *:::no-loc text="WebSPA":::* app, refresh the page. Sign out and back in, if needed.
1. Select the shopping bag icon.
1. Select the **:::no-loc text="CHECKOUT":::** button.
1. Notice the discount coupon elements aren't present.
