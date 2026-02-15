This unit covers the core implementation patterns for building an AI agent using the GitHub Copilot SDK. These patterns apply to any agent scenario. The code examples use C# and .NET, which is the platform used in the module exercise.

## Set up the GitHub Copilot SDK client

The first step is creating a `CopilotClient` instance that manages the connection to the Copilot CLI server. Typically, you register the client as a singleton service in your application.

### Install required packages

Add the GitHub Copilot SDK and the Microsoft.Extensions.AI package (used for tool definitions) to your project:

```bash
dotnet add package GitHub.Copilot.SDK
dotnet add package Microsoft.Extensions.AI
```

### Configure the client

Create a `CopilotClient` with `CopilotClientOptions` that control startup behavior and logging:

```csharp
var client = new CopilotClient(new CopilotClientOptions
{
    AutoStart = true,
    LogLevel = "info"
});
```

The `AutoStart` option tells the SDK to launch the Copilot CLI server process automatically when the first session is created. The `LogLevel` option controls the verbosity of SDK diagnostic output.

After creating the client, start it:

```csharp
await client.StartAsync();
```

This code establishes the connection to the CLI server and prepares the client for session creation.

## Define agent tools

Tools give the agent the ability to interact with your application's backend services. In the GitHub Copilot SDK for .NET, you define tools using `AIFunctionFactory.Create` from the `Microsoft.Extensions.AI` package.

### Create a tool service

A common pattern is to create a dedicated service class that contains all the tool methods your agent can call. Each method represents one action the agent can take:

```csharp
public class SupportAgentTools
{
    public async Task<string> GetOrderDetailsAsync(int orderId)
    {
        // Query the database for order information
        var order = await _dbContext.Orders.FindAsync(orderId);
        return order != null
            ? $"Order {orderId}: {order.ProductName}, Status: {order.Status}"
            : "Order not found.";
    }

    public async Task<string> ProcessReturnAsync(int orderId, string reason)
    {
        // Business logic to process the return
        var order = await _dbContext.Orders.FindAsync(orderId);
        order.Status = "Return Initiated";
        await _dbContext.SaveChangesAsync();
        return $"Return initiated for order {orderId}.";
    }
}
```

### Register tools with the SDK

Convert your service methods into tool definitions that the SDK can use. Each tool needs a name, description, and parameter descriptions so the AI model understands when and how to use it:

```csharp
var toolService = new SupportAgentTools(dbContext);

var tools = new List<AIFunction>
{
    AIFunctionFactory.Create(
        async ([Description("The order ID number")] int orderId) =>
            await toolService.GetOrderDetailsAsync(orderId),
        "get_order_details",
        "Look up the status and details of a specific order."),

    AIFunctionFactory.Create(
        async ([Description("The order ID")] int orderId,
               [Description("The reason for the return")] string reason) =>
            await toolService.ProcessReturnAsync(orderId, reason),
        "process_return",
        "Process a return request for an order.")
};
```

Each `AIFunctionFactory.Create` call takes three arguments:

1. **A lambda function** that wraps your service method, with `[Description]` attributes on each parameter.
1. **A tool name** that the AI model uses to reference the tool.
1. **A description** that helps the model understand when to call the tool.

The `[Description]` attributes on parameters are important—they tell the AI model what each parameter represents, which helps the model provide accurate values when calling the tool.

## Create and configure a session

Sessions represent individual conversations or task contexts. You configure a session with the model, system prompt, tools, and other settings.

### Configure the session

Use `SessionConfig` to specify how the session should behave:

```csharp
var config = new SessionConfig
{
    Model = "gpt-4.1",
    SystemMessage = new SystemMessageConfig
    {
        Mode = SystemMessageMode.Replace,
        Content = @"You are a customer support agent for an e-commerce company.

CAPABILITIES:
- Look up order details
- Process returns

RULES:
- Only assist with order-related inquiries
- Always verify order details before taking action
- Be polite and professional"
    },
    Tools = tools,
    InfiniteSessions = new InfiniteSessionConfig
    {
        Enabled = false
    }
};
```

Key configuration options:

- **Model**: Specifies which AI model to use for this session.
- **SystemMessage**: Defines the agent's role and behavior. The `Mode` determines whether your prompt replaces the default system message (`Replace`) or appends to it (`Append`).
- **Tools**: The list of tool definitions the agent can use.
- **InfiniteSessions**: Controls automatic context compaction for long conversations. When enabled, you can tune the `BackgroundCompactionThreshold` and `BufferExhaustionThreshold` to control when compaction occurs.

### Create the session

Create a session from the client using your configuration:

```csharp
var session = await client.CreateSessionAsync(config);
```

## Handle responses with events

