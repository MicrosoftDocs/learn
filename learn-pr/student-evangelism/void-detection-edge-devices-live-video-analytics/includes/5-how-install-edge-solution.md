[Vision on Edge solution](https://github.com/Azure-Samples/azure-intelligent-edge-patterns/tree/master/factory-ai-vision/EdgeSolution) is a web-based solution using
Custom Vision and Live Video Analytics on IoT Edge. In this unit, you'll learn how to install Vision on Edge solution through Azure Cloud Shell. 

## Using installer

To do so, you use an [installer](https://github.com/Azure-Samples/azure-intelligent-edge-patterns/tree/master/factory-ai-vision/Installer) to deploy the required resources easily in your Azure subscription. This folder contains a bash script and other files listed below to create and set up Azure resources required to run the video analytics solution on IoT Edge.

- [factory-ai-vision-install.sh](https://github.com/Azure-Samples/azure-intelligent-edge-patterns/blob/master/factory-ai-vision/Installer/factory-ai-vision-install.sh) is a bash script intended to be used in the Azure Cloud Shell. This script makes use of the other files in the folder.
- [deploy-custom-vision-arm.json](https://github.com/Azure-Samples/azure-intelligent-edge-patterns/blob/master/factory-ai-vision/Installer/deploy-custom-vision-arm.json) is an [Azure Resource Management template](https://docs.microsoft.com/azure/templates/) for deploying various resources in Azure required.
- [deployment.template.json](https://github.com/Azure-Samples/azure-intelligent-edge-patterns/blob/master/factory-ai-vision/Installer/deployment.lva.json) is a template the script uses to generate a [deployment manifest](https://docs.microsoft.com/azure/iot-edge/module-composition), which can be used for deploying Live Video Analytics on IoT Edge module (and others).
- [acs.zip](https://github.com/Azure-Samples/azure-intelligent-edge-patterns/blob/master/factory-ai-vision/Installer/acs.zip) is an archive file format that contains bash script and other files.

## Steps to follow

The installer is available in the [GitHub repository](https://github.com/Azure-Samples/azure-intelligent-edge-patterns/tree/master/factory-ai-vision/Installer). When you download [the acs.zip file](https://github.com/Azure-Samples/azure-intelligent-edge-patterns/blob/master/factory-ai-vision/Installer/acs.zip), the following steps will be performed to build your solution using Azure Cloud Shell: 

1. Create a Custom Vision service
2. Create an Azure Media Service
3. Select your IoT Hub
4. Select your IoT device
5. Deploy your edge modules to IoT Edge

Upon the successful completion of the installer, you should see all of the required Azure resources in your subscription, and Vision on Edge solution is deployed on IoT Edge. Next, you'll connect to the Vision on Edge solution.
