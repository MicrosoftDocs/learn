In this unit, we'll explain how to configure and upload the device firmware to the IoT DevKit. After the cloud-hosted function is deployed in the exercise, the firmware uses the Function URL to post recorded audio to the HTTP-triggered Function. The IoT Hub device connection string authenticates the DevKit to IoT Hub so it can receive cloud-to-device (C2D) translated-result messages and perform other IoT Hub operations. Before uploading the device code, you'll need to configure the IoT Hub device connection string for the IoT DevKit.

Since you've registered the device in IoT Hub, the legacy Visual Studio Code workflow retrieves the connection string automatically. It saves the string locally in your development environment and sends it to the device.

The components used in this unit are:

**Device connection string:** used by the IoT DevKit to authenticate and connect to IoT Hub, send device-to-cloud messages, receive cloud-to-device (C2D) messages, and respond to direct methods if the device firmware implements them. In this sample, the translated result is delivered back to the DevKit as a C2D message for display.

**Device Code:** The device code is in the **Device** folder in the project sample. The folder includes the **DevKitTranslator.ino** Arduino sketch and supporting configuration files such as **azure_config.h**, which you'll edit later with the cloud-hosted Function URL. Arduino code has two functions called setup and loop. The setup function for this project is called once when the device starts up. It initializes the device, connects to WiFi, and connects to the IoT Hub. After that, the loop function is called repeatedly to do whatever your solution needs. The loop function has a switch-case structure for this project. It includes the following functions described in the code file.

- DoIdle()

- DoRecording()

- DoRecorded()

- DoWavReady()

- DoUploader()

- DoSelectLanguage() 

Steps we follow are:

1. Configure connection string to the IoT Devkit
2. Upload the code to the IoT Devkit
3. Test the project

At the end of the unit, your device code will be compiled and uploaded to the IoT DevKit. You'll have a working translation app with firmware running on the device and a cloud-hosted Function app in Azure. The device records your voice and sends an HTTP request to the Function URL. The Function app calls Azure AI Speech to translate the audio and sends the translated text back to the device as an IoT Hub cloud-to-device (C2D) message for display. IoT Hub provides device identity and connection, and carries the translated results as C2D messages; IoT Hub doesn't invoke Azure AI Speech.
