# Exercise: Build your serverless backend

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

Then add the following `extractConnectionStringParts` function to your code:

```javascript
function extractConnectionStringParts() {
}
```

Now it's time to implement the serverless function that will send the results from generateSasToken to the client:

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

The next step is to implement the frontend part to contact your serverless API and upload the image to Azure Blob Storage.
