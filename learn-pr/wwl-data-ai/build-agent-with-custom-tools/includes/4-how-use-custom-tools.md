Custom tools in an agent can be defined in a handful of ways, depending on what works best for your scenario. You may find that your company already has Azure Functions implemented for your agent to use, or a public OpenAPI specification gives your agent the functionality you're looking for.

## Agents function calling

Function calling allows agents to execute predefined functions dynamically based on user input. This feature is ideal for scenarios where agents need to perform specific tasks, such as retrieving data or processing user queries, and can be done in code from within the agent. Your function may call out to other APIs to get additional information or initiate a program.

### Example: Defining and using a function

Start by defining a function that the agent can call. For instance, here's a fake snowfall tracking function:

```python
import json

def recent_snowfall(location: str) -> str:
    """
    Fetches recent snowfall totals for a given location.
    :param location: The city name.
    :return: Snowfall details as a JSON string.
    """
    mock_snow_data = {"Seattle": "0 inches", "Denver": "2 inches"}
    snow = mock_snow_data.get(location, "Data not available.")
    return json.dumps({"location": location, "snowfall": snow})

user_functions: Set[Callable[..., Any]] = {
    recent_snowfall,
}
```

Register the function with your agent using the Azure AI SDK:

```python
# Initialize agent toolset with user functions
functions = FunctionTool(user_functions)
toolset = ToolSet()
toolset.add(functions)

# Create your agent with the toolset
agent = project_client.agents.create_agent(
    model="gpt-4o-mini",
    name="snowfall-agent",
    instructions="You are a weather assistant tracking snowfall. Use the provided functions to answer questions.",
    toolset={"functions": [recent_snowfall]}
)
```

The agent can now call `recent_snowfall` dynamically when it determines that the prompt requires information that can be retrieved by the function.

## OpenAPI defined tools

OpenAPI defined tools allow agents to interact with external APIs using standardized specifications. This approach simplifies API integration and ensures compatibility with various services. Azure AI Agent Service uses OpenAPI 3.0 specified tools.

> [!TIP]
> Currently, three authentication types are supported with OpenAPI 3.0 tools: `anonymous`, `API key`, and `managed identity`.

### Example: Using an OpenAPI specification

1. **Prepare the OpenAPI spec**: Create a JSON file (`snowfall_openapi.json`) describing the API.

    ```json
    {
      "openapi": "3.0.0",
      "info": {
        "title": "Snowfall API",
        "version": "1.0.0"
      },
      "paths": {
        "/snow": {
          "get": {
            "summary": "Get snowfall information",
            "parameters": [
              {
                "name": "location",
                "in": "query",
                "required": true,
                "schema": {
                  "type": "string"
                }
              }
            ],
            "responses": {
              "200": {
                "description": "Successful response",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "location": {"type": "string"},
                        "snow": {"type": "string"}
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    ```

1. **Register the OpenAPI tool**:

    ```python
    from azure.ai.projects.models import OpenApiTool, OpenApiAnonymousAuthDetails
    
    with open("snowfall_openapi.json", "r") as f:
        openapi_spec = json.load(f)
    
    auth = OpenApiAnonymousAuthDetails()
    openapi_tool = OpenApiTool(name="snowfall_api", spec=openapi_spec, auth=auth)
    
    agent = project_client.agents.create_agent(
        model="gpt-4o-mini",
        name="openapi-agent",
        instructions="You are a snowfall tracking assistant. Use the API to fetch snowfall data.",
        tools=[openapi_tool]
    )
    ```

The agent can now use the OpenAPI tool to fetch snowfall data dynamically.

## Azure Functions integration

Azure Functions provide serverless computing capabilities for real-time processing. This integration is ideal for event-driven workflows, enabling agents to respond to triggers such as HTTP requests or queue messages.

### Example: Using Azure Functions with a queue trigger

1. **Define an Azure Function**: Develop and deploy your Azure Function. In this example, imagine we have a function in our Azure subscription to fetch the snowfall for a given location.

1. **Integrate the Azure Function with the agent**:

    ```python
    storage_service_endpoint = "https://<your-storage>.queue.core.windows.net"
    
    azure_function_tool = AzureFunctionTool(
        name="get_snowfall",
        description="Get snowfall information using Azure Function",
        parameters={
                "type": "object",
                "properties": {
                    "location": {"type": "string", "description": "The location to check snowfall."},
                },
                "required": ["location"],
            },
        input_queue=AzureFunctionStorageQueue(
            queue_name="input",
            storage_service_endpoint=storage_service_endpoint,
        ),
        output_queue=AzureFunctionStorageQueue(
            queue_name="output",
            storage_service_endpoint=storage_service_endpoint,
        ),
    )
    
    agent = project_client.agents.create_agent(
        model=os.environ["MODEL_DEPLOYMENT_NAME"],
        name="azure-function-agent",
        instructions="You are a snowfall tracking agent. Use the provided Azure Function to fetch snowfall based on location.",
        tools=azure_function_tool.definitions,
    )
    ```

The agent can now send requests to the Azure Function via a storage queue and process the results.

> [!NOTE]
> One of the concepts related to agents and custom tools that developers often have difficulty with is the *declarative* nature of the solution. You don't need to write code that explicitly *calls* your custom tool functions - the agent itself decides to call tool functions based on messages in prompts. By providing the agent with functions that have meaningful names and well-documented parameters, the agent can "figure out" when and how to call the function all by itself!

By using one of the available custom tool options (or any combination of them), you can create powerful, flexible, and intelligent agents with Azure AI Agent Service. These integrations enable seamless interaction with external systems, real-time processing, and scalable workflows, making it easier to build custom solutions tailored to your needs.
