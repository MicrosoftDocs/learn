As the senior lead developer at a picture framing company, you have been asked to research  Logic Apps and the types of connectors provided. You want to connect Logic Apps to use an in-house Web API that estimates framing prices.

Let's get started by learning about Logic Apps and their ability to monitor events and carry out actions.

## What are Logic Apps?

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4qhug]

Azure Logic Apps is a cloud service that you can use to integrate apps, systems, data, and services within your enterprise or across organizations. They help to simplify how you design and build scalable solutions in the cloud, on-premises, or both.

## What can you do with a Logic App?

You can use Logic Apps to connect and orchestrate multiple systems into a single workflow. For example, a workflow can:

- Send an email notification when an event occurs.
- Move files to Azure Storage from servers in your organization.
- Monitor social media activity, perform sentiment analysis and create alerts when a post is critical to your business.
- Connect to common business systems by using built-in connectors.
- Connect to unusual or unique systems by using custom connectors that you create.

Logic Apps can do all of these things without the need to rebuild or redeploy code.

## Operations in Logic Apps

*Connectors* in Logic Apps enable you to communicate with an external service. Each connector has various operations available. Operations that can initiate a workflow are called *Triggers*. Operations that perform some task are called *Actions*.

## Logic Apps triggers

Triggers start a Logic Apps workflow. For example, an HTTP trigger could start a workflow that uses an action to send an email, carry out operations on a data store, or post some content to a social media site.

There are several categories of triggers, which reflect their usage in various scenarios:

- **Polling triggers** call your service at a specified frequency to check for new data. When new data is available, it causes a new execution of your workflow.
- **Push triggers** listen for data on an endpoint and wait for an event to occur. When raised, the event causes a new run of your workflow instance.
- **Recurrence triggers** create and run an instance of your logic app based on a schedule.

## Logic Apps connectors

Logic Apps offers over 200 built-in connectors. They fall into various categories:

- **Built-in connectors** have actions and triggers that integrate with Azure Apps and Functions.
- **Managed connectors** have triggers and actions that call other services and systems. These connectors are organized into subcategories.
- **Managed API connectors** have actions and triggers that integrate with Azure Blob Storage, Microsoft 365, Dynamics, Power BI, and more.
- **On-premises connectors** have actions and triggers that integrate with on-premise installations of SQL Server, SharePoint Server, Oracle, and file shares.
- **Integration account connectors** transform and validate XML, encode and decode flat files, and process business-to-business (B2B) messages with AS2, EDIFACT, and X12 protocols.
- **Enterprise connectors** provide access to enterprise systems such as SAP, IBM Message Queue, etc.
