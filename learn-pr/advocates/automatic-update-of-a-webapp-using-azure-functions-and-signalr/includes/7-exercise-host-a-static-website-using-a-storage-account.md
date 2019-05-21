Up to this point you have only run the application on your machine. The next step is to deploy the app to Azure.

## Enable advanced creation of Azure Functions in the Visual Studio Code Azure Functions extension

To give you control over the settings associated with creating Azure Functions apps, update the Azure Functions extension to enable advanced settings.

1. Click **File > Preferences > Settings**
2. Navigate through **User Settings > Extensions > Azure Functions**
3. Check the checkbox for **Azure Function: Advanced Creation**

    ![Enable advanced Functions creation](../media/serverless-app-extension-adv-creation.png)

## Deploy the function app

1. Press the **CTRL/CMD+Shift+P** to open the Visual Studio Code command palette.

1. If you are already signed-in to Azure in Visual Studio Code with a different account, use the **Azure: Sign Out** command to sign out. Otherwise, you create the function app outside of the Learn sandbox and may incur costs.

1. Search for and select the **Azure Functions: Deploy to Function App** command.

1. When prompted, select **Sign in to Azure** and sign in with the same account you used to sign into the Learn sandbox.  

1. Follow the prompts to provide the following information.

   | Name              | Value                                                        |
   | ----------------- | ------------------------------------------------------------ |
   | Function app      | Select **Create new Function App in Azure**                  |
   | Function app name | Enter a unique name                                          |
   | OS                | Select **Windows**                                           |
   | Plan              | Select **Consumption**                                       |
   | Language          | Select **JavaScript**                                        |
   | Resource group    | Select **<rgn>[sandbox resource group name]</rgn>**          |
   | Storage account   | Select the account you created earlier                       |

    A new function app is created in Azure and the deployment begins. The Azure Functions Visual Studio Code extension first creates the Azure resources and then deploys the function app.

    Once complete, the Azure Functions extension reports the primary endpoint of the function in a message box as shown by this screenshot.

    ![New function app](../media/serverless-app-new-function-app.png)

    The function app name (labeled as **1** in the image) is the unique name you provided to the extension as you created the app. The app end point (labeled as **2**) is the function app name followed by *azurewebsites.net*.

1. Open **public/index.html.js** and replace `<FUNCTION_APP_ENDPOINT>` with the function's endpoint.

1. Another message appears in Visual Studio code asking if you want to upload local settings. Select  **Upload settings** to copy the values from **local.settings.json** to the server.

    ![Upload local settings](../media/serverless-app-upload-local-settings.png)

    If the message box doesn't appear or has been dismissed from Visual Studio Code, you can still upload your local settings by opening the Visual Studio Code command palette via **CTRL/CMD+Shift+P** and select **Azure Functions: Upload local settings**. If prompted, choose to overwrite any existing settings.

## Configure static websites in Azure Storage

<!-- 
    REVIEW:
    Need to update prerequisites to include Azure Storage extension

    CONCLUSION
    Done
 -->

Use the following steps to configure the Azure Storage account to host a static website.

1. Open the Visual Studio Code command palette via **CTRL/CMD+Shift+P**.

1. Search for and select the **Azure Storage: Configure static website** command.

   | Name              | Value                                                             |
   | ----------------- | ----------------------------------------------------------------- |
   | Storage account   | Select the account you created earlier                            |
   | Default file      | Select **index.html** as the index document name for the account. |
   | Error document    | Press **Enter** to accept the default 404 error document path     |

## Deploy the web application to Azure Storage

1. Open the Visual Studio Code command palette via **CTRL/CMD+Shift+P**.

1. Search for and select the **Azure Storage: Deploy to static website** command.

1. Select the Storage account you created earlier.

1. When prompted for a folder, select **browse** and choose the *public* subfolder, which contains the web app.

1. A notification appears that the upload was successful. The upload can take several minutes.

## Determine the primary endpoint address of the static website

1. In the command palette, search for **Azure Storage: Browse static website** and choose your Storage account. The site opens in the browser. At this point, the app won't run because of CORS requirements of Azure Functions.

1. Copy the URL in the browser, which is the endpoint of the static site hosted in your Storage account. You use the endpoint value to set up CORS settings for the function app in the next section.

## Setup CORS in our function app

1. In the command palette, search for and select the **Azure Functions: Open in portal** command.

1. Select the subscription and function app name.

1. Once the portal is open in the browser, select the **Platform features** tab and select **CORS**.

1. Check the checkbox next to **Enable Access-Control-Allow-Credentials**.

1. Add an entry with the *static website* **primary endpoint** as the value (make sure to remove the trailing `/`). You should be able to paste this value in from your clipboard.

1. Click **Save** to persist the CORS settings.

    ![Enable CORS support for Azure Functions app](../media/serverless-app-function-cors.png)

## Test the deployed application

Now you can make change to the application's data and observe how to the data is automatically updated.

Again, consider having Visual Studio Code on one side of the screen and the running application on the other. This way you can see the UI update as changes are made to the database.

1. In Visual Studio integrated terminal, enter the following command and watch as the UI is automatically updated.

    ```bash
    npm run update
    ```

    ![End state of serverless web app](../media/serverless-app-deployed.png)