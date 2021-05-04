So far, your edge device is configured to IoT Hub, and your edge modules are deployed and are running at your edge device.

To deploy a Video Analytics solution with your machine learning model, you will need to connect the web module container to your device's IP address and port 8181. The web module is the web application that the user interacts with.

After connecting the web application, you need to add a camera to stream out the video file that you uploaded to the RTSP simulator. To do that, you need to provide RTSP URL. Then you will add your endpoint and labels. Finally, you'll deploy a task by providing your camera, model, and object detail.

As a summary, you'll perform the following steps in the web application:
1. Connect to web application
2. Add a camera that will stream the video feed.
3. Add a model and upload your labels
4. Create a solution deployment

The solution deployment will start to detect the person in the production floor using the YOLO model.
