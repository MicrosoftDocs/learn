The NVIDIA DeepStream SDK requires some prerequisite software.  We'll walk through the installation of these dependencies and explain their roles.

1. Install the dependency packages that will provide tools to compile C and C++ applications from source. Notice that multiple `gstreamer`-based plug-ins are included. They're needed because NVIDIA DeepStream uses the [GStreamer](https://gstreamer.freedesktop.org/) library for media handling and graph composition in DeepStream applications. Use the following commands to install these requirements on the host terminal:

    ```bash
    sudo apt install \
    libssl1.0.0 \
    libgstreamer1.0-0 \
    gstreamer1.0-tools \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    libgstrtspserver-1.0-0 \
    libjansson4 \
    gcc \
    make \
    git \
    python3
    ```

1. Install the NVIDIA driver version 470.63.01 from the NVIDIA Unix drivers page at: https://www.nvidia.com/Download/driverResults.aspx/179599/en-us

    1. The installation package should download to your local user's *Downloads* folder. Go to the download location and install the package by using these commands:
    ```bash
    chmod 755 NVIDIA-Linux-x86_64-470.63.01.run
    sudo ./NVIDIA-Linux-x86_64-470.63.01.run 
    ```

1. Install CUDA Toolkit 11.4 by adding NVIDIA's Ubuntu-based CUDA repo into your APT sources. The CUDA Toolkit allows your development environment to use GPU acceleration on devices where compatible hardware is present. The toolkit includes special compiler tools and libraries that allow you to build and run GPU-accelerated applications. It also automatically installs the compatible drivers to allow running GPU-accelerated applications on the host system.  

    To install CUDA Toolkit 11.4, run these commands on the host terminal:

    ```bash
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
    sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
    wget https://developer.download.nvidia.com/compute/cuda/11.4.1/local_installers/cuda-repo-ubuntu1804-11-4-local_11.4.1-470.57.02-1_amd64.deb
    sudo dpkg -i cuda-repo-ubuntu1804-11-4-local_11.4.1-470.57.02-1_amd64.deb
    sudo apt-key add /var/cuda-repo-ubuntu1804-11-4-local/7fa2af80.pub
    sudo apt-get update
    sudo apt-get -y install cuda
    ```

1. Install TensorRT 8.0.1 GA from NVIDIA. [TensorRT](https://developer.nvidia.com/tensorrt) is an SDK that provides high-performance implementation of deep-learning inference algorithms via hardware acceleration. It includes various optimizations to deliver low latency and high throughput in applications that use deep learning. To install it, you need an NVIDIA Developer Program membership. If you don't have one, you'll be prompted to create one when you complete the following the steps. This free membership allows you to access the necessary installation files.  

    >[!NOTE]
    >
    >You'll need to have a browser on your host machine to complete this process.
    >  
    >If you don't have one, you can easily install the Firefox browser on your host machine by using this command:
    >`sudo apt install firefox`

    1. Add the CUDA repository to your apt sources by running the following commands:
       
       ```bash
       echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda-repo.list
       wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
       sudo apt-key add 7fa2af80.pub
       sudo apt-get update
       ```

    1. Open a browser on the host machine and download the [TensorRT 8.0.1 GA for Ubuntu 18.04 and CUDA 11.3 DEB local repo package](https://developer.nvidia.com/compute/machine-learning/tensorrt/secure/8.0.1/local_repos/nv-tensorrt-repo-ubuntu1804-cuda11.3-trt8.0.1.6-ga-20210626_1-1_amd64.deb).

    1. The installation package should download to your local user's *Downloads* folder. Go to the download location and install the package by using these commands:

       ```bash
       cd ~/Downloads
       sudo dpkg -i nv-tensorrt-repo-ubuntu1804-cuda11.3-trt8.0.1.6-ga-20210626_1-1_amd64.deb 
       sudo apt-key add /var/nv-tensorrt-repo-ubuntu1804-cuda11.3-trt8.0.1.6-ga-20210626/7fa2af80.pub 
       sudo apt-get update 
       sudo apt-get install \
       libnvinfer8=8.0.1-1+cuda11.3 \
       libnvinfer-plugin8=8.0.1-1+cuda11.3 \
       libnvparsers8=8.0.1-1+cuda11.3 \
       libnvonnxparsers8=8.0.1-1+cuda11.3 \
       libnvinfer-bin=8.0.1-1+cuda11.3 \
       libnvinfer-dev=8.0.1-1+cuda11.3 \
       libnvinfer-plugin-dev=8.0.1-1+cuda11.3 \
       libnvparsers-dev=8.0.1-1+cuda11.3 \
       libnvonnxparsers-dev=8.0.1-1+cuda11.3 \
       libnvinfer-samples=8.0.1-1+cuda11.3 \
       libnvinfer-doc=8.0.1-1+cuda11.3
       ```

1. Install librdkafka to enable the Kafka protocol adaptor used by the [DeepStream message broker](https://docs.nvidia.com/metropolis/deepstream/dev-guide/text/DS_plugin_gst-nvmsgbroker.html).  Open a terminal and run the following commands:

    ```bash
    cd ~
    git clone https://github.com/edenhill/librdkafka.git
    cd librdkafka
    git reset --hard 7101c2310341ab3f4675fc565f64f0967e135a6a
    ./configure
    make sudo make install
    sudo mkdir -p /opt/nvidia/deepstream/deepstream-6.0/lib
    sudo cp /usr/local/lib/librdkafka* /opt/nvidia/deepstream/deepstream-6.0/lib
    ```

1. Install the DeepStream SDK. The SDK includes all the libraries, development sources, and samples to get you started with building custom IVA pipelines.

    1. Open a browser on the host machine. Go to the [NVIDIA DeepStream - Version 6.0.0-1 Download](https://developer.nvidia.com/deepstream-6.0_6.0.0-1_amd64deb).

    1. It should download to your local user's *Downloads* folder. Go to the download location and install the package by using these commands:

    ```bash
    cd ~/Downloads
    sudo apt-get install ./deepstream-6.0_6.0.0-1_amd64.deb
    ```

You're now ready to start exploring how to build Intelligent Video Analytics applications by using the NVIDIA DeepStream SDK. We'll examine and run a sample application.
