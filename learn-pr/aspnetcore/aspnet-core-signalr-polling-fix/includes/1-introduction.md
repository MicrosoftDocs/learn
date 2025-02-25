ASP.NET Core SignalR is an open-source library that simplifies adding real-time web functionality to apps. Real-time web functionality enables server-side code to push events to connected clients as they fire on the server. With SignalR, clients can also send messages to the server, an action that demonstrates duplex communication.

## Learning objectives

In this module, you learn how to replace existing functionality in a client application. The application is a Blazor WebAssembly app whose implemented solution relies on client-side polling. Here, you refactor the code to use ASP.NET Core SignalR.

## Blazing Pizza ordering app scenario

Imagine you're part of a development team that's going to update the live app feature of an existing website. The live map is part of an ordering system that lets Blazing Pizza customers track the progress of their orders.

The current solution is being implemented through client-side polling for order status updates. This method is less than ideal, because it has the potential to flood the server with requests. Blazing Pizza has been receiving reports of orders that fail to be processed, resulting in a loss of sales and, potentially, a loss of repeat customers.

The failures that are reported in the logs occur during peak hours of the sales day and are correlated with customers' watching the live order map. They're flooding the server with requests, and the process fails. In this module, you use SignalR to address these concerns.

## What is the main goal?

By the end of this session, you're familiar with the process of identifying opportunities to use ASP.NET Core SignalR. You understand the steps involved in evaluating what code needs to change as part of refactoring to ASP.NET Core SignalR. And you realize the benefits associated with using ASP.NET Core SignalR as an alternative to client-side polling.
