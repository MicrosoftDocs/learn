Azure Functions features a variety of language runtimes. If your language of choice is not provided by default, you can use a custom handler.

## What are custom handlers?

At its core, a custom handler is a web server. The web server receives events from the Functions host. You then have an opportunity to write code in your preferred language to respond to the events.

With custom handlers, you can use any language that supports HTTP primitives. That's nearly any language.

## Important concepts and flow

Azure Functions has three central concepts that are important to understand:

- **Triggers**. A trigger is an event that begins running a function. Examples of common triggers include HTTP requests, new queue messages, and changes to a database. Selecting the right trigger is important to deciding how your function runs.
- **Bindings**. Bindings are helper code that connects your function to another cloud service. Both input and output bindings are available to pass data in and out of your function.
- **Functions host**. The Functions host controls the application event flow. As the host captures events, it invokes the handler and is responsible for returning a function's response.

Here's what the flow looks like from start to finish:

:::image type="content" source="../media/azure-functions-custom-handlers-overview.png" alt-text="Diagram that shows an overview of custom handlers.":::

The following actions describe how a request is processed through the Functions host and a custom handler:

1. When an event occurs that matches a trigger (for example, an HTTP request), a request is sent to the Functions host.
1. The Functions host creates a request payload and sends that to the web server (custom handler). The payload contains information on the trigger, input binding data, and other metadata.
1. The function executes your logic, and a response is sent back to the Functions host.
1. The Functions host passes outgoing data to a function's output binding for processing.
