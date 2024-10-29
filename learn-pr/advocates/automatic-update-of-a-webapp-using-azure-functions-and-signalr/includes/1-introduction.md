
As an engineer with Tailwind Traders, you've learned your company is planning to launch a new website that provides stock price information to customers. Recently, an intern created a website prototype for the new application and the Lead Architect has now asked you to step in and improve the solution. Your objective is to update the app to implement automatic updates of the stock price information, but ensure communication between the client and server happens only when data changes on the server.

## Prototype architecture

The server prototype has 2 functions:

|Function name|Trigger type|Description|
|--|--|--|
|**getStocks**|Azure Cosmos DB|The server is responsible for reading all data from the stocks table in the database and returning that data in an HTTP response whenever the client requests it.|
|**setPrice**|Timer|A function to change the data in the database runs on a timer trigger. This simulates receiving changes from a backend system.|

As a prototype, the intern simulated the stock feed with a timer function, which updates every minute. The client website requests all the stocks from the `/api/getStocks` API endpoint every 5 seconds in an attempt to display near real time data. This client request isn't efficient. Instead of pulling the data from the server, it's more efficient for the server to push any new stock information. 

## Tasks to be done

In this module, you will:

- Run the prototype: View the client application, which polls the server for all stocks on a regular interval
- Improve the application: Implement a serverless Azure Functions app to broadcast changes to connected clients using SignalR Service to product near real-time updates.
- Update the client JavaScript web application to connect to SignalR to get and display the messages.
