Now that Fabrikam has analyzed their application, they are now ready to start the refactoring process to actually move services out of their monolithic architecture into microservices. Let's modify the application to move the package processing service into a microservice.

## Refactor application

Before we deploy the updated application, let's take a look at how it was updated. The monolithic app has a service to process packages, *PackageProcessor.cs*. The Fabrikam team pulled this out into the microservice.

### Drone Delivery before

In PackageProcessor.cs there is a PackageProcessor class that does the call to the package processing natively in the monolithic app. 

```csharp
public class PackageProcessor : IPackageProcessor
    {
        public Task<PackageGen> CreatePackageAsync(PackageInfo packageInfo)
        {
            //Uses common data store e.g. SQL Azure tables
            Utility.DoWork(100);
            return Task.FromResult(new PackageGen { Id = packageInfo.PackageId });
        }
    }
```



### Drone Delivery after

In the after, the PackageProcessor has been changed to a PackageServiceCaller. It still implements the IPackageProcessor interface, but instead makes an HTTP call to the microservice. 

```csharp
public class PackageServiceCaller : IPackageProcessor
    {
        private readonly HttpClient httpClient;

        public static string FunctionCode { get; set; }

        public PackageServiceCaller(HttpClient httpClient)
        {
            this.httpClient = httpClient;
        }

        public async Task<PackageGen> CreatePackageAsync(PackageInfo packageInfo)
        {
            var result = await httpClient.PutAsJsonAsync($"{packageInfo.PackageId}?code={FunctionCode}", packageInfo);
            result.EnsureSuccessStatusCode();

            return new PackageGen { Id = packageInfo.PackageId };
        }
    }
```

The microservice will be deployed on an Azure Function and contains the following code.

```csharp
public static class PackageServiceFunction
    {
        [FunctionName("PackageServiceFunction")]
        public static Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Function, "put", Route = "packages/{id}")] HttpRequest req,
            string id, ILogger log)
        {
            log.LogInformation("C# HTTP trigger function processed a request.");

            //Uses common data store e.g. SQL Azure tables
            Utility.DoWork(100);
            return Task.FromResult((IActionResult)new CreatedResult("http://example.com", null));
        }
    }
```

By putting this code on an Azure Function, this service can scale independently.

Now let's redeploy the application. We'll deploy our refactored service on Azure Functions first, then deploy the refactored application on App Service, and point it to the function.

## Deploy Azure Function

1. Run this command to set up environment variables pointed to our services.

    ```azurecli
    APPSERVICENAME="$(az webapp list \
                        --resource-group <rgn>[sandbox resource group]</rgn> \
                        --query '[].name' \
                        --output tsv)"
    FUNCTIONAPPNAME="$(az functionapp list \
                        --resource-group <rgn>[sandbox resource group]</rgn> \
                        --query '[].name' \
                        --output tsv)"
    ```

1. Let's build and zip up the application code for the function.

    ```bash
    cd ~/mslearn-microservices-architecture/src/after
    dotnet build ./PackageService/PackageService.csproj -c Release
    cd PackageService/bin/Release/netcoreapp2.2
    zip -r PackageService.zip .
    ```

1. Run this command to push the code to the Azure Function.

    ```azurecli
    az functionapp deployment source config-zip \
        --resource-group <rgn>[sandbox resource group]</rgn> \
        --name $FUNCTIONAPPNAME 
        --src PackageService.zip
    ```

## Deploy the updated DroneDelivery application

Now that our service is running on an Azure Function, we need to point our drone application to that function.

1. We first need to get the access code for the function, so we can successfully call it from the application. Run the following commands to retrieve this code. You'll display the function app name and code, for use in the next steps.

    ```azurecli
    RESOURCEGROUPID=$(az group show \
                        --resource-group <rgn>[sandbox resource group]</rgn> \
                        --query id \
                        --output tsv)
    FUNCTIONCODE=$(az rest \
                        --method post \
                        --query default \
                        --output tsv \
                        --uri "https://management.azure.com$RESOURCEGROUPID/providers/Microsoft.Web/sites/$FUNCTIONAPPNAME/functions/PackageServiceFunction/listKeys?api-version=2018-02-01")
    echo "FunctionName - $FUNCTIONAPPNAME"
    echo "FunctionCode - $FUNCTIONCODE"
    ```

1. In Cloud Shell run these commands to open *appsettings.json* in the Code editor.

    ```bash
    cd ~/mslearn-microservices-architecture
    code src/DroneDelivery-after/appsettings.json
    ```

1. In the Code editor, there are two values you need to replace; `PackageServiceUri` and `PackageServiceFunctionCode`. In `PackageServiceUri` replace `<FunctionName>` with the name of your function.

    In `PackageServiceFunctionCode` replace the `<FunctionCode>` with function code you just retrieved. Once complete, your *appsettings.json* file should look similar to this:

    ```json
    {
      "Logging": {
        "LogLevel": {
          "Default": "Warning"
        }
      },
      "AllowedHosts": "*",
      "PackageServiceUri": "https://packageservicefunction-abc.azurewebsites.net/api/packages/",
      "PackageServiceFunctionCode": "SvrbiyhjXJUdTPXrkcUtY6bQaUf7OXQjWvnM0Gq63hFUhbH2vn6qYA=="
    }
    ```

1. Press `Ctrl-s` to save the file, and `Ctrl-q` to close the Code editor.

1. Run this command to deploy the updated application to App Service.

    ```bash
    cd ~/mslearn-microservices-architecture/after
    zip -r DroneDelivery-after.zip . -x ./PackageService/\*
    az webapp deployment source config-zip \
        --resource-group <rgn>[sandbox resource group]</rgn> \
        --name $APPSERVICENAME \
        --src DroneDelivery-after.zip
    ```

## Test performance of new architecture

Now that we have moved the problematic service to an microservice running on an Azure Function, let's see how this impacted application performance.
