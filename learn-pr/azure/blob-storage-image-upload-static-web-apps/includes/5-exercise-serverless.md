It's time to create your application's backend. For that you are going to create an Azure Function that will serve as the REST API generating on-demand shared access signatures so your users can upload images to your Blob Storage container. This exercise will guide you on how to create the Azure Function, install the required libraries, and write the code that will generate on-demand SAS keys.

## Create the Azure Function REST API

1. Create project folder, call it `upload_image`. Then open that folder inside Visual Studio Code. Once in VS Code, be sure you have the [Azure Functions extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) installed.

2. Create a new Azure Function. Type `ctrl+shift+p` to launch the command prompt. Type `Azure Functions: Create New Project`. Select the `upload_image` folder, for language choose `JavaScript`, and finally select `HttpTrigger` to add a function to your project. Call it `credentials`, and set authorization level as `anonymous`.

3. Go to the Azure portal, navigate to your storage account, and copy the connection string from there.

    :::image type="content" source="../media/account-keys.png" alt-text="Azure portal copy account key":::

4. Add the connection string in the `AzureWebJobsStorage` key of your project's `local.settings.json`:

    ```json
    {
        "IsEncrypted": false,
        "Values": {
          "AzureWebJobsStorage": "DefaultEndpointsProtocol=https;AccountName=youraccountname;AccountKey=<SecretAccountKey>;EndpointSuffix=core.windows.net",
          "FUNCTIONS_WORKER_RUNTIME": "node"
        }
    }    
    ```

5. Install the Azure SDK dependency used for generating the SAS token.

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

    The function `generateSasToken` takes your Azure Blob Storage connection string, a container name, and a permissions string, and uses that to build the SAS token. A `StorageSharedKeyCredential` is built based on your connection string. This credential will be used by `generateBlobSASQueryParameters` to generate the shared access signature that will make sure the parameters sent during the image upload can be authenticated towards your storage account credentials. Finally you provide a `expiresOn` value of 2 hours to make sure they user has enough time to upload their image, while at the same time the SAS will expire preventing abuse.

2. Create a file inside the `credentials` folder and call it `utils.js`. Paste the content from this file inside there: [utils.js](https://github.com/MicrosoftDocs/mslearn-blob-storage-image-upload-static-web-app/blob/main/credentials/utils.js)

3. In the `index.js` file, require the `extractConnectionStringParts` function in your code, which takes care of extracting the `accountKey`, `accountName`, and `url` from your storage account connection string.

    Your `require` section should now look like this:

    ```javascript
    const {
        StorageSharedKeyCredential,
        ContainerSASPermissions,
        generateBlobSASQueryParameters
    } = require("@azure/storage-blob");
    const { extractConnectionStringParts } = require('./utils.js');
    ```

4. Implement the serverless function entry point that will send the results from `generateSasToken` to the client:

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

Your `index.js` should look like this once you have filled all the code: [index.js](https://github.com/MicrosoftDocs/mslearn-blob-storage-image-upload-static-web-app/blob/main/credentials/index.js)

You have successfully created your serverless backend. The next step is to implement the frontend that will let you upload images to Azure Blob Storage.
