In order to update the application to support the new functionality, you need to create a few new functions and update the JavaScript on the client.

## Manage client connections

The web client uses the SignalR client SDK to establish a connection to the server. The SDK retrieves the connection via a function named **negotiate** (by convention) to connect to the service.

1. Open the Visual Studio Code command palette by pressing `CTRL/CMD+Shift+P`.
2. Search for and select the **Azure Functions: Create Function** command.
3. When prompted, provide the following information.

    | Name                | Value                          |
    | ------------------- | ------------------------------ |
    | Function app folder | select the main project folder |
    | Template            | HTTP Trigger                   |
    | Name                | negotiate                      |
    | Authorization level | Anonymous                      |

A folder named *negotiate* is now available in your function app. Open *negotiate/index.js* and add the following SignalR binding to the `bindings` array.

```json
{
    "type": "signalRConnectionInfo",
    "name": "connectionInfo",
    "hubName": "stocks",
    "direction": "in"
}
```

This configuration allows the function to return the connection information to the server which is used to identify connected clients. 

Next, open *negotiate/index.js* and update the function to use the following code.

```javascript
module.exports = async function (context, req, connectionInfo) {
    context.res.body = connectionInfo;
};
```

As the function is called, the SignalR connection is returned as the response to the function.

Now that the function responsible for managing connected clients is implemented, you can create a function responsible for pushing changes to the client.

## Detect and broadcast database changes

First, you need to create a new Azure Function that listens for changes in the database. This is possible by using the built-in Cosmos DB bindings.

1. Open the Visual Studio Code command palette by pressing `CTRL/CMD+Shift+P`.
2. Search for and select the **Azure Functions: Create Function** command.
3. When prompted, provide the following information.

    | Name                                   | Value                          |
    | -------------------------------------- | ------------------------------ |
    | Function app folder                    | select the main project folder |
    | Template                               | Azure Cosmos DB Trigger        |
    | Name                                   | stocksChanged                  |
    | App setting for your Cosmos DB account | AzureCosmosDBConnectionString  |
    | Database name                          | stocksdb                       |
    | Collection name                        | stocks                         |
    | Collection name for leases             | leases                         |
    | Create lease collection if not exists  | true                           |

Now a folder named *stocksChanged* is created and contains the files for the new function. Open *stocksChanged/function.json* in Visual Studio Code. Add a trailing comma after the last `cosmosDBTrigger` property and then add the property `"feedPollDelay": 500`. This setting tells the function to wait only a half second (500 milliseconds) after recognizing data changes before contacting connected clients.

The Cosmos DB binding for your function should now look like the following code.

```json
{
  "type": "cosmosDBTrigger",
  "name": "documents",
  "direction": "in",
  "leaseCollectionName": "leases",
  "connectionStringSetting": "AzureCosmosDBConnectionString",
  "databaseName": "stocksdb",
  "collectionName": "stocks",
  "createLeaseCollectionIfNotExists": "true",
  "feedPollDelay": 500
}
```

Next, add a SignalR binding to the function so that incoming changes may be broadcast to clients.

```json
{
  "type": "signalR",
  "name": "signalRMessages",
  "connectionString": "AzureSignalRConnectionString",
  "hubName": "stocks",
  "direction": "out"
}
```

The beauty of all the configuration is that the function code is simple. Update the *stocksChanged/index.js* file to reflect the following code.

```javascript
module.exports = async function (context, documents) {
    const updates = documents.map(stock => ({
        target: 'updated',
        arguments: [stock]
    }));

    context.bindings.signalRMessages = updates;
    context.done();
}
```

An array of changes is prepared by creating an object formatted to be read by SignalR. Every updated stock is provided to the `arguments` array along with a `target` property set to `updated`.

The value of the `target` property is used on the client when listening for specific messages broadcast by SignalR.

## Update the web application

Open index.html paste the the following code in place of the current DIV with the ID of `app`.

```html
<div id="app" class="container">
    <h1 class="title">Stocks</h1>
    <div id="stocks">
        <div v-for="stock in stocks" class="stock">
            <transition name="fade" mode="out-in">
                <div class="list-item" :key="stock.price">
                    <div class="lead">{{ stock.symbol }}: ${{ stock.price }}</div>
                    <div class="change">Change:
                        <span
                            :class="{ 'is-up': stock.changeDirection === '+', 'is-down': stock.changeDirection === '-' }">
                            {{ stock.changeDirection }}{{ stock.change }}
                        </span>
                    </div>
                </div>
            </transition>
        </div>
    </div>
</div>
```

This markup adds a transition element which allows Vue.js to add and remove CSS classes in order to achieve a subtle animation as stock data changes. When a stock is updated, the tile fades out and quickly back in to view. This way if the page is full of stock data, users can easily see which stocks have changed.

Next, add the following script block just above the reference to *index.html.js*.

```html
<script src="https://cdn.jsdelivr.net/npm/@aspnet/signalr@1.1.0/dist/browser/signalr.js"></script>
```

This script adds a reference to the SignalR SDK.

Now open *index.html.js* and replace the file with the following code.

