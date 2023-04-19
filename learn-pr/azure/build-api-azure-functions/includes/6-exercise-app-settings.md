It's time to put some gasoline in this API engine and fire it up. That's an analogy for connecting the function endpoints to the database. You're probably better at coding than we are with analogies.

## Get the database connection string

1. Paste the following code into Azure Cloud Shell on the right, and press <kbd>Enter</kbd>.

   ```bash
   cd mslearn-build-api-azure-functions/DB_SETUP && ./GET_CONNECTION_STRING.sh
   ```

1. Copy the database connection string that is returned in Azure Cloud Shell.

## Add connection string to local settings

1. In Visual Studio Code, open the `local.settings.json` file.

1. In the "Values" section, add a setting for "CONNECTION_STRING", and paste in the value you copied in the previous section.

   ```json
   {
     "IsEncrypted": false,
     "Values": {
       "AzureWebJobsStorage": "",
       "FUNCTIONS_WORKER_RUNTIME": "node",
       "CONNECTION_STRING": "PASTE YOUR CONNECTION STRING HERE"
     }
   }
   ```

## Examine the productsService for the connection string

Open the `api/services/productsService.ts` file.

Look at line 3. Notice that the connection string is read from the `process.env` variable.

  ```typescript
  const CONNECTION_STRING = process.env.CONNECTION_STRING;
  ```

## Test out the GetProducts endpoint from Visual Studio Code

1. To start the project, press <kbd>F5</kbd>.

1. Go to the */api/GetProducts* URL.

   ```http
   http://localhost:7071/api/GetProducts
   ```

Behold the products.

   :::image type="content" source="../media/all-products.png" alt-text="Screenshot of a web browser displaying items in the products collection displayed is JSON format." loc-scope="other"::: <!-- no-loc -->
