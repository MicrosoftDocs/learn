Now that you've run a DeepStream sample application, you can modify the samples to get different behavior.

1. Let's start by viewing the structure of the sample configuration in a text editor. We'll make a copy of the sample configuration used in the previous section and look at some settings we can change. Run these commands:

    ```
    cd /opt/nvidia/deepstream/deepstream-6.0/samples/configs/deepstream-app
    sudo cp source4_1080p_dec_infer-resnet_tracker_sgie_tiled_display_int8.txt source4_1080p_dec_infer-resnet_tracker_sgie_tiled_display_int8_modified.txt
    sudo vi source4_1080p_dec_infer-resnet_tracker_sgie_tiled_display_int8_modified.txt
    ```

    >[!NOTE]
    >
    > Here are some tips for using vi when you edit the *source4_1080p_dec_infer-resnet_tracker_sgie_tiled_display_int8_modified.txt* file:
    >
    >- Select the **i** key to put the editor into Insert mode. Then you'll be able to make changes.
    >- Select **Esc** to go exit Insert mode and return to Normal mode.
    >- To save and quit, enter **:x**, and then select **Enter**.
    >- Save the file, enter **:w**, and then select **Enter**.
    >- To close vi, enter **:quit**, and then select **Enter**.

2. Note the various configuration sections and how they contribute to the overall application. These sections are denoted with brackets (`[]`). For example, `[application]`, `[tiled-display]`, `[source0`], and `[sink0]`. These sections are explained in detail in the [Configuration Groups section of the DeepStream SDK documentation](https://docs.nvidia.com/metropolis/deepstream/dev-guide/text/DS_ref_app_deepstream.html#configuration-groups).

    For example, to change the input to use an RTSP video stream instead of a local video file, change `[tiled-display]` and `[source0]`:

    ```
    [tiled-display]
    enable=1
    rows=2
    columns=2
    width=1280
    height=720
    gpu-id=0
    #(0): nvbuf-mem-default - Default memory allocated, specific to particular platform
    #(1): nvbuf-mem-cuda-pinned - Allocate Pinned/Host cuda memory, applicable for Tesla
    #(2): nvbuf-mem-cuda-device - Allocate Device cuda memory, applicable for Tesla
    #(3): nvbuf-mem-cuda-unified - Allocate Unified cuda memory, applicable for Tesla
    #(4): nvbuf-mem-surface-array - Allocate Surface Array memory, applicable for Jetson
    nvbuf-memory-type=0
    
    [source0]
    enable=1
    #Type - 1=CameraV4L2 2=URI 3=MultiURI 4=RTSP
    type=3
    uri=file://../../streams/sample_1080p_h264.mp4
    num-sources=4
    #drop-frame-interval=2
    gpu-id=0
    # (0): memtype_device   - Memory type Device
    # (1): memtype_pinned   - Memory type Host Pinned
    # (2): memtype_unified  - Memory type Unified
    cudadec-memtype=0
    ```
   Then make the following changes. (Note the changes to the `rows`, `columns`, `type`, `uri`, and `num-sources` fields.)

    ```
    [tiled-display]
    enable=1
    rows=1
    columns=1
    width=1280
    height=720
    gpu-id=0
    #(0): nvbuf-mem-default - Default memory allocated, specific to particular platform
    #(1): nvbuf-mem-cuda-pinned - Allocate Pinned/Host cuda memory, applicable for Tesla
    #(2): nvbuf-mem-cuda-device - Allocate Device cuda memory, applicable for Tesla
    #(3): nvbuf-mem-cuda-unified - Allocate Unified cuda memory, applicable for Tesla
    #(4): nvbuf-mem-surface-array - Allocate Surface Array memory, applicable for Jetson
    nvbuf-memory-type=0
    
    [source0]
    enable=1
    #Type - 1=CameraV4L2 2=URI 3=MultiURI 4=RTSP
    type=4
    uri=rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov
    num-sources=1
    #drop-frame-interval=2
    gpu-id=0
    # (0): memtype_device   - Memory type Device
    # (1): memtype_pinned   - Memory type Host Pinned
    # (2): memtype_unified  - Memory type Unified
    cudadec-memtype=0
    
    ```

3. Run the changed configuration by using these commands:

    ```Bash
    cd /opt/nvidia/deepstream/deepstream-6.0/samples/configs/deepstream-app
    deepstream-app -c source4_1080p_dec_infer-resnet_tracker_sgie_tiled_display_int8_modified.txt
    ```

### Try this

Look at the various sample configurations included in the DeepStream SDK. How might you change these samples to create a smart home security system? Assume you have multiple RTSP cameras that serve feeds over unique RTSP endpoints. Could you create a DeepStream application that uses those live video streams as input and apply inference to detect people and vehicles?

### Next steps

To finish this module and earn your trophy, complete a final knowledge check.
