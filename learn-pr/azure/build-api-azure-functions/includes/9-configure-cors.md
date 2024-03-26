The API has been created and you're ready to connect the front-end web application and actually see this project work. But before you can do that, you have to tell the API that it's OK for the front-end application to call it. This connection is made with something called *Cross-Origin Resource Sharing*, or CORS.

## Modify CORS settings for local Azure Functions app

You can specify the domains and ports to which your API listens to. Specify the CORS property under *Host* in the *local.settings.json* file in the main function project folder. The *local.settings.json* file is the same file where you stored the database connection string.

It's common in development to set the CORS value to `"*"`. The `"*"` means that everyone and their pet (although pets have trouble typing) can access this API. CORS is only a setting that you need in a production environment, so it's helpful to essentially turn it off during development.

```json
{
  "IsEncrypted": false,
  "Values": {
    "AzureWebJobsStorage": "",
    "FUNCTIONS_WORKER_RUNTIME": "node",
    "AzureWebJobsFeatureFlags": "EnableWorkerIndexing",
    "CONNECTION_STRING": "AccountEndpoint=https://tailwind-traders-2778.documents.azure.com..."
  },
  "Host": {
    "CORS": "*"
  }
}
```

> [!WARNING]
> The \* wildcard for a CORS setting is fine for development, but dangerous in production. When configuring CORS on a deployed Azure Functions app, the application setting should be changed to the front-end application URL when this API is deployed to production.

As the clever developer you are (Tailwind Traders is beyond lucky to have you), you configure the API to allow access during development. Now you can light up the front end and see the Products Manager app in all its glory.
