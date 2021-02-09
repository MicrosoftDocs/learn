1. Clone this GitHub repository.

   ```
   git clone https://github.com/gloveboxes/Creating-an-image-recognition-solution-with-Azure-IoT-Edge-and-Azure-Cognitive-Services.git
   ```

2. Install the Azure IoT Edge runtime on your Linux desktop or device (eg Raspberry Pi).

   Follow the instructions to [Deploy your first IoT Edge module to a Linux x64 device](https://docs.microsoft.com/azure/iot-edge/quickstart-linux/?WT.mc_id=iot-0000-dglover).

3. Install the following software development tools.

   1. Visual Studio Code
   2. Plus, the following Visual Studio Code Extensions
      - Azure IoT Edge
      - [JSON Tools](https://marketplace.visualstudio.com/items?itemName=eriklynd.json-tools&WT.mc_id=iot-0000-dglover) useful for changing the "Create Options" for a module.
   3. Docker Community Edition on your development machine

4. With Visual Studio Code, open the IoT Edge solution you cloned from GitHub to your developer desktop.

## Build the solution

You need to ensure the image you plan to build matches the target processor architecture specified in the deployment.template.json file.

1. Specify your Docker repository in the module.json file for each module. If you are using a supported Linux Azure IoT Edge Distribution, such as Ubuntu 18.04 as your development machine and you have Azure IoT Edge installed locally then I strongly recommend setting up a local Docker Registry. It will significantly speed up your development, deployment and test cycle.

   To set up a local Docker Registry for prototyping and testing purposes.

```
docker run -d -p 5000:5000 --restart always --name registry registry:2
```

1. If pushing the image to a local Docker repository the specify localhost:5000.

```
"repository": "localhost:5000/camera-capture-opencv"
```

1. Confirm processor architecture you plan to build for. From the Visual Studio Code bottom bar click the currently selected processor architecture, then from the popup select the desired processor architecture.

2. Next, Build and Push the solution to Docker by right mouse clicking the deployment.template.json file and select "**Build and Push IoT Edge Solution**". The first build will be slow as Docker needs to pull the base layers to your local machine. If you are cross compiling to arm32v7 then the first build will be very slow as OpenCV and Python requirements need to be compiled. On a fast Intel i7-8750H processor cross compiling this solution will take approximately 40 minutes.


## Deploy the solution

When the Docker Build and Push process has completed select the Azure IoT Hub device you want to deploy the solution to. Right mouse click the deployment.json file found in the config folder and select the target device from the drop-down list.
