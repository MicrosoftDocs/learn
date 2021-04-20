# Describe the Serverless Backend

For a client to be able to use anonymous authentication when sending data to Azure Blob Storage they would need to have a SAS token allowing them to perform their requests. You are going to create a serverless API that creates such a token, and sends it to the browser.

Your Azure Function will return a URL where images should be uploaded to, and a SAS token, so the browser client can authenticate its upload requests.

To generate the SAS token your function will use your storage account `Connection String` and extract the `accountKey`, `accountName`, and storage `URL` from there. The first two values are going to be used to build the shared key credentials, while the URL is going to be sent directly to the browser.

To limit how long the SAS token is going to be valid, you are going to specify an `expiresOn` value of two hours. After that time has passed the SAS token will no longer be valid. Be sure to adapt this time frame to meet the security requirements of your application. We advice to always give as restricted access as possible.

Create new azure functions project. Make sure Azure Functions Core Tools is installed to run the project locally.

SAS tokens can be generated for different kind of resources on Azure, and with various permission levels. In this case your SAS token will grant access to your `images` container.

Once the SAS token and the URL have been generated, you serverless API will return a JSON object with the following format:

```javascript
{    
    sasKey: "sample sas key",
    url: "sample URL"
}
```

Let's move on to the next exercise to implement the serverless backend.
