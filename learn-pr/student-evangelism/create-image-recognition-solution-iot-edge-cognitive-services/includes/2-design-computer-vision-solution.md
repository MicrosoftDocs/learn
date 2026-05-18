In this module, you'll build an image recognition solution with an IoT Edge device capable of communicating via audio. Azure IoT Hub manages the IoT Edge device. The exported Azure AI Custom Vision model runs locally in the Image Classification module on IoT Edge, and at runtime the Camera Capture module calls Azure Speech text to speech in Foundry Tools as the cloud Speech dependency. The provided image classification model was created in and exported from Azure AI Custom Vision before the exercise. Free-tier or free-trial capacity for Azure services is subject to current service limits and pricing.
- [Azure IoT Hub](/azure/iot-hub/)
- [Azure Speech text to speech](/azure/ai-services/speech-service/get-started-text-to-speech)
- [Azure AI Custom Vision](/azure/ai-services/custom-vision-service/overview) (used to create and export the provided model before the exercise)

You'll configure IoT Edge runtime for your Linux computer to act as an IoT Edge device. In this lab-only workflow, you'll use Visual Studio Code to deploy your solution at the edge.

> [!NOTE]
> The Visual Studio Code deployment path is included for this lab because the exercise assets depend on the Azure IoT Edge Tools and Azure IoT Hub extensions. Microsoft's [IoT Edge development tools documentation](/azure/iot-edge/development-environment#development-tools) states that the Azure IoT Edge Tools for Visual Studio Code extension is in maintenance mode and identifies the Azure IoT Edge Dev Tool CLI (`iotedgedev`) as the preferred development tool for new IoT Edge module development. The [Azure IoT Hub extension documentation](/azure/iot-hub/reference-iot-hub-extension) warns that the extension depends on the deprecated Azure Account extension and will be retired in a future update. Before using VS Code extensions for production deployments, check current Microsoft guidance; for production, prefer supported Azure CLI or Azure portal workflows for IoT Hub and device management, and `iotedgedev` or other supported automation for IoT Edge module development and deployment where appropriate.

> [!IMPORTANT]
> This lab requires the supported Azure IoT Edge runtime: IoT Edge 1.5 LTS in the current Microsoft IoT Edge [supported releases](/azure/iot-edge/support#releases) and [version history](/azure/iot-edge/version-history#version-history) guidance, or a later supported release if official guidance has superseded 1.5 when you run the lab. IoT Edge 1.4 LTS reached end of life on November 12, 2024, so don't use 1.4 LTS for this lab.

## Solution components

The solution runs on Azure IoT Edge and consists of custom modules, device hardware, and Azure services which work in unison.

- The **Camera Capture Module** scans items using a camera, calls the Image Classification Module to identify each item, calls Azure Speech text to speech to synthesize the item label, and plays the audio through the attached speaker.
- The **Image Classification Module** identifies the item locally on the IoT Edge device. The module uses a provided machine learning model that was created in and exported from Azure AI Custom Vision before the exercise; you don't create, train, or export that model in this module.
- A **USB Camera** captures images of items to be purchased.
- A **speaker** plays the synthesized item name generated when the Camera Capture Module calls Azure Speech text to speech.
- **Azure IoT Hub** (free tier) manages the Azure IoT Edge devices used to implement the solution.
- **Azure Speech text to speech** generates natural speech for the item label when called by the Camera Capture Module.
- **Azure AI Custom Vision** was used to create and export the provided fruit classification model. If existing Azure Custom Vision customers want to replace it after the exercise, they must create, train, and export their own model; those steps aren't part of this module. For an IoT Edge-exportable fruit classifier, create the replacement project as **Classification** with **Multiclass (single tag per image)** classification, choose **General (compact)**, and select the **Basic platforms** export capability. Don't choose regular non-compact domains such as **Food** or **General**, which can't be exported for local IoT Edge use. Train the optional replacement with at least 30 images per tag plus extra test images, using images that vary by camera angle, lighting, background, subject size, and type and that meet Custom Vision constraints (`.jpg`, `.png`, `.bmp`, or `.gif`; no greater than 6 MB, or 4 MB for prediction images; preferably at least 256 pixels on the shortest edge). Custom Vision accepts images shorter than 256 pixels on an edge, but automatically scales them up, which can affect image quality and model results. Export from the **Performance** tab for a trained compact-domain iteration. If **Export** is unavailable, the selected iteration doesn't use a compact domain; select a compact-domain iteration from the **Iterations** section of the **Performance** tab, or switch and retrain the project with a compact domain before exporting. Choose **DockerFile** and **Linux** for IoT Edge. See [Build an image classifier with Custom Vision](/azure/iot-edge/tutorial-deploy-custom-vision#build-an-image-classifier-with-custom-vision), [Choose training images](/azure/ai-services/custom-vision-service/getting-started-build-a-classifier#choose-training-images), and [Export your model](/azure/ai-services/custom-vision-service/export-your-model). Azure AI Custom Vision is planned for retirement on September 25, 2028, so new production plans should evaluate [Microsoft's Custom Vision migration options](/azure/ai-services/custom-vision-service/migration-options) or alternatives.
- **Visual Studio Code** is a source-code editor. In this lab, you use Visual Studio Code and the IoT extensions as a lab-only development and deployment workflow for the IoT Edge device. For production, validate current Microsoft extension guidance and use supported CLI, portal, or `iotedgedev` workflows where appropriate.

## Steps to follow

The overall module steps are:

1. Configure IoT Edge device

      a. Create an IoT Hub

      b. Create an edge device in your hub

      c. Install IoT Edge runtime on Linux

      d. Set the connection string to Azure IoT Edge

2. Clone the repository

3. Create a Foundry resource for Speech in Southeast Asia, unless you update the sample code and deployment template to make the Speech region configurable

4. Build and deploy the solution

5. Monitor the solution

After completing the module, your Linux computer will act as an IoT Edge device, and it will be configured to the IoT Hub. You'll have the modules deployed on the edge device. The resulting solution will perform image classification with the prebuilt model at the edge and synthesize speech with Azure Speech for the self-checkout scenario.
