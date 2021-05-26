This module builds a docker container with a pre-trained [YOLOv4 (tiny)](https://github.com//AlexeyAB/darknet) [TensorFlowLite model](https://www.tensorflow.org/lite). The app code is based on the [tensorflow-yolov4-tflite](https://github.com/hunglc007/tensorflow-yolov4-tflite) project. This project uses
TensorFlow v2.3.0.

## Create a container image

You can push/pull Container images with Container Registry using the Docker CLI or the Azure CLI. Azure portal integration allows you to inspect the container images in your container registry visually.

A Dockerfile is a text file that provides the build instructions we use to build and run a Docker image. You'll use **Docker build** command to build the container image with the YOLO model. Upon successful completion, the docker image will be stored on your PC.

## Create an Azure container registry

You'll use the Azure container registry to store and manage a container image. Use **az acr to** create a registry in Azure.

## Push image to container registry

Before pushing a container image to the registry, you need a tag to version an image. You'll use **the docker tag** command to tag the image with container registry information.

To push an image from your local computer to an Azure Container Registry repository, first, use the docker login command and specify the URL of the login server for the registry. The login server URL for a registry in Azure Container Registry has the form ***<registry_name>.azurecr.io***.

Then, use **the docker push** command to push the image to the container registry.

## Deploy to IoT Edge as edge module

After pushing the image to your container registry, your image URI would be in the form of ***<registry_name>.azurecr.io.<image_name : tag_version>***.

You will provide image URI, container registry name, login server, and password details to deploy the container image as an edge module on IoT Edge.

Now you have your own inference module on the edge device, and the prediction endpoint can be accessed through **http://{module
name}:80/score** within your edge device.

## Steps to follow

The overall steps you follow:

1.  Download pre-trained YOLO model

2.  Build the container image with the YOLO model

3.  Create a container registry in Azure

4.  Push docker image to Azure Container Registry

5.  Deploy containerized YOLO model as an IoT Edge module