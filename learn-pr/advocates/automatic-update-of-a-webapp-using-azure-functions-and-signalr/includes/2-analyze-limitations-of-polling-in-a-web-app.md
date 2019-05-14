![Polling-based web application](../media/serverless-app-polling-concept.png)

The application’s current architecture reports stock information by fetching changes from the server based on a timer. This type of design is accompanied by some significant drawbacks.

As the application scales, the amount of data exchanged between the client and server will become a problem. Each HTTP request header includes hundreds of bytes of data along with the session's cookie. All this overhead, especially when under heavy load, creates wasted resources and unnecessarily taxes the server.

Beyond bloated headers, timer-based polling is inefficient. In the prototype, the client application contacts the server regardless of whether or not there are any changes to the underlying data. Also, once data is returned from the server the entire list of stocks is updated on the web page - again - whether or not there are any changes in the data.

## Application design

Before you begin making changes to the application, first take a moment to get acquainted with the initial design of the application.

### Server

On the server, a Cosmos DB database is used for persistence. When called, an Azure Function configured with Cosmos DB bindings returns the database content.

The function named `getStocks` is responsible for returning all the stocks in the database. Connection to the Cosmos DB database is achieved through bindings which are configured in the *function.json* file:

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

The first binding (`httpTrigger`) in the array defines how the function is called.

| The configuration...                                        | via the property:        |
| ----------------------------------------------------------- | ------------------------ |
| defines the function as an HTTP-triggered function          | `type`                   |
| allows unauthenticated incoming requests                    | `authLevel`, `direction` |
| accepts GET requests                                        | `methods`                |
| exposes the request context through a parameter named `req` | `name`                   |

The second binding (`http`) defines what is returned from the function.

| The configuration...                                         | via the property:   |
| ------------------------------------------------------------ | ------------------- |
| allows the function to return an HTTP response               | `type`, `direction` |
| exposes the response context through a parameter named `res` | `name`              |

The third binding (`cosmosDB`) establishes a connection to Cosmos DB. The configuration:

| The configuration...                                         | via the property:         |
| ------------------------------------------------------------ | ------------------------- |
| makes Cosmos DB data available as the function is called     | `type`, `direction`       |
| exposes the data to the function through a parameter named `stocks` | `name`                    |
| connects to the Cosmos DB data with a connection string      | `ConnectionStringSetting` |
| points to a the `stocksdb` database                          | `databaseName`            |
| points to the `stocks` data collection                       | `collectionName`          |

With these bindings, GET requests made to `getStocks` has data available through the `stocks` parameter. In fact, this configuration makes the code for the function trivial.

```javascript
module.exports = async function (context, req, stocks) {
    context.res.body = stocks;
};
```

### Client

The client uses Vue.js for to compose the UI and the axios library to handle requests to the Azure Function.

> [!NOTE]
> The web client is written in Vue.js, but this is not a requirement or even a recommendation. Other applications using the same underlying application architecture could use any UI framework or even be implemented using vanilla JavaScript.

The logic implemented on the page includes the use of a timer to send a request to the server every five seconds. The response returns an array of stocks which are then displayed to the user.

```javascript
const LOCAL_BASE_URL = 'http://localhost:7071';
const REMOTE_BASE_URL = '<FUNCTION_APP_ENDPOINT>';

const getAPIBaseUrl = () => {
    const isLocal = /localhost/.test(window.location.href);
    return isLocal ? LOCAL_BASE_URL : REMOTE_BASE_URL;
}

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
                const apiUrl = `${getAPIBaseUrl()}/api/getStocks`;
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

## Supporting CORS

In the *local.settings.json* file, the `Host` section includes the following settings.

```json
  "Host" : {
    "LocalHttpPort": 7071,
    "CORS": "http://localhost:8080",
    "CORSCredentials": true
  }
```

This configuration tells the locally-running function app that a web application running at *localhost:8080* is allowed to make requests to functions running at *localhost:7071*. The property `CORSCredentials` tells function app to accept credential cookies from the request.

Now that you're more familiar with the starting point of the application, it's time to get the application running on your machine.