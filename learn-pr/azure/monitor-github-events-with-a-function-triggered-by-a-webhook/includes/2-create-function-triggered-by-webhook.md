You have decided on using Azure Functions to monitor the company GitHub Wiki for updates. Each time the Wiki is updated, you want to be able to trigger a function that would be able to process details about the update (such as updated date, contributor name etc.).  The first step is to create a Functions App that contains a function triggered by a webhook.  

In this unit, you'll learn about the benefits of using webhooks, and how you can trigger an Azure Function using webhooks.

## What is a webhook?

Webhooks are user-defined HTTP callbacks. They're triggered by some event, such as pushing code to a repo or updating a wiki page. When the event occurs, the source site makes an HTTP request to the URL configured for the webhook. Users can configure them to cause events on one site to run a Function App.

One common use of webhooks in a DevOps environment is to notify an Azure function that the code or configuration for an application has changed in GitHub. The payload of the message sent through the webhook contains the details of the event. You can use the webhook with a function to perform a task such as deploying the updated version of the application.

## Azure functions, triggers, and bindings (review)

In this module, we'll use a webhook to trigger an Azure function. Read the following to review Azure functions key concepts will use in the exercises:

Azure Functions is a serverless compute service. It enables you to run code without having to explicitly provision or manage any infrastructure. You can use Azure Functions to run script or code in response to a variety of events.

A *Trigger* causes a function to run. A trigger defines how a function is invoked. A function must have exactly one trigger. Triggers have associated data, which is often provided as the payload of the function.

A *Binding* is used to connect a resource to a function. You can define input bindings and  output bindings. Data from bindings is provided to the function as parameters. You can mix and match different bindings to suit your needs. Bindings are optional and a function might have one or multiple input and/or output bindings.

Triggers and bindings let you avoid hard-coding access to other services. Your function receives data (for example, the content of a queue message) in function parameters. You send data (for example, to create a queue message) by using the return value of the function.