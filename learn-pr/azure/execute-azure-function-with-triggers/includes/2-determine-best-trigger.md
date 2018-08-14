An Azure Function is useless if there’s nothing to tell it when to execute. For example, using the situation from the previous unit, we could create an Azure Function to send out a reminder text message to our customers. However, if we don’t tell the function when it should run, our customers will never be reminded. 

Here, you will examine triggers at a high-level and explore the most common types of triggers.

## What is a trigger?

A trigger is a service that defines how an Azure Function is invoked. For example, if you wanted a function to execute every 10 minutes, you could use a timer trigger.

Every function must have exactly one trigger associated with it. This means that if you wanted to execute a piece of logic under multiple conditions you would need to create multiple functions.

## What is a binding?

A binding is a connection to data within your function. Bindings are optional and come in the form of input and output bindings. An input binding is the data your function receives, and an output binding is the data your function sends.

Unlike a trigger, a function can have multiple input and output bindings.

## Types of triggers

Azure Functions support a wide range of trigger types for the most common situations that a company would encounter. Here are some common triggers that you'll see:

| Type | Purpose | 
| --- | --- | 
| **Timer** | Executes a function at a set interval. | 
| **HTTP** | Executes a function when receiving an HTTP request. |  
| **Blob** | Executes a function when a file is uploaded or updated in Azure Blob storage. | 
| **Queue** | Executes a function when a message is added to an Azure Storage queue. | 
| **Cosmos DB** | Executes a function when a document changes in a collection. | 
| **Event Hub** | Executes a function when an event hub receives a new event. | 

In this module, we're going to focus on timer, HTTP, and blob.

## Summary

To execute and Azure Function we need to wire-up a trigger. Timer, HTTP, and blob triggers are some common types of triggers and can help solve a large portion of your business needs.



