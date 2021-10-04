The DeepStream 6.0 `container-builder` is capable of building cross-platform container images.  We will need to use this capability in order to build a container that is compatible with the ARM64 CPU present on our target NVIDIA Embedded device.

The following steps are to be completed on an X86 based host machine that has the DeepStream 6.0 Graph Composer / Docker installed and assumes that you have completed the steps described in the previous modules `Setup and Configuration of an NVIDIA DeepStream Development Environment` and `Introduction to DeepStream 6.0 Graph Composer with Microsoft Azure`.

1. To begin, we must install dependencies needed to enable cross-platform support in Docker by installing the `qemu-user-static` and `binfmt-support` packages.  To do this, execute the following commands in a terminal on the host:

    ```Bash
    sudo apt install qemu-user-static binfmt-support
    ```

1. Once installation has completed, execute the following commands on the host to configure cross-platform support in Docker:

    ```Bash
    sudo docker run --rm --privileged multiarch/qemu-user-static --reset --persistent yes --credential yes 
    ```

1. Next, we will create a `container-builder` configuration that will produce an ARM64 based container to support the deepstream-test4 graph.  To begin, navigate to `/opt/nvidia/deepstream/deepstream/reference_graphs/deepstream-test4` and create a new file with in this directory with:

    ```Bash
    cd /opt/nvidia/deepstream/deepstream/reference_graphs/deepstream-test4
    sudo vi ds_test4_container_builder_jetson.yaml
    ```

    Then paste in the configuration specified below and save the `ds_test4_container_builder_jetson.yaml` file:

    ```
    %YAML 1.2
    ################################################################################
    # Copyright (c) 2021, NVIDIA CORPORATION. All rights reserved.
    #
    # NVIDIA Corporation and its licensors retain all intellectual property
    # and proprietary rights in and to this software, related documentation
    # and any modifications thereto.  Any use, reproduction, disclosure or
    # distribution of this software and related documentation without an express
    # license agreement from NVIDIA Corporation is strictly prohibited.
    #
    ################################################################################
    ---
    # final stage
    unique_stage: final_image
    base_image: "nvcr.io/nvdeepstream/deepstream6_ea/deepstream-l4t:6.0-ea-21.06-samples"
    stage_model: clean_stage
    apt_deps:
    - curl
    - ca-certificates
    - unzip
    local_copy_files:
    - src: "/opt/nvidia/graph-composer/graph-composer-0.5.0_arm64.deb"
      dst: "/tmp/"
    - src: "parameters.yaml"
      dst: "/workspace/test4/" # ends with '/' is folder
    
    custom_runs:
     - "dpkg -i /tmp/graph-composer-0.5.0_arm64.deb && rm -rf /tmp/graph-composer-0.5.0_arm64.deb"
    
    work_folder: /workspace/test4/
    
    env_list:
      PATH: "/opt/nvidia/graph-composer/:$PATH"
      LD_LIBRARY_PATH: "/opt/nvidia/graph-composer/:$LD_LIBRARY_PATH"
      DISPLAY: ":0"
    
    # Setup entrypoint
    entrypoint:
    - "gxe"
    - "--manifest"
    - "deepstream-test4_manifest.yaml"
    - "--app"
    - "deepstream-test4.yaml,parameters.yaml"
    ---
    # Container Builder Config
    container_builder: main # required
    graph:
      graph_files: [ deepstream-test4.yaml ]
      graph_dst: /workspace/test4/
      manifest_dst: /workspace/test4/deepstream-test4_manifest.yaml
      ext_install_root: /workspace/test4/
      registry_arch: aarch64
      registry_distro: ubuntu_18.04
      registry_cuda: cuda-10.2
    docker_build:
        image_name: deepstream-test4-jetson
    ```

    >[!NOTE]
    > Here are some tips for using **vi** when editing the `ds_test4_container_builder_jetson.yaml` file: 
    >- Press the `i` key to put the editor into Insert mode, then you will be able to make changes.
    >- Press `Esc` to go stop Insert mode and return to Normal mode.
    >- To Save and Quit, type `:x`, and press `Enter`.
    >- Save the file, type `:w`, and press `Enter`.
    >- To quit vi, type `:quit` and press `Enter`.

    Take note that this specification uses a base image from nvcr.io named `nvcr.io/nvdeepstream/deepstream6_ea/deepstream-l4t:6.0-ea-21.06-samples`, and copies in the `deepstream-test4.yaml` and `parameters.yaml` files. The image entrypoint starts the deepstream-test4 graph and overrides it with the values present in `parameters.yaml`.  For this reason, we also need to update this file before we actually build the container.

