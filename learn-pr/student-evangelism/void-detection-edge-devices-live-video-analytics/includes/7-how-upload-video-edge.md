In this unit, you'll learn how to upload sample video file to your edge device and copy the  video file to RTSP simulator instead of real camera. RTSP simulator is deployed to your edge device in a docker container, and it helps you stream the video file.

## Steps to follow

1. Use a [bottle shelf video](https://github.com/Azure-Samples/azure-intelligent-edge-patterns/blob/master/factory-ai-vision/EdgeSolution/modules/CVCaptureModule/videos/scenario4-empty-shelf-alert.mkv) file to simulate a live stream.
2. Download the video file from GitHub
3. Upload the video file to the edge device
4. Copy the video file to RTSP simulator
5. Get the RTSP URL

After uploading the video file to RTSP simulator, RTSP simulator host the video in the specific location in its container, then you can access the RTSP stream of your video through RTSP URL that is in the format of  ***rtsp://rtspsim:554/media/<video_name>***.