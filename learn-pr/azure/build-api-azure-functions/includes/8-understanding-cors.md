Web applications that are running on a specific domain or port are not allowed to make requests to different domains or ports. Why? That seems excessive.

The browser blocks any request that your app makes to a different domain or port because this violates something called the "Same-Origin Policy". This policy is enforced by all browsers and restricts requests to only the "same-origin" as the web application. This is a security measure. It helps to reduce the chance that you might inadvertantly load a malicious script from a mean third-party site. It also makes it more difficult to call API's from unauthorized applications. You worked hard on this API. You wouldn't want just anyone to be able to use it.

In the case of the Product Manager application, the frontend and api both run on localhost in development. That is the same domain, so that does not violate the same-origin policy. However, the plot thickens: The frontend runs on port 5000, and the api runs on port 7071. These ports are different, this does violate the same-origin policy. You cannot call the API from the frontend.

To fix this, you'll use something called "Cross-Origin Resource Sharing", or, CORS.

## CORS

CORS is an HTTP Header that a server uses to specify which domains, ports and protocols can access it's resources. The header will automatically be added by the server. If the browser making the request is part of an allowed domain and port, the server will grant access to the resources.

Azure Functions supports CORS. You can modify the function configuration to allow certain domains and ports to access the API.

## Modifying CORS settings in Azure Functions

You can specify which domains and ports the API is allowed to respond to by specifying the "CORS" property under "Host" in the `local.settings.json` file in the main function project folder. This is the same file where you stored the database connection string.

It's common in development to set the "CORS" value to "\*". This means that everyone and their dog (although dogs have trouble typing) can access this API. CORS is only a setting that you need in production, so it's helpful to essentially turn it off during development.

```json
{
  "IsEncrypted": false,
  "Values": {
    "AzureWebJobsStorage": "",
    "FUNCTIONS_WORKER_RUNTIME": "node",
    "CONNECTION_STRING": "AccountEndpoint=https://tailwind-traders-2778.documents.azure.com..."
  },
  "Host": {
    "CORS": "*"
  }
}
```

> [!IMPORTANT]
> CORS is an essential security component of any API. Always avoid setting CORS to "\*" in a production environment. In a later exercise, we'll publish the function to Azure and examine how to control CORS for production vs development.

As the network savvy developer you are (Tailwind Traders is beyond lucky to have you), you'll now configure the API to allow access during development so that you can lightup the frontend and see this application in all it's glory.
