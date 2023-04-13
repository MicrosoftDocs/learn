For a client to be able to use anonymous authentication when sending data to Azure Blob Storage, the storage backend needs to have a way to authorize their requests. This can be solved by proving users with a SAS token that, once attached to their requests, lets them upload images to the storage backend. You're going to create a serverless API that creates SAS tokens on demand.

First, you'll create an Azure Function that will return a JSON object containing two values: a URL to which images should be uploaded and a SAS token. The browser client will use these values to authenticate its upload requests.

## Generating shared access signatures

Shared access signatures need to be configured with several parameters that specify everything from what kind of access you're granting to users to when that access will expire.

Your SAS token also needs to carry information that will let Azure authenticate and authorize requests the token makes. This information is extracted from your own storage account credentials. In this case, your function will use your storage account `Connection String` and extract the `accountKey`, `accountName`, and storage `URL`. The first two values will be used to build the shared key credentials. The URL is sent directly to user's browser so it knows where to upload the image.

To limit how long the SAS token is valid, you'll specify an `expiresOn` value of two hours. After that time has passed, the SAS token won't work. Be sure to adapt this time frame to meet the security requirements of your application. We advise giving the most restricted possible access.

SAS tokens can be generated for different kind of resources on Azure, and with various permission levels. In this case, your SAS token will grant access to your `images` container, and will allow blob creation in that container.

## The serverless API

Once the SAS token and the URL have been generated, you need to return that information to the user so they can upload images. You'll create a serverless API that returns a JSON object with the following format:

```javascript
{
  "sasKey": "sv=2020-06-12&se=2021-04-26T19%3A32%3A43Z&sr=c&sp=c&sig=<SecretSignature>",
  "url": "https://uploadimages.blob.core.windows.net"
}
```

You'll use node.js to create this project, along with the `@azure/storage-blob` SDK provided by Microsoft. Let's move on to the exercise to implement the serverless backend.
