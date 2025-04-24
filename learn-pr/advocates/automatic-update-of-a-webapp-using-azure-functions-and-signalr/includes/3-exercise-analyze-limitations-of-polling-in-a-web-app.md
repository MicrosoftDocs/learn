Before you change the prototype, you need to run it to validate the assumptions. The prototype is in a source code repository on GitHub.  

## Create Azure resources

1. In a separate browser tab or window, fork the sample repository on GitHub with the following link: [mslearn-advocates.azure-functions-and-signalr](https://github.com/MicrosoftDocs/mslearn-advocates.azure-functions-and-signalr/fork). This fork allows you to push your changes to your own version of the source code. This step is required in order to deploy the source code to Azure later in the module.

1. In the terminal, clone your forked repository. In the following command, replace `<YOUR-GITHUB-ALIAS>` with your account:

    ```bash
    git clone https://github.com/<YOUR-GITHUB-ALIAS>/mslearn-advocates.azure-functions-and-signalr stock-prototype
    ```

1. Ensure that you're in the **stock-prototype** folder `cd stock-prototype` if needed). Install the dependencies in the **setup-resources** folder.

    ```bash
    cd setup-resources && npm install
    ```

    If you receive warnings about `EBADENGINE`,  you can ignore them.

1. Sign in to Azure with the Azure CLI.

    ```bash
    az login
    ```

1. In the browser that opens, sign in to your Azure account.

The Visual Studio Code terminal displays a list of the subscriptions associated with this account.

1. In the list, find the subscription that you want to use for this exercise.

   If you missed the list from the sign-in, you can use the following snippet to list your subscriptions again.

    ```bash
    az account list --output table
    ```

1. To set the default subscription, replace `YOUR-SUBSCRIPTION-ID` with a subscription ID from the previous Azure CLI output.

    ```bash
    az account set --subscription <YOUR-SUBSCRIPTION-ID>
    ```

    This default subscription is used to create the Azure resources.

1. Create the Azure resources and upload the sample data to the database. The process can take a few minutes to complete.

    ```bash
    bash create-start-resources.sh "<YOUR-SUBSCRIPTION-NAME>"
    ```

    Make sure you wrap the name in double quotes. If the script generates an error about the location lacking available resources, edit the script to change the location: `LOCATION=<NEW LOCATION>`.

1. Copy the following information from the output and save it. You need it to run the prototype.

    | Resource Type | Environment variable |
    |--|--|
    |Azure Cosmos DB|Referred to as COSMOSDB_CONNECTION_STRING|
    |Azure Storage|Referred to as STORAGE_CONNECTION_STRING|
    |Resource Group|Referred to as RESOURCE_GROUP_NAME.|

1. At the terminal, still in the `setup-resources` directory, use a Node.js script to upload sample data into the database with the following command.

    ```bash
    npm start
    ```

    The output shows the starting data for the fictitious stock application:

    ```console
    Seed data added. Symbol ABC
    Seed data added. Symbol DEF
    Seed data added. Symbol GHI
    ```

1. In the terminal, navigate to the **root** folder.

    ```bash
    cd ..
    ```

## Install dependencies and run the prototype

1. Install the dependencies.

    ```bash
    cd start/client && npm install && cd ../..
    cd start/server && npm install && cd ../..
    ```

1. If the notification asks you to select an Azure functions app for the workspace, select `start/server`. In a later step, you use this function app to run the server-side code.

1. If you receive a notification about installing the latest Azure Functions Core Tools, select **Install**.

## Get the client and server URLs

When you're running locally, the client and server applications need to know where to find each other. The URLs are:

- **Client**: http://localhost:3000
- **Server**: http://localhost:7071

## Update local settings for the Azure Functions app

Add the connection strings to the prototype's Azure Functions app. 

1. Create the **./start/server/local.settings.json** file and paste in the following. This file has the configuration settings for the local functions project. 

    :::code language="json" source="~/../microsoftdocs-mslearn-advocates-azure-functions-and-signalr/start/server/sample.local.settings.json" :::

1. Update the following variables with the values you copied and saved earlier.

    |Property|Value|
    |--|--|
    |AzureWebJobsStorage|Replace with the Storage connection string.|
    |COSMOSDB_CONNECTION_STRING|Replace with the Cosmos DB connection string.|

    Now the Functions app can receive requests from the client, then connect to the database and correctly manage the timer trigger.

## Add local settings for the Client app

Add the server URL to the prototype's client application.

Open **./start/client** and create a `.env` file with the following contents. 

```
BACKEND_URL=http://localhost:7071
```

## Run the server application

1. Start the Azure Functions application by entering the following command in the terminal.

    ```bash
    cd start/server && npm start
    ```

1. Wait until the terminal displays the API endpoints.

    ```console
    Functions:
    
            getStocks: [GET] http://localhost:7071/api/getStocks
    
            setPrice: timerTrigger
    ```

## Run the client application

1. In a new terminal, start the client application.

    ```bash
    cd start/client && npm start

1. When the notification displays that the application is running, select **Open in Browser** to use the prototype.

    :::image type="content" source="../media/visual-studio-code-notification-open-browser-3000.png" alt-text="Screenshot of Visual Studio Code notification to open the browser.":::

1. Arrange your browser windows so you can see the terminal and the prototype of the stock prices at the same time.
1. In the prototype browser window, open the browser's developer tools. Notice the browser is making a request to the API every 5 seconds for all the data, even though the data isn't changed.
1. In the browser window, watch the output for the Azure Functions app. A single stock price changes every minute. When the price in the API changes, the next client fetch of all data includes that change.

    :::image type="content" source="../media/visual-studio-code-terminal-output-stock-change.png" alt-text="Screenshot of Visual Studio Code terminal showing console output of the stock price change.":::

1. In both the terminals for client and server, stop the applications with <kbd>Ctrl</kbd> + <kbd>C</kbd> or kill the terminal by selecting the trashcan icon.

In this unit, you ran the prototype. While the client does run successfully, it isn't efficient. Each individual client might not notice the inefficiency with just a few stocks. But it becomes more noticeable as the number of stocks grows and the number of clients that pull from the server grows. The prototype can be improved. Let's learn how in the next unit.