The application you're building is a photo gallery. It uses client-side JavaScript to call APIs to upload and display images. In this unit, you will create an API using a serverless function that generates a time-limited URL to upload an image. The web application uses this URL to upload an image to Blob storage using the [Blob storage REST API](https://docs.microsoft.com/rest/api/storageservices/blob-service-rest-api).

## Create a Blob storage container for images

The application requires a separate storage container to upload and host images.

Create a new container in your Storage account named **images** in your Storage account with public access to all blobs.

```azurecli
az storage container create \
    -n images \
    --account-name <storage account name> \
    --public-access blob
```

## Create a function app

Azure Functions is a service for running serverless functions. A serverless function can be triggered (called) by events, such as an HTTP request, or when a blob is created in a storage container.

A function app is a container for one or more serverless functions.

Create a new function app with a unique name. Function apps require a Storage account. In this unit, you will use the existing storage account you created in the last unit.

```azurecli
az functionapp create \
    -n <function app name> \
    -g <rgn>[Sandbox resource group name]</rgn> \
    -s <storage account name> \
    --consumption-plan-location $(az group show -n <rgn>[Sandbox resource group name]</rgn> --query location --output tsv)
```

## Create an HTTP-triggered serverless function

To securely upload an image to Blob storage, the photo gallery web app makes an HTTP request to the serverless function to generate a time-limited URL. The function is triggered by an HTTP request and uses the Azure Storage SDK to generate and return the secure URL.

