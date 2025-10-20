Now that you understand what tracing is and what to trace, it's time to implement tracing in your generative AI applications. In this section, you learn how to set up tracing infrastructure and instrument your code to capture meaningful trace data.

Using the Trail Guide AI Assistant as our example, you explore the practical steps to add tracing to a real application, from initial setup to capturing detailed execution flows.

## Set up tracing infrastructure

Before you can capture traces, you need to configure the tracing infrastructure. Azure AI Foundry provides built-in tracing capabilities that integrate with Azure Application Insights using OpenTelemetry.

> [!NOTE]
> To trace an application, you need an Azure AI Foundry project with an associated Azure Application Insights resource. To learn how to set up monitoring and logging infrastructure for AI applications, explore the [Monitor your generative AI application](/training/modules/monitor-generative-ai-app?azure-portal=true) module.

### Install required packages

Install the necessary packages for tracing in your Python environment:

```bash
pip install azure-ai-projects azure-monitor-opentelemetry opentelemetry-instrumentation-openai-v2
```

These packages provide:

- **azure-ai-projects**: Client to connect to your Azure AI Foundry project.
- **azure-monitor-opentelemetry**: Integration with Azure Application Insights.
- **opentelemetry-instrumentation-openai-v2**: Automatic tracing for OpenAI SDK calls.

### Configure the tracing provider

Setting up tracing involves three key steps: instrumenting the OpenAI SDK, connecting to your project, and configuring Azure Monitor.

```python
from opentelemetry.instrumentation.openai_v2 import OpenAIInstrumentor
from azure.monitor.opentelemetry import configure_azure_monitor
from azure.ai.projects import AIProjectClient
from azure.identity import DefaultAzureCredential
from opentelemetry import trace

# Enable automatic tracing for all OpenAI calls
OpenAIInstrumentor().instrument()

# Connect to your Azure AI project
project_client = AIProjectClient(
    credential=DefaultAzureCredential(),
    endpoint="https://<your-resource>.services.ai.azure.com/api/projects/<your-project>"
)

# Configure Azure Monitor to collect traces
connection_string = project_client.telemetry.get_connection_string()
configure_azure_monitor(connection_string=connection_string)

# Get tracer for custom spans and chat client for model calls
tracer = trace.get_tracer(__name__)
chat_client = project_client.inference.get_chat_completions_client()
```

Once configured, every OpenAI SDK call automatically generates trace data that appears in Azure AI Foundry. However, to trace your business logic, you need to create custom spans.

## Create reusable tracing functions

The key to effective tracing is creating reusable functions that combine your business logic with meaningful tracing data.

### Model call wrapper with timing

Instead of calling the model directly, create a wrapper function that adds timing and metadata. The wrapper function captures what you're asking the model, how long it takes to respond, and details about the response:

```python
def call_model(system_prompt, user_prompt, span_name):
    with tracer.start_as_current_span(span_name) as span:
        # Record what we're asking the model
        span.set_attribute("prompt.user", user_prompt)
        start_time = time.time()
        
        # Make the actual model call (automatically traced by OpenAI instrumentation)
        response = chat_client.chat.completions.create(
            model="gpt-4o",
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": user_prompt}
            ]
        )
        
        # Record timing and response metrics
        duration = time.time() - start_time
        output = response.choices[0].message.content
        span.set_attribute("response.time", duration)
        span.set_attribute("response.tokens", len(output.split()))
        
        return output
```

The wrapper pattern gives you consistent timing across all model calls, standard attributes for debugging, and a reusable structure for any AI operation.

### Business logic with tracing

For your application's core functions, wrap them in spans that capture both inputs and outputs. Notice how wrapping functions in spans creates a **hierarchy**. For example, the `recommend_hike` span contains the `recommend_model_call` span:

```python
def recommend_hike(preferences):
    with tracer.start_as_current_span("recommend_hike") as span:
        # Build the prompt for this specific task
        prompt = f"""
        Recommend a named hiking trail based on the following user preferences.
        Provide only the name of the trail and a one-sentence summary.
        Preferences: {preferences}
        """
        
        # Call the model with our wrapper function
        response = call_model(
            "You are an expert hiking trail recommender.",
            prompt,
            "recommend_model_call"
        )
        
        # Store the result for debugging
        result = response.strip()
        span.set_attribute("hike_recommendation", result)
        return result
```

## Implement session-level tracing

For complete user interactions, create a top-level span that encompasses the entire workflow. The top-level span represents the full user journey from input to final response:

```python
def trail_guide_session(user_preferences):
    with tracer.start_as_current_span("trail_guide_session") as session_span:
        # Generate unique session ID for tracking across multiple interactions
        session_id = f"session_{int(time.time())}"
        session_span.set_attribute("session.id", session_id)
        
        print("--- Trail Guide AI Assistant ---")
        
        # Execute the core business logic (the recommend_hike function creates child spans)
        hike = recommend_hike(user_preferences)
        print(f"✅ Recommended Hike: {hike}")
        
        # Mark session as successful for monitoring
        session_span.set_attribute("session.success", True)
        print(f"🔍 Trace ID available for session: {session_id}")
        
        return hike
```

## Understanding the trace hierarchy

When you view traces in Azure AI Foundry, you find a hierarchical structure that shows how your application flows:

- **trail_guide_session** (your main workflow)
  - **recommend_hike** (business logic span)
    - **recommend_model_call** (your custom model call span)
      - **chat gpt-4o** (automatic OpenAI SDK span)

Each level provides different insights:

- **Session level**: Overall success/failure, user journey timing.
- **Business logic level**: Individual operation performance and results.
- **Model call level**: Prompt engineering effectiveness and response quality.
- **SDK level**: Model performance, token usage, and API errors.

With these basic tracing patterns, you can start monitoring your AI assistant. The next unit covers advanced scenarios like handling multiple model calls, JSON parsing, and error debugging.
