The GitHub Copilot SDK is a multi-platform toolkit (currently in Technical Preview) that allows you to embed an AI agent runtime into your own applications. The SDK exposes the same engine behind the GitHub Copilot CLI as a programmable interface, giving your app the ability to understand natural language instructions, plan actions, and invoke tools to fulfill those instructions. You don't need to build all that infrastructure from scratch.

## Why use an SDK for AI agents?

Building a full-featured AI agent from the ground up is complex. You need to handle conversation state management across turns, decide when to call which external API, ensure the AI's responses stay within boundaries, manage multiple AI models for different tasks, and implement safety measures. Building agentic workflows from scratch means you've essentially built a mini platform before you even get to your business logic.

The GitHub Copilot SDK removes that complexity by providing a prebuilt, production-tested agent engine. The SDK handles authentication, model management, chat sessions, and streaming. You focus on what gets built on top of those building blocks—your domain-specific tools and business logic.

## Architecture overview

The GitHub Copilot SDK communicates with the GitHub Copilot CLI, which runs in server mode as a local process. The SDK manages the CLI process lifecycle automatically. All SDK languages share this same architecture.

The architecture follows this flow:

`Your Application → SDK Client → (JSON-RPC) → Copilot CLI (server mode)`

You interact with the SDK through a client library in your programming language of choice. The SDK handles the communication protocol, so you work with simple method calls rather than raw messages.

### Language support

The SDK provides idiomatic libraries for four programming languages:

