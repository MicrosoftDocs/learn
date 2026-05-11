In this module, you built a self-checkout image recognition solution using Azure IoT Edge, a prebuilt Azure AI Custom Vision classification model, and Azure Speech text to speech. The Image Classification module runs inference locally at the edge. The Camera Capture module calls that local classifier, then calls Azure Speech to announce the recognized fruit label through a speaker. By combining IoT Hub device management with containerized IoT Edge modules, you deployed a complete machine learning pipeline to an edge device without building security or communication infrastructure from scratch.

## In this module, you learned how to:

- Described how Azure IoT Edge, Azure IoT Hub, a camera, and containerized modules support image recognition at the edge
- Used a prebuilt, exported Azure AI Custom Vision classification model packaged in an IoT Edge module
- Created the required Azure resources, including an IoT Hub device identity and a Foundry resource for Speech in Southeast Asia, unless you update the sample code and deployment template to make the Speech region configurable
- Built and deployed the solution to an Azure IoT Edge device by using Visual Studio Code
- Verified module status, monitored events from the edge device and Azure IoT Hub, and identified cleanup steps for lab resources

## Learn more

- [Azure IoT Edge documentation](/azure/iot-edge/)
- [Azure IoT Edge supported platforms](/azure/iot-edge/support)
- [Azure AI Custom Vision documentation](/azure/ai-services/custom-vision-service/)
- [Azure AI Custom Vision migration options](/azure/ai-services/custom-vision-service/migration-options)
- [Azure Speech text to speech](/azure/ai-services/speech-service/text-to-speech)
- [Azure Speech language and voice support](/azure/ai-services/speech-service/language-support)
- [Troubleshoot your IoT Edge device](/azure/iot-edge/troubleshoot)
- [Deploy Azure IoT Edge modules using Azure CLI](/azure/iot-edge/how-to-deploy-modules-cli)
- [Develop IoT Edge modules with Azure IoT Edge Dev Tool CLI (preferred; VS Code IoT Edge extension in maintenance mode)](/azure/iot-edge/tutorial-develop-for-linux)
- [Manage Azure resource groups by using Azure CLI](/azure/azure-resource-manager/management/manage-resource-groups-cli)

