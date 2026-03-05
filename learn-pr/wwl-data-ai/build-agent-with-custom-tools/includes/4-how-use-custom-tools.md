Custom tools in an agent can be defined in a handful of ways, depending on what works best for your scenario. You may find that your company already has Azure Functions implemented for your agent to use, or a public OpenAPI specification gives your agent the functionality you're looking for.

## Function Calling

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
```

Register the function with your agent using the Azure AI SDK:

```python
# Define a function tool for the model to use
function_tool = FunctionTool(
    name="recent_snowfall",
    parameters={
        "type": "object",
        "properties": {
            "location": {"type": "string", "description": "The city name to check snowfall for."},
        },
        "required": ["location"],
        "additionalProperties": False
    },
    description="Get recent snowfall totals for a given location.",
    strict=True,
)

# Add the function tool to a list of tools for the agent
tools: list[Tool] = [function_tool]

# Create your agent with the toolset
agent = project_client.agents.create_version(
    name="snowfall-agent",
    definition=PromptAgentDefinition(
        model="gpt-4.1",
        instructions="You are a weather assistant tracking snowfall. Use the provided functions to answer questions.",
        tools=tools,
    )
)
```

The agent can now call *recent_snowfall* dynamically when it determines that the prompt requires information that can be retrieved by the function.

## Azure Functions

Azure Functions provide serverless computing capabilities for real-time processing. This integration is ideal for event-driven workflows, enabling agents to respond to triggers such as HTTP requests or queue messages.

### Example: Using Azure Functions with a queue trigger

First, develop and deploy your Azure Function. In this example, imagine we have a function in our Azure subscription to fetch the snowfall for a given location.

When your Azure Function is in place, integrate add it to the agent definition as an Azure Function tool:

  ```python
  tool = AzureFunctionTool(
      azure_function=AzureFunctionDefinition(
          input_binding=AzureFunctionBinding(
              storage_queue=AzureFunctionStorageQueue(
                  queue_name="STORAGE_INPUT_QUEUE_NAME",
                  queue_service_endpoint="STORAGE_QUEUE_SERVICE_ENDPOINT",
              )
          ),
          output_binding=AzureFunctionBinding(
              storage_queue=AzureFunctionStorageQueue(
                  queue_name="STORAGE_OUTPUT_QUEUE_NAME",
                  queue_service_endpoint="STORAGE_QUEUE_SERVICE_ENDPOINT",
              )
          ),
          function=AzureFunctionDefinitionFunction(
              name="queue_trigger",
              description="Get weather for a given location",
              parameters={
                  "type": "object",
                  "properties": {"location": {"type": "string", "description": "location to determine weather for"}},
              },
          ),
      )
  )

  agent = project_client.agents.create_version(
      agent_name="MyAgent",
      definition=PromptAgentDefinition(
          model="gpt-4.1",
          instructions="You are a helpful weather assistant. Use the provided Azure Function to get weather information for a location when needed.",
          tools=[tool],
      ),
  )
  ```

The agent can now send requests to the Azure Function via a storage queue and process the results.

## OpenAPI Specification

OpenAPI defined tools allow agents to interact with external APIs using standardized specifications. This approach simplifies API integration and ensures compatibility with various services. The Foundry Agent Service uses OpenAPI 3.0 specified tools.

> [!TIP]
> Currently, three authentication types are supported with OpenAPI 3.0 tools: *anonymous*, *API key*, and *managed identity*.

### Example: Using an OpenAPI specification

First, create a JSON file ( in this example, called *weather_openapi.json*) describing the API.

  ```json
  {
    "openapi": "3.1.0",
    "info": {
      "title": "get weather data",
      "description": "Retrieves current weather data for a location based on wttr.in.",
      "version": "v1.0.0"
    },
    "servers": [
      {
        "url": "https://wttr.in"
      }
    ],
    "auth": [],
    "paths": {
      "/{location}": {
        "get": {
          "description": "Get weather information for a specific location",
          "operationId": "GetCurrentWeather",
          "parameters": [
            {
              "name": "location",
              "in": "path",
              "description": "City or location to retrieve the weather for",
              "required": true,
              "schema": {
                "type": "string"
              }
            },
            {
            "name": "format",
            "in": "query",
            "description": "Always use j1 value for this parameter",
            "required": true,
            "schema": {
              "type": "string",
              "default": "j1"
            }
          }
          ],
          "responses": {
            "200": {
              "description": "Successful response",
              "content": {
                "text/plain": {
                  "schema": {
                    "type": "string"
                  }
                }
              }
            },
            "404": {
              "description": "Location not found"
            }
          },
          "deprecated": false
        }
      }
    },
    "components": {
      "schemes": {}
    }
  }
  ```

Then, register the OpenAPI tool in the agent defintion:

  ```python
  from azure.ai.projects.models import OpenApiTool, OpenApiAnonymousAuthDetails
  
  with open(weather_asset_file_path, "r") as f:
        openapi_weather = cast(dict[str, Any], jsonref.loads(f.read()))

  tool = OpenApiTool(
      openapi=OpenApiFunctionDefinition(
          name="get_weather",
          spec=openapi_weather,
          description="Retrieve weather information for a location.",
          auth=OpenApiAnonymousAuthDetails(),
      )
  )
  
agent = project_client.agents.create_version(
      agent_name="openapi-agent",
      definition=PromptAgentDefinition(
          model="gpt-4.1",
          instructions="You are a weather assistant. Use the API to fetch weather data.",
          tools=[openapi_tool],
      ),
  )
  ```

The agent can now use the OpenAPI tool to fetch weather data dynamically.

> [!NOTE]
> One of the concepts related to agents and custom tools that developers often have difficulty with is the *declarative* nature of the solution. You don't need to write code that explicitly *calls* your custom tool functions - the agent itself decides to call tool functions based on messages in prompts. By providing the agent with functions that have meaningful names and well-documented parameters, the agent can "figure out" when and how to call the function all by itself!

By using one of the available custom tool options (or any combination of them), you can create powerful, flexible, and intelligent agents with Foundry Agent Service. These integrations enable seamless interaction with external systems, real-time processing, and scalable workflows, making it easier to build custom solutions tailored to your needs.
