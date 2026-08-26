::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=47a6ce12-cefb-4f67-88ba-f01af4619c1a]

::: zone-end

::: zone pivot="text"

AI applications require supporting services that can evolve independently without adding unnecessary network hops or deployment complexity. This module guides you through the use of sidecars in Azure App Service to run supporting AI components beside a main Linux app container.

Imagine you're a developer building a conversational AI backend for an internal support portal. A Python API validates requests, applies business rules, and formats responses. The API sends prompts to a local model server over `localhost`, which avoids a separate network endpoint for regulated data. Your team must still evaluate the model image, outbound connectivity, logging, and storage against the application's compliance requirements. The team wants to update the model-serving image without rebuilding the API image. The API and model server must scale together because every API instance requires a local model endpoint. Only the API should receive external traffic. The model server accepts requests over the shared network namespace. Both containers need a shared directory for temporary model artifacts, but the artifacts don't require durable storage. The solution also pulls images from Azure Container Registry without storing registry passwords. An App Service sidecar keeps the processes in separate images while App Service manages them as one application.

After completing this module, you'll be able to:

- Explain when an App Service sidecar fits a tightly coupled AI application component.
- Configure main and sidecar containers, target ports, environment variables, and private registry authentication.
- Implement container communication over `localhost` and file exchange through the shared `/home` volume.
- Diagnose sidecar image pull, startup, resource, and connectivity failures.

> [!NOTE]
> All Azure CLI examples in this module are based on the most recent version of the `az webapp sitecontainers` command group at the time of writing. Azure CLI is updated often. Visit the [Azure CLI documentation for App Service site containers](/cli/azure/webapp/sitecontainers) for the most up-to-date information.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
