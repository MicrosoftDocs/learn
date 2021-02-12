This module will deploy a Custom Vision model to a Linux machine running Azure IoT Edge. Custom Vision is an image classifier trained in the cloud with your images. IoT Edge gives you the possibility to run this model with your camera – if necessary, in an offline mode.

The solution runs on Azure IoT Edge and consists of the following components services:

1. The **Camera Capture Module** handles scanned items using a camera. It then calls the Image Classification module to identify the item. A call is then made to the "Text to Speech" module to convert the item label to speech, and the name of the item scanned is played on the attached speaker to the visually impaired person.
2. The **Image Classification Module** runs a TensorFlow machine learning model trained with images of fruit. It handles classifying the scanned items.
3. The **Text to Speech Module** converts the name of the item scanned from text to speech using Azure Speech Services.
4. A USB Camera is used to capture images of items to be bought.
5. A Speaker for text to speech playback.
6. **Azure IoT Hub** (Free tier) is used to manage, deploy, and report Azure IoT Edge devices running the solution.
7. **Azure Speech Services** (free tier) is used to generate very natural speech telling the shopper what they have just scanned.
8. **Azure Custom Vision service** was used to build the fruit model used for image classification.
9. **Visual Studio Code**: is a source-code editor. You use Visual Studio Code as a development tool for the IoT device.

The overall module steps are:

1. Install IoT Edge runtime for Linux desktop
2. Register device to the IoT Hub
   1. Create an IoT Hub
   2. Create a device identity
3. Build and deploy image classification solution on edge device using Cognitive Services
   1.  Clone the GitHub repo which contains the IoT Edge solution
   2.  Build the solution using VS Code
   3. Deploy the solution using VS Code
4. Monitor the solution

When the solution is deployed to the IoT Edge device, the system will tell you what items have been scanned.