The NVIDIA DeepStream SDK requires some prerequisite software.  We'll walk through the installation of these dependencies and explain their roles.

1. Install the `build-essential` meta-package that will provide tooling to compile C and C++ applications from source. We'll also install a few helper programs that are required to compile certain sources that will be referenced after this step. To start, run these commands on the host terminal:

    ```bash
    sudo apt install \
    build-essential \
    pkg-config \
    libglvnd-dev
    ```

1. Install extra packages that might be referenced at runtime when a DeepStream application is run. Notice that multiple `gstreamer`-based plug-ins are included. They're needed because NVIDIA DeepStream uses the [GStreamer](https://gstreamer.freedesktop.org/) library for media handling and graph composition in DeepStream applications. Use the following commands to install these requirements on the host terminal:

    ```bash
    sudo apt install \
    libssl1.0.0 \
    libgstreamer1.0-0 \
    gstreamer1.0-tools \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    libgstreamer1.0-dev \
    libgstrtspserver-1.0-0 \
    libjansson4 
    ```

1. Install TensorRT 8.0.1.6 from NVIDIA. [TensorRT](https://developer.nvidia.com/tensorrt) is an SDK that provides high-performance implementation of deep-learning inference algorithms via hardware acceleration. It includes various optimizations to deliver low latency and high throughput in applications that use deep learning. To install it, you need an NVIDIA Developer Program membership. If you don't have one, you'll be prompted to create one when you complete the following the steps. This free membership allows you to access the necessary installation files.  

    >[!NOTE]
    >
    >You'll need to have a browser on your host machine to complete this process.
    >  
    >If you don't have one, you can easily install the Firefox browser on your host machine by using this command:
    >`sudo apt install firefox`

    1. Open a browser on the host machine and go to the [NVIDIA TensorRT 8.x Download repository](https://developer.nvidia.com/nvidia-tensorrt-8x-download).

    1. Select **TensorRT 8,0 GA Update 1**. Install the **TensorRT 8.0 GA Update 1 for Linux and CUDA 11.3, CUDA 11.2, CUDA 11.1, CUDA 11.0**.

    1. The installation package should download to your local user's Downloads folder. Go to the download location and install the package by using these commands:

       ```bash
       cd ~/Downloads
       sudo dpkg -i <name of downloaded package>
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

1. Install [NVIDIA cuDNN](https://developer.nvidia.com/cudnn). This package provides a GPU-accelerated library of primitives for use in [deep neural networks](https://developer.nvidia.com/deep-learning).

    1. Open a browser on the host machine. Go to the [NVIDIA cuDNN Download repository](https://developer.nvidia.com/rdp/cudnn-download).

    1. Install both the runtime package and the development package. Select **Download cuDNN v8.2.2 (July 6th, 2021), for CUDA 11.4**. Install **cuDNN Runtime Library for Ubuntu18.04 x86_64 (Deb)** and **cuDNN Developer Library for Ubuntu18.04 x86_64 (Deb)**.

    1. These packages should download to your local user's Downloads folder.  Go to the download location and install *both* packages by using these commands:

    ```bash
    cd ~/Downloads
    sudo dpkg -i <name of downloaded package>
    ```

1. Install the DeepStream SDK. The SDK includes all the libraries, development sources, and samples to get you started with building custom IVA pipelines.

    1. Open a browser on the host machine. Go to the [NVIDIA DeepStream SDK 6.0 - Downloads page](https://developer.nvidia.com/deepstream-sdk-6.0-early-access).

    1. Select the **DeepStream on x86 Core - Debian** package. It should download to your local user's Downloads folder. Go to the download location and install the package by using these commands:

    ```bash
    cd ~/Downloads
    sudo dpkg -i <name of downloaded package>
    ```

You're now ready to start exploring how to build Intelligent Video Applications by using the NVIDIA DeepStream SDK. We'll examine and run a sample application.
