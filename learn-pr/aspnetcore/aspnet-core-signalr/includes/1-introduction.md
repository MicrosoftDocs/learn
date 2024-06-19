ASP.NET Core SignalR is an open-source library that simplifies adding real-time web functionality to apps. Real-time web functionality enables server-side code to push events to connected clients as they fire on the server. With SignalR, clients can also send messages to the server for duplex communications.

## Example scenario

Imagine you're part of a development team that's been asked to update the live app feature of an existing website. The live map is part of an ordering system that lets Contoso Pizza customers track the progress of their orders.

The current solution is implemented through client-side polling for order status change updates. This method is less than ideal, because it has the potential to flood the server with requests. Contoso Pizza has been receiving reports of orders that fail to be processed, resulting in a loss of sales and, potentially, loss of repeat customers.

The failures that are reported in the logs occur during peak hours of the sales day. When too many customers view the live order map at the same time, the server is overwhelmed with requests and the process fails. In this module, you'll use SignalR to address these concerns.

## What will we be doing?

In this module, you'll learn the common terminology associated with SignalR, what it is, and how it works. You'll learn when SignalR is appropriate to use and when it's not the best solution. Finally, you'll check your knowledge of SignalR by answering a few key questions.

## What is the main goal?

By the end of this session, you'll be familiar with SignalR terminology. You'll have a fundamental understanding of its capabilities and limitations. With this knowledge, you'll be able to help decide whether SignalR is a viable option for your team.
