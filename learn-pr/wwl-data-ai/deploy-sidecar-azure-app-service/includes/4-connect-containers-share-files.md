::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=91c07794-6b5e-4703-8974-6bc74537db9a]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

App Service sidecars communicate through a shared network namespace, so a main app can call a supporting process without a separate service endpoint. Containers also share the default App Service `/home` volume for file exchange. These mechanisms simplify tightly coupled AI components, but developers need to account for unique ports, timeouts, file permissions, and storage durability.

> [!NOTE]
> The code and configuration examples are patterns to adapt to your application. You should use explicit timeouts, validate untrusted data, and choose durable Azure Storage when files must survive restarts or scale operations.

## Connect through the shared network namespace

All containers in a sidecar-enabled app share one network namespace. A container reaches another container with `localhost:<port>`, not with a container name or service name. Each process must listen on a unique port because the processes share the same local interfaces.

In the conversational AI application, the main API calls the model server at `http://localhost:11434`. The URL remains local to each App Service instance. When App Service scales the app to several instances, each main container calls the model-server sidecar on its own instance.

The following Python fragment creates a bounded HTTP client for the local model endpoint. The timeout prevents a stalled model server from holding an API request indefinitely.

```python
import asyncio

import httpx

MODEL_ENDPOINT = "http://localhost:11434/v1/chat/completions"

async def request_completion(messages: list[dict[str, str]]) -> dict:
    timeout = httpx.Timeout(10.0, connect=2.0)
    async with httpx.AsyncClient(timeout=timeout) as client:
        async with asyncio.timeout(30.0):
            response = await client.post(
                MODEL_ENDPOINT,
                json={"model": "support-model", "messages": messages},
            )
        response.raise_for_status()
        return response.json()
```

The short connection timeout detects a process that isn't listening. The HTTPX value limits network inactivity during read, write, and connection-pool operations. The `asyncio.timeout` context sets a 30-second deadline for the complete request. Your values should reflect measured startup and inference behavior rather than arbitrary defaults.

App Service routes external traffic only to the main container. A sidecar target port identifies the process port for internal communication, but it doesn't publish the sidecar as a separate public endpoint. The main app remains responsible for external authentication, authorization, request validation, and response filtering.

## Design reliable local requests

Local communication removes external network routing, but it doesn't remove distributed-process failure modes. The model process can restart, run out of memory, reject a request, or take longer than the API's response budget. The main API needs to treat the local call as a fallible dependency.

A practical request policy includes:

- A short connection timeout to detect an unavailable sidecar.
- An application-level request deadline that fits the API's client-facing latency target.
- Cancellation when the original API request ends.
- A limited retry only when the operation is safe to repeat.
- Clear error mapping so clients can distinguish temporary unavailability from invalid input.
- Correlation identifiers in both container logs.

You shouldn't retry every failure. A second request can duplicate work when the model server completed the first operation but the response was lost. Retries can also increase resource pressure during a sidecar failure. Use a small retry budget only for errors that the model API defines as transient and only when the operation is idempotent.

Readiness also matters during deployment and scale-out. The main container can start before the model is fully loaded. You can make the API return a temporary unavailable response until a lightweight sidecar health request succeeds, rather than accepting inference traffic that can't complete.

## Use the shared home volume

By default, App Service mounts the same `/home` volume into the main container and every sidecar. Containers can exchange files through a dedicated directory such as `/home/models` without adding a `volumeMounts` array to their site container definitions. This built-in mount is the simplest option when all containers can use the same in-container path.

The built-in mount is available unless the app sets `WEBSITES_ENABLE_APP_SERVICE_STORAGE=false`. The setting also controls whether Linux custom-container data in `/home` persists across restarts and is shared across scaled-out instances. When you need only temporary coordination within one app instance, treat the files as recreatable even if App Service storage is enabled. You can use Azure Storage directly when the application requires a durable system of record.

For the conversational AI application, the model server's `MANIFEST_PATH` and the main API's `MODEL_INFO_PATH` can both resolve to `/home/models/manifest.json`. The model server can write a completed artifact to that shared path:

```python
from pathlib import Path

SHARED_DIRECTORY = Path("/home/models")
SHARED_DIRECTORY.mkdir(parents=True, exist_ok=True)

temporary_manifest = SHARED_DIRECTORY / "manifest.json.tmp"
completed_manifest = SHARED_DIRECTORY / "manifest.json"
temporary_manifest.write_text('{"model": "support-model"}', encoding="utf-8")
temporary_manifest.replace(completed_manifest)
```

The main API reads the completed file from `/home/models/manifest.json`. Writing to a temporary name and then renaming the file prevents the API from reading a partially written manifest.

## Avoid unnecessary custom mounts

The default shared `/home` volume already meets this application's file-exchange requirement, so don't add `volumeMounts` entries to the main or sidecar definitions. Explicit mounts change the container's file-system view and can prevent the app or SCM endpoint from starting when a mount configuration conflicts with the runtime environment.

You can use `/home/models/manifest.json` in both containers and keep `volumeMounts` absent from the site container specification. If an existing deployment becomes unavailable after you add custom mounts, you can remove the `volumeMounts` configuration and restore the last known working container definitions before you investigate other causes.

## Choose the correct storage boundary

The shared `/home` directory works for files that belong to the web app's operational workflow. You shouldn't treat the directory as a model registry, audit store, or independent durable system of record.

The shared `/home` directory fits data such as:

- Temporary files produced and consumed on the same app instance.
- Generated configuration that a sidecar refreshes and the main app reads.
- Local model metadata that can be recreated from a durable source.
- Intermediate request artifacts with a short lifetime.

The default `/home` volume can persist across restarts and be shared across instances when App Service storage is enabled, subject to the App Service plan's storage quota. Use [Azure Blob Storage](/azure/storage/blobs/storage-blobs-introduction) or [Azure Files](/azure/storage/files/storage-files-introduction) when the data needs an explicit durable storage boundary outside the web app. Use a managed data service when several applications need coordinated access, consistency, or independent scaling.

File exchange also requires a clear ownership protocol. A reader can observe a partially written file if a writer updates the shared path directly. You can write to a temporary name and then rename the completed file, or publish a small manifest only after all related artifacts are ready.

## Validate communication and file access

Validation should test the same paths and ports that application code uses. A successful external response from the main container doesn't prove that the model sidecar is ready. Test the local dependency through a main-app health operation or diagnostic endpoint that doesn't expose sensitive model details.

You can verify the integration in this order:

1. Confirm that each container definition has a unique target port.
1. Confirm that the model process logs show a listener on the expected port.
1. Call a lightweight model health operation from the main container.
1. Send a representative inference request and record the latency.
1. Write a test artifact from the designated writer container.
1. Read the artifact through the consumer container's shared path.
1. Restart the app and confirm that the application recreates any required temporary data.

You should avoid exposing a generic proxy to the sidecar. A narrow health or inference operation preserves the main API as the external security boundary.

::: zone-end

## Additional resources

The following resources describe App Service sidecar networking and volume behavior in more detail. You can use them to verify platform constraints before you design a communication or file-sharing contract.

- [Access a sidecar from another container](/azure/app-service/configure-sidecar#access-a-sidecar-from-the-main-container-or-from-another-sidecar)
- [Use persistent shared storage in a Linux custom container](/azure/app-service/configure-custom-container#use-persistent-shared-storage)
- [Sidecars overview in Azure App Service](/azure/app-service/overview-sidecar)
