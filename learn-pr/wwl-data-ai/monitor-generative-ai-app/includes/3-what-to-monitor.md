Before you can optimize performance or make informed decisions about deployment, you need to know what to look at. In generative AI applications, especially those built using Azure AI Foundry, **monitoring isn’t about measuring everything, it’s about measuring the right things**.

Let's explore the key performance signals you should monitor in your generative AI system and how they connect to real-world outcomes like user experience, reliability, and cost.

## Monitor generative AI apps

Traditional monitoring for web services focuses on uptime, memory use, and API failure rates. While some of those still matter here, generative AI systems have unique dynamics. Each request can vary drastically in how much compute it uses depending on factors like:

- Prompt and response length
- Model complexity
- Backend resource configuration
- User traffic patterns

That means monitoring needs to focus on **behavioral metrics** tied directly to how the language model performs under different conditions.

## Understand the core metrics that matter

Here are the four most important things you should monitor when deploying a generative AI app:

### Latency and response time

**Latency** refers to the time it takes for a request to travel from the client to the system and for the system to *start* processing it. Essentially, it's the delay before any response *begins*.

**Response time** is the *total* time it takes from the moment a request is sent by the client until the *complete* response is received. The response time includes the latency, the time taken to process the request on the system, and the time taken to send the response back to the client.

Slow responses can feel broken or unreliable, directly affecting how users perceive your service. The response time is often the first indication that your deployment might be underpowered or overloaded.

The full request-response cycle of a generative AI system can be illustrated as follows:

:::image type="content" source="../media/latency.png" alt-text="Diagram illustrating latency.":::

Where a **user** sends the first request, which then travels across the **network**. The **system** receives the request and begins processing, sending input to the **language model** and waiting for the generated output. The system finalizes the output and sends the response back through the network to the user.

By monitoring and optimizing each of these components, you can ensure a smoother and more reliable user experience.

### Throughput

Throughput refers to the number of requests your app can process within a given time frame. It reflects how well your system scales with demand.

:::image type="content" source="../media/throughput.png" alt-text="Diagram illustrating throughput.":::

Understanding throughput is important, especially when multiple users access the app concurrently. Often, the ability to handle requests is limited by compute resources or queuing delays.

### Token usage

Tokens are the building blocks of text when working with language models. Each word, punctuation mark, and even spaces count as tokens. When you make a request to a deployed model through its API, both the input (your prompt) and the output (the response) consume tokens.

:::image type="content" source="../media/token-usage.png" alt-text="Diagram illustrating token usage.":::

To keep costs under control, you can monitor the number of tokens used in each request. Unexpected spikes in token usage can indicate issues with prompt design or inefficient handling of responses. Monitoring token usage is useful for estimating operational cost per request.

### Error and failure rates

Knowing how often the app fails to respond as expected helps maintain its reliability and performance. Failures can come from various sources, such as:

- **Model timeouts**: When the model takes too long to process a request and exceeds the allowed time limit. Can be due to complex computations or high server load.
- **Input parsing issues**: When the app can't correctly interpret the input data. Can be due to unexpected input formats or errors in the data itself.
- **Infrastructure limits**: When the underlying infrastructure can't handle the load. Can be due to insufficient resources or high traffic.

By tracking these failures, you can identify stress points within the system before they escalate and affect production. This proactive approach allows you to address potential issues early, ensuring a smoother and more reliable user experience.

### Understand how these metrics interact

These metrics don’t exist in isolation. For example:

- A decrease in latency might come at the cost of lower throughput (if compute resources are exhausted).
- Token usage spikes might lead to higher latency and higher cost.
- Failure rates can rise when throughput is too high for the infrastructure.

Monitoring helps you observe these trade-offs in real-time, which is essential if you want to adjust deployment parameters intelligently.

In the next section, you explore the tools available to you when building generative AI systems with Azure AI Foundry.
