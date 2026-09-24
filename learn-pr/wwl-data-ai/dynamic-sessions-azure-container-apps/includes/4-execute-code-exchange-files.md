::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=40aa1730-d1a9-4f9b-b5fb-4cd3b37a7bed]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

An AI backend interacts with a dynamic session through the session pool management API. The backend authenticates with Microsoft Entra ID before it assigns each user or conversation an application-controlled identifier. It then sends only authorized code and files into the isolated environment.

> [!NOTE]
> The Python examples in this unit use `azure-identity`, `requests`, and `langchain-azure-dynamic-sessions` to demonstrate integration patterns. Adapt the fragments to your application's HTTP client, orchestration framework, validation policy, and current [code interpreter data-plane API](/rest/api/containerapps/) before using them in production.

## Authenticate the backend

Every management API request requires a Microsoft Entra bearer token. The calling identity needs the Azure ContainerApps Session Executor role on the session pool, and the token's audience must be `https://dynamicsessions.io`. A managed identity provides passwordless authentication when the backend runs on Azure.

You can assign the role at the session pool scope so the identity can't execute code in unrelated pools. The following command assumes that you already know the backend identity's principal ID and the session pool resource ID.

```azurecli
az role assignment create \
    --role "Azure ContainerApps Session Executor" \
    --assignee <BACKEND_PRINCIPAL_ID> \
    --scope <SESSION_POOL_RESOURCE_ID>
```

Application code can use `DefaultAzureCredential` in both local development and Azure-hosted environments. The credential selects an available developer credential locally and a managed identity in Azure without storing an application secret in source code.

```python
from azure.identity import DefaultAzureCredential

credential = DefaultAzureCredential()
access_token = credential.get_token(
    "https://dynamicsessions.io/.default"
).token
```

Request a token when the application prepares a call rather than caching the token indefinitely. `DefaultAzureCredential` handles token caching and renewal, while your code obtains a valid token for the next request.

## Create secure session identifiers

A session identifier routes a request to an existing session or causes the pool to allocate a new one. Reusing the identifier preserves temporary files and state across related calls. Because the identifier grants access to that state when combined with an authorized token, the backend must treat it as sensitive.

Generate an unpredictable identifier on the server for each authenticated user or agent conversation. Keep the association in server-side application state, and don't accept an arbitrary identifier from the client. A random UUID is suitable because its hyphenated representation meets the dynamic session identifier format.

```python
from uuid import uuid4


def create_session_identifier() -> str:
    return str(uuid4())
```

The identifier alone doesn't authenticate a caller. The backend still authorizes the user before using the stored association and authenticates every pool request with its own token. This design prevents a user from changing a request parameter to target another conversation's environment.

## Submit code for execution

The code interpreter `executions` endpoint accepts inline code and returns the execution response. In a production AI application, the orchestration layer might supply the code, but the backend should validate the request against its policy before submission. Isolation reduces the impact of untrusted code but doesn't determine whether the requested action is appropriate.

The following helper creates authenticated headers and common query parameters. It asks `DefaultAzureCredential` for a valid token for each operation and keeps the session identifier under application control.

```python
from azure.identity import DefaultAzureCredential

API_VERSION = "2025-10-02-preview"
TOKEN_SCOPE = "https://dynamicsessions.io/.default"


class DynamicSessionClient:
    def __init__(
        self,
        pool_management_endpoint: str,
        session_identifier: str,
    ) -> None:
        self.endpoint = pool_management_endpoint.rstrip("/")
        self.identifier = session_identifier
        self.credential = DefaultAzureCredential()

    def _headers(self) -> dict[str, str]:
        token = self.credential.get_token(TOKEN_SCOPE).token
        return {"Authorization": f"Bearer {token}"}

    def _params(self) -> dict[str, str]:
        return {
            "api-version": API_VERSION,
            "identifier": self.identifier,
        }
```

The next method submits synchronous Python code. `raise_for_status()` keeps authentication, validation, capacity, and service failures from looking like successful executions. The caller must still inspect the returned execution data for an error raised by the Python code.

```python
import requests


def execute_python(
    client: DynamicSessionClient,
    code: str,
) -> dict:
    response = requests.post(
        f"{client.endpoint}/executions",
        headers={
            **client._headers(),
            "Content-Type": "application/json",
        },
        params=client._params(),
        json={
            "properties": {
                "codeInputType": "inline",
                "executionType": "synchronous",
                "code": code,
            }
        },
        timeout=30,
    )
    response.raise_for_status()
    return response.json()
```

The data-plane API version can change while the feature evolves. Keep the version in configuration instead of scattering it across request methods, then test the response contract when you update it.

## Exchange files with a session

