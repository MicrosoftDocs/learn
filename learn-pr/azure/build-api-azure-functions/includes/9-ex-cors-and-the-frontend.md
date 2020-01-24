1. If the Function app is running, press the "disconnect" button in the debug bar to terminate it.

   ![VS Code debug bar with a red box outlining the disconnect button](../media/terminate-debug-process.png)

1. Open the `api/local.settings.json` file.

1. Add a setting after the "Values" block which specifies the "Host" and "CORS" properties.

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

1. Start the Function project with <kbd>F5</kbd>.

## Connect the frontend web application

1. Open the `frontend/index.js` file.

1. On the second line of the file, set the `API` variable to "http://localhost:7071/api".

   ```javascript
   const API = "http://localhost:7071/api";
   ```

1. The frontend application should still be running in a browser tab on port 5000. Refresh the page.

1. The application loads in the data from the API.

1. Try creating, updating and deleting products to ensure that all endpoints work.

In this exercise, you allowed CORS access for your local deveopment environment. You also connected the frontend application so that it could consume the API. The last step is to publish the API to Azure and setup security.
