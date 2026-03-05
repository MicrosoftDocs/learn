Azure Functions provides two identity and access mechanisms that differ from general Azure security patterns: identity-based connections that replace connection strings in trigger and binding configurations, and authorization keys that control access to HTTP-triggered endpoints. These mechanisms change how you configure bindings, authenticate to downstream services, and protect function endpoints from unauthorized callers. Understanding both features helps you eliminate stored credentials from your function app's configuration while maintaining appropriate access control.

## Replace connection strings with identity-based connections

Azure Functions binding extensions support identity-based connections, which use the function app's managed identity to authenticate instead of requiring a connection string stored in application settings. This approach eliminates secrets from your trigger and binding configuration entirely. Rather than storing a full connection string that contains account keys or shared access signatures, you configure the binding with a named connection that includes only the service endpoint or account name. The runtime handles authentication transparently using the assigned managed identity.

To set up an identity-based connection, enable a system-assigned managed identity on the function app, then assign the required Azure roles on the target resource. The function app authenticates using the identity, and no secret values appear in application settings. This is particularly valuable for AI backends that connect to multiple Azure services, because each additional connection string in configuration expands the surface area for credential leaks.

The most common identity-based connection is for the runtime's own storage dependency. You can replace the traditional `AzureWebJobsStorage` connection string with identity-based settings by configuring the storage account name and assigning the appropriate roles:

```
AzureWebJobsStorage__accountName = mystorageaccount
```

The runtime authenticates with the function app's managed identity. The minimum required role is `Storage Blob Data Owner`, which covers host-level coordination such as function state, key storage, and timer locks. If your app uses blob triggers, you also need `Storage Queue Data Contributor` and `Storage Account Contributor` because blob triggers internally use storage queues for blob receipts. For the Service Bus and Cosmos DB patterns covered in this module, `Storage Blob Data Owner` alone is sufficient.

## Use identity-based connections for trigger and output bindings

Identity-based connection configuration differs from connection string configuration in how you set up the named connection prefix. Each binding's `connection` property in `function_app.py` references a named prefix (for example, `connection="ServiceBusConnection"`). With connection strings, you create a single application setting with the prefix name containing the full connection string. With identity-based connections, you create settings using the prefix with property suffixes that specify the service endpoint.

The following examples show how identity-based configuration works for common binding types used in AI backends:

**Service Bus trigger with identity-based connection:** Replace the Service Bus connection string with the fully qualified namespace. Assign the `Azure Service Bus Data Receiver` role to the function app's managed identity on the Service Bus namespace. For output bindings, assign the `Azure Service Bus Data Sender` role instead.

```
ServiceBusConnection__fullyQualifiedNamespace = mynamespace.servicebus.windows.net
```

```python
# Code fragment - focus on Service Bus trigger with identity-based connection
@app.service_bus_queue_trigger(
    arg_name="msg",
    queue_name="document-jobs",
    connection="ServiceBusConnection"
)
def process_document(msg: func.ServiceBusMessage) -> None:
    job = json.loads(msg.get_body().decode("utf-8"))
    # Process the document...
```

**Cosmos DB output binding with identity-based connection:** Replace the Cosmos DB connection string with the account endpoint. Assign the `Cosmos DB Built-in Data Contributor` role to the function app's managed identity.

```
CosmosDBConnection__accountEndpoint = https://mycosmosaccount.documents.azure.com:443/
```