The GitHub Copilot SDK uses an event-driven model for communication. After sending a message, you subscribe to events to receive responses and detect when processing is complete.

### Subscribe to session events

Use the `session.On` method with pattern matching to handle different event types:

```csharp
var responseBuilder = new StringBuilder();
var tcs = new TaskCompletionSource<string>();

session.On(evt =>
{
    switch (evt)
    {
        case AssistantMessageEvent msg:
            responseBuilder.Append(msg.Data.Content);
            break;

        case SessionIdleEvent:
            tcs.SetResult(responseBuilder.ToString());
            break;

        case SessionErrorEvent err:
            tcs.SetException(
                new Exception($"Agent error: {err.Data.Message}"));
            break;
    }
});
```

Each event type serves a specific purpose:

- **AssistantMessageEvent**: Contains a portion of the agent's response text. You accumulate these message pieces to build the full response.
- **SessionIdleEvent**: Signals that the agent finished processing, including all tool calls. This event indicates that the response is complete.
- **SessionErrorEvent**: Indicates an error occurred during processing. The `Data.Message` property contains the error description.

### Send a message and await the response

Use `SendAsync` with a `MessageOptions` object to send the user's prompt to the agent:

```csharp
await session.SendAsync(new MessageOptions
{
    Prompt = "What is the status of order 12345?"
});

// Wait for the response with a timeout
var response = await tcs.Task.WaitAsync(TimeSpan.FromSeconds(30));
```

The `TaskCompletionSource` pattern shown here lets you bridge the event-driven SDK model with async/await code. When the `SessionIdleEvent` fires, it completes the task with the accumulated response text.

## Error handling best practices

Robust error handling is critical for production agents.

### Tool handler errors

Wrap your tool handlers in try-catch blocks and return meaningful error messages rather than throwing exceptions. When a tool returns an error message, the AI model can interpret it and provide a helpful response to the user:

```csharp
AIFunctionFactory.Create(
    async ([Description("The order ID")] int orderId) =>
    {
        try
        {
            return await toolService.GetOrderDetailsAsync(orderId);
        }
        catch (Exception ex)
        {
            return $"Error retrieving order: {ex.Message}";
        }
    },
    "get_order_details",
    "Look up the status and details of a specific order.")
```

### Session-level error handling

Use the `SessionErrorEvent` to catch errors during agent processing. You can also configure the `OnErrorOccurred` session hook, which returns an `ErrorHandling` value to control how the agent responds to errors:

- **Retry**: Attempt the failed operation again.
- **Skip**: Continue processing without the failed result.
- **Abort**: Stop processing and surface the error.

### Timeouts

Always set a timeout when awaiting responses. The previous example uses `WaitAsync(TimeSpan.FromSeconds(30))` to prevent indefinite waiting if the agent encounters an unexpected issue.

## System prompt design

The system prompt is one of the most important configuration decisions. It defines who the agent is, what it can do, and how it should behave. A well-structured system prompt typically includes:

- **Role definition**: What the agent represents (for example, "You're a customer support agent for ContosoShop").
- **Capabilities**: What tools are available and what they do.
- **Workflow guidance**: How the agent should approach tasks (for example, "Always verify order details before processing a return").
- **Rules and constraints**: Boundaries the agent must follow (for example, "Only discuss order-related topics" or "Escalate refund requests over $100").

Keep the system prompt focused and specific. Vague instructions lead to unpredictable behavior, while overly restrictive rules can make the agent unhelpful.

## Stream responses with delta events

For interactive applications like chat UIs, you can stream the agent's response token by token instead of waiting for the complete message. Use `AssistantMessageDeltaEvent` to capture each partial token as it arrives:

```csharp
session.On(evt =>
{
    switch (evt)
    {
        case AssistantMessageDeltaEvent delta:
            // Render each token as it arrives
            Console.Write(delta.Data.DeltaContent);
            break;

        case SessionIdleEvent:
            Console.WriteLine();
            tcs.SetResult("Done");
            break;

        case SessionErrorEvent err:
            tcs.SetException(
                new Exception($"Agent error: {err.Data.Message}"));
            break;
    }
});
```

The `DeltaContent` property contains the incremental text fragment. Streaming provides a more responsive experience because users see the response as it forms, rather than waiting for the model to generate the entire message.

## Summary

The GitHub Copilot SDK provides a powerful framework for implementing AI agents that can reason, use tools, and maintain context. By defining your agent's capabilities through tools, configuring sessions with clear system prompts, and handling responses with events, you can build sophisticated agents that deliver real business value. Robust error handling and thoughtful prompt design are critical to ensuring your agent operates reliably and effectively in production scenarios. In the next unit, you'll see how to apply these implementation patterns to build a sample customer support agent using the GitHub Copilot SDK.
