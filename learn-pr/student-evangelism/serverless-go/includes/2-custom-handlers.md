Azure Functions features a variety of language runtimes out-of-the-box. In instances where your language of choice is not provided by default, you can use a custom handler. Custom handlers give you the flexibility to use any language you prefer with Azure Functions.

## What are custom handlers?

At its core, a custom handler is a web server. The web server receives events from the Functions host, giving you the opportunity to write code in your preferred language to respond to the events.

What languages can you use with custom handlers? The answer is, any language that supports HTTP primitives. Think about that for a second, that's nearly any language.

## Important concepts and flow

Azure Functions has three central concepts that are important to understand:

- **Triggers**. A trigger is an event that begins running a function. Examples of common triggers include HTTP requests, new queue messages, and changes to a database. Selecting the right trigger is important to deciding how your function runs.
- **Bindings**. Bindings are helper code that connects your function to another cloud service. Both input and output bindings are available to pass data in and out of your function.
- **Functions host**. The Functions host controls the application event flow. As the host captures events, it invokes the handler, and is responsible for returning a function's response.

Here's what the flow looks like from start to finish:

:::image type="content" source="../media/azure-functions-custom-handlers-overview.png" alt-text="Diagram showing a custom handlers overview.":::

The following actions describe how a request processed through the Functions host and a custom handler.

1. **An event occurs:** When an event occurs that matches a trigger (for example, an HTTP request), a request is sent to the Functions host.
1. **Request payload created:** The Functions host then creates a request payload and sends that to the web server (custom handler). The payload contains information on the trigger, input binding data, and other metadata.
1. **Function execution:** At this point, the function executes your logic and a response is sent back to the Functions host.
1. **Outputs processed:** Outgoing data is passed to a function's output binding by the Functions host.
