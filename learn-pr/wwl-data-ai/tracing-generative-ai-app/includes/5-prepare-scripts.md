To generate monitoring data that is captured by Application Insights and visualized in Azure Monitor, you need to run a service you deployed through the Azure AI Foundry.

A service can simply be a deployed language model, or a deployed generative AI app like an AI assistant or agent.

To integrate monitoring into your code, you need to:

- Use the Azure AI Foundry SDK to **run model inference** and emit telemetry.
- Use the OpenTelemetry standard to **capture spans** representing each inference call and execution step.
- Export data automatically to Azure Monitor and store it automatically with Application Insights.

> [!Note]
> The code snippets provided here are just to highlight what parts of the code would do. A complete working example is provided in the exercise.

## Run model inference

To begin monitoring your generative AI application, you first use the [Azure AI Foundry SDK](/azure/ai-foundry/how-to/develop/sdk-overview?tabs=sync&pivots=programming-language-python?azure-portal=true) to run model inference. Model inference could be anything from a single language model completion to a full multi-turn assistant.

The Azure AI Foundry SDK allows you to connect with a specific Azure AI hub and project. With Python, this may look like the following code sample:

```python
connection_string = os.getenv('PROJECT_CONNECTION_STRING')
credential = DefaultAzureCredential()
project = AIProjectClient.from_connection_string(
    conn_str=connection_string,
    credential=credential
)
```

After, you can use the Azure AI model inference package (part of the Azure AI Foundry SDK) to interact with a deployed service. For example:

```python
chat_client = project.inference.get_chat_completions_client()
model_name = os.environ.get("AZURE_OPENAI_DEPLOYMENT_NAME", "gpt-4o")

response = chat_client.complete(
            model=model_name,
            messages=[
                SystemMessage("You are an AI assistant that acts as a travel guide."),
                UserMessage(content=(
                "What are some recommended supplies for a camping trip in the mountains?"
            ))]
```

## Capture spans with a tracer

To easily trace the path of an inference request through your application, Azure integrates with the [OpenTelemetry](https://opentelemetry.io/?azure-portal=true) standard.

The OpenTelemetry standard uses spans and a tracer to organize your monitoring data:

- **Spans**: Individual units of work within your application, such as an inference request, or an API call. Each span records metadata like duration, success/failure status, and custom attributes. Spans are the building blocks of a trace.
- **Tracer**: The tracer is the component in your code responsible for creating and managing spans. It’s part of the OpenTelemetry SDK and plays a central role in distributed tracing.

In your application, for example, you start by getting a tracer instance and generating unique identifiers for spans:

```python
# Get the tracer instance
tracer = trace.get_tracer(__name__)

# Generate a session ID for this script execution
SESSION_ID = str(uuid.uuid4())

# Configure the tracer to include session ID in all spans
os.environ['AZURE_TRACING_GEN_AI_CONTENT_RECORDING_ENABLED'] = 'true'

```

Then, you can use the tracer to create a span named `generate_completion` to represent the process of generating a response from the AI model:

```python
# Generate a chat completion about camping supplies
with tracer.start_as_current_span("generate_completion") as span:
    try:
        span.set_attribute("session.id", SESSION_ID)

        response = chat_client.complete(
            model=model_name,
            messages=[
                SystemMessage("You are an AI assistant that acts as a travel guide."),
                UserMessage(content=(
                "What are some recommended supplies for a camping trip in the mountains?"
            ))]
        )

    except Exception as e:
        span.set_status(Status(StatusCode.ERROR, str(e)))
        span.record_exception(e)
        raise
```

## Export data automatically

Finally, you need to ensure you're connecting with your Applications Insights resource to automatically export the generated monitoring data. When you connect an Application Insights resource with your Azure AI Foundry project, you can get the resource through the project:

```python
application_insights_connection_string = project.telemetry.get_connection_string()
configure_azure_monitor(connection_string=application_insights_connection_string)

AIInferenceInstrumentor().instrument()
```

Using the `AIinferenceInstrumentor` ensures that all AI inference operations performed by `chat_client` are automatically traced and monitored.

Now that you understand how to monitor, let's explore what we can do with the information we track.