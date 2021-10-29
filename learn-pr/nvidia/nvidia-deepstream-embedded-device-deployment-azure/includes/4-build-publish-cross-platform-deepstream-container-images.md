The DeepStream 6.0 `container-builder` package can build cross-platform container images. You'll need to use this capability to build a container that's compatible with the ARM64 CPU on your target NVIDIA embedded device.

Complete the following steps on an x86-based host machine that has DeepStream 6.0 Graph Composer with Docker installed. The steps assume that you completed the steps described in [Set up and configure an NVIDIA DeepStream development environment](/learn/modules/setup-configure-nvidia-deepstream-development/?azure-portal=true) and [Introduction to NVIDIA DeepStream Graph Composer with Azure](/learn/modules/introduction-nvidia-deepstream-graph-composer-azure/?azure-portal=true).

1. To begin, you must install the `qemu-user-static` and `binfmt-support` packages. The packages are dependencies that are needed for cross-platform support in Docker. To perform this step, run the following commands in a terminal on the host:

    ```bash
    sudo apt install qemu-user-static binfmt-support
    ```

1. When installation is finished, run the following commands on the host to configure cross-platform support in Docker:

    ```bash
    sudo docker run --rm --privileged multiarch/qemu-user-static --reset --persistent yes --credential yes 
    ```

1. Next, you'll create a `container-builder` configuration that produces an ARM64-based container to support the *deepstream-test4* graph. To begin, go to */opt/nvidia/deepstream/deepstream/reference_graphs/deepstream-test4* and create a new file in this directory:

    ```bash
    cd /opt/nvidia/deepstream/deepstream/reference_graphs/deepstream-test4
    sudo vi ds_test4_container_builder_jetson.yaml
    ```

    Then, paste the following configuration and save the *ds_test4_container_builder_jetson.yaml* file:

    ```bash
    %YAML 1.2
    ################################################################################
    # Copyright (c) 2021, NVIDIA CORPORATION. All rights reserved.
    #
    # NVIDIA Corporation and its licensors retain all intellectual property
    # and proprietary rights in and to this software, related documentation
    # and any modifications thereto. Any use, reproduction, disclosure or
    # distribution of this software and related documentation without an express
    # license agreement from NVIDIA Corporation is strictly prohibited.
    #
    ################################################################################
    ---
    # Final stage
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
    
    # Set up entrypoint
    entrypoint:
    - "gxe"
    - "--manifest"
    - "deepstream-test4_manifest.yaml"
    - "--app"
    - "deepstream-test4.yaml,parameters.yaml"
    ---
    # Container builder config
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
    >
    > Here are some tips for using the vi editor when you edit the *ds_test4_container_builder_jetson.yaml* file:
    >
    >- To enter insert mode, select **i**. Then, you can make changes.
    >- To exit insert mode and return to normal mode, select **Esc**.
    >- To save the file and quit, select **x**, and then select **Enter**.
    >- To save the file, select **w**, and then select **Enter**.
    >- To quit vi, enter **Quit**, and then select **Enter**.

   This specification uses a base image from nvcr.io named nvcr.io/nvdeepstream/deepstream6_ea/deepstream-l4t:6.0-ea-21.06-samples. It copies in the *deepstream-test4.yaml* and *parameters.yaml* files. The image entrypoint starts the *deepstream-test4* graph and overrides it with the values in *parameters.yaml*. For this reason, you must update this file before you actually build the container.

1. Return to the directory of the *deepstream-test4* reference and edit the *parameters.yaml* file:

    ```bash
    cd /opt/nvidia/deepstream/deepstream/reference_graphs/deepstream-test4
    sudo vi parameters.yaml
    ```

    Change the value of `msg-broker-proto-lib` to `/opt/nvidia/deepstream/deepstream/lib/libnvds_azure_edge_proto.so`.

    Also, change the value of `msg-conv-payload-type` to `1`. This parameter controls how the resulting message output is formatted. If you don't change this parameter, the output uses a hard-coded format that's provided in the NVIDIA samples. The format might not represent your object detection classes if you update the model used in `NvDsInferVideo`.

    The final contents of *parameters.yaml* should look like the following example:

    ```Output
    ################################################################################
    # Copyright (c) 2021, NVIDIA CORPORATION. All rights reserved.
    #
    # NVIDIA Corporation and its licensors retain all intellectual property
    # and proprietary rights in and to this software, related documentation
    # and any modifications thereto. Any use, reproduction, disclosure or
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

1. Build the cross-platform image on the host machine by running the following command in a terminal:

    ```bash
    cd /opt/nvidia/deepstream/deepstream/reference_graphs/deepstream-test4
    sudo container_builder -c ds_test4_container_builder_jetson.yaml
    ```

    After the code runs successfully, output that contains the message `Successfully tagged deepstream-test4-jetson:latest` appears.

1. Now, you're ready to publish this image to the container registry you created in the previous module. Run the following code in a terminal on the host to tag the image with a name that follows the format you used earlier. For \<Login Server\>, use the URL of your container registry.

    ```bash
    sudo docker tag deepstream-test4-jetson <Login Server>/deepstream_test4_jetson:v1
    ```

1. With your image now properly tagged, push the image to your container registry in Azure by executing the following code in a terminal on the host. For \<Login Server\>, use the URL of your container registry.

    ```bash
    sudo docker push <Login Server>/deepstream_test4_jetson:v1
    ```

With your cross-platform image now published to the Azure container registry, you're ready to provision your NVIDIA embedded hardware for the IoT Edge runtime to deploy this workload as an IoT Edge module.
