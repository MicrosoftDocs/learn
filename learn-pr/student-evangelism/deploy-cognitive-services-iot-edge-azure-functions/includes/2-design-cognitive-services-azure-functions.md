In this module, we’ll build a translator application by deploying Azure Functions to the IoT Devkit. The Azure Function that you create in this module uses Cognitive Speech Services. The function receives voice data and interactively translates speech from a foreign language into the target language and displays the result on the screen of the IoT Devkit. 

You will use the following components in the design of the solution: 

- **Azure Functions and serverless:** Serverless computing enables developers to build applications without worrying about application infrastructure. Serverless computing has three parts:

   - Serverless Kubernetes
   - Serverless Functions
   
   - Serverless Application Environments
   
   In this module, we use Azure functions only. Azure Functions enable you to develop serverless applications. You run small pieces of code (called "functions").  Specific events trigger the function to run the code.
- **Cognitive Speech Service:** The Speech service is an API that provides you speech-to-text, text-to-speech, and speech translation functionality into a single Azure subscription. In this module, you will use the Cognitive Speech service to integrate real-time speech translation.  

- **Visual Studio Code**: is a source-code editor. You use Visual Studio Code as a development tool for the IoT Devkit.  

- **Azure IoT Device Workbench:** is a Visual Studio Code extension. You use the Azure IoT Device Workbench to open a project, create and deploy Azure functions, and debug IoT Devkit.  

- **C#:**  You will develop Azure Function by using C# programming language in .NET class libraries.

- **Function app:** is the container that hosts the execution of individual functions.

- **Devkit Translator:** is a project sample using Azure Functions and Cognitive Services that are available on GitHub: [https://github.com/Azure-Samples/mxchip-iot-devkit-translator](about:blank). You will use this code as a basis and modify it for the scenario outlined above  

- **Device code:** is Arduino Sketch File (.ino file extension) that you can use for controlling an Arduino circuit board.  

The overall module steps are :

1.  Configure IoT Devkit to the cloud
2.  Create a Cognitive Speech Service in Azure
3.  Build a translator sample using VS Code
   - Open “Devkit Translator” sample
   - Provision Azure IoT Hub and IoT device and Azure Functions
   - Configure Speech API key in the Azure function
   - Deploy Azure function
   - Configure and compile the code 

After completing the module, your device will be configured to the IoT Hub. You will have the Azure function app deployed in the cloud. You will also implement the device code in the IoT Devkit. The device code will use the Azure function and will execute the code in a serverless environment. The resulting solution will perform speech translation using Cognitive Services for the Digital signage scenario.