1. Sign into the [Azure portal](https://portal.azure.com/triplecrownlabs.onmicrosoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Search for the function app you just created using the **Search** box. Click on the result to open it.

    ![Open the function app](../media/2-search-function-app.png)

1. In the left navigation of the Function Apps window, point to **Functions** and click the plus sign (+) to create a new serverless function.

    ![Create a new function](../media/2-new-function.png)

1. Click **Custom function** to see a list of function templates.

1. Find the **HttpTrigger** template and click C# or JavaScript.

1. Use the following values to create a function that generates a blob upload URL:

    | Setting      |  Suggested value   | Description                                        |
    | --- | --- | ---|
    | **Language** | C# or JavaScript | Select the language that you want to use. |
    | **Name your function** | GetUploadUrl | Enter this name exactly as shown, so the application can discover the function. |
    | **Authorization level** | Anonymous | Allows the function to be accessed publicly. |

    ![Enter settings for a new HTTP-triggered function](../media/2-new-function-httptrigger.png)

1. Click **Create** to create the function.

::: zone pivot="csharp"

8. When the function's source code appears, replace all of the content in the **run.csx** file with the content in the [**csharp/GetUploadUrl/run.csx**](https://raw.githubusercontent.com/Azure-Samples/functions-first-serverless-web-application/master/csharp/GetUploadUrl/run.csx) file.

1. Click **Logs** below the code window to expand the logs panel.

1. Click **Save**. Check the logs panel to ensure the function is successfully compiled.

::: zone-end

::: zone pivot="javascript"

8. This function requires the `azure-storage` package from npm. The package generates the shared access signature (SAS) token that's required to build the secure URL. To install the npm package, click on the Functions app on the left navigation and click **Platform features**.

1. Click **Console** to reveal a console window.

    ![Open a console window](../media/2-open-console.jpg)

1. Ensure the current directory is **d:\home\site\wwwroot** by running the command `cd d:\home\site\wwwroot`.

1. Run the command `npm init -y` to create an empty **package.json** file.

1. To install the package, run the command `npm install --save azure-storage` in the console. Save the package as **package.json**. It may take a few minutes to complete the operation.

1. Click on the function (**GetUploadUrl**) in the left navigation to reveal the function. Replace all of the content in the **index.js** file with the content in the [**javascript/GetUploadUrl/index.js**](https://raw.githubusercontent.com/Azure-Samples/functions-first-serverless-web-application/master/javascript/GetUploadUrl/index.js) file.

    ![Contents of index.js after update](../media/2-paste-js.jpg)

1. Click **Logs** below the code window to expand the logs panel.

1. Click **Save**. Check the logs panel to ensure the function is successfully compiled.

::: zone-end

The function generates a shared access signature (SAS) URL that's used to upload a file to Blob storage. The SAS URL is valid for a short time and only allows a single file to be uploaded. Consult the Blob storage documentation for more information on [how to use shared access signatures](https://docs.microsoft.com/azure/storage/common/storage-dotnet-shared-access-signature-part-1).


## Add an environment variable for the storage connection string

The function that you created requires a connection string for the Storage account so that it can generate the SAS URL. Instead of hardcoding the connection string in the function body, it can be stored as an application setting. Application settings are accessible as environment variables by all functions in the function app.

1. In Cloud Shell, query the Storage account connection string and save it to a Bash variable named **STORAGE_CONNECTION_STRING**.

    ```azurecli
    export STORAGE_CONNECTION_STRING=$(az storage account show-connection-string -n <storage account name> -g <rgn>[Sandbox resource group name]</rgn> --query "connectionString" --output tsv)
    ```

    Confirm the variable is set successfully.

    ```azurecli
    echo $STORAGE_CONNECTION_STRING
    ```

1. Create a new application setting named **AZURE_STORAGE_CONNECTION_STRING** using the value saved from the previous step.

    ```azurecli
    az functionapp config appsettings set \
        -n <function app name> \
        -g <rgn>[Sandbox resource group name]</rgn> \
        --settings AZURE_STORAGE_CONNECTION_STRING=$STORAGE_CONNECTION_STRING \
        -o table
    ```

    Confirm that the command's output contains the new application setting with the correct value.

## Test the serverless function

In addition to creating and editing functions, the Azure portal also provides a built-in tool for testing functions.

1. To test the HTTP serverless function, on the right of the code window, click on the **Test** tab to expand the test panel.

1. Change the **Http method** to **GET**.

1. Under **Query**, click **Add parameter** and add the following parameter:

    | Name      |  Value   | 
    | --- | --- |
    | **filename** | image1.jpg |

1. In the test panel, click **Run** to send an HTTP request to the function.

1. The function returns an upload URL in the output. The function execution appears in the Logs panel.

    ![Logs showing function ran successfully](../media/2-test-function.png)

## Configure CORS in the function app

Because the function front end is hosted in Blob storage, it has a different domain name than the function app. For the client-side JavaScript to successfully call the function that you created, the function app has to be configured for cross-origin resource sharing (CORS).

1. In the left navigation of the Function Apps window, click on the name of your function app.

1. Click on **Platform features** to view a list of advanced features.

1. Under **API**, click **CORS**.

    ![Select CORS](../media/2-open-cors.jpg)

1. Add an allow origin for the URL of your web site you created in the previous unit and omit the trailing slash (/). For example: `https://firstserverlessweb.z4.web.core.windows.net`.

    ![CORS settings showing serverless web app URL added](../media/2-add-cors.png)

1. Click **Save**.

::: zone pivot="javascript"

6. Still in the Azure portal, navigate to the Function Apps window and click on the name of your function app. Select the **Overview** tab. Click **Restart** to make sure that the changes for CORS take effect.

::: zone-end

::: zone pivot="csharp"

6. Navigate back to the `GetUploadUrl` function and select the **Integrate** tab.

1. Under **Selected HTTP methods**, select **OPTIONS**.

    **GET**, **POST**, and **OPTIONS** should all be selected. CORS uses the **OPTIONS** method, which isn't selected by default for C# functions.  

1. Click **Save**.

1. Still in the Azure portal, navigate to the Function Apps window and click on the name of your function app. Select the **Overview** tab. Click **Restart** to make sure that the changes for CORS take effect.

::: zone-end

## Configure CORS in the Storage account

Because the function app also makes client-side JavaScript calls to Blob storage to upload files, you have to configure the Storage account for CORS.

- Run the following command to allow all origins to upload files to the Storage account:

    ```azurecli
    az storage cors add --methods OPTIONS PUT --origins '*' --exposed-headers '*' --allowed-headers '*' --services b --account-name <storage account name>
    ```

## Modify the web app to upload images

The web app retrieves settings from a file named **settings.js**. In the following steps, you create the file using Cloud Shell. You set `window.apiBaseUrl` to the URL of the function app, and `window.blobBaseUrl` to the URL of the Azure Blob storage endpoint.

1. In Cloud Shell, ensure that the current directory is the **www/dist** folder.

    ```bash
    cd ~/functions-first-serverless-web-application/www/dist
    ```

1. Open the Cloud Shell Editor in the current directory by typing the command `code .`, including the dot.

    ```bash
    code .
    ```

1. In the Cloud Shell window below the editor, query the function app's URL.

    ```azurecli
    echo "https://"$(az functionapp show -n <function app name> -g <rgn>[Sandbox resource group name]</rgn> --query "defaultHostName" --output tsv)
    ```

1. Add the following line into the editor window, using the function app URL you retrieved in the previous step.

    ```bash
    window.apiBaseUrl = '<function app url>'
    ```

1. In the Cloud Shell window below the editor, query the Azure Blob Storage endpoint URL.

    ```azurecli
    echo $(az storage account show -n <storage account name> -g <rgn>[Sandbox resource group name]</rgn> --query primaryEndpoints.blob -o tsv | sed 's/\/$//')
    ```

1. Append a second line into the editor window, using the Storage endpoint URL you retrieved in the previous step.

    ```bash
    window.blobBaseUrl = '<blob storage endpoint url>'
    ```

1. Save the file as **settings.js** and close the editor.

1. Confirm the file was successfully written and it now contains 2 lines.

    ```azurecli
    cat settings.js
    ```

1. Upload the file to Blob storage.

    ```azurecli
    az storage blob upload \
        -c \$web \
        --account-name <storage account name> \
        -f settings.js \
        -n settings.js
    ```

## Test the web application

At this point, the gallery application is able to upload an image to Blob storage, but it can't display images yet. It will try to call a `GetImages` function that doesn't exist yet because you create it in a later module. The call will fail and the web page will appear to be stuck on "Analyzing...," but the image you select will be successfully uploaded.

You can verify that an image is successfully uploaded by checking the contents of the **images** container in the Azure portal.

1. In a browser window, browse to the application. Select an image file and upload it. The upload completes, but because we haven't added the ability to display images yet, the app doesn't show the uploaded photo. (The web page appears to be stuck on "Analyzing image..." You'll fix that later.)

1. In Cloud Shell, confirm the image was uploaded to the **images** container.

    ```azurecli
    az storage blob list \
        --account-name <storage account name> \
        -c images \
        -o table
    ```

1. Before moving on to the next unit, delete all files in the **images** container.

    ```azurecli
    az storage blob delete-batch \
        -s images \
        --account-name <storage account name>
    ```

## Summary

In this unit, you created an Azure Functions app and learned how to use a serverless function to allow a web application to upload images to Blob storage. Next, you will learn how to create thumbnails for the uploaded images using a blob-triggered serverless function.