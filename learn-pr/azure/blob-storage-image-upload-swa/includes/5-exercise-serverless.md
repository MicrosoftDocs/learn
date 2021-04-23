# Exercise: Build your serverless backend

Create project folder 

Start a Azure Function Project with a node.js backend.

Go to portal and get the Account Key

Add the account key in the `AzureWebJobsStorage` key of `local.settings.json`

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

Create a new function, call it `credentials`.

Open the `index.js` file from your credentials folder and add the following function at the bottom:

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

To complete the required code, you'll need to add the following `extractConnectionStringParts` function to your code, which takes care of extracting the `accountKey`, `accountName`, and `url` from your storage account connection string:

```javascript
function extractConnectionStringParts() {
    TODO: fill in or provide library where to download it
}
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

Your `index.js` should like like this once you have filled all the code: [link to index.js from github](link.html)

The next step is to implement the frontend part to contact your serverless API and upload the image to Azure Blob Storage.
