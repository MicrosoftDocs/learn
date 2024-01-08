As the lead developer at a picture-frame company, you've been asked to research Azure Logic Apps and the included connector types. Your goal is to connect from Azure Logic Apps to an in-house, custom-built Web API that estimates framing prices.

Let's get started by learning about Azure Logic Apps and this platform's ability to monitor events and carry out actions.

## What is Azure Logic Apps?

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4qhug]

Azure Logic Apps is a cloud service you can use to integrate apps, services, systems, and data within your enterprise or across organizations. This integration platform helps simplify how you design and build scalable solutions in the cloud, on premises, or both.

## What can you do with Azure Logic Apps?

You can orchestrate data and tasks among multiple services and systems into a single workflow using Azure Logic Apps. For example, a workflow can perform the following tasks by connecting to common business systems using connectors or create your own connectors to access custom or unique systems through REST APIs:

- Send an email notification when an event occurs.
- Move files to Azure Storage from servers in your organization.
- Monitor social media activity, analyze sentiment, and send alerts when a business-critical post is published.

Azure Logic Apps can do all these things without the need to rebuild or redeploy code.

## Components in Azure Logic Apps

*Connectors* are components in Azure Logic Apps that help you communicate with an external service. Each connector has various operations, which can include *triggers* that launch a workflow, *actions* that perform tasks, or both.

### Azure Logic Apps connectors

Azure Logic Apps offers hundreds of connectors, which fall into the following main groups:

| Connector group | Description |
|-----------------|-------------|
| **Built-in** | Triggers and actions that natively run on the Azure Logic Apps runtime. Some integrate directly with specific Azure services without having to create a connection; for example, Azure Functions. |
| **Managed** | Triggers and actions that call other services and systems. These operations usually require that you create a connection first. These connectors are hosted and run in Azure and are managed by Microsoft. Managed connectors can fall across the following subgroups: <br><br>- **Standard connectors**: Triggers and actions that integrate with Azure Storage, Microsoft 365, Microsoft Dynamics, Microsoft Power BI, and more. <br><br>- **Enterprise connectors**: Triggers and actions that can access enterprise systems such as SAP, IBM Message Queue, and others for an extra cost. <br><br>- **On-premises connectors**: Triggers and actions that integration with on-premises SQL Server, SharePoint Server, Oracle, file shares, and more. <br><br>- **Integration account connectors**: Triggers and actions that transform and validate XML, encode and decode flat files, and process business-to-business (B2B) messages with AS2, EDIFACT, and X12 protocols. |
|||

### Triggers in Azure Logic Apps

A trigger always starts a workflow in Azure Logic Apps. For example, you can use a Request trigger that waits for an inbound call or request from elsewhere to start a workflow. Subsequent actions can send an email, run operations on a data store, and post some content to a social media site.

Triggers have the following general types, which reflect their uses in various scenarios.

- ***Polling*** **trigger**: This trigger type runs on a schedule and sends an outbound call that checks for data or an event that meets specific conditions. Whenever data or an event meets the conditions, the trigger starts a new workflow execution.

- ***Push*** **trigger**: This trigger type waits and listens for data or an event that meets specific conditions. Each time that data or an event meets the conditions, the trigger starts a new workflow execution.

Triggers can be specific to a service or system, or they can be generic. For example, generic triggers include the Recurrence trigger and Request trigger, which you can use to start any workflow.
