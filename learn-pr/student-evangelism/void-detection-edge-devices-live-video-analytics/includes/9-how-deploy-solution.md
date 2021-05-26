So far, your edge device is configured to IoT Hub, and your edge modules are deployed and are running at your edge device. To deploy a Video Analytics solution with your images, you'll need to connect the web application that the user interacts with. After connecting the web application, you first need to add a camera to stream out the video file you uploaded to the RTSP simulator. To do that, you need to provide RTSP URL. Then you'll manually capture images and tag objects as gaps. You need to capture at least 15 images to get a good result. Finally, you'll deploy a task by providing your camera and object detail. In the end, the solution deployment will start to detect voids on the shelf, and it will train the model using Custom Vision API. 

## Steps to follow

As a summary, you'll perform the following steps in the web application:

1. Connect to web application
2. Add a camera that will stream the video feed
3. Capture images from the camera
4. Tag objects as a gap
5. Create a solution deployment


