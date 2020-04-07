So far, you have verified, compiled, and deployed the code of the function in the cloud using the Azure IoT Workbench extension. In this unit, we'll learn how to implement the device code to the IoT Devkit. Before deploying the device code, you'll need to configure the connection string to the IoT Devkit.  

Since you have registered the device in the IoT Hub, the VS code will retrieve the connection string automatically. It will be saved locally in your development environment, and it will be sent back to the device.

The components used in this unit are:

**Device connection string:** used by devices to send Device to Cloud messages, receive Cloud to Device messages or response direct method. The IoT Devkit can communicate with the cloud by configuring the connection string.

**Device Code:** The device code is in the Device folder in the project sample, and contains a single file called **DevKitTranslator.ino**. This file is an Arduino sketch file for the firmware. Arduino code has two functions called setup and loop. The setup function for this project is called once when the device starts up. It initializes the device, connects to WiFi, connects to the IoT Hub.  After that, the loop function is called repeatedly to do whatever your solution needs. The loop function has a switch-case structure for this project. It includes the following functions described in the code file.

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

At the end of the unit, your device code will be compiled and uploaded to the IoT device. You will now have a working translation app on your IoT device hosted in Azure. The device records your voice. Whenever the IoT Hub receives a message from the device, it uses Cognitive Service APIs. An HTTP trigger invokes an Azure function when it receives an HTTP request to its function URL. HTTP triggers allow you to obtain data and return data to the caller.