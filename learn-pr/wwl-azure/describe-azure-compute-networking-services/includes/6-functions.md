Azure Functions is an event-driven, serverless compute option that doesn’t require maintaining virtual machines or containers. If you build an app using VMs or containers, those resources have to be “running” in order for your app to function. With Azure Functions, an event wakes the function, alleviating the need to keep resources provisioned when there are no events.

:::image type="content" source="../media/functions-trigger-to-output.png" alt-text="Diagram showing event triggers activating the function runtime, which routes results to outputs like APIs, storage, and events.":::

## Serverless computing in Azure

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=bd90a678-3c03-4e0f-9470-f6f0626373e0]

## Benefits of Azure Functions

Using Azure Functions is ideal when you're only concerned about the code running your service and not about the underlying platform or infrastructure. Functions are commonly used when you need to perform work in response to an event (often via a REST request), timer, or message from another Azure service, and when that work can be completed quickly, within seconds or less.

Functions scale automatically based on demand, so they may be a good choice when demand is variable.

Azure Functions runs your code when it's triggered and automatically deallocates resources when the function finishes. In this model, Azure charges you only for the CPU time used while your function runs.

:::image type="content" source="../media/functions-serverless-economics.png" alt-text="Diagram showing serverless runs scale with events and bill only while running.":::

Functions can be either stateless or stateful. When they're stateless (the default), they behave as if they restart every time they respond to an event. When they're stateful (called Durable Functions), the runtime passes a context through the function to track prior activity.

Functions are a key component of serverless computing. They're also a general compute platform for running any type of code. If the needs of your app change, you can deploy the project in an environment that isn't serverless. This flexibility lets you manage scaling, run on virtual networks, and even completely isolate the functions.

