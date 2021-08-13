For a client to be able to use anonymous authentication when sending data to Azure Blob Storage, the storage backend needs to have a way to authorize their requests. This can be solved by proving users with a SAS token that once attached to their requests will let them upload images to the storage backend. You are going to create a serverless API that creates SAS tokens on demand.

You are going to create an Azure Function that will return a JSON object containing two values: a URL where images should be uploaded to, and a SAS token. The browser client will use these values to authenticate its upload requests.

To generate the SAS token your function will use your storage account `Connection String` and extract the `accountKey`, `accountName`, and storage `URL` from there. The first two values are going to be used to build the shared key credentials, while the URL is going to be sent directly to the browser.

To limit how long the SAS token is going to be valid, you are going to specify an `expiresOn` value of two hours. After that time has passed the SAS token will no longer be valid. Be sure to adapt this time-frame to meet the security requirements of your application. We advice to always give as restricted access as possible.

SAS tokens can be generated for different kind of resources on Azure, and with various permission levels. In this case your SAS token will grant access to your `images` container, and will allow creating blobs in that container.

Once the SAS token and the URL have been generated, you serverless API will return a JSON object with the following format:

```javascript
{
  "sasKey": "sv=2020-06-12&se=2021-04-26T19%3A32%3A43Z&sr=c&sp=c&sig=<SecretSignature>",
  "url": "https://uploadimages.blob.core.windows.net"
}
```

You are going to use node.js to create this project. Let's move on to the exercise to implement the serverless backend.
