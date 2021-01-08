As with input bindings, there are multiple types of output bindings. However not all types support both input and output. You'll use them anytime you want to send or store data. Here, we'll look at the types that support output bindings and when to use them.

## Output binding types

- **Blob Storage** - You can use the blob output binding to write blobs.

- **Azure Cosmos DB** - The Azure Cosmos DB output binding lets you write a new document to an Azure Cosmos DB database using the SQL API.

- **Event Hubs** - Use the Event Hubs output binding to write events to an event stream. You must have send permission to an event hub to write events to it.

- **HTTP** - Use the HTTP output binding to respond to the HTTP request sender. This binding requires an HTTP trigger and allows you to customize the response associated with the trigger's request. This can also be used to connect to web hooks.

- **Microsoft Graph** - Microsoft Graph output bindings allow you to write to files in OneDrive, modify Excel data, and send email through Outlook.

- **Mobile Apps** - The Mobile Apps output binding writes a new record to a Mobile Apps table.

- **Notification Hubs** - You can send push notifications with Notification Hubs output bindings.

- **Queue Storage** - Use the Azure Queue storage output binding to write messages to a queue.

- **Send Grid** - Send emails using SendGrid bindings.

- **Service Bus** - Use Azure Service Bus output binding to send queue or topic messages.

- **Table storage** - Use an Azure Table storage output binding to write to a table in an Azure Storage account.

- **Twilio** - Send text messages with Twilio.

To create a binding as an output, you must define the `direction` as `out`. The parameters for each type of binding may vary.

## Combining input and output bindings

It's possible to apply multiple bindings to a single function. This allows you to define both input and output bindings, and the input and output can even be the same binding type.
