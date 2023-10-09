In this exercise, we'll create your application's backend. You'll create an Azure Function that serves as the REST API generating on-demand shared access signatures so your users can upload images to your Blob Storage container. This exercise will guide you on how to create the Azure Function, install the required libraries, and write the code that generates on-demand SAS keys.

## Create the Azure Function REST API

1. Open Visual Studio Code.

1. Create a project folder on your computer and name it `upload_image`. In Visual Studio Code, select **File** > **Open Folder**, navigate to the folder you just created, and select **Select Folder**.

1. Select **Extensions** on the left side of the window, then search for **Azure Functions**. Install the extension if necessary.

1. Next, we'll create an Azure Function. Press <kbd>Ctrl + Shift + P</kbd> on your keyboard to open the Command Palette.

1. Enter *Azure Functions: Create New Project*, then select the **Azure Functions: Create New Project** task in the window.

1. Select the **upload_image** folder.

1. Select **JavaScript** for the language.

1. Select **Model V3**.

1. Select **HttpTrigger**, then name the function *credentials* and select **Anonymous** for the authorization level.

1. In the Azure portal, navigate to the storage account you created earlier.
1. Select **Access keys** under **Security + networking** on the left hand menu.
1. Select **Show** next to the first **Connection string**, then select the **Copy** icon to  copy your storage account connection string.

    :::image type="content" source="../media/account-keys.png" alt-text="Screenshot of the Access Keys page in the Azure portal.":::

1. Return to Visual Studio Code and add the connection string in the `AzureWebJobsStorage` key of your project's `local.settings.json`, then save the file.

    ```json
    {
        "IsEncrypted": false,
        "Values": {
          "AzureWebJobsStorage": "<YOUR_CONNECTION_STRING>",
          "FUNCTIONS_WORKER_RUNTIME": "node"
        }
    }    
    ```

1. Select **Terminal** > **New Terminal**. Select Bash as the terminal type in the drop-down at the top left. Use the following command to install the Azure SDK dependency used for generating the SAS token.

    ```bash
    npm install @azure/storage-blob
    ```

## Generating shared access signatures

1. Open the `index.js` file from your `credentials` folder and add the following function at the bottom:

    ```javascript
    function generateSasToken(connectionString, container, permissions) {
        const { accountKey, accountName, url } = extractConnectionStringParts(connectionString);
        const sharedKeyCredential = new StorageSharedKeyCredential(accountName, accountKey.toString('base64'));
    
        var expiryDate = new Date();
        expiryDate.setHours(expiryDate.getHours() + 2);
    
        const sasKey = generateBlobSASQueryParameters({
            containerName: container,
            permissions: ContainerSASPermissions.parse(permissions),
            expiresOn: expiryDate,
        }, sharedKeyCredential);
    
        return {
            sasKey: sasKey.toString(),
            url: url
        };
    }
    ```

    The function `generateSasToken` takes your Azure Blob Storage connection string, a container name, and a permissions string, and uses them to build the SAS token. A `StorageSharedKeyCredential` is built based on your connection string. This credential will be used by `generateBlobSASQueryParameters` to generate the shared access signature that ensures the parameters sent during the image upload can be authenticated to your storage account credentials. Finally you provide a `expiresOn` value of two hours. The shared access signature will expire in two hours to help prevent abuse, but also to ensure the user has enough time to upload their image.

1. Create a file inside the `credentials` folder and call it `utils.js`. Paste the content from this file into your file: [utils.js](https://github.com/MicrosoftDocs/mslearn-blob-storage-image-upload-static-web-app/blob/main/credentials/utils.js). Save the file.

1. In the `index.js` file, require the `extractConnectionStringParts` function in your code, which takes care of extracting the `accountKey`, `accountName`, and `url` from your storage account connection string.

    Your `require` section should now look like this:

    ```javascript
    const {
        StorageSharedKeyCredential,
        ContainerSASPermissions,
        generateBlobSASQueryParameters
    } = require("@azure/storage-blob");
    const { extractConnectionStringParts } = require('./utils.js');
    ```

1. Implement the serverless function entry point that will send the results from `generateSasToken` to the client:

    ```javascript
    module.exports = async function (context, req) {
        const permissions = 'c';
        const container = 'images';
        context.res = {
            body: generateSasToken(process.env.AzureWebJobsStorage, container, permissions)
        };
        context.done();
    };
    ```

1. Your `index.js` should look like the following once you've finished entering all the code:

    ```javascript
    const {
        StorageSharedKeyCredential,
        ContainerSASPermissions,
        generateBlobSASQueryParameters
    } = require("@azure/storage-blob");
    const { extractConnectionStringParts } = require('./utils.js');
    
        module.exports = async function (context, req) {
        const permissions = 'c';
        const container = 'images';
        context.res = {
            body: generateSasToken(process.env.AzureWebJobsStorage, container, permissions)
        };
        context.done();
    };
    
    function generateSasToken(connectionString, container, permissions) {
        const { accountKey, accountName, url } = extractConnectionStringParts(connectionString);
        const sharedKeyCredential = new StorageSharedKeyCredential(accountName, accountKey.toString('base64'));
    
        var expiryDate = new Date();
        expiryDate.setHours(expiryDate.getHours() + 2);
    
        const sasKey = generateBlobSASQueryParameters({
            containerName: container,
            permissions: ContainerSASPermissions.parse(permissions),
            expiresOn: expiryDate,
        }, sharedKeyCredential);
    
        return {
            sasKey: sasKey.toString(),
            url: url
        };
    }
    ```

You've successfully created your serverless backend. The next step is to implement the frontend that will let you upload images to Azure Blob Storage.