File operations let code process user uploads and produce artifacts such as charts or transformed documents. The backend uploads only files authorized for the current task. Code interpreter sessions place uploaded files in `/mnt/data`, where subsequent executions with the same identifier can access them.

The following method uploads a file by using a multipart request. The context manager closes the local file even when the request fails, and the explicit timeout prevents the backend from waiting indefinitely.

```python
from pathlib import Path

import requests


def upload_file(
    client: DynamicSessionClient,
    file_path: Path,
) -> dict:
    with file_path.open("rb") as source:
        response = requests.post(
            f"{client.endpoint}/files",
            headers=client._headers(),
            params=client._params(),
            files={
                "file": (
                    file_path.name,
                    source,
                    "application/octet-stream",
                )
            },
            timeout=30,
        )

    response.raise_for_status()
    return response.json()
```

After code creates an output file, the backend can list session files and download the selected artifact. Encode the service-side file name as one URL path segment because supported file names can contain reserved URL characters. Never construct a local destination from an untrusted file name without validating it because path traversal could overwrite an unintended file.

```python
from urllib.parse import quote


def list_files(client: DynamicSessionClient) -> dict:
    response = requests.get(
        f"{client.endpoint}/files",
        headers=client._headers(),
        params=client._params(),
        timeout=15,
    )
    response.raise_for_status()
    return response.json()


def download_file(
    client: DynamicSessionClient,
    file_name: str,
    destination: Path,
) -> None:
    encoded_file_name = quote(file_name, safe="")
    response = requests.get(
        f"{client.endpoint}/files/{encoded_file_name}/content",
        headers=client._headers(),
        params=client._params(),
        timeout=30,
    )
    response.raise_for_status()
    destination.write_bytes(response.content)
```

The code interpreter file upload limit is 128 MB. For larger source data, redesign the task so the session receives a smaller approved input or use a custom execution architecture that meets the workload's storage requirements.

## Reuse a session across operations

Related calls reuse the same environment when they include the same identifier before the session expires. This behavior lets the application upload a document once, execute an analysis, and create another visualization without uploading the source again. A different identifier creates or addresses a separate environment.

The following sequence uses one client instance and therefore one identifier. The supplied code payload represents validated output from an AI orchestration layer.

```python
from pathlib import Path

session_id = create_session_identifier()
client = DynamicSessionClient(pool_endpoint, session_id)

upload_file(client, Path("operational-data.csv"))
execution = execute_python(client, supplied_python_payload)
available_files = list_files(client)
download_file(client, "trend.png", Path("trend.png"))
```

Session reuse is temporary convenience, not a durable storage guarantee. Save accepted results and source data in application-controlled storage so the backend can recover when the cooldown removes the session.

## Integrate a LangChain agent

Direct REST access is appropriate when the backend needs explicit control over session identifiers, file exchange, or API responses. When an AI application already uses LangChain, the `langchain-azure-dynamic-sessions` package provides `SessionsPythonREPLTool` as a higher-level integration with the same code interpreter pool. The tool can participate in a LangChain agent's tool-calling workflow without requiring the application to construct each execution request.

The following fragment creates the tool from a pool management endpoint and makes it available to an agent. The tool generates a random session identifier when the application creates the instance. Calls through that instance reuse the same session until the session expires.

```python
# Code fragment - focus on creating the LangChain tool
from langchain_azure_dynamic_sessions import SessionsPythonREPLTool

python_repl = SessionsPythonREPLTool(
    pool_management_endpoint=pool_management_endpoint
)
agent_tools = [python_repl]
```

Don't register one long-lived tool instance as a shared singleton for every user. Create a separate tool and agent context for each authenticated user or conversation so unrelated requests don't share temporary files or Python state. The application still controls user authorization, validates agent requests, assigns the Azure ContainerApps Session Executor role to its identity, and stores durable artifacts outside the session.

The LangChain adapter is useful when the agent primarily needs Python execution as a tool. Direct API calls provide more explicit control when the backend must upload source files before execution, download specific artifacts, manage identifier mapping, or interpret the complete service response. For a complete agent example, see [Use code interpreter sessions in LangChain with Azure Container Apps](/azure/container-apps/sessions-tutorial-langchain).

::: zone-end

## Additional resources

These resources provide the current authentication, execution, and file API details. You can use them to confirm request formats and security requirements when you implement the backend integration.

- [Run code in a code interpreter session](/azure/container-apps/sessions-code-interpreter#run-code-in-a-session)
- [Work with files in a code interpreter session](/azure/container-apps/sessions-code-interpreter#work-with-files)
- [Authenticate to dynamic sessions](/azure/container-apps/sessions-usage#authentication-and-authorization)
