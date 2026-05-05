In this unit, we'll start by opening a legacy sample project called "**Devkit Translator**” in Visual Studio Code. We’ll provision Azure services to create a cloud-hosted Azure Function app, then deploy the function app to Azure by using the legacy Azure IoT Device Workbench sample workflow.

>[!IMPORTANT]
>The Azure IoT Device Workbench-based sample path is legacy/archived and unsupported for new development. The Workbench commands in this module are retained as legacy sample commands. For current projects, deploy the cloud-hosted Function app with the Azure Functions extension for Visual Studio Code or Azure Functions Core Tools, and manage IoT Hub/devices with Azure CLI plus the Azure IoT extension (`azure-iot`) or Azure IoT Explorer.

 The components in this unit are: 

- **Azure IoT Device Workbench (legacy)**: an archived extension for Visual Studio Code that previously simplified the end-to-end process of IoT DevKit development. It could also install dependency extensions like **Azure Functions** and **Azure IoT Hub Toolkit**.
- **Legacy Azure IoT Device Workbench provisioning command/workflow**: the archived sample workflow command that provisions or selects Azure resources for this sample, including an IoT Hub, an IoT Hub device identity, and a cloud-hosted Azure Function app. It isn't a distinct Azure service and isn't Azure IoT Hub Device Provisioning Service.
- **Devkit Translator**: a translator project sample that is available on GitHub: [https://github.com/Azure-Samples/mxchip-iot-devkit-translator](https://github.com/Azure-Samples/mxchip-iot-devkit-translator). The project contains two main parts - Functions and Device folders. 

- **Functions folder:** has two code files – DevKitTranslatorFunction.cs,  SpeechTranslation.cs.

- **DevKitTranslatorFunction.cs**: a function code file that lives in the Functions folder in the project sample. The function name in the code file is **devkit_translator.** The function passes the HTTP audio stream to the Speech SDK task in **SpeechTranslation.cs**, recognizes/transcribes the source speech, and returns translated text in the target language.

Steps we follow are:

1. Start Visual Studio Code.

2. Open Devkit Translator sample

3. Provision Azure services (IoT Hub, IoT Hub device, and a cloud-hosted Azure Function app)

4. Configure the Azure Function app application settings with the Speech key/region and the backend `iotHubConnectionString` that has ServiceConnect permissions for cloud-to-device (C2D) messaging. In the legacy sample code, set the `deviceName` constant to the IoT Hub device ID (`--device-id`) you created or reused.

5. Deploy Azure function to the cloud

By the end of this unit, your Azure Function app will be deployed to the cloud. The function app will publish a Function URL. The full Function URL includes an access key that is required, by default, to access your function over HTTP. The IoT DevKit calls the cloud-hosted HTTP-triggered Function URL, the Function calls Azure AI Speech, and then the Function sends the translated text to the device by using IoT Hub cloud-to-device (C2D) messaging for display.

>[!WARNING]
>The Function URL copied from **Get Function URL** includes an access key by default. Treat the full URL as a secret, don't commit it or the **azure_config.h** file, and rotate or delete the lab key after the exercise. For production, use stronger authentication such as Azure API Management or App Service Authentication where appropriate.

##   
