Azure Functions is a cloud-based compute service that provides event-driven and scalable serverless compute for Azure. In some cases, you’re only billed for the time your function code runs.

You can use Azure Functions to run your code when you need it to run. For example, your code can run as the result of an event or change, such as when a message arrives in a queue or when a stored object is updated. You can also define a scheduled interval for your code to run by using `cron` rules.

## Use triggers to decide when to run code

Azure Functions lets you define triggers, which start the execution of your code. Triggers can also process inputs for passing data into your functions. Each function can have only one trigger. Some of the trigger types supported by Azure functions include:

- **Storage**: You can listen for events from databases like Azure Cosmos DB. For example, when a new row is inserted.
- **Events**: Event Grid and Event Hubs produce events that can trigger your code.
- **HTTP code**: Web requests and webhooks can trigger HTTP code.
- **Queues**: Queue messages can be processed, as well.
- **Timer**: Invoke code based on a specified time interval.

## Use bindings to connect to data sources

Bindings are ways to simplify coding for input and output data. While you can use a client SDK to connect to services from your function code, Azure Functions provides bindings to simplify these connections. Essentially, bindings are connection code you don’t have to write. You can integrate with many services on Azure and solve integration problems and automate business processes.

Bindings come in two flavors, input, and output. An *output binding* provides a way to write data to the data destination; for example, placing a message on a queue or a new row in a database. An *input binding* can be used to pass data to your function from a data source different than the one that triggered the function.

## Features

There are some features that makes Azure Functions a compelling choice:

- **Flexible hosting plans.** There are three different hosting plans to fit your business needs.

  - **Consumption plan**. A fully serverless hosting option for Functions. Functions scale automatically, and you pay for compute resources only when your functions are running. This plan provides cost-efficient compute for short process workloads that tend to be more intermittent with less-predictable loads.
  - **Premium plan**. In this plan, your functions are kept initialized, meaning there’s no delay after being idle. The Premium plan is a good plan to choose when your function app needs to run for longer periods, but you still need the dynamic scale. This plan also lets you start scaling with more resources faster than with the Consumption plan. In the Consumption plan there’s also limits on the execution time, which this plan can supersede. While you still get the cost benefits of dynamic scale, you pay more.
  - **Dedicated plan**. You run your functions with a regular App Service plan. It’s best for scenarios where your functions need to run continuously. Another benefit is that you fully control how the app scales and can more easily predict costs. A Dedicated plan is also a good choice when you have an existing but underutilized App Service plan available.

- **Dynamic scaling**. In most plans, functions are dynamically scaled based on load. When demand of execution increases, more resources are allocated automatically to the service and when requests fall, resources and application instances drop off automatically. In Consumption plan, you don’t pay at all for idle functions.

- **Event based architecture**. Functions are meant to be small and focused. They process incoming data and are done or raise a new event in turn. Some common usage areas of Azure functions are sending emails, starting backup, order processing, task scheduling such as database clean-up, sending notifications, messages, and IoT data processing.
