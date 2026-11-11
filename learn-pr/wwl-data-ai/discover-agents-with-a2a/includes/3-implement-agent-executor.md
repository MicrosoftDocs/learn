::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=4aa67aff-ec07-4424-82ce-a6816ed21a4d]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

The **Agent Executor** is a core component of an A2A agent. It defines how your agent processes incoming requests, generates responses, and communicates with clients or other agents. Think of it as the bridge between the A2A protocol and your agent's specific business logic.

## Understand the agent executor

The `AgentExecutor` interface handles all incoming requests sent to your agent. It receives information about the request, processes it according to the agent’s capabilities, and sends responses or events back through a communication channel.  

**Key responsibilities:**
- Execute tasks requested by users or other agents.  
- Stream responses or send individual messages back to the client.  
- Handle task cancellation if supported.  

## Implement the interface

An Agent Executor typically defines two primary operations:

**Execute**  
- Processes incoming requests and generates responses.  
- Accesses request details (for example, user input, task context).  
- Sends results back via an event queue, which may include messages, task updates, or artifacts.

**Cancel**  
- Handles requests to cancel an ongoing task.  
- May not be supported for simple agents.  

The executor uses the **RequestContext** to understand the incoming request and an **EventQueue** to communicate results or events back to the client.

## Request handling flow

Consider a "Hello World" agent workflow:

1. The agent has a small helper class that implements its core logic (for example, returning a string).  
1. The executor receives a request and calls the agent’s logic.  
1. The executor wraps the result as an event and places it on the event queue.  
1. The routing mechanism sends the event back to the requester.  

For cancellation, a basic agent might only indicate that cancellation isn't supported.

## Run a Foundry agent from the executor

A more realistic executor wraps an AI agent, such as an Agent Framework agent backed by a model in your Microsoft Foundry project. In that case, the executor:

1. Reports the task's progress with a **TaskUpdater**, which marks the task as submitted and then working.
1. Converts the incoming A2A message into the input the agent expects.
1. Runs the agent and streams each update back to the caller as an **artifact**, so the caller can show partial results as they arrive.
1. Marks the task as complete when the agent finishes, or as failed if an error occurs.

The executor is the only part of your server that knows how your agent works. Everything else, such as the Agent Card and request handling, is the same for any agent.

The Agent Executor is central to making your A2A agent functional. It defines how the agent executes tasks and communicates results, providing a standardized interface for clients and other agents. Properly implemented executors enable seamless integration and collaboration in multi-agent workflows.

::: zone-end
