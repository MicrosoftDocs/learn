::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=446765b0-134d-418d-8fca-23b0da8ae091]

::: zone-end

::: zone pivot="text"

AI applications on Azure need safe configuration, strong secret handling, and durable storage. These capabilities help you meet latency, reliability, and governance goals. Configuring applications on Azure Kubernetes Service (AKS) lets you externalize settings. You can also secure sensitive values and attach persistent storage for stateful AI workloads.

Imagine you deploy an AI inference API that serves models at scale. The service needs environment-specific settings for endpoints. It also needs API keys for upstream services and a durable location for temporary artifacts and user uploads. You aim for predictable rollouts and secure operations. Without Kubernetes features, teams hardcode values into containers. They risk leaking credentials or losing state when Pods restart. ConfigMaps let you separate configuration from code. Secrets protect sensitive values like API keys and connection strings. PersistentVolumeClaims (PVCs) give you durable storage that survives Pod restarts. Together, these features help you run stateful AI workloads securely on AKS.

## After completing this module, you'll be able to:

- Explain why externalized configuration and secret handling matter for AI solutions on Azure
- Implement ConfigMaps for nonsensitive settings and inject them into Pods
- Implement Secrets for sensitive values and consume them securely in Pods
- Attach persistent storage using PersistentVolume and PersistentVolumeClaim for stateful AI workloads
- Deploy and verify configuration and storage on AKS using `kubectl`

> [!NOTE]
> All examples in this module follow current Kubernetes resource APIs. Validate fields against official Kubernetes and AKS documentation when adapting to your environment.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
