![Polling-based web application](../media/serverless-app-polling-concept.png)

The application’s current architecture reports stock information by fetching changes from the server based on a timer. This design is often called a polling-based design.  

Before we analyze any limitations, let's review the current architecture. The server is responsible for storing stock information and the client renders data in the browser.

We'll set up the current solution on your local machine in the next unit. 

### Server

The stock price information is stored on the server in an Azure Cosmos DB database. When triggered by an HTTP request, the function uses bindings to return content from the database.

The function named `getStocks` is responsible for reading the stock information from the database. As mentioned, the connection to the Azure Cosmos DB database is achieved by using an input binding. This binding is configured in the *function.json* file, as shown in the following snippet.

```json
{
  "bindings": [
    {
      "type": "httpTrigger",
      "authLevel": "anonymous",
      "direction": "in",
      "name": "req",
      "methods": ["get"]
    },
    {
      "type": "http",
      "direction": "out",
      "name": "res"
    },
    {
      "type": "cosmosDB",
      "direction": "in",
      "name": "stocks",
      "ConnectionStringSetting": "AzureCosmosDBConnectionString",
      "databaseName": "stocksdb",
      "collectionName": "stocks"
    }
  ]
}
```

The first binding (`httpTrigger`) in the array defines how the function is triggered.

| The configuration...                                        | via the property:        |
| ----------------------------------------------------------- | ------------------------ |
| defines the function as an HTTP-triggered function          | `type`                   |
| allows unauthenticated incoming requests                    | `authLevel`, `direction` |
| exposes the request context through a parameter named `req` | `name`                   |
| accepts GET requests                                        | `methods`                |

The second binding (`http`) defines what is returned from the function.

| The configuration...                                         | via the property:   |
| ------------------------------------------------------------ | ------------------- |
| allows the function to return an HTTP response               | `type`, `direction` |
| exposes the response context through a parameter named `res` | `name`              |

The third binding (`cosmosDB`) establishes a connection to Azure Cosmos DB.

| The configuration...                                         | via the property:         |
| ------------------------------------------------------------ | ------------------------- |
| makes an Azure Cosmos DB data available as the function is called     | `type`, `direction`       |
| exposes the data to the function through a parameter named `stocks` | `name`                    |
| connects to the Azure Cosmos DB data with a connection string      | `ConnectionStringSetting` |
| points to the `stocksdb` database                          | `databaseName`            |
| points to the `stocks` data collection                       | `collectionName`          |

With these bindings, GET requests to `getStocks` make data available through the `stocks` parameter. As you can see in the following code snippet, the function code to retrieve stock information is trivial thanks to the power of Azure Functions bindings. 

```javascript
module.exports = async function (context, req, stocks) {
    context.res.body = stocks;
};
```

### Client

The sample client uses Vue.js to compose the UI and the axios HTTP client to handle requests to the function.

<!--
    REVIEW:
    I removed the note about Vue.js because is was too apologetic and unnecessary

    CONCLUSION:
    Acknowledged
-->

The page uses a timer to send a request to the server every five seconds to request stocks. The response returns an array of stocks, which are then displayed to the user.

```javascript
const LOCAL_BASE_URL = 'http://localhost:7071';

const app = new Vue({
    el: '#app',
    interval: null,
    data() {
        return {
            stocks: []
        }
    },
    methods: {
        async update() {
            try {
                const apiUrl = `${LOCAL_BASE_URL}/api/getStocks`;
                const response = await axios.get(apiUrl);
                app.stocks = response.data;
            } catch (ex) {
                console.error(ex);
            }
        },
        startPoll() {
            this.interval = setInterval(this.update, 5000);
        }
    },
    created() {
        this.update();
        this.startPoll();
    }
});
```

The `update` method is called every five seconds once polling is started by the `startPoll` method. Inside the `update` method, a GET request is sent to the `getStocks` function and the result is set to `app.stocks` which updates the UI.

The server and client code is relatively straightforward but, as we'll see, this simplicity brings with it some limitations.

## Supporting CORS

<!-- 
    REVIEW:
    This section is very specific to running the app locally, whereas the analysis and setup aren't. I would consider placing this closer to the actual running of the app locally

    CONCLUSION:
    We decided to keep it as-is in order to avoid a large-scale content refactoring.
-->

In the *local.settings.json* file, the `Host` section includes the following settings.

```json
  "Host" : {
    "LocalHttpPort": 7071,
    "CORS": "http://localhost:8080",
    "CORSCredentials": true
  }
```

This configuration allows a web application running at *localhost:8080* to make requests to the function app running at *localhost:7071*. The property `CORSCredentials` tells function app to accept credential cookies from the request.

CORS is an HTTP feature that enables a web application running under one domain to access resources in another domain. Web browsers implement a security restriction known as same-origin policy that prevents a web page from calling APIs in a different domain; CORS provides a secure way to allow one domain (the origin domain) to call APIs in another domain. 

You can set CORS rules individually for each of the Azure Storage services, by calling Set Blob Service Properties, Set File Service Properties, Set Queue Service Properties, and Set Table Service Properties. Once you set the CORS rules for the service, then a properly authorized request made against the service from a different domain will be evaluated to determine whether it is allowed according to the rules you have specified.

## Analysis of current solution

Let's think about some of the drawbacks of this timer-based polling approach.

In the timer-based polling prototype, the client application contacts the server whether or not changes exist to the underlying data. Once data is returned from the server the entire list of stocks is updated on the web page - again - regardless of any changes in the data. This polling mechanism is an inefficient solution. 

Selecting the best polling interval for your scenario is also a challenging. Polling forces you to make a choice between how much each call to the backend costs and how quickly you want your app to respond to new data. Delays also often exist between when new data becomes available and when it's detected by the app. The following illustration shows the issue.

![An illustration showing a timeline and a polling trigger checking for new data every five minutes. New data becomes available after seven minutes. The app isn't aware of the new data until the next poll, which occurs at 10 minutes.](../media/polling-example.png)

In the worst case, the potential delay for detecting new data is equal to the polling interval. So why not use a smaller interval?

As the application scales, the amount of data exchanged between the client and server will become a problem. Each HTTP request header includes hundreds of bytes of data along with the session's cookie. All this overhead, especially when under heavy load, creates wasted resources and unnecessarily taxes the server.

Now that you're more familiar with the starting point of the application, it's time to get the application running on your machine.

<!-- 
    REVIEW:
    I'm still considering whether we install and run the app before this analysis. Let's discuss.

    CONCLUSION:
    We decided to leave as is, for cost/benefit reasons.
-->
