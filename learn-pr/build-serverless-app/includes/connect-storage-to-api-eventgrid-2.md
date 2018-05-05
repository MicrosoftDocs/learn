## Overview of Azure Event Grid

By using Event Grid, you can easily build applications with event-based architectures. You select the Azure resource that you want to subscribe to, and you provide the event handler or webhook endpoint to send the event to. Event Grid has built-in support for events coming from Azure services, such as Blob storage and resource groups. Event Grid also provides custom support for application and third-party events, using custom topics and custom webhooks.

## Concepts

As you get going, keep in mind the following five Event Grid concepts:

* **Events**: What happened.
* **Event sources/publishers**: Where the event took place.
* **Topics**: The endpoint where publishers send events.
* **Event subscriptions**: The endpoint or built-in mechanism to route events, sometimes to multiple handlers. Subscriptions are also used by handlers to intelligently filter incoming events.
* **Event handlers**: The app or service reacting to the event.

## What can I do with Event Grid?

Event Grid provides several capabilities that vastly improve serverless, ops automation, and integration work: 

* **Serverless application architectures**: Event Grid connects data sources and event handlers. For example, use Event Grid to instantly trigger a serverless function to run image analysis each time a new photo is added to a Blob storage container. 
* **Ops Automation**: Event Grid speeds automation and simplifies policy enforcement. For example, Event Grid can notify Azure Automation when a virtual machine is created or a SQL Database instance is spun up. These events can be used to automatically check to ensure that service configurations are compliant, put metadata into operations tools, tag virtual machines, or file work items.
* **Application integration**: Event Grid connects your app with other services. For example, create a custom topic to send your app's event data to Event Grid, and take advantage of its reliable delivery, advanced routing, and direct integration with Azure. Alternatively, you can use Event Grid with Logic Apps to process data anywhere, without writing code. 

Let's go ahead and set up Event Grid to process the images that are uploaded to your website.