Each binding extension documents its supported identity properties and required roles. The suffix pattern differs by service: storage bindings use `__accountName` or service-specific URIs, Cosmos DB uses `__accountEndpoint`, and messaging services use `__fullyQualifiedNamespace`. Consult the [identity-based connections reference](/azure/azure-functions/functions-reference#configure-an-identity-based-connection) for the complete list of supported bindings and their configuration properties.

## Authenticate SDK clients with managed identity

For Azure services without dedicated binding support, such as Azure AI Document Intelligence, Azure OpenAI Service, or Azure AI Search, you create SDK clients directly in your function code. These clients can authenticate using the same managed identity that serves your trigger and binding connections, providing a consistent identity-based approach across all service integrations.

`DefaultAzureCredential` from the Azure Identity library provides a credential chain that works in both local development and production environments. Locally, it authenticates using your developer credentials from Azure CLI or Visual Studio Code. In production, it uses the function app's managed identity. This dual behavior means the same code runs without modifications across environments.

Initialize both the credential object and the service client outside the function handler at the module level. This placement ensures the objects persist across invocations on the same instance, avoiding the overhead of repeated credential resolution and connection establishment. Module-level initialization is safe because Azure Functions reuses the same process for multiple invocations until the instance is recycled.

```python
# Code fragment - focus on module-level client initialization
import os
from azure.identity import DefaultAzureCredential
from azure.ai.documentintelligence import DocumentIntelligenceClient
from azure.search.documents import SearchClient

credential = DefaultAzureCredential()

doc_client = DocumentIntelligenceClient(
    endpoint=os.environ["DOCUMENT_INTELLIGENCE_ENDPOINT"],
    credential=credential
)

search_client = SearchClient(
    endpoint=os.environ["SEARCH_ENDPOINT"],
    index_name=os.environ["SEARCH_INDEX"],
    credential=credential
)
```

For production deployments, assign the minimum required roles for each service. Azure AI Document Intelligence requires the `Cognitive Services User` role, Azure AI Search requires `Search Index Data Reader` or `Search Index Data Contributor` depending on the operations your function performs, and Azure OpenAI Service requires `Cognitive Services OpenAI User`. Applying the principle of least privilege limits the impact of any identity compromise.

## Secure HTTP endpoints with authorization keys

Azure Functions uses access keys to restrict access to HTTP-triggered function endpoints. This mechanism is specific to Azure Functions and operates independently from Microsoft Entra authentication. Access keys provide a basic barrier that prevents unauthorized callers from invoking your functions, but they don't verify caller identity or provide fine-grained access control.

Azure Functions defines four types of keys, each with a different scope:

- **Function keys:** Scoped to a single function. Each function can have multiple named keys. Include the key in the `x-functions-key` header or the `code` query parameter when calling the function.
- **Host keys:** Scoped to all functions in the function app. A single host key grants access to every HTTP-triggered function in the app. Use host keys for administrative tools or monitoring agents that need to call multiple functions.
- **System keys:** Used by specific extensions to authenticate internal operations. For example, the MCP extension uses the `mcp_extension` system key to authenticate MCP client connections to the function app. System keys are managed by the runtime and shouldn't be shared broadly.
- **Master key:** Provides administrative access and overrides all other key types. The master key also grants access to the runtime REST APIs. Treat the master key as a highly sensitive credential and never embed it in client applications.

You set the authorization level per HTTP trigger using the `auth_level` parameter in the `@app.route()` decorator. The `anonymous` level requires no key, which is appropriate for health check endpoints or functions behind an API gateway that handles authentication separately. The `function` level requires a function-specific key or a host key, and is the recommended baseline for production endpoints. The `admin` level requires the master key and should be reserved for administrative operations.

```python
# Code fragment - focus on authorization levels
@app.route(route="classify", methods=["POST"], auth_level=func.AuthLevel.FUNCTION)
def classify_document(req: func.HttpRequest) -> func.HttpResponse:
    # This function requires a function key or host key to invoke
    pass

@app.route(route="health", methods=["GET"], auth_level=func.AuthLevel.ANONYMOUS)
def health_check(req: func.HttpRequest) -> func.HttpResponse:
    return func.HttpResponse("OK", status_code=200)
```

Access keys provide a basic access barrier but don't replace authentication for production AI endpoints. For applications that require caller identity verification, layer Azure API Management or App Service Authentication (Easy Auth) on top of access keys. API Management adds rate limiting, request validation, and OAuth 2.0 token verification, while Easy Auth integrates Microsoft Entra ID directly with the function app.

## Additional resources

- [Identity-based connections for Azure Functions](/azure/azure-functions/functions-reference#configure-an-identity-based-connection)
- [Azure Functions access keys](/azure/azure-functions/security-concepts#function-access-keys)
- [DefaultAzureCredential overview](/azure/developer/python/sdk/authentication/credential-chains#defaultazurecredential-overview)
