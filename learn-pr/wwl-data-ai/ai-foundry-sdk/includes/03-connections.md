Each Azure AI Foundry project includes **connected resources**, which are defined both at the *parent* (Azure AI Foundry resource or hub) level, and at the *project* level. Each resource is a *connection* to an external service, such as Azure storage, Azure AI Search, Azure OpenAI, or another Azure AI Foundry resource.

[ ![Screenshot of the connected resources page in Azure AI Foundry portal.](../media/ai-project-connections.png) ](../media/ai-project-connections.png#lightbox)

With the Azure AI Foundry SDK, you can connect to a project and retrieve connections; which you can then use to consume the connected services.

For example, the **AIProjectClient** object in Python has a **connections** property, which you can use to access the resource connections in the project. Methods of the **connections** object include:

- `connections.list()`: Returns a collection of connection objects, each representing a connection in the project. You can filter the results by specifying an optional **connection_type** parameter with a valid enumeration, such as `ConnectionType.AZURE_OPEN_AI`.
- `connections.get(connection_name, include_credentials)`: Returns a connection object for the connection with the name specified. If the **include_credentials** parameter is **True** (the default value), the credentials required to connect to the connection are returned - for example, in the form of an API key for an Azure AI services resource.

The connection objects returned by these methods include connection-specific properties, including credentials, which you can use to connect to the associated resource.

The following code example lists all of the resource connections that have been added to a project:

```python
from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient

try:

    # Get project client
    project_endpoint = "https://....."
    project_client = AIProjectClient(            
            credential=DefaultAzureCredential(),
            endpoint=project_endpoint,
        )
    
    ## List all connections in the project
    connections = project_client.connections
    print("List all connections:")
    for connection in connections.list():
        print(f"{connection.name} ({connection.type})")

except Exception as ex:
    print(ex)
```
