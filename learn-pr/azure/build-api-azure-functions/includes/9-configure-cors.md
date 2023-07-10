The API has been created and you're ready to connect the front-end web application and actually see this project work. But before you can do that, you have to tell the API that it's OK for the front-end application to call it. This connection is made with something called *Cross-Origin Resource Sharing*, or CORS.

## Modify CORS settings in Azure Functions

You can specify the domains and ports your API is allowed to respond to. Specify the CORS property, under *Host* in the local.settings.json file in the main function project folder. The local.settings.json file is the same file where you stored the database connection string.

It's common in development to set the CORS value to `"*"`. The `"*"` means that everyone and their pet (although pets have trouble typing) can access this API. CORS is only a setting that you need in a production environment, so it's helpful to essentially turn it off during development.

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

> [!WARNING]
> The \* wildcard is fine for development, but dangerous in production. The application setting for CORS should be changed to the URL of the front-end application when this API is deployed to production.

As the clever developer you are (Tailwind Traders is beyond lucky to have you), you configure the API to allow access during development. Now you can light up the front end and see the Products Manager app in all its glory.
