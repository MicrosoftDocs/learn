The new approach you want to implement is possible by threading together three different technologies: Cosmos DB, Azure Functions, and SignalR.

Cosmos DB globally distributed database

As data changes in the database, Cosmos DB exposes a "change feed". This feed lists the changes made to the database and is updated every time a document is created, modified or deleted. By listening to the change feed your application can automatically respond to data changes.

Azure Functions ships with a binding that runs code anytime there is an update to the Cosmos DB change feed. Once a  function is listening to the change feed, then you can work with a sub-set of your data that just represents data changes.

\* TODO: add more SignalR info

Finally, by leveraging SignalR, you can broadcast information from the change feed to connected clients.
