::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=d9fd1af7-7d8b-4e29-924b-16830aef386b]

::: zone-end

::: zone pivot="text"

AI applications require a secure, scalable location to store container images that serve inference APIs, data pipelines, and backend services. This module guides you through using Azure Container Registry (ACR) to store, build, and manage container images for AI solutions on Azure.

Imagine you're a developer building an AI inference service that processes customer requests in real time. Your team maintains several container images: a model serving API, a preprocessing service, and a monitoring sidecar. Each image requires updates as models improve and dependencies change. Currently, your team builds images locally and pushes them from developer workstations, leading to inconsistent builds and unclear versioning. Your client expects reliable deployments with traceable image versions and the ability to roll back to previous releases. You need a centralized registry that supports cloud-based builds, enforces consistent tagging, and integrates with your deployment pipelines.

## Learning objectives

After completing this module, you'll be able to:

- Explain how Azure Container Registry organizes images using registries, repositories, and artifacts
- Build and manage container images in the cloud using ACR Tasks
- Implement tagging and versioning strategies for reliable container deployments
- Use the Azure CLI to manage container images and run ACR quick tasks

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
