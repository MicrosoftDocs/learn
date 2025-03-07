You have decided to use Azure Functions to monitor the company GitHub **wiki** for updates. Each time the wiki is updated, you want to be able to trigger a function that can process details about the update, such as updated date, contributor name, and so on. The first step is to create an Azure function app that contains a function triggered by a webhook.  

In this unit, you'll learn about the benefits of using webhooks, and how you can trigger an Azure Function using webhooks.

## What is a webhook?

Webhooks are user-defined HTTP callbacks. They're triggered by some event, such as pushing code to a repo or updating a wiki page. When the event occurs, the source site makes an HTTP request to the URL configured for the webhook. With Azure Functions, we can define logic in a function that runs when a webhook message is received.

One common use of webhooks in a DevOps environment is to notify an Azure function that the code or configuration for an application has changed in GitHub. The payload of the message sent through the webhook contains the details of the event. You can use the webhook with a function to perform a task such as deploying the updated version of the application.

## What is Azure Functions?

Azure Functions is a serverless compute service. It enables you to run code without having to explicitly provision or manage any infrastructure. You can use Azure Functions to run script or code in response to various events.

A *Trigger* causes a function to run. A trigger defines how a function is invoked. A function must have exactly one trigger. Triggers have associated data, which is often provided as the payload of the function.

A *Binding* is used to connect a resource to a function. You can define input bindings and output bindings. Data from a binding is provided to the function as parameters. For example, you can connect a database to your Azure Functions code by using a binding. Then you don’t need to wire up the database to the function with any connection code. Bindings are optional and a function might have one or multiple input and/or output bindings.