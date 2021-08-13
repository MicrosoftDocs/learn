Create project folder, call it `uploadimage`. Then open that folder inside Visual Studio Code. Once in VS Code make sure you have the [Azure Functions extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) installed. 

Type `ctrl+shift+p` to launch the command prompt type `Azure Functions: Create New Project`. Select the `upload_image` folder, for language choose `JavaScript`, and finally select `HttpTrigger` to add a function to your project. Call it `credentials`, and set authorization level as `anonymous`.

Then go to the Azure Portal, navigate to your storage account, and copy the connection string.

:::image type="content" source="../media/account_keys.png" alt-text="Azure Portal Copy Account Key":::

Add the connection string in the `AzureWebJobsStorage` key of your project's `local.settings.json`:

```json
{
    "IsEncrypted": false,
    "Values": {
      "AzureWebJobsStorage": "DefaultEndpointsProtocol=https;AccountName=youraccountname;AccountKey=<SecretAccountKey>;EndpointSuffix=core.windows.net",
      "FUNCTIONS_WORKER_RUNTIME": "node"
    }
}    
```

Install the Azure SDK dependency used for generating the SAS token.

```bash
npm install @azure/storage-blob
```

Open the `index.js` file from your `credentials` folder and add the following function at the bottom:

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

The function `generateSasToken` takes your Azure Blob Storage connection string, a container name, and a permissions strings, and uses that to build the SAS token. A `StorageSharedKeyCredential` is built based on your connection string. This credential will be used by `generateBlobSASQueryParameters` to generate the shared access signature that will make sure the parameters sent during the image upload can be authenticated towards your storage account credentials. Finally you provide a `expiresOn` value of 2 hours to make sure they user has enough time to upload their image, while at the same time the SAS will expire preventing abuse.

To complete the required code, you'll need to add the following `extractConnectionStringParts` function to your code, which takes care of extracting the `accountKey`, `accountName`, and `url` from your storage account connection string. Create a file inside the `credentials` folder and call it `utils.js`. Paste the content from this file inside there: [utils.js](https://github.com/MicrosoftDocs/mslearn-blob-storage-image-upload-static-web-app/blob/main/credentials/utils.js)

Your `require` section should now look like this:

```javascript
const {
    StorageSharedKeyCredential,
    ContainerSASPermissions,
    generateBlobSASQueryParameters
} = require("@azure/storage-blob");
const { extractConnectionStringParts } = require('./utils.js');
```

Now it's time to implement the serverless function entry point that will send the results from `generateSasToken` to the client:

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

Your `index.js` should like like this once you have filled all the code: [index.js](https://github.com/MicrosoftDocs/mslearn-blob-storage-image-upload-static-web-app/blob/main/credentials/index.js)

The next step is to implement the frontend part to contact your serverless API and upload the image to Azure Blob Storage.
