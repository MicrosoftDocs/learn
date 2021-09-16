ASP.NET Core SignalR is an open-source library that simplifies adding real-time web functionality to apps. Real-time web functionality enables server-side code to push content to clients instantly. In addition to this, clients can also send messages to the server &mdash; this is know as duplex communication.

## Example scenario

Imagine your part of a development team that is hired to fulfill a contractual obligation to deliver notifications to employees. The employees of **MilesLong (&trade;) Warehouse Incorporated** (a fictional company) maintain a warehouse of various goods. Employees work in different sections of the warehouse, performing a number of roles. The facility has many data points of concern, for example; when packages arrive where do they need to go, do they need to be put in long-form storage, do they need to be refrigerated, and so on? Likewise, where do various containers or packages need to be shipped to and when? The company needs a notification system developed from the ground up. The notification system requires real-time functionality, where notifications need to be communicated to clients as they occur on the server.

## What will we be doing?

In this module, you'll first learn the common nomenclature of ASP.NET Core SignalR to familiarize yourself with the terminology. You'll create a server application, which will expose a SignalR endpoint. The SignalR endpoint will be backed by a `Hub` subclass that contains methods that are invokable from clients and server alike. Additionally, it will expose events that clients will subscribe to. Then, you'll create a client app that will connect to the server's endpoint &mdash; with it's connection it can send and receive messages. Finally, you'll assert your knowledge of SignalR by answering a knowledge check.

## What is the main goal?

By the end of this session, you'll be able to create an ASP.NET Core SignalR server application. You'll be comfortable with all of the moving parts of real-time web functionality. You will be able to create a consuming client application, and have an understanding of how to call server code from the client, and listen for events.
