In this unit, you will:

* Create an App Configuration store in your Azure account.
* Connect *eShopOnContainers* to the App Configuration store.

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

    Endpoint=https://eshoplearn20201026204439872.azconfig.io;Id=<id>;Secret=<secret>
    ```

    In the preceding output, the string prefixed with "Endpoint=" represents the App Configuration store's connection string.

1. Copy the connection string. You'll use it in a moment.

## Connect your app to App Configuration

In the *deploy\k8s\helm-simple\webspa\templates\configmap.yaml* file, uncomment the `AppConfig__Endpoint` line. Replace the `<connection-string>` placeholder with the connection string on your clipboard. Save your changes.

The `AppConfig__Endpoint` line will resemble the following YAML:

<!--TODO: should we store this connection string in Key Vault instead?-->

```yaml
AppConfig__Endpoint: "Endpoint=https://eshoplearn20200630195254680.azconfig.io;Id=<id>;Secret=<secret>"
```

## Add the feature flag for Coupons

1. In another tab, sign into the [Azure portal](https://portal.azure.com?azure-portal=true) with the same account and directory as the Cloud Shell.
1. Use the search box to find and open the App Configuration resource prefixed with *:::no-loc text="eshoplearn":::*.
1. In the **Operations** section, select **Feature manager** > **Add**.
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

1. In the `CreateHostBuilder` method of *src/Web/WebSPA/Program.cs*, replace the comment `// Add the AddAzureAppConfiguration code` with the following code. Save your changes.

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

    * The `ConfigureAppConfiguration` method is called to register the configuration provider for App Configuration.
    * The `Connect` method provides a connection string to the App Configuration store. Recall that the connection string is stored in *deploy\k8s\helm-simple\webspa\templates\configmap.yaml* as an environment variable with the key `AppConfig__Endpoint`. The environment variables configuration provider replaces the double underscore (`__`) with a colon (`:`).
    * The `UseFeatureFlags` method defines a cache expiration policy of five seconds for the feature flags. The default value is 30 seconds. Once five seconds have elapsed, the cache is refreshed with updated feature flag values.
    * The `ConfigureRefresh` method defines a cache expiration policy of five seconds for the `FeatureManagement:Coupons` key in the App Configuration store. The default value is 30 seconds. Once five seconds have elapsed, the cache is refreshed with an updated value for the `FeatureManagement:Coupons` key.

1. Apply the following changes in *src/Web/WebSPA/Startup.cs*:
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

## Redeploy the app

Redeploy the SPA to confirm that it works as intended.

1. Just as you did before, begin by building the `webspa` service with the following script:

    ```bash
    deploy/k8s/build-to-acr.sh --services webspa
    ```

1. Run the following script to deploy to AKS:

    ```bash
    deploy/k8s/deploy-application.sh --charts webspa
    ```

## Test the feature flag

To verify the feature flag works as expected, start a purchase as follows:

1. In the app, refresh the page. The SPA reloads.
1. Select the shopping bag icon in the upper right.
1. Select the **:::no-loc text="CHECKOUT":::** button.
1. Notice the **:::no-loc text="HAVE A DISCOUNT CODE?":::** field is present because the coupons feature is enabled in the Azure portal.
1. In the Azure portal, clear the Coupons feature's **Enabled** check box.
1. Wait a few seconds. In the app, refresh the page. The WebSPA reloads.
1. Select the shopping bag icon in the upper right.
1. Select the **:::no-loc text="CHECKOUT":::** button.
1. Notice the **:::no-loc text="HAVE A DISCOUNT CODE?":::** field isn't present.
