In this module, you learned to implement an application that uses push technology in order to keep web clients automatically updated. To achieve your goal, you used Cosmos DB and Azure Functions in concert with SignalR to detect and broadcast changes in the database.

With this new application architecture your application enjoys the following benefits:

- An efficient web application architecture where communication between the client and the server happens only when data is changed
- Simple data change detection by using Azure Functions to listen to the Cosmos DB change feed
- Server-push architecture with a wide range of support for new and old browsers via SignalR
- Reduced response time down from five seconds to a little over a half second to automatically update the UI.

<!-- Cleanup sandbox -->
[!include[](../../../includes/azure-sandbox-cleanup.md)]