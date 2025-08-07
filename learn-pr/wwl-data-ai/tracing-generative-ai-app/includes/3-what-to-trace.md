To monitor and debug generative AI applications effectively, you need to understand tracing. Traces offer detailed visibility into how different parts of your application work together, helping you identify errors and performance issues.

In this section, you learn what **traces**, **spans**, and **attributes** are and how they relate to each other. Using examples from your Trail Guide AI Assistant, you explore what kinds of data tracing captures and how that data supports debugging and performance analysis.

## Understand the key concepts of tracing

There are three core concepts in tracing that are important to understand: trace, span, and attribute. These elements help us break down and analyze system behavior in detail, offering insights into the performance and interactions of various parts of an AI system.

|Concept|Definition|
|---|---|
|**Trace**|A trace represents the entire journey of a request or operation as it flows through a system, from start to finish. It typically encompasses multiple spans and shows how different parts of the system are connected. For example, in a GenAI app, a trace could represent the entire lifecycle of the session where a user queries the system for a recommendation.|
|**Span**|A span represents a specific unit of work or operation within the trace. It's a single operation within a trace, such as an HTTP request or a model inference call. Each span includes timing information, such as the start and end times, to measure how long it took to complete that operation.|
|**Attribute**|Attributes are metadata associated with a span. They provide more details about the operation or the resources involved. For example, an attribute could describe the type of span (like an HTTP request) or a resource identifier (like the session ID).|

> [!Note]
> When a request passes through multiple services or systems, tracing helps track its journey across them. This is called distributed tracing, and it connects the data from each service under one trace, making it easier to identify performance issues or failures across the system.

Together, traces, spans, and attributes allow you to capture a detailed view of how requests and operations are processed, helping us identify areas for optimization or troubleshooting within a system.

## Explore examples of what you can trace

Let's explore what to trace and how we can use this information to identify errors by examining example traces from the Trail Guide AI Assistant. These examples demonstrate the types of operations you can monitor and the insights they provide for debugging and optimization.

### Example 1: Model inference operation

The AI system includes an inference operation that represents an API call to a generative AI model like GPT-4o, which is deployed through Azure AI Foundry.

:::image type="content" source="../media/inference.png" alt-text="Screenshot of a trace view showing the performance of the inference operation." lightbox="../media/inference.png":::

This trace shows the complete lifecycle of the **get_chat_completion_client** operation with two key spans:

| Span | Represents |
|---|---|
|**GET/subscriptions...**|Fetches the AI project information and validates access|
|**POST/subscriptions...**|Sends the user query and prompt to the model for processing|

Each span includes timing data, allowing you to identify which operations are taking the most time. For example, if the POST request consistently takes longer than expected, you might need to optimize your prompt or consider a different model configuration.

### Example 2: Complete application workflow

A more complex trace shows the full application workflow, including multiple components working together:

:::image type="content" source="../media/spans.png" alt-text="Screenshot of a trace view showing multiple steps as part of an app." lightbox="../media/spans.png":::

This trace captures a complete user interaction with the Trail Guide assistant. Each span in the trace represents a specific operation:

| Span |Represents|
|---|---|
|**trail_guide_session**|The entire user session from input to final recommendation|
|**recommend_hike**|The logic block that generates a hiking trail recommendation|
|**recommend_model_call**|The function call that sends the prompt to the LLM to get a hike suggestion|
|**chat gpt-4o**|The actual model call to GPT-4o handled by Azure AI Inference SDK|
|**trip_profile_generation**|The logic block that generates a structured trip profile for the hike|
|**trip_profile_model_call**|The model call for generating the trip profile JSON|
|**chat gpt-4o**|Another model call to GPT-4o for the trip profile (nested within trip_profile_model_call)|

Notice how the spans are hierarchically organized. The `trail_guide_session` span encompasses all other operations, while some spans like `recommend_model_call` contain nested spans that represent the actual LLM interactions.

### What insights can you gain from tracing?

By analyzing these traces from the Trail Guide AI Assistant, you can identify specific issues and optimization opportunities:

**Performance bottlenecks**: Suppose you notice that the `trip_profile_generation` span consistently takes 4-6 seconds while the `recommend_hike` span completes in under 1 second. Comparing duration tells you that generating structured trip profiles is your bottleneck. You might optimize by simplifying the trip profile schema, using a faster model, or implementing caching for common hiking destinations.

**Error patterns**: If the `recommend_model_call` span frequently fails when users ask about "winter hiking gear," but succeeds for "summer hiking gear," you identified a data gap. Your training data or retrieval system might lack sufficient winter equipment information, requiring you to update your knowledge base or adjust your prompts to handle seasonal variations better.

**Resource utilization**: Trace data reveals that each `chat gpt-4o` span consumes significant tokens and processing time. If you see two GPT-4o calls per user session (one for hike recommendations, another for trip profiles), you might optimize by combining these two calls into a single, more efficient prompt that generates both outputs simultaneously.

**User experience insights**: End-to-end timing shows that a complete Trail Guide session takes 8-12 seconds from user query to final recommendation. If customers are abandoning the assistant after 5-6 seconds, you know you need to either speed up processing or provide interim feedback like "Finding the perfect trails for you..." to keep users engaged.

**Debugging specific failures**: When a customer reports receiving recommendations for discontinued hiking boots, you can trace their exact session. The trace might show that the retrieval operation accessed outdated product data, pointing you to a specific data synchronization issue rather than a model problem.

These concrete insights from Trail Guide traces enable you to make targeted improvements that directly affect customer satisfaction and business outcomes.
