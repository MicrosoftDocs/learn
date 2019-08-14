Now that Fabrikam has analyzed their application, they are now ready to start the refactoring process to actually move services out of their monolithic architecture into microservices. Let's modify the application to move the package processing service into a microservice.

## Refactor application

Before we deploy the updated application, let's take a look at how it was updated. The monolithic app has a service to process packages, *PackageProcessor.cs*. The Fabrikam team pulled this out into the microservice.

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

1. Run this command to set up git for our function.

    ```azurecli
    az functionapp deployment source config-local-git \
        --resource-group <rgn>[sandbox resource group]</rgn> \
        --name $FUNCTIONAPPNAME
    ```

1. Run this command to add a remote repo pointing to the function app. Replace `<deploymentuser>` with the deployment user you created earlier.

    ```bash
    git remote add azurefunction https://<deploymentuser>@$FUNCTIONAPPNAME.scm.azurewebsites.net/$FUNCTIONAPPNAME.git
    ```

1. Run this command to push the code to the Azure Function. Enter the password of the deployment user you created earlier.

    ```bash
    git push azurefunction master
    ```

## Deploy the updated DroneDelivery application

1. Now that our service is running on an Azure Function, we need to point our drone application to that function. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Select **App Services** on the left, then select your **packageservicefunction-abc** function.

1. In the **Function Apps** overview, select your **PackageServiceFunction** function.

    TODO - insert screenshot

1. Select **</> Get function URL**, copy the URL and it keep handy. You'll need it again shortly.

1. Back in Cloud Shell run these commands to open *appsettings.json* in the Code editor.

    ```bash
    cd ~/mslearn-microservices-architecture
    code src/DroneDelivery-after/appsettings.json
    ```

1. Now you need the URL that you copied a couple steps ago. The URL should look similar to this:

    `https://packageservicefunction-abc.azurewebsites.net/api/packages/{id}?code=SvrbiyhjXJUdTPXrkcUtY6bQaUf7OXQjWvnM0Gq63hFUhbH2vn6qYA==`

    In the Code editor, there are two values you need to replace with values from this URL, `PackageServiceUri` and `PackageServiceFunctionCode`. In `PackageServiceUri` replace `<URL_OF_PackageService_Function>` with the corresponding value from your URL.

    In `PackageServiceFunctionCode` replace the `<PackageServiceFunction code>` with the code in your URL. You'll want everything after the `code=` including the `==` at the end. Once complete, your *appsettings.json* file should look similar to this:

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

1. Run this command to open up the *.deployment* file in the Code editor.

    ```bash
    code .deployment
    ```

1. In the *.deployment* file, replace `DroneDelivery-before` with `DroneDelivery-after` in both occurrences. The file should look like this:

    ```text
    [config]
    project = src/DroneDelivery-after/DroneDelivery-after.csproj
    ```

1. Press **Ctrl-s** to save the file, and **Ctrl-q** to close the Code editor.

1. Run this command to add and commit the updated files and deploy the application.

    ```bash
    git add .deployment src/DroneDelivery-after/appsettings.json
    git commit -m "Updating application to use the Azure Function"
    git push azure master
    ```
