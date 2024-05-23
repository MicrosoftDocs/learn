![Polling-based web application.](../media/serverless-app-polling-concept.png)

The application's current architecture reports stock information by fetching _all_ stock price information from the server based on a timer. This design is often called a polling-based design. 

### Server

The stock price information is stored in an Azure Cosmos DB database. When triggered by an HTTP request, the function `getStocks` returns all rows from the database.


:::code language="typescript" source="~/../microsoftdocs-mslearn-advocates-azure-functions-and-signalr/start/server/src/functions/getStocks.ts" :::

* **Get data**: The first section of code, **cosmosInput**, gets all the items in the `stocks` table, with the query `SELECT * from c`, in the `stocksdb` database in Cosmos DB. 
* **Return data**: The second section of code, **app.http**, receives that data into the function as an input in `context.extraInputs` then returns it as the response body back to the client. 


### Client

The sample client uses Vue.js to compose the UI and the Fetch client to handle requests to the API.

The HTML page uses a timer to send a request to the server every five seconds to request stocks. The response returns an array of stocks, which are then displayed to the user.

:::code language="html" source="~/../microsoftdocs-mslearn-advocates-azure-functions-and-signalr/start/client/index.html" :::

:::code language="javascript" source="~/../microsoftdocs-mslearn-advocates-azure-functions-and-signalr/start/client/src/index.js" :::

Once the `startPoll` method begins polling, the `update` method is called every five seconds. Inside the `update` method, a GET request is sent to the `/api/getStocks` API endpoint and the result is set to `app.stocks`, which updates the UI.

The server and client code is relatively straightforward: get all data, display all data. As we find out in our analysis, this simplicity brings with it some limitations.

## Analysis of prototype solution

As a Tailwind Traders engineer, you've identified some of the drawbacks of this timer-based polling approach.

* **Unnecessary API requests**: In the timer-based polling prototype, the client application contacts the server whether or not changes exist to the underlying data. 
* **Unnecessary page refreshes**: Once data is returned from the server, the entire list of stocks is updated on the web page, even if no data has changed. This polling mechanism is an inefficient solution.
* **Polling intervals**: Selecting the best polling interval for your scenario is also a challenge. Polling forces you to make a choice between how much each call to the backend costs and how quickly you want your app to respond to new data. Delays often exist between the time that new data becomes available and the time that the app detects it. The following illustration shows the issue.

    ![An illustration showing a timeline and a polling trigger checking for new data every five minutes. New data becomes available after seven minutes. The app isn't aware of the new data until the next poll, which occurs at 10 minutes.](../media/polling-example.png)
    
    In the worst case, the potential delay for detecting new data is equal to the polling interval. So why not use a smaller interval?

* **Amount of data**: As the application scales, the amount of data exchanged between the client and server becomes a problem. Each HTTP request header includes hundreds of bytes of data along with the session's cookie. All this overhead, especially when under heavy load, creates wasted resources and unnecessarily taxes the server.

Now that you're more familiar with the prototype, it's time to get the application running on your machine.


## Supporting CORS

In the *local.settings.json* file of the Functions App, the `Host` section includes the following settings.

:::code language="json" source="~/../microsoftdocs-mslearn-advocates-azure-functions-and-signalr/start/server/sample.local.settings.json" :::

This configuration allows a web application running at *localhost:3000* to make requests to the function app running at *localhost:7071*. The property `CORSCredentials` tells the function app to accept credential cookies from the request.

Cross-origin resource sharing (CORS) is an HTTP feature that enables a web application running under one domain to access resources in another domain. Web browsers implement a security restriction known as same-origin policy that prevents a web page from calling APIs in a different domain; CORS provides a secure way to allow one domain (the origin domain) to call APIs in another domain. 

When running locally, CORS is configured for you in the sample's local.settings.json file, which is never published. When you deploy the client app (unit 7), you have to also update the CORS settings in the function app to allow access from the client app. 