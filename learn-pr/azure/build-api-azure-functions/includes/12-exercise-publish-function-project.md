Your API is ready for prime time. Let's put it in the cloud. Azure, here we come.

## Publish the api project to Azure

1. Open the Command Palette.

1. Enter "deploy to function".

1. Select **Azure Functions: Deploy to Function App**.

1. When prompted, select the following values.

   | Name            | Value                                                    |
   | --------------- | -------------------------------------------------------- |
   | project folder  | api                                                      |
   | Function App    | Create new Function App in Azure (Advanced)              |
   | Name            | Your Azure Cosmos DB Account Name (for example, tailwind-traders-xxxx) |
   | OS              | Linux                                                    |
   | Hosting Plan    | Consumption                                              |
   | Runtime         | Node 10.x                                                |
   | Resource Group  | learn-....                                               |
   | Storage Account | cloudshell...                                            |
   | App Insights    | Skip for now                                             |

   > [!IMPORTANT]
   > There are two "Create Function App in Azure" options. It's important that you select the option that is marked **(Advanced)**.

1. When prompted, select **Upload Settings**.

    :::image type="content" source="../media/upload-settings.png" alt-text="Screenshot of a Visual Studio Code notification asking if you want to upload settings. A callout highlights the Upload settings button." loc-scope="vs-code":::

## Set the API URL for the front-end app

1. On line 3 in the `frontend/index.js` file, replace the value of `API' with the following URL, replacing the "tailwind-traders-xxxx" with the name of your Function app.

   ```javascript
   const API = "https://tailwind-traders-xxx.azurewebsites.net/api";
   ```

## Get function key

1. Open the Command Palette.

1. Enter "functions portal".

1. Select **Azure Functions: Open in Portal**.

1. Select the "tailwind-traders-xxxx" function app that you created.

   In your browser, the Function App opens.

1. Select **Platform Features** for a specific Function App.

   ![Screenshot of the Azure portal with red box outlining the "Platform features" tab.](../media/platform-features.png)

1. Select **Function App Settings**.

   ![Screenshot of the Azure portal with red box outlining the "Function app settings" option.](../media/function-app-settings.png)

1. Scroll down to the **Host Keys** section.

1. Select **Copy**  next to the "default" key.

   ![Screenshot of the Azure portal with red box outlining the "Host keys" section and the copy button for the default key.](../media/copy-default-key.png)

## Set the function key for the front-end app

1. Open the `frontend/index.js` file.

1. Paste the value on your clipboard into the value of the `KEY` variable on line 3.

   ```javascript
   const KEY = "Iry/Itp6ou9y8SpOoz3hb3D7iaDAkzejXSmVs...";
   ```

1. In your browser, refresh the Products Manager app.

1. You should see a "Network Error" message.

1. To open the browser developer tools, press <kbd>Cmd</kbd>/<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>I</kbd>.

1. Note there's a "blocked by CORS policy" message.

    :::image type="content" source="../media/blocked-by-cors.png" alt-text="Screenshot of a web browser with developer tools open showing a blocked by CORS error message in the console." loc-scope="other"::: <!-- no-loc -->

## Enable CORS on the Function app in Azure

1. For the Function app, return to the Azure portal page.

1. Select **Platform Features**.

   ![Screenshot of the Azure portal with red box outlining the "Platform features" tab.](../media/platform-features.png)

1. Select the **CORS** option.

   ![Screenshot of the Azure portal with red box outlining the "Platform features" tab.](../media/cors-option.png)

1. To the list of allowed URLs, add `http://localhost:5000`.

   ```http
   http://localhost:5000
   ```

1. At the top, select **Save**.

## Test the front-end app

1. Return to the Products Manager app running in your browser.

1. Refresh the page. The app should still show the data, but this time using the API that is in production.

   ![Screenshot of a web browser with the Products Manager application running shown populated with data.](../media/working-application.png)
