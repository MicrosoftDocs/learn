::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=23daf292-1c3e-4946-9ae7-d7b98e136340]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

The Foundry Agent Service is the recommended provider for production environments built with the Microsoft Agent Framework. It handles persistent conversation history on the service side, supports built-in tools such as code execution and file search, and integrates seamlessly with Azure identity management. These features allow you to focus on your agent's behavior rather than its infrastructure overhead.

## Configuring a Foundry agent

Creating and interacting with a Foundry agent follows a consistent sequence of steps.

### 1. Set up your Foundry project

Before writing any code, you need a Microsoft Foundry project with a deployed model. You connect to your project using two pieces of information: 

* **Project endpoint**—the URL of your Foundry project.
* **Model deployment name**—the name of the model deployment you want to use for your agent.

### 2. Configure authentication

The Agent Framework connects to your Foundry project using Azure credentials. In most scenarios, `DefaultAzureCredential` resolves the right credential automatically based on your environment—Azure CLI during development, managed identity in production. No connection strings or API keys need to be hardcoded.

### 3. Initialize the Foundry chat client

Create a Foundry chat client by providing your credentials, project endpoint, and model name. This client is the bridge between your application and the Foundry Agent Service. It handles authentication, request routing, and service-side session management.

### 4. Create the agent

Using the chat client, create an agent by providing a set of instructions that define its behavior:

* **Instructions**—the system prompt that defines the agent's role, goals, and constraints
* **Tools** *(optional)*—Custom functions the agent can call to take actions or retrieve information

The framework registers any tools you provide and automatically generates their schemas, so the model knows when and how to invoke them.

### 5. Establish a session and run the agent

To begin interacting, you open a **session** via the agent instance. The session acts as the container for the conversation state. You send user messages to the session's execution method, which processes the prompt, coordinates any necessary tool calls, and returns the model's response.

## Multi-turn conversations

A single call to the agent's run method handles one exchange—one user message, one response. For a real conversation, you need the agent to remember what was said in earlier turns. That's what a **session** is for.

For the Foundry provider, the sessions are backed by **service-side storage**—the conversation history lives in the Foundry Agent Service rather than in your application's memory. 

* **Persistent history**—Because the state lives on the service side, a user's conversation can continue across multiple requests, even if your application restarts or scales out to multiple instances.

* **Local history**—For providers that don't support service-side history, the framework maintains the conversation state in memory within the session object. Local history is suitable for short-lived or stateless applications, but it doesn't persist across process restarts.

## Nonstreaming vs. streaming responses

The Agent Framework supports two response modes:

- **Non-streaming (synchronous)**—the run method waits for the agent to finish processing and returns a complete response object. Non-streaming is the simplest pattern and works well when you don't need to display output incrementally.

- **Streaming (asynchronous)**—the run method returns a response stream that you iterate over asynchronously, receiving partial updates as the model generates them. Streaming is better suited for user-facing interfaces where showing output progressively improves the experience.

In both cases, the response exposes a `text` property that aggregates all text content from the agent's output, making it straightforward to extract the final answer regardless of which mode you use.

::: zone-end