```javascript
const LOCAL_BASE_URL = 'http://localhost:7071';
const REMOTE_BASE_URL = ''; // get value from portal

const getAPIBaseUrl = () => {
    const isLocal = /localhost/.test(window.location.href);
    return isLocal ? LOCAL_BASE_URL : REMOTE_BASE_URL;
}

const app = new Vue({
    el: '#app',
    data() {
        return {
            stocks: []
        }
    },
    methods: {
        async getStocks() {
            try {
                const apiUrl = `${getAPIBaseUrl()}/api/getStocks`;
                const response = await axios.get(apiUrl);
                app.stocks = response.data;
            } catch (ex) {
                console.error(ex);
            }
        },
        created() {
            this.getStocks();
        }
    }
});

const connect = () => {
    const connection = new signalR.HubConnectionBuilder()
                            .withUrl(`${getAPIBaseUrl()}/api`)
                            .build();

    connection.serverTimeoutInMilliseconds = (1000 * 60) * 5; // 5 minutes

    connection.onclose(()  => {
        console.log('SignalR connection disconnected');
        setTimeout(() => connect(), 2000);
    });

    connection.start().then(() => {
        console.log("SignalR connection established");
    });

    connection.on('updated', updatedStock => {
        const index = app.stocks.findIndex(s => s.id === updatedStock.id);
        app.stocks.splice(index, 1, updatedStock);
    });
};

connect();
```

The changes you just made accomplished two goals: removed all polling logic from the client and added handlers to listen for messages coming from the server.

When examining the script in sections, the script begins with a helper function that returns the base URL of the script. 

```javascript
const LOCAL_BASE_URL = 'http://localhost:7071';
const REMOTE_BASE_URL = ''; // get value from portal

const getAPIBaseUrl = () => {
    const isLocal = /localhost/.test(window.location.href);
    return isLocal ? LOCAL_BASE_URL : REMOTE_BASE_URL;
}
```

When you deploy the application to Azure, you will paste the appropriate remote URL value into the script allowing it to run either locally on your machine or deployed to the cloud.

The Vue.js-related code is streamlined now that changes are pushed to the client. Consider this segment of the code you just pasted in to the script file:

```javascript

const app = new Vue({
    el: '#app',
    data() {
        return {
            stocks: []
        }
    },
    methods: {
        async getStocks() {
            try {
                const apiUrl = `${getAPIBaseUrl()}/api/getStocks`;
                const response = await axios.get(apiUrl);
                app.stocks = response.data;
            } catch (ex) {
                console.error(ex);
            }
        },
        created() {
            this.getStocks();
        }
    }
});
```

The same stocks array is used here as in the previous implementation, but all the polling code is removed and the logic for `getStocks` remains unchanged. The `getStocks` function is still called as the component is created.

Next, consider this segment of the client code:

```javascript
const connect = () => {
    const connection = new signalR.HubConnectionBuilder()
                            .withUrl(`${getAPIBaseUrl()}/api`)
                            .build();

    connection.serverTimeoutInMilliseconds = (1000 * 60) * 5; // 5 minutes

    connection.onclose(()  => {
        console.log('SignalR connection disconnected');
        setTimeout(() => connect(), 2000);
    });

    connection.start().then(() => {
        console.log("SignalR connection established");
    });

    connection.on('updated', updatedStock => {
        const index = app.stocks.findIndex(s => s.id === updatedStock.id);
        app.stocks.splice(index, 1, updatedStock);
    });
};

connect();
```

When the page loads the `connect` function is called. In the body of the `connect` function, the first action is to use the SignalR SDK to create a connection by calling `HubConnectionBuilder`.  The result is a SignalR connection to the server.

Next, the server is set timeout after five minutes by setting the appropriate value to `serverTimeoutInMilliseconds`.

In order to gracefully recover after the server has timed out, the `onclose` handler reestablishes a connection two seconds after the connection has closed by calling `connect` again.

As the client receives messages from the server, it listens for messages via the `on('updated',...` syntax. Once an update is received, the following actions take place:

- The changed stock is located in the array.
- The old version is removed.
- The new version is inserted at the same index position in the array.

Manipulating the array using this approach allows Vue to detect changes in the data and trigger animation effects to notify users of changes.

## Update security settings

As the you run the application on your local machine, you need to update the CORS settings to grant the local web server access to the Azure Functions you created.

Open *local.settings.json* and paste the following code to replace the existing value for `Hosts`.

```json
  "Host" : {
    "LocalHttpPort": 7071,
    "CORS": "http://localhost:8080",
    "CORSCredentials": true
  }
```

Now when you run the web application in along with the functions server, the two can communicate with each other.

## Run the application

To see the updated application running locally, Press **F5** to start debugging the functions app.

Next, to run the web application on your machine, open a terminal and run `npm start`:

```bash
npm start
```

You can now navigate to [localhost:8080](http://localhost:8080) to see the application working in the browser.

## Observe automatic updates

Now you can make change to the application's data and observe how to the data is automatically updated. Since the update to the browser happens nearly immediately, consider having Visual Studio Code open one side of your screen and the running application on the other. This way you can see the UI update right after you issue the command to update the database.

Return to Visual Studio Code and enter the the following command in the integrated terminal and watch as the application automatically updates.

```bash
npm run update
```
