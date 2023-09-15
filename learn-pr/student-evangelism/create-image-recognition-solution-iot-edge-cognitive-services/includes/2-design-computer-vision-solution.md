In this module, you'll build an image recognition solution with an IoT Edge device capable of communicating via audio. This solution will use three Azure services, each with free tier services.
- [Azure IoT Hub](https://azure.microsoft.com/services/iot-hub/)
- [Azure Custom Vision](https://azure.microsoft.com/services/cognitive-services/custom-vision-service/)
- [Azure Speech Services](https://azure.microsoft.com/services/cognitive-services/speech-services/)

You'll configure IoT Edge runtime for your Linux computer to act as an IoT Edge device. You'll use Visual Studio Code to deploy your solution at the edge.

## Solution components 

The solution runs on Azure IoT Edge and consists of several services which work in unison. 

- The **Camera Capture Module**  scans items using a camera.
- The **Image Classification Module** identifies the item.  The Image Classification Module comprises of a machine learning model that has been trained with images of fruit which classifies the scanned items. 
- The **Text to Speech Module**  converts the item label to speech. After this, scanned item's name is played on the speaker. The **Text to Speech Module** converts the scanned item's name to audio  speech using Azure Speech Services. 
- A **USB Camera** captures images of items to be purchases.
- A **speaker** is used for playback of the item recognized from the text. 
- **Azure IoT Hub** (free tier) manages the Azure IoT Edge devices used to implement the solution.
- **Azure Speech Services** (free tier) generates natural speech informing the shopper about the scanned item.
- **Azure Custom Vision service** is used to build the fruit model used for image classification.
- **Visual Studio Code** is a source-code editor. You use Visual Studio Code as a development tool for the IoT device.

## Steps to follow

The overall module steps are:

1. Configure IoT Edge device

      a. Create an IoT Hub

      b. Create an edge device in your hub

      c. Install IoT Edge runtime on Linux

      d. Set the connection string to Azure IoT Edge

2. Clone the repository

3. Create Azure Speech Service

4. Build and deploy the solution

5. Monitor the solution

After completing the module, your Linux computer will act as an IoT Edge device, and it will be configured to the IoT Hub. You'll have the modules deployed on the edge device. The resulting solution will perform image classification using Azure AI services for the self-checkout scenario.
