Web applications that are running on a specific domain or port aren't allowed to make requests to different domains or ports. Why?

The browser blocks any request that your app makes to a different domain or port because this violates something called the "Same-Origin Policy". The Same-Origin Policy is enforced by all browsers and restricts requests to only the "same-origin" as the web application. It helps to reduce the chance that you might inadvertently load a malicious script from a mean third-party site. It also makes it more difficult to call APIs from unauthorized applications. You worked hard on the Products Manager API. You wouldn't want just anyone out there to use it.

In the Products Manager application, the frontend and api both run on localhost in development. That is the same domain, so that does not violate the same-origin policy. However, the plot thickens: The frontend runs on port 5000, and the api runs on port 7071. These ports are different, and different ports violate the same-origin policy. You cannot call the API from the frontend.

To address the "Same-Origin" problem, you'll use something called "Cross-Origin Resource Sharing", or, CORS.

## CORS

CORS is an HTTP Header that a server uses to specify which domains, ports and protocols can access its resources. The header will automatically be added by the server. If the browser making the request is part of an allowed domain and port, the server will grant access to the resources.

Azure Functions supports CORS. You can modify the function configuration to allow certain domains and ports to access the API.

## Modifying CORS settings in Azure Functions

You can specify which domains and ports the API is allowed to respond to by specifying the "CORS" property under "Host" in the `local.settings.json` file in the main function project folder. The `local.settings.json` file is the same file where you stored the database connection string.

It's common in development to set the "CORS" value to "\*". The "\*" means that everyone and their dog (although dogs have trouble typing) can access this API. CORS is only a setting that you need in production, so it's helpful to essentially turn it off during development.

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

As the clever developer you are (Tailwind Traders is beyond lucky to have you), you'll now configure the API to allow access during development so that you can light up the frontend and see the Products Manager application in all its glory.
