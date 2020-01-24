Web applications that are running on a specific domain or port are not allowed to make requests to different domains or ports. The browser will block these requests because they violate something called the "Same-Origin Policy". This policy is enforced by all browsers and restricts requests to only the "same-origin" as the web application. This is a security measure. It helps to reduce the chance that you might inadvertantly load a malicious script. It also makes it more difficult to call API's from unauthorized applications.

In the case of the Product Manager application, the frontend and api both run on localhost in development. That is the same domain, so that does not violate the same-origin policy. The frontend runs on port 5000, and the api runs on port 7071. These ports are different, so any requests from the frontend to the API will be blocked.

To fix this, we use something called "Cross-Origin Resource Sharing", or, CORS.

## CORS

CORS is an HTTP Header that a server uses to specify which domains, ports and protocols can access it's resources. The header will automatically be added by the server. If the browser making the request is part of an allowed domain and port, the server will grant access to the resources.

Azure Functions supports and has CORS enabled by default. Even when running and debugging functions locally. In order to use the API locally, you'll have to modify the configuration of the function to allow access.

## Modifying CORS settings in Azure Functions

You can specify which domains and ports the API is allowed to respond to by specifying the "CORS" property under "Host" in the `local.settings.json` file in the main function project folder. This is the same file where you stored the database connection string earlier in the module.

It's common in development to set the "CORS" value to "\*". This says that any client on any domain, any port and any protocol can access this API. CORS is only a setting that you need in production, so it's helpful to essentially turn it off during development.

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

In the next exercise, you'll configure the API CORS settings and connect the frontend.