1. Navigate back to the directory of the deepstream-test4 reference and edit the `parameters.yaml` with:

    ```
    cd /opt/nvidia/deepstream/deepstream/reference_graphs/deepstream-test4
    sudo vi parameters.yaml
    ```

    Modify the value of `msg-broker-proto-lib` to `/opt/nvidia/deepstream/deepstream/lib/libnvds_azure_edge_proto.so`

    Also, modify the value of `msg-conv-payload-type` to `1`.  This parameter will control how the resulting message output is formatted, if you do not change this the output will use a hard-coded format provided in the NVIDIA samples that may not represent your object detection classes should you update the model used in `NvDsInferVideo`.  
    
    The final contents of `parameters.yaml` should look like the following:

    ```
    ################################################################################
    # Copyright (c) 2021, NVIDIA CORPORATION. All rights reserved.
    #
    # NVIDIA Corporation and its licensors retain all intellectual property
    # and proprietary rights in and to this software, related documentation
    # and any modifications thereto.  Any use, reproduction, disclosure or
    # distribution of this software and related documentation without an express
    # license agreement from NVIDIA Corporation is strictly prohibited.
    #
    ################################################################################
    
    components:
    - name: nv_ds_single_src_input39..3c18
      parameters:
        uri: file:///opt/nvidia/deepstream/deepstream/samples/streams/sample_1080p_h264.mp4
    name: NvDsSingleSrcInput..1b00
    ---
    components:
    - name: nv_ds_stream_mux42..36d8
      parameters:
        batch-size: 1
        height: 1080
        width: 1920
    name: NvDsStreamMux..16d8
    ---
    components:
    - name: nv_ds_msg_conv_broker61..4748
      parameters:
        msg-broker-conn-str: 127.0.0.1;9092;test-topic
        msg-broker-proto-lib: /opt/nvidia/deepstream/deepstream/lib/libnvds_azure_edge_proto.so
        msg-conv-config: /opt/nvidia/deepstream/deepstream/sources/apps/sample_apps/deepstream-test4/dstest4_msgconv_config.txt
        msg-conv-payload-type: 1
        topic: test-topic
        name: NvDsMsgConvBroker..bb00
    ```

1. You can now build the cross-platform image on the host machine by running the following in a terminal:

    ```
    cd /opt/nvidia/deepstream/deepstream/reference_graphs/deepstream-test4
    sudo container_builder -c ds_test4_container_builder_jetson.yaml
    ```

    Upon successful completion, you should see output that contains the message `Successfully tagged deepstream-test4-jetson:latest`

1. We are now ready to publish this image into the Azure Container Registry that was created in the previous module.  

    First, we will tag the image to have a name that follows our previous format by executing the following in a terminal on the host (where `<Login Server>` is the url of your Azure Container Registry):

    ```
    sudo docker tag deepstream-test4-jetson <Login Server>/deepstream_test4_jetson:v1
    ```

1. With our image now properly tagged, we now push the image into our Azure Container registry by executing the following in a terminal on the host (where `<Login Server>` is the url of your Azure Container Registry):

    ```
    sudo docker push <Login Server>/deepstream_test4_jetson:v1
    ```

With our cross-platform image now published into the Azure Container Registry, we are now ready to provision our NVIDIA Embedded hardware for the IoT Edge Runtime to prepare for deployment of this workload as an IoT Edge module.