In the first exercise, you have already installed the Azure IoT Edge runtime on your Linux computer. Make sure you have installed the following software development tools.

- [Docker Community Edition](https://docs.docker.com/install/) on your Linux computer
- [Visual Studio Code](https://code.visualstudio.com/?WT.mc_id=iot-0000-dglover) is a code editor and is one of the most popular Open Source projects on GitHub. It runs on Linux, macOS, and Windows.
- The following Visual Studio Code Extensions
   - [Azure Account](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account)
   - [Azure IoT Tools](https://marketplace.visualstudio.com/items?itemName=vsciot-vscode.azure-iot-toolkit)
   - [Docker extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) for Visual Studio Code
   - [JSON Tools](https://marketplace.visualstudio.com/items?itemName=eriklynd.json-tools) useful for changing the "Create Options" for a module.

## Create Azure Cognitive Services

In this module, you use Azure Custom Vision and Azure Speech services.

1. [Azure Custom Vision](https://azure.microsoft.com/services/cognitive-services/custom-vision-service/) service is used to create a machine learning model with fruit images provided. Then the model is exported and added to the project folder.

2. [Azure Speech Services](https://azure.microsoft.com/services/cognitive-services/speech-to-text/) is used to generate speech from label of the item. You will add the speech key in deployment template. To create Azure Speech Services:
    1. Go to the Azure portal and search for Cognitive Services.    

    2. Search for speech service and select Microsoft Speech Service.

    3. Select **Create**.
   
        ![[The illustration shows Azure Speech service.](../media/create-speech.png)](../media/create-speech.png#lightbox)

   4. Create cognitive services and enter the information.

      ![[The illustration shows how to create a speech service.](../media/enter-details.png)](../media/enter-details.png#lightbox)

## Install the Docker Registry on the Linux computer

Azure IoT Edge relies on Docker images being distributed from a Docker Registry. In production, you would deploy Docker images from a registry such as Azure Container Registry.

When you are developing an Azure IoT Edge module, it is faster to install a local container registry on the device and deploy Docker images from the local registry to Azure IoT Edge.

Open the terminal in your Linux computer and run the following command to set up a local Docker Registry.

```
docker run -d -p 5000:5000 --restart=always --name registry registry:2
```

## Clone the image recognition solution to the Linux computer

1. Clone this GitHub repository.

   ```
   git clone https://github.com/MicrosoftDocs/mslearn-oxford.create-image-recognition-with-azure-iot-edge
   ```

2. Open the solution from the Visual Studio Code menu.

## Update the Azure Speech key

Open the deployment.template.json file and update the **azureSpeechServicesKey** with the key you copied from the Azure Speech service.

   ![[The illustration shows how to update speech service key.](../media/speech-services-key.png)](../media/speech-services-key.png#lightbox)

## Confirm the processor

You need to ensure the image you plan to build matches the target processor architecture. In our case, we are going to build for **amd64**. Confirm processor architecture. 

From the Visual Studio Code, bottom bar click the currently selected processor architecture, then from the popup select **amd64**.

   ![[The illustration shows how to select a processor.](../media/select-processor.png)](../media/select-processor.png#lightbox)

## Build the solution

Build and Push the solution to Docker by right mouse clicking the deployment.template.json file and select "**Build and Push IoT Edge Solution**". The first build will be slow as Docker needs to pull the base layers to your local machine. 

If you are cross-compiling to amd64 then the first build will be very slow as OpenCV and Python requirements need to be compiled. On a fast Intel i7-8750H processor, cross-compiling this solution will take approximately 40 minutes.

   ![[The illustration shows how to build and push the solution.](../media/build-push-solution.png)](../media/build-push-solution.png#lightbox)

## Deploy the solution

When the Docker Build and Push process has been completed, select the Azure IoT Hub device you want to deploy the solution to. Right mouse click the deployment.json file found in the config folder and select the target device from the drop-down list.

   ![[The illustration shows how to create a deployment.](../media/create-deployment.png)](../media/create-deployment.png#lightbox)