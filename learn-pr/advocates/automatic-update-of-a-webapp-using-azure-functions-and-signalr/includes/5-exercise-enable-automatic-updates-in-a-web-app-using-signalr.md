To add SignalR to this prototype, you need to create:

* An Azure SignalR resource
* A few new functions to support SignalR
* Update the client to support SignalR

## Create a SignalR resource

You need to create an Azure SignalR resource.

1. Return to the terminal to create the SignalR resource. 
1. Navigate to the `setup-resources` subdirectory to create the resource.

    ```bash
    cd stock-prototype/setup-resources && bash create-signalr-resources.sh & cd ..
    ```

1. Copy the connection string for the SignalR resource. You'll need this to update the server code.

    | Resource Type | Environment variable |
    |--|--|
    |Azure SignalR|Referred to as SIGNALR_CONNECTION_STRING|

## Update server configuration environment variables

In **./start/server/local.settings.json**, add a variable to the **Values** object named `SIGNALR_CONNECTION_STRING` with the value listed in the terminal and save the file.

## Create the `signalr-open-connection` function

The web client uses the SignalR client SDK to establish a connection to the server. The SDK retrieves the connection via a function named **signalr-open-connection** to connect to the service.

1. Open the Visual Studio Code command palette by pressing **F1**.

1. Search for and select the **Azure Functions: Create Function** command.
1. Choose **Set default** then select **start/server** to set the location of the Function app.
1. Select **Yes** when asked to **Initialize project for use with VS Code?**. 

1. When prompted, provide the following information.

    | Name                | Value                          |
    | ------------------- | ------------------------------ |
    | Template            | HTTP Trigger                   |
    | Name                | signalr-open-connection        |

    A file named *signalr-open-connection.ts* is now available at `./start/server/src/functions`.

1. Open *signalr-open-connection.ts* and replace the everything with the following code.

    :::code language="typescript" source="~/../microsoftdocs-mslearn-advocates-azure-functions-and-signalr/solution/server/src/functions/signalr-open-connection.ts" :::


    The SignalR connection information is returned from the function.

## Create the `signalr-send-message` function

1. Open the Visual Studio Code command palette by pressing **F1**.
1. Search for and select the **Azure Functions: Create Function** command.
1. Select the location of the Function app as **start/server**.

1. When prompted, provide the following information.

    | Name                | Value                          |
    | ------------------- | ------------------------------ |
    | Template            | Azure Cosmos DB trigger                   |
    | Name                | `signalr-send-message`        |
    | Cosmos DB connection string | COSMOSDB_CONNECTION_STRING | 
    | Database name to be monitored | `stocksdb`|
    | Collection name | `stocks` |
    | Checks for existence and automatically creates the leases collection|true|

    Refresh the Explorer window in Visual Studio Code to see the updates. A file named *signalr-open-connection* is now available at `./start/server/src/functions`.
1. Open *signalr-send-message.ts* and replace the everything with the following code. 

    :::code language="typescript" source="~/../microsoftdocs-mslearn-advocates-azure-functions-and-signalr/solution/server/src/functions/signalr-send-message.ts" :::

* **Define incoming data**: The `comingFromCosmosDB` object defines the Cosmos DB trigger to watch for changes.
* **Define outgoing transport**: The `goingOutToSignalR` object defines the same SignalR connection. The hubName is the same hub `default`.
* **Connect data to transport**: The `dataToMessage` gets the _changed_ items in the `stocks` table and sends each changed item individually through SignalR using the `extraOutputs` using the same hub `default`. 
* **Connect to app**: The `app.CosmosDB` ties the bindings to the function name `send-signalr-messages`. 

## Commit changes and push to GitHub

1. In the terminal, commit the changes to the repository.

    ```bash
    git add .
    git commit -m "Add SignalR functions"
    git push
    ```

## Create the `signalr-send-message` function

Create a function app and related resources in Azure to which you can publish the new functions code.

