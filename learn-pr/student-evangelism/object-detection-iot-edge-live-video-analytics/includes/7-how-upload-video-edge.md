This unit explains the historical video-upload flow used by the archived Vision on Edge sample. The original sample copied an employee-safety video to an RTSP simulator container on the IoT Edge device so that the rest of the solution could treat the file as a live camera stream.

> [!IMPORTANT]
> The original sample repository's archived and isn't actively maintained. Don't depend on its videos, RTSP simulator, or deployment assets for a current solution. For a supported lab, use media you're authorized to use and a maintained RTSP simulator, camera, or video ingestion component that matches your current architecture.

## Steps to follow

For a supported private lab, you'd complete these steps:

1. Select a video file that you're allowed to use for testing.
2. Copy the video file to the edge device over a secure channel, such as SSH through a private network, Azure Bastion, or a tightly restricted SSH rule.
3. Confirm that the edge device is running a supported streaming component or RTSP simulator.
4. Copy the video into the location expected by that simulator.
5. Use the simulator's internal RTSP URL from other edge modules.

The historical module used an [employee safety video](https://github.com/Azure-Samples/azure-intelligent-edge-patterns/blob/master/factory-ai-vision/EdgeSolution/modules/CVCaptureModule/videos/scenario2-employ-safety.mkv) from the archived sample repository. If that link's unavailable or the file doesn't meet your requirements, use your own test video.

After uploading the video file to a supported RTSP simulator, the stream URL typically has a format like `rtsp://<simulator-host>:554/media/<video-name>`. In the archived sample, the container name was `rtspsim`, so the internal edge-module URL was `rtsp://rtspsim:554/media/<video-name>`.
