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
1. Notice the **:::no-loc text="HAVE A DISCOUNT CODE?":::** field isn't present. This is expected because the coupons feature is disabled.