| Language | Package |
|---|---|
| Node.js (TypeScript) | `npm install @github/copilot-sdk` |
| Python | `pip install github-copilot-sdk` |
| Go | `go get github.com/github/copilot-sdk/go` |
| .NET (C#) | `dotnet add package GitHub.Copilot.SDK` |

Whether you're building a web application in TypeScript or a backend service in C#, you can incorporate the same AI agent capabilities.

## Key features

The SDK provides several built-in capabilities that simplify building AI agents.

### Production-grade agent loop

The SDK provides the same proven execution loop that powers GitHub Copilot CLI. This execution loop manages multi-turn conversations, calls tools, and iterates until the task is complete. You don't need to code the planning and orchestration logic.

### Tool orchestration

You can define custom tools that the AI agent invokes as needed during its reasoning process. When you register a tool (like `lookupCustomer(id)`), the agent's AI model can determine when to call it. The SDK handles the wiring so the AI can call your tool in a structured way through an actual function call in the runtime, rather than guessing at code.

In .NET, tools are defined using `AIFunctionFactory` from the `Microsoft.Extensions.AI` package. Each tool includes a name, description, parameter schema, and a handler function.

### Multi-model flexibility

The SDK isn't tied to one AI model. It supports multiple AI models and allows dynamic model routing. For example, you might use a faster model for simple tasks and a more capable model for complex reasoning, within the same application.

### Real-time streaming

The SDK supports streaming responses, meaning as the AI generates output, you can stream it to your app. For example, you can stream tokens to show a typing indicator or partial answer in a chat UI. This behavior makes the experience more interactive and responsive.

### Authentication and security

The SDK supports multiple authentication methods:

- **GitHub signed-in user**: Reuses stored OAuth credentials from the Copilot CLI login.
- **OAuth GitHub App**: Passes user tokens from your GitHub OAuth app.
- **Environment variables**: Uses `COPILOT_GITHUB_TOKEN`, `GH_TOKEN`, or `GITHUB_TOKEN`.
- **Bring your own key (BYOK)**: Uses your own API keys for providers like OpenAI, Azure AI Foundry, or Anthropic without requiring GitHub authentication.

A GitHub Copilot subscription is required unless you use the BYOK option.

### Context management

The SDK automatically manages conversation history within a session. It tracks previous messages and tool outputs so the AI model has the context it needs for coherent multi-turn interactions. For long sessions, the SDK provides an **infinite sessions** feature that automatically compacts context when the context window approaches its limit, preventing token overflow errors.

## Core concepts

Understanding the SDK's core concepts helps you work with it effectively.

### Client

The `CopilotClient` class manages the connection to the Copilot CLI server. You create one client instance for your application and use it to create sessions. The client handles starting and stopping the CLI process, establishing the communication channel, and managing session lifecycles.

Configuration options include `AutoStart` (automatically starts the CLI server when the first session is created), `LogLevel` (controls logging verbosity), `CliPath` (specifies a custom path to the CLI executable), and `GithubToken` (provides a GitHub token directly instead of relying on environment variables or CLI login).

### Session

A `CopilotSession` represents a single conversation or task context. Each session has its own conversation history, model configuration, tool definitions, and system prompt. You create sessions from the client using `CreateSessionAsync`, send messages to them, and receive responses through an event-driven model.

Key session configuration options include:

- **Model**: The AI model to use (for example, `gpt-4.1`).
- **SystemMessage**: Defines the agent's role and behavior through a `SystemMessageConfig` object with a `Mode` (Append or Replace) and `Content` string.
- **Tools**: Custom tool definitions the agent can invoke.
- **InfiniteSessions**: Controls automatic context compaction through an `InfiniteSessionConfig` object. When enabled, you can configure `BackgroundCompactionThreshold` (the percentage of context window usage that triggers background compaction) and `BufferExhaustionThreshold` (the percentage at which the SDK forces compaction to prevent token overflow).

### Tools

Tools are functions that you register with a session so the AI agent can call them during reasoning. Each tool has a name, description, parameters, and a handler function. When the AI model decides to use a tool, the SDK intercepts the request, calls your handler, and feeds the result back to the model for further reasoning.

In .NET, you define tools using `AIFunctionFactory.Create` from `Microsoft.Extensions.AI`:

```csharp
AIFunctionFactory.Create(
    async ([Description("The order ID number")] int orderId) =>
        await GetOrderDetailsAsync(orderId),
    "get_order_details",
    "Look up the status and details of a specific order.")
```

### Events

The SDK uses an event-driven communication model. When you send a message to a session, the SDK fires events as processing occurs:

- **AssistantMessageEvent**: The AI model produced a complete response.
- **AssistantMessageDeltaEvent**: The AI model produced a partial response token during streaming. The `Data.DeltaContent` property contains the incremental text, which you can display in real time.
- **SessionIdleEvent**: The session finished processing (including any tool calls).
- **SessionErrorEvent**: An error occurred during processing.
- **ToolExecutionStartEvent** and **ToolExecutionCompleteEvent**: A tool was invoked.

You subscribe to these events to capture the agent's responses and handle errors. For nonstreaming scenarios, use `AssistantMessageEvent` to collect the full response. For streaming scenarios (like showing a typing indicator in a chat UI), use `AssistantMessageDeltaEvent` to render tokens as they arrive.

### Session hooks

The SDK provides hooks that let you intercept and modify agent behavior at key points:

- **OnPreToolUse**: Intercept tool calls before execution. Your handler returns a `PermissionDecision` value—`Allow` to proceed, `Deny` to block the call, or `Ask` to prompt the user for confirmation.
- **OnPostToolUse**: Process tool results after execution, useful for logging or modifying results before they reach the model.
- **OnUserPromptSubmitted**: Intercept and modify user prompts before processing.
- **OnErrorOccurred**: Handle errors by returning an `ErrorHandling` value—`Retry` to attempt the operation again, `Skip` to continue without the result, or `Abort` to stop processing.
- **OnSessionStart**: Runs when a session begins, useful for initialization tasks.
- **OnSessionEnd**: Runs when a session ends, useful for cleanup or logging.

These hooks enable you to implement permission controls, logging, and safety guardrails.

## Prerequisites for .NET development

To use the GitHub Copilot SDK in a .NET application, your environment needs:

- .NET 8.0 or later.
- The GitHub Copilot CLI, installed and available in your system PATH.
- A GitHub account with an active Copilot subscription (or your own API keys for BYOK).
- The `GitHub.Copilot.SDK` NuGet package.
- The `Microsoft.Extensions.AI` NuGet package (for defining tools using `AIFunctionFactory`).

## Summary

The GitHub Copilot SDK provides a powerful, production-ready platform for building AI agents in your applications. By abstracting away the complexities of agent orchestration, tool integration, and context management, the SDK lets you focus on defining your agent's capabilities and business logic. With support for multiple languages, real-time streaming, and flexible authentication options, the GitHub Copilot SDK is a versatile choice for adding AI agent functionality to a wide range of applications.
