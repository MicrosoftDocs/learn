The original [Vision on Edge solution](https://github.com/Azure-Samples/azure-intelligent-edge-patterns/tree/master/factory-ai-vision/EdgeSolution) was a web-based sample that used Azure Video Analyzer Edge (formerly Live Video Analytics on IoT Edge) and interacted with edge modules. The repository's archived and isn't actively maintained.

> [!IMPORTANT]
> Don't use the Vision on Edge installer as a current deployment path. The sample repository's archived, its installer flow no longer matches the original module, it references retired Azure Video Analyzer Edge components, and the checked deployment templates (`deployment.lva.json`, `deployment.ava.json`, and `deployment.opencv.json`) pin the IoT Edge system modules to `mcr.microsoft.com/azureiotedge-agent:1.0` and `mcr.microsoft.com/azureiotedge-hub:1.0` instead of the current IoT Edge 1.5 LTS baseline. Azure Media Services also retired on June 30, 2024. Treat this unit as a historical overview only.

## Historical installer

The original module used an [installer](https://github.com/Azure-Samples/azure-intelligent-edge-patterns/tree/master/factory-ai-vision/Installer) to deploy resources in an Azure subscription. This folder contained a bash script and other files that created and configured Azure resources for the video analytics solution on IoT Edge.

- [factory-ai-vision-install.sh](https://github.com/Azure-Samples/azure-intelligent-edge-patterns/blob/master/factory-ai-vision/Installer/factory-ai-vision-install.sh) was a bash script intended for Azure Cloud Shell.
- [deploy-custom-vision-arm.json](https://github.com/Azure-Samples/azure-intelligent-edge-patterns/blob/master/factory-ai-vision/Installer/deploy-custom-vision-arm.json) was an Azure Resource Manager template for deploying Custom Vision resources. Custom Vision is supported for existing customers until September 25, 2028; after that date, API calls fail. Microsoft recommends creating a transition plan by September 25, 2026. For new object-detection work, plan to use Azure Machine Learning AutoML.
- [deployment.lva.json](https://github.com/Azure-Samples/azure-intelligent-edge-patterns/blob/master/factory-ai-vision/Installer/deployment.lva.json) preserved the historical Live Video Analytics on IoT Edge (LVA) deployment manifest from the original module. It deploys the `lvaEdge` module with the unmaintained `mcr.microsoft.com/media/live-video-analytics:2` image, so it isn't a supported current deployment target. The current archived installer uses the separate Azure Video Analyzer Edge manifest `deployment.ava.json` with `mcr.microsoft.com/media/video-analyzer:1`, or `deployment.opencv.json`; don't treat the LVA and Azure Video Analyzer manifests as the same product path.
- [acs.zip](https://github.com/Azure-Samples/azure-intelligent-edge-patterns/blob/master/factory-ai-vision/Installer/acs.zip) was the archive used by the historical exercise.

> [!WARNING]
> The archived Vision on Edge installer (`factory-ai-vision-install.sh`) calls `az iot hub connection-string show` without `--policy-name`, so it defaults to the high-privilege `iothubowner` shared-access policy. It also writes secrets such as the Custom Vision key, IoT Hub connection string, and Azure Video Analyzer provisioning token into plaintext config files under `factoryai_configs/factoryai_cfgs/`, then substitutes those values into the generated `deploy.modules.json` file before running `az iot edge set-modules`. That command submits the generated manifest to IoT Hub as IoT Edge deployment and module-twin desired configuration, so the secrets can exist in both local artifacts and the applied IoT Edge configuration. Terminal output, command logs, scrollback, and screenshots from a reproduction can also expose connection strings and generated config values. Treat this as historical sample behavior. For any current implementation, prefer Microsoft Entra ID for IoT Hub access. If you still need a connection string, use a least-privilege shared-access policy or role assignment matched to the exact operations needed instead of `iothubowner`, don't persist secrets to disk, delete generated files such as `deploy.modules.json` and reproduction logs after a lab reproduction, and rotate or delete lab credentials when you finish.

## Historical prerequisites

The archived installer expected these prerequisites and permissions before it could finish:

- An existing Azure IoT Hub and a registered IoT Edge device.
- Azure CLI in Azure Cloud Shell or another shell, plus the Azure IoT extension. The script explicitly ran `az extension add --name azure-iot`.
- Access to retrieve the IoT Hub connection string by using `az iot hub connection-string show`.
- Permission to apply the deployment manifest by using `az iot edge set-modules`.

That dependency chain is one reason the archived installer isn't a self-contained current lab flow.

## Historical steps

The installer in the archived [GitHub repository](https://github.com/Azure-Samples/azure-intelligent-edge-patterns/tree/master/factory-ai-vision/Installer) was originally documented as performing these steps:

1. Create a Custom Vision service
2. Create an Azure Media Services account
3. Select your IoT Hub
4. Select your IoT Edge device
5. Deploy edge modules to IoT Edge

The current archived installer doesn't reproduce the Azure Video Analyzer Edge and Azure Media Services path shown in the original screenshots. Its script now branches to `deployment.ava.json` or `deployment.opencv.json`, and the Azure Video Analyzer Edge path can prompt for a provisioning token instead of the historical resources shown here. Because these services, manifests, and sample assets aren't maintained for this module, don't run the installer in a current subscription.

For a current implementation, start with a Microsoft-documented alternative such as Azure AI Video Indexer enabled by Arc or another maintained edge video pipeline. Azure AI Video Indexer enabled by Arc runs as an Azure Arc extension-enabled service on Azure Arc-enabled Kubernetes, and its real-time analysis capability is currently in preview. Keep that Arc/Kubernetes option separate from IoT Edge 1.5 deployments; it isn't an IoT Edge module or LVA drop-in replacement. If your design requires custom image classification or object detection, plan for Azure Machine Learning AutoML. For broader generative or custom-solution scenarios, evaluate Azure AI Foundry separately.
