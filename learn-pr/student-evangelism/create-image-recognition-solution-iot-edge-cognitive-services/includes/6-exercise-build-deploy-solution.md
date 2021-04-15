In the first exercise, you have already installed the Azure IoT Edge runtime on your Linux computer. Make sure you have installed the following software development tools.

- Docker Community Edition on your Linux computer
- Visual Studio Code: Visual Studio Code is a code editor and is one of the most popular Open Source projects on GitHub. It runs on Linux, macOS, and Windows.
- The following Visual Studio Code Extensions
   - Azure Account
   - Azure IoT Tools
   - Python extension for Visual Studio Code
   - Docker for Visual Studio Code
   - JSON Tools useful for changing the "Create Options" for a module.

## Install the Docker Registry on the Linux computer

Azure IoT Edge relies on Docker images being distributed from a Docker Registry. In production, you would deploy Docker images from a registry such as Azure Container Registry.

When you are developing an Azure IoT Edge module, it is faster to install a local container registry on the device and deploy Docker images from the local registry to Azure IoT Edge.

From the terminal, run the following command to set up a local Docker Registry.

```
docker run -d -p 5000:5000 --restart=always --name registry registry:2
```
## Clone the image recognition solution to the Linux computer

1. Clone this GitHub repository.

   ```
   git clone https://github.com/gloveboxes/Creating-an-image-recognition-solution-with-Azure-IoT-Edge-and-Azure-Cognitive-Services.git
   ```

2. Open the solution from the Visual Studio Code menu.

## Update the Azure Speech key

Open the deployment.template.json file and update the BingKey with the key you copied from the Azure Speech service.

## Confirm the processor

You need to ensure the image you plan to build matches the target processor architecture. In our case, we are going to build for **amd64**. Confirm processor architecture. From the Visual Studio Code, bottom bar click the currently selected processor architecture, then from the popup select **amd64**.

## Build the solution

Build and Push the solution to Docker by right mouse clicking the deployment.template.json file and select "**Build and Push IoT Edge Solution**". The first build will be slow as Docker needs to pull the base layers to your local machine. 

If you are cross-compiling to amd64 then the first build will be very slow as OpenCV and Python requirements need to be compiled. On a fast Intel i7-8750H processor, cross-compiling this solution will take approximately 40 minutes.

## Deploy the solution

When the Docker Build and Push process has been completed, select the Azure IoT Hub device you want to deploy the solution to. Right mouse click the deployment.json file found in the config folder and select the target device from the drop-down list.
