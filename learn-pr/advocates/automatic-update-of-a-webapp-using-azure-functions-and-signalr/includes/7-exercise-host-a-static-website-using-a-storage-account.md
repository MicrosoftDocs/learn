Now that the API is deployed to the cloud, as a Tailwind Traders engineer, you need to update the client code and deploy it to support the SignalR messages coming for Azure Functions.

## Update the client application

1. In Visual Studio Code, open `./start/client/src/index.js` and replace all the code to listen for SignalR messages. The code gets the initial stock list with an HTTP request and then listens for updates from the SignalR connection. When a stock is updated, the client updates the stock price in the UI.

    :::code language="javascript" source="~/../microsoftdocs-mslearn-advocates-azure-functions-and-signalr/solution/client/src/index.js" :::

1. Open `./start/client/index.html` and paste the following code in place of the current DIV with the ID of app.

    :::code language="html" source="~/../microsoftdocs-mslearn-advocates-azure-functions-and-signalr/solution/client/index.html" :::

    This markup includes a transition element, which allows Vue.js to run a subtle animation as stock data changes. When a stock is updated, the tile fades out and quickly back in to view. This way if the page is full of stock data, users can easily see which stocks have changed.

1. Add the following script block just above the reference to *bundle.js* to include the SignalR SDK.

    ```html
    <script src="https://cdn.jsdelivr.net/npm/@aspnet/signalr@1.0.3/dist/browser/signalr.js"></script>
    ```

## Update the client .env 

1. Create an environment variables file in the `start/client` folder named `.env`.
1. Add a variable named `BACKEND_URL` and add its value you copied from unit 5.

    ```console
    BACKEND_URL=https://YOUR-FUNTIONS-APP-NAME.azurewebsites.net
    ```

## Create an Azure Static Web apps resource and deploy client

1. Open the [Azure portal](https://portal.azure.com/#create/Microsoft.FunctionApp) to create a new Azure Static Web Apps resource.
1. Use the following information to complete the resource creation **Basics** tab.

    | Name                                   | Value                          |
    | -------------------------------------- | ------------------------------ |
    | Subscription                            | Select your subscription.|
    | Resource group                         | Use the resource group `stock-prototype`.|
    | Static Web App name                      | Postpend your name to `client`. For example, `client-jamie`.|
    | Hosting plan type                       | Select **Free**.                       |
    | Deployment source                       | Select **GitHub**.                       |    
    | Organization                        | Select your GitHub account|
    | Repository    |  Search and select `mslearn-advocates.azure-functions-and-signalr`. |
    | Branch            | Select the **main** branch.                    |
    | Build Presets| Select **Vue.js**.|
    | App location | Enter `/start/client`.|
    | API Location | Leave empty.|
    | Output Location | Enter `dist`.|

1. Select **Preview workflow file** to review the deployment settings. The **Build And Deploy** step should look like the following: 

    :::code language="yaml" source="~/../microsoftdocs-mslearn-advocates-azure-functions-and-signalr/example-client-workflow.yml" range="30-42":::

1. Select **Close** to save the change. 

1. Select **Review + Create**, then select **Create** to create the resource. Wait for the deployment to complete before continuing.
1. Select **Go to resource** to open the new Azure Static Web App resource.
1. On the **Overview** page, copy the **URL** value. This is the base URL of the deployed static web app.

## Add the BACKEND_URL variable to the repository

The workflow needs to have the `BACKEND_URL` environment variable set to the deployed Azure Functions app base URL from unit 5.

1. In a browser for your GitHub fork of the sample repository, select **Settings -> Security -> Secrets and variables -> Actions**.
1. Select **Variables**, then select **New repository variable**. 
1. Use the following table to create the variable:

    |Name|Value|
    |---|---|
    |BACKEND_URL|The base URL of the deployed Azure Functions app. The URL should be in the format of `https://<FUNCTIONS-RESOURCE-NAME>.azurewebsites.net`|

1. Select **Add variable** to save the variable to the repository.

## Edit GitHub deployment workflow

1. In Visual Studio Code terminal, pull down the new workflow file from your fork (origin). 

    ```bash
    git pull origin main
    ```

1. Open the `.github/workflows/azure-static-web-apps-*.yml` file. 
1. Change the `name` value at the top of the file to `Client`.
1. Edit the **Build And Deploy** step to add the **env** property for the `BACKEND_URL` environment variable. 

    :::code language="yaml" source="~/../microsoftdocs-mslearn-advocates-azure-functions-and-signalr/example-client-workflow.yml" :::

1. Save and push the changes to the repository.

    ```bash
    git add .
    git commit -m "Add BACKEND_URL environment variable"
    git push
    ```

1. Open the **Actions** tab in the GitHub fork repository to watch the deployment. 

## Update CORS in the function app

By default, function apps don't allow CORS requests. You need to update the function app to allow requests from the static web app.

1. In the Azure portal, navigate to the Azure Functions app created in unit 5.
1. In the left-hand menu, select **API -> CORS**.
1. Select **Enable Access-Control-Allow-Credentials**.
1. Add the value you copied for the Static Web Apps resource URL. 

    |Property|Value|
    |--|--|
    |Allowed origins|The base URL of the deployed static web app. |

1. Select **Save** to save the CORS settings.

## Test the deployment of the client

1. In a browser, use the URL of the deployed static web app to open the client.
1. Open developer tools to watch the Console to see when the SignalR data for updated stock is received. Remember these aren't HTTP requests, so you won't see them in the Network tab.

Congratulations! You've deployed your stock app improved with SignalR!