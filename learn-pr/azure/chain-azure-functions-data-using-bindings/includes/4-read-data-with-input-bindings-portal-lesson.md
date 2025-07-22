To connect to a data source, you need to configure an *input binding*. An input binding makes it possible to write minimal code to create a message. You don't need to write code for tasks, such as opening a storage connection; the Azure Functions runtime and binding take care of those tasks for you.

## Input binding types

Azure chain functions can have multiple types of input. However, not all types support both input and output. Use an input function whenever you want to ingest data of that type. Here, we look at the input function types that support input bindings and when to use them.

- **Azure Blob Storage**: Blob Storage bindings allow you to read from a blob.

- **Azure Cosmos DB**: Azure Cosmos DB input bindings use the SQL API to retrieve one or more Azure Cosmos DB documents, and pass them to the input parameter of the function. The document ID, or query parameters, can be determined based on the trigger that invokes the function.

- **Mobile Apps**: A Mobile Apps input binding loads a record from a mobile table endpoint and passes it into your function.

- **Azure Table storage**: You can read data and work with Azure Table storage.

A full listing of supported bindings is available [here.](/azure/azure-functions/functions-triggers-bindings?tabs=csharp#supported-bindings)

To create a binding as an input, you must define `direction` as `in`. The parameters for each type of binding might vary.

## What is a binding expression?

A binding expression is specialized text in *function.json*, function parameters, or code that is evaluated when the function is invoked to yield a value. For example, if you have a Service Bus Queue binding, you could use a binding expression to obtain the name of the queue from App Settings.

### Types of binding expressions

There are several types of binding expressions, including:

- App settings
- Trigger filename
- Trigger metadata
- JSON payloads
- New GUID
- Current date and time

Most binding expressions are identified by being wrapped in curly braces. However, app setting binding expressions are wrapped in percent signs rather than curly braces. For example, if the blob output binding path is `%Environment%/newblob.txt`, and the Environment app setting value is *Development*, a blob is created in the Development container.

## Summary

Input bindings allow you to connect your function to a data source. You can connect to several types of data sources, and the parameters for each vary. To resolve values from input sources, use binding expressions in the *function.json* file, in function parameters, or in code.
