Up to this point you have only run the application on your machine. You will now deploy the app to Azure.

### Deploy the function app

1. Open the Visual Studio Code command palette via `CTRL/CMD+Shift+P`.

2. Search for and select the **Azure Functions: Deploy to Function App** command.

3. When prompted, provide the following information.

   | Name              | Value                                                        |
   | ----------------- | ------------------------------------------------------------ |
   | Folder to deploy  | Select the main project folder                               |
   | Subscription      | Select your subscription                                     |
   | Function app      | Select **Create New Function App**                           |
   | Function app name | Enter a unique name                                          |
   | Resource group    | Select the same resource group as your other resources in this tutorial |
   | Storage account   | Select the account you created earlier                       |

   A new function app is created in Azure and the deployment begins. The Azure Functions Visual Studio Code extension first creates the Azure resources and deploys the function app.

   Wait for deployment to complete.

### Upload function app local settings

1. Open the Visual Studio Code command palette via `CTRL/CMD+Shift+P`.

2. Search for and select the **Azure Functions: Upload local settings** command.

3. When prompted, provide the following information.

   | Name                | Value                                       |
   | ------------------- | ------------------------------------------- |
   | Local settings file | local.settings.json                         |
   | Subscription        | Select your subscription                    |
   | Function app        | Select the previously deployed function app |
   | Function app name   | Enter a unique name                         |

Local settings are uploaded to the function app in Azure. If prompted to overwrite existing settings, select **Yes to all**.

### Configure static websites in Azure Storage

Use the following steps to configure the Azure Storage account to host a static website.

1. Open the Visual Studio Code command palette via `CTRL/CMD+Shift+P`.
2. Search for and select the **Azure Storage: Configure static website** command.
3. Select your subscription and storage account. The browser will open directly to the page for configuring this setting.
4. Select **Enabled**.
5. Enter `index.html` as the **Index document name**.
6. Click **Save**.
7. The static websites **primary endpoint** appears on the screen. Copy this value and set it aside as it is required to configure cross origin resource sharing (CORS) in the Azure Function app.

### Enable function app cross origin resource sharing (CORS)

Although there is a CORS setting in **local.settings.json**, it is not propagated to the function app in Azure. You need to set it separately.

#### Add CORS origin

1. Open the Visual Studio Code command palette via `CTRL/CMD+Shift+P`.

2. Search for and select the **Azure Functions: Open in portal** command.

3. Select the subscription and function app name to open the function app in the Azure portal.

4. Under the **Platform features** tab, select **CORS**.

5. Add an entry with the static website **primary endpoint** as the value (make sure to remove the trailing `/`).

6. Click **Save** to persist the CORS settings.

#### Enable CORS credentials support

In order for the SignalR JavaScript SDK to function, support for credentials in CORS must be enabled.

Currently, this feature can only be enabled using the Azure command line interface (CLI) or REST APIs. You will execute a command in Azure Cloud Shell to enable this feature. 

1. Return to the **Cloud Shell** in the browser.

2. Execute the following command, replacing `<>` with valid values based on resources you have created.

   ```
   az resource update --resource-group <RESOURCE_GROUP_NAME> --parent sites/<FUNCTION_APP_NAME> --name web --namespace Microsoft.Web --resource-type config --set properties.cors.supportCredentials=true --api-version 2015-06-01
   ```

3. Once completed, CORS credentials support is enabled in the function app.

### Update function app URL in the web application

1. In the Azure portal, navigate to the function app's overview page.
2. Copy the function app's URL.
3. In Visual Studio Code, open *index.html.js* and paste in the value of `REMOTE_SERVER_URL` with the function app's URL.
4. Save the file.

### Deploy the web application to Azure Storage

1. Open the Visual Studio Code command palette via `CTRL/CMD+Shift+P`.
2. Search for and select the **Azure Storage: Deploy to static website** command.
3. Select the subscription and Storage account.
4. When prompted for a folder, select **browse** and choose the **content** folder containing *index.html*.
5. A notification should appear that the upload was successful.
6. Click the button to open the app in a browser.

## Observe automatic updates

Now you can make change to the application's data and observe how to the data is automatically updated. 

Again, consider having Visual Studio Code on one side of the screen and the running application on the other. This way you can see the UI update as changes are made to the database.

In Visual Studio integrated terminal, enter the following command and watch as the UI is automatically updated.

```bash
npm run update
```
