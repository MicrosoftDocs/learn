To monitor and debug generative AI applications effectively, you need to understand tracing. Traces offer detailed visibility into how different parts of your application work together, helping you identify errors and performance issues.

In this section, you learn what **traces**, **spans**, and **attributes** are and how they relate to each other. Using examples from your Trail Guide AI Assistant, you explore what kinds of data tracing captures and how that data supports debugging and performance analysis.

## Understand the key concepts of tracing

In tracing, three core concepts are important to understand: trace, span, and attribute. These elements help us break down and analyze system behavior in detail, offering insights into the performance and interactions of various parts of an AI system.

|Concept|Definition|
|---|---|
|**Trace**|A trace represents the entire journey of a request or operation as it flows through a system, from start to finish. It typically encompasses multiple spans and shows how different parts of the system are connected. For example, in a GenAI app, a trace could represent the entire lifecycle of the session where a user queries the system for a recommendation.|
|**Span**|A span represents a specific unit of work or operation within the trace. It is a single operation within a trace, such as an HTTP request or a model inference call. Each span includes timing information, such as the start and end times, to measure how long it took to complete that operation.|
|**Attribute**|Attributes are additional metadata associated with a span. They provide more details about the operation or the resources involved. For example, an attribute could describe the type of span (like a HTTP request) or a resource identifier (like the session ID).|

> [!Note]
> When a request passes through multiple services or systems, tracing helps track its journey across them. This is called distributed tracing, and it connects the data from each service under one trace, making it easier to identify performance issues or failures across the system.

Together, traces, spans, and attributes allow you to capture a detailed view of how requests and operations are processed, helping us identify areas for optimization or troubleshooting within a system.

## Explore examples of what you can trace

Let's explore what to trace, and how we can use this information to identify errors, by taking two example traces. Both traces are logged for the Trail Guide AI Assistant that helps customers by recommending a hike and what gear is appropriate.

First, the AI system can include an inference operation that represents an API call to a generative AI model like GPT-4o, which is deployed through Azure AI Foundry.

:::image type="content" source="../media/inference.png" alt-text="Screenshot of a trace view showing the performance of the inference operation.":::

The operation has two spans: a GET request and a POST request. Here's how to interpret the information:

- **Trace**: Represents the complete lifecycle of the **get_chat_completion_client** operation.
- **Spans**:
    - GET/subscriptions...: Represents the GET request that fetched the AI project information.
    - POST/subscriptions...: Represents the POST request, which involved sending data to the AI project.

:::image type="content" source="../media/spans.png" alt-text="Screenshot of a trace view showing multiple steps as part of an app.":::