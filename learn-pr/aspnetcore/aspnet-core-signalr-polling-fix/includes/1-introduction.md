ASP.NET Core SignalR is an open-source library that simplifies adding real-time web functionality to apps. Real-time web functionality enables server-side code to push events to connected clients as they fire on the server. In addition to this, clients can also send messages to the server, thus exhibiting duplex communication.

## Learning objectives

In this module, you'll learn how to replace existing functionality in a client application. The application in question is a Blazor WebAssembly app and its implemented solution relies on client-side polling. Instead, you'll refactor the code to use ASP.NET Core SignalR.

## Blazing Pizza ordering app scenario

Imagine you're part of a development team that is hired to update an existing website's live map feature. The live map is part of an ordering system where customers of Blazing Pizza can track their order progress. The current solution is implemented using client-side polling for order status change updates. This method is less than ideal as it has the potential to flood the server with requests. Blazing Pizza has been getting reports of orders that fail to be processed, resulting in a loss of sales and potential repeat customers. The failures reported in the logs are around the peak hours of the sales day and are correlated to customers watching the live order map. Their clients are flooding the server with too many requests, and it fails. We'll use SignalR to address these concerns.

## What is the main goal?

By the end of this session, you'll be familiar with the process of identifying opportunities to use ASP.NET Core SignalR. You'll understand the steps involved to evaluate what code needs to change as part of refactoring to ASP.NET Core SignalR. You'll realize the benefits associated with using ASP.NET Core SignalR as an alternative to client-side polling.
