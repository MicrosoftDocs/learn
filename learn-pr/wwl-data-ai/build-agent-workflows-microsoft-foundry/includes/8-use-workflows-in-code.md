After designing and testing a workflow in the Microsoft Foundry visual designer, you can integrate it into your applications using the Azure AI Projects SDK. This allows you to embed workflow-driven automation into web apps, APIs, backend services, and other software solutions.

Workflows are created in the Foundry portal using the visual designer, which generates the underlying YAML definition. Once a workflow is saved in your project, you can invoke it programmatically by referencing its name. You can also download the workflow's YAML definition from the portal and include it in your codebase.

## Invoke a workflow

Before running a workflow, establish a connection to your Microsoft Foundry project using the `AIProjectClient`. This client handles authentication and provides access to the OpenAI-compatible API for executing conversations and invoking workflows. To run an existing workflow in your project, create a conversation and invoke the workflow by name.

```python
# Reference a workflow created in the Foundry portal
workflow_name = "triage-workflow"

# Create a conversation context for the workflow
conversation = openai_client.conversations.create()

# Execute the workflow, passing input to drive the workflow logic
stream = openai_client.responses.create(
    conversation=conversation.id,
    extra_body={"agent": {"name": workflow_name, "type": "agent_reference"}},
    input="Users can't reset their password from the mobile app.",
    stream=True,
)
```

The `input` parameter lets you pass a prompt or message to the workflow, which the workflow can use to drive its logic—such as processing a user request, triaging a support ticket, or answering a question. Depending on how your workflow is designed, this input might be:

- A user question that agents analyze and respond to
- A support ticket description for classification and routing
- A data payload that triggers processing logic
- An empty string that simply starts the workflow without specific input

## Process workflow events

When streaming is enabled, your application receives events as the workflow executes. These events let you display real-time progress, capture agent outputs, and respond to workflow actions.

```python
for event in stream:
    if event.type == "response.completed":
        print("Workflow completed:")
        for message in event.response.output:
            if message.content:
                for content_item in message.content:
                    if content_item.type == 'output_text':
                        print(content_item.text)
    if (event.type == "response.output_item.done") and event.item.type == ItemType.WORKFLOW_ACTION:
        print(f"Action '{event.item.action_id}' completed with status: {event.item.status}")
```

Common event types include:

| Event Type | Description |
|------------|-------------|
| `response.completed` | The workflow finished executing and returned a final response |
| `response.output_item.done` | An individual output item (such as a workflow action) completed |

By monitoring these events, you can see how the workflow progresses in real-time, or trigger external actions based on workflow state. Alternatively, you can choose to wait for the entire workflow to complete and process the final response without streaming. For workflows that include human-in-the-loop patterns, your application may need to handle pauses where the workflow waits for user input. In these cases, you can send additional messages to the conversation to provide the requested input and resume workflow execution.

## Benefits of code integration

Integrating workflows into your code enables several scenarios:

| Scenario | Benefit |
|----------|---------|
| Web applications | Embed AI-driven workflows directly in user-facing apps |
| APIs and microservices | Expose workflow capabilities through REST endpoints |
| Batch processing | Invoke workflows programmatically for bulk operations |
| Testing and validation | Automate workflow testing as part of CI/CD pipelines |
| Custom interfaces | Build specialized UIs tailored to specific workflow use cases |

By combining the visual design experience of the Foundry portal with the flexibility of code integration, you can create powerful AI-driven solutions that fit seamlessly into your existing software architecture.
