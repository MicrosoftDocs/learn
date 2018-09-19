In the previous unit, you saw how a serverless function can facilitate the secure uploading of images to Blob storage from a web application. In this module, you create another serverless function to watch for uploaded images and create thumbnails from them.

## Create a Blob storage container for thumbnails

The full-size images are stored in a container named **images**. You need another container to store thumbnails of those images.

Create a new container named **thumbnails** in your Storage account with public access to all blobs.

```azurecli
az storage container create -n thumbnails --account-name <storage account name> --public-access blob
```

## Create a blob-triggered serverless function

A trigger defines how a function is invoked. The function you create next uses a blob trigger. The function is automatically invoked when a blob (image file) is uploaded to the **images** container. A function must have one trigger. Triggers have associated data, which are usually the payload that triggered the function.

Bindings define how a function reads or writes data in Azure or third-party services. This function creates a thumbnail version of the image that triggers it and saves the thumbnail in a *thumbnails* container.

1. Sign into the [Azure portal](https://portal.azure.com/triplecrownlabs.onmicrosoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Open your Function app, you can use the **Search** box at the top of the portal to find it by name.

1. In the Functions app window's left navigation, point to **Functions** and click the plus sign (+) to create a new serverless function. If a quickstart page appears, click **Custom function** to see a list of function templates.

1. Find the **BlobTrigger** template and select it.

1. Use these values to create a function that creates thumbnails as images are uploaded:

    | Setting      |  Suggested value   | Description                                        |
    | --- | --- | ---|
    | **Language** | C# or JavaScript | Choose your preferred language. |
    | **Name your function** | ResizeImage | Enter this name exactly as shown, so the application can discover the function. |
    | **Path** | images/{name} | Execute the function when a file appears in the **images** container. |
    | **Storage account information** | AZURE_STORAGE_CONNECTION_STRING | Use the environment variable previously created with the connection string. |

    ![Enter settings for the new function](../media/3-new-function.png)

1. Click **Create** to create the function.

1. When the function is created, click **Integrate** to view its trigger, input, and output bindings.

1. Click **New output** to create a new output binding.

    ![Select New Output on the Integrate tab](../media/3-new-output.jpg)

1. Select **Azure Blob Storage** and click **Select**. You may have to scroll down to see the **Select** button.

    ![Select Azure Blob storage](../media/3-storage-output.jpg)

1. Enter the following values:

    | Setting      |  Suggested value   | Description                                        |
    | --- | --- | ---|
    | **Blob parameter name** | thumbnail | The function uses the parameter with this name to write the thumbnail. |
    | **Use function return value** | No |  |
    | **Path** | thumbnails/{name} | The thumbnails are written to a container named **thumbnails**. |
    | **Storage account connection** | AZURE_STORAGE_CONNECTION_STRING | Use the environment variable previously created with the connection string. |

    ![Enter settings for the blob output binding](../media/3-blob-output.png)

1. Click **Save** to save your changes.

::: zone pivot="javascript"

11. Click on **Advanced editor** in the top right corner of the window to reveal the JSON that represents the bindings.

1. In the `blobTrigger` binding, add a property named `dataType` with a value of `binary`. This configures the binding to pass the blob contents to the function as binary data.

    ```json
    {
        "name": "myBlob",
        "type": "blobTrigger",
        "direction": "in",
        "path": "images/{name}",
        "connection": "AZURE_STORAGE_CONNECTION_STRING",
        "dataType": "binary"
    }
    ```

1. Click **Save** to create the new binding.

::: zone-end

::: zone pivot="csharp"

11. Select the **ResizeImage** function name in the left navigation to open the function's source code.

1. The function requires a NuGet package called **ImageResizer** to generate the thumbnails. NuGet packages are added to C# functions using a **project.json** file. To create the file, click **View Files** on the right to reveal the files that make up the function.

1. Click **Add** to add a new file named **project.json**. Press **Enter** when done to add the file.

1. Copy the contents of the [**/csharp/ResizeImage/project.json**](https://raw.githubusercontent.com/Azure-Samples/functions-first-serverless-web-application/master/csharp/ResizeImage/project.json) file into the newly created file. Save the file. Packages are automatically restored when the file is updated.

    ![project.json file with ImageResizer](../media/3-project-json.png)

1. Under **View Files**, select **run.csx**. Replace its content with the content in the [**/csharp/ResizeImage/run.csx**](https://raw.githubusercontent.com/Azure-Samples/functions-first-serverless-web-application/master/csharp/ResizeImage/run.csx) file.

1. To expand the logs panel, click **Logs** below the code window.

1. Click **Save**. Check the Logs panel to ensure the function is successfully saved and there are no errors.

::: zone-end

::: zone pivot="javascript"

14. This function requires the `jimp` package from npm to resize the photo. To install the npm package, click on the Functions app name on the left navigation and click **Platform features**.

1. Click **Console** to reveal a console window.

1. Run the command `npm install jimp` in the console. It may take a few minutes to complete the operation.

1. Click on the **ResizeImage** function name in the left navigation to reveal the function. Replace all the content in the **index.js** file with the content of the [**/javascript/ResizeImage/index.js**](https://raw.githubusercontent.com/Azure-Samples/functions-first-serverless-web-application/master/javascript/ResizeImage/index.js) file.

1. To expand the logs panel, click **Logs** below the code window.

1. Click **Save**. Check the Logs panel to ensure the function is successfully saved and there are no errors.

::: zone-end

## Test the serverless function

1. Open the application in a browser. Select an image file and upload it. The upload completes, but because we haven't added the ability to display images yet, the app doesn't show the uploaded photo.

1. In Cloud Shell, confirm the image was uploaded to the **images** container.

    ```azurecli
    az storage blob list \
        --account-name <storage account name> \
        -c images \
        -o table
    ```

1. Confirm the thumbnail was created in a container named **thumbnails**.

    ```azurecli
    az storage blob list \
        --account-name <storage account name> \
        -c thumbnails \
        -o table
    ```

1. Get the URL for the thumbnail.

    ```azurecli
    az storage blob url \
        --account-name <storage account name> \
        -c thumbnails \
        -n <filename> \
        --output tsv
    ```

    Open the URL in a browser and confirm the thumbnail was properly created.

1. Before continuing to the next unit, delete all files in the **images** and **thumbnails** containers.

    ```azurecli
    az storage blob delete-batch \
        -s images \
        --account-name <storage account name>
    ```

    ```azurecli
    az storage blob delete-batch \
        -s thumbnails \
        --account-name <storage account name>
    ```

## Summary

In this unit, you created a serverless function to create a thumbnail when an image is uploaded to a Blob storage container. Next, you will learn how to use Azure Cosmos DB to store and list image metadata.