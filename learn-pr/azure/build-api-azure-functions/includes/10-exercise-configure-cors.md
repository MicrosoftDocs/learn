In this exercise, you'll configure Cross-Origin Resource Sharing (CORS) in your local Azure Functions, and see the Product Manager application come to life.

## Configure CORS

1. Open the `api/local.settings.json` file.

1. Add a "Host" section below the "Values" property. Set the "CORS" value on "Host" to "\*".

   ```json
   {
     "IsEncrypted": false,
     "Values": {
       "AzureWebJobsStorage": "",
       "FUNCTIONS_WORKER_RUNTIME": "node",
        "AzureWebJobsFeatureFlags": "EnableWorkerIndexing",
       "CONNECTION_STRING": "PASTE YOUR CONNECTION STRING HERE"
     },
     "Host": {
       "CORS": "*"
     }
   }
   ```

1. If the API is still running, restart the process by selecting **Disconnect** in the debug bar, and then pressing <kbd>F5</kbd> to start it again.

## Check the front-end app

1. The front-end app should still be running in a browser tab on port 5000. Refresh the page.

1. The app loads the data from the API.

   :::image type="content" source="../media/working-application.png" alt-text="Screenshot of web browser displaying the Products Manager application shown populated with data." loc-scope="other":::

1. To ensure that all endpoints work, try creating, updating, and deleting products.

That app looks good. It looks **very** good. None of it would be possible without your brilliant API. Ready to test what you've learned?
