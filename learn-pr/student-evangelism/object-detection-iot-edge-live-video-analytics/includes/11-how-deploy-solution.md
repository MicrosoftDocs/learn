In the historical workflow, after the edge device and modules were configured, the learner connected to the Vision on Edge web application. The web application was used to add a camera stream, add model endpoint information and labels, and create a task that detected people in the sample video.

> [!IMPORTANT]
> The web application path in this module depends on archived Vision on Edge assets and retired Azure Video Analyzer Edge (formerly Live Video Analytics on IoT Edge) components. It isn't a current supported deployment path. For new solutions, use a supported video analytics service such as Azure AI Video Indexer enabled by Arc. Azure AI Video Indexer enabled by Arc is generally available on supported Arc-enabled Kubernetes clusters, but deploying the Azure AI Video Indexer enabled by Arc extension requires prior subscription approval through the gated-services application process. Its real-time video analysis capability is currently in preview/early access and requires separate subscription approval in addition to its hardware requirements, preview limitations, and other feature limitations. You can also use another maintained edge video pipeline.

For current designs, avoid exposing management or video web applications directly on a public IP address. Prefer VPN/private network access, SSH local port forwarding over an approved SSH path, or another controlled network path. Use Azure Bastion for VM SSH/RDP management, not as a direct HTTP relay for the web application. Production endpoints require TLS, authentication, and least-privilege access controls.

## Historical steps

As a summary, the original web application workflow included these steps:

1. Connect to the web application
2. Add a camera that streamed the video feed from an RTSP URL
3. Add a model endpoint and upload labels
4. Create a solution deployment task

These steps are useful for understanding how the sample was intended to connect video input, model inference, and visualization. Don't treat them as current instructions unless you replace the retired dependencies with supported components and validate the entire solution.