1. Open the [Azure portal](https://portal.azure.com/#create/Microsoft.FunctionApp) to create a new functions app.
1. Use the following information to complete the resource creation **Basics** tab.

    | Name                                   | Value                          |
    | -------------------------------------- | ------------------------------ |
    | Resource group                         | Create a new resource group names `stock-prototype`.|
    | Function App name                      | Postpend your name to `api`. For example, `api-jamie`.|
    | Code or container                          | Select **code**.                       |
    | Runtime stack                        | Select **Node.js**.                       |
    | Version            |  Select an LTS version of Node.js.                    |
    | Region  | Select a region close to you.                           |
    | Operating System | Select **Linux**.|
    | Hosting | Select **Consumption Plan**.|

1. Don't fill out any other tabs and select **Review + create** then select **Create**. Wait for the deployment to complete before continuing.
1. Select **Go to resource** to open the new function app.

## Configure the GitHub deployment

Connect your new function app to the GitHub repository to enable continuous deployment. In a production environment, you would instead deploy code changes to a staging slot before swapping them into production. 

1. In the Azure portal page for the new function app, select **Deployment Center** from the left-hand menu.
1. Select **Source** of **GitHub**.
1. Use the following information to complete the deployment configuration.

    | Name                                   | Value                          |
    | -------------------------------------- | ------------------------------ |
    | Organization    | Select your GitHub account.                       |
    | Repository                        | Search for and select `mslearn-advocates.azure-functions-and-signalr`.                       |
    | Branch            | Select the **main** branch.                    |
    | Workflow Option| Select **Add a workflow ...**.|
    | Authentication type | Select **User-assigned-identity**.|
    | Subscription | Select the same subscription as seen at the top of the page. |
    | Identity | Select **Create new**.|

1. Select **Save** at the top of the section to save the settings. This creates a new workflow file in your forked repository.
1. This deployment configuration creates a GitHub Actions workflow file in the repository. You need to update the workflow file to use the correct package path for the function app.

## Edit GitHub deployment workflow

1. In Visual Studio Code terminal, pull down the new workflow file from your fork (origin). 

    ```bash
    git pull origin main
    ```

    This should place a new folder at **.github** with a path to your workflow file: `.github/workflows/main_RESOURCE_NAME.yml where RESOURCE_NAME is the Azure Functions app name. 

1. Open the workflow file. 
1. Change the `name` value at the top of the file to `Server`.
1. Because the source repository has the Azure Functions app in a subdirectory, the action file needs to change to reflect that. In the **env** section, add a new variable named `PACKAGE_PATH` to use the package path. 

    ```YAML
    env:
      PACKAGE_PATH: 'start/server'
    ```

1. Find the **Resolve Project Dependencies Using Npm** step and replace the contents with the following YAML to also use the package subdirectory path. The critical change is the path in the `pushd` command to include the `env.PACKAGE_PATH` variable.

    :::code language="yaml" source="~/../microsoftdocs-mslearn-advocates-azure-functions-and-signalr/example-server-workflow.yml" range="29-36":::
    
1. Find the **Zip artifact for deployment** step and replace the contents with the following YAML to also use the package subdirectory path. 

    :::code language="yaml" source="~/../microsoftdocs-mslearn-advocates-azure-functions-and-signalr/example-server-workflow.yml" range="45-49":::

    The zip file is placed at the root of repository so the `../` value is necessary to place the zip file at the root.

1. Save the file and commit the changes to the repository.

    ```bash
    git add .
    git commit -m "Update deployment workflow to use package path"
    git push
    ```

    This change will trigger the workflow to run. You can watch the workflow from the **Actions** section of the fork on GitHub.

## Configure the environment variables for the API functions

1. In the Azure portal, select **Settings -> Configuration** then select **New application setting**.
1. Enter the settings for the Cosmos DB and SignalR connection strings. You can find the values in the `local.settings.json` in the `start/server` folder. 

    | Name | Value |
    |--|--|
    | **COSMOSDB_CONNECTION_STRING** | The connection string for the Cosmos DB account. |
    | **SIGNALR_CONNECTION_STRING** | The connection string for the SignalR account. |

1. Select **Save** to save the settings.

## Test the deployment of the API Functions

1. In the Azure portal, select **Overview** and select **URL** to open the app in a browser. 
1. Copy the URL, you'll need that when you update the client `.env` file for the `BACKEND_URL` value when you work in Unit 7. 
1. Open the URL in a browser to test the API functions.
1. Append `/api/getStocks` to the URL in the browser and press **Enter**. You should see a JSON array with stock data.

You've updated the server code to return stocks with SignalR and you've deployed to a function app. Next, you'll update the client to use SignalR to receive updates.
