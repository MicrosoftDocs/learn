In this module, you'll build a translator application for an MXChip IoT DevKit by deploying an Azure Function in the cloud. You'll use Visual Studio Code to create and deploy a function. The MXChip device posts audio to the cloud-hosted HTTP-triggered function, which calls Azure AI Speech translation to recognize and transcribe the spoken source language and translate the text into English by default. The function sends the translated text back to the device through IoT Hub cloud-to-device messaging, and the IoT DevKit displays it. Later customization can change the configured source and target languages.

You'll use the following components in the design of the solution: 

- **Azure Functions and serverless:** Serverless computing enables developers to build applications without worrying about application infrastructure. This module uses Azure Functions as event-driven serverless compute: small pieces of code (called "functions") run when specific events trigger them, such as HTTP requests from the IoT DevKit. Azure includes other serverless services, but they're outside the scope of this module.

- **Azure AI Speech:** The Speech service provides speech-to-text, text-to-speech, and speech translation functionality in an Azure subscription. In this module, you'll use Speech translation to recognize and transcribe audio and translate it into target text. The function then sends the translated text to the IoT DevKit through IoT Hub cloud-to-device messaging for display. Speech can also synthesize speech if you add that capability, but speech synthesis isn't part of the base display scenario.  

- **Visual Studio Code**: is a source-code editor. You use Visual Studio Code as a development tool for the IoT device and function code.  

- **Legacy Azure IoT Device Workbench:** was a Visual Studio Code extension for IoT DevKit projects. Treat references to Azure IoT Device Workbench as legacy context and use the current project files and supported tooling called out in the exercises.  

- **C#:**  You'll develop Azure Function by using C# programming language in .NET class libraries.

- **Function app:** is the container that hosts the execution of individual functions. Configure the Function App with secure app settings for the Speech key and region, and with an IoT Hub backend connection string setting named `iotHubConnectionString` that has permission to send cloud-to-device messages, such as a shared access policy with the ServiceConnect permission.

- **Devkit Translator sample:** is a project sample using Azure Functions and Azure AI Speech that is available on [GitHub](https://github.com/Azure-Samples/mxchip-iot-devkit-translator). You'll use this code as a basis and modify it for the scenario outlined above  

- **Device code:** is Arduino Sketch File (.ino file extension) that you can use for controlling an Arduino circuit board.  

The overall module steps are:

Before you provision cloud resources, choose one provisioning path. If an earlier exercise or your own setup already created an IoT Hub and IoT Hub device identity, reuse those resources instead of creating duplicates. The Azure IoT Device Workbench path referenced by the archived sample is legacy; use it only when reproducing the archived workflow, and don't also provision the same IoT Hub/device resources with another tool.

1. Configure IoT DevKit with cloud services

2. Create an Azure AI Speech resource in Azure

3. Build a translator sample using Visual Studio Code

   a. Open “Devkit Translator” sample

   b. Reuse an existing IoT Hub/device identity, or provision Azure IoT Hub, IoT device, and Azure Functions resources once

   c. Configure secure Function App settings for the Speech key and region and for the IoT Hub backend connection setting, `iotHubConnectionString`

   d. Deploy the Azure Function

   e. Configure and compile the code

After completing the module, your device will be configured with IoT Hub. You'll have the Azure Function app deployed in the cloud. You'll also implement the device code on the IoT DevKit. The device code will post audio to the cloud-hosted HTTP-triggered Azure Function, and the function code will execute in Azure's serverless environment. The function sends translated text back through IoT Hub cloud-to-device messaging for display on the IoT DevKit. The resulting solution will perform speech translation using Azure AI Speech for the digital signage scenario.
