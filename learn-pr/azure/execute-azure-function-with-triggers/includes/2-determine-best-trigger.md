An Azure Functions app doesn't do work until something tells it to execute. For example, we could create an Azure Function to send out a reminder text message to our customers before an appointment. If we don't tell the function when it should run, our customers will never receive a message.

This unit describes triggers at a high level, explores the most common types of triggers, and uses bindings to connect a trigger to a function.

## What is a trigger?

A trigger is an object that defines how an Azure Function is invoked. For example, if you want a function to execute every 10 minutes, you could use a timer trigger.

Every function must have exactly one trigger associated with it. If you want to execute a piece of logic that runs under multiple conditions, you need to create multiple functions that share the same core function code.

In this module, we're going to focus on three trigger types: **timer**, **HTTP**, and **blob**.

## Types of triggers

Azure Functions supports a wide range of trigger types. Here are some of the most common types:

| Type | Purpose |
| --- | --- |
| **Timer** | Execute a function at a set interval. |
| **HTTP** | Execute a function when an HTTP request is received. |
| **Blob** | Execute a function when a file is uploaded or updated in Azure Blob storage. |
| **Queue** | Execute a function when a message is added to an Azure Storage queue. |
| **Azure Cosmos DB** | Execute a function when a document changes in a collection. |
| **Event Hub** | Execute a function when an event hub receives a new event. |

## What is a binding?

A binding is a connection to data within your function. Bindings are optional and can be input bindings, output bindings, or both. An input binding is the data that your function receives. An output binding is the data that your function sends.

Unlike a trigger, a function can have multiple input bindings and output bindings.

In the next exercise, we'll run a function on a schedule using a Timer trigger.
