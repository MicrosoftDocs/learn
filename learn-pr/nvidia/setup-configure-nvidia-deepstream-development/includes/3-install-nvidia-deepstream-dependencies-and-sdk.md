The NVIDIA DeepStream SDK requires the installation of specific prerequisite software.  We will walk through the installation of these dependencies and explain their role in the process.

1. We will begin by installing the `build-essential` meta-package that will provide tooling to compile C and C++ applications from source.  We will also install a few helper programs that are needed to compile certain sources that will be referenced after this step.  To begin, execute the following commands on the host terminal:

    ```bash
    sudo apt install \
    build-essential \
    pkg-config \
    libglvnd-dev
    ```

1. After we have installed the source compilation helper packages, we will install extra packages that may be referenced at runtime when executing a DeepStream application.  You will notice the inclusion of multiple `gstreamer` based plugins. This is because NVIDIA DeepStream leverages the [gstreamer](https://gstreamer.freedesktop.org/) library for media handling and graph composition in DeepStream applications.  Install these requirements on the host terminal with:

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

1. Next, we will need to install the TensorRT 8.0.1.6 from NVIDIA. [TensorRT](https://developer.nvidia.com/tensorrt) is an SDK that allows for high-performance execution of deep learning inference algorithms by utilizing hardware acceleration. It includes various optimizations to deliver low latency and high throughput in applications that make use of deep learning.  Installation will require that you have an existing NVIDIA Developer Program Membership.  If you do not have one, you will be prompted to create while following the steps below.  This free membership will allow you to access the necessary installation files.  

    >[!NOTE]
    >You will need a browser installed on your host machine in order to complete this process.  
    >If one is not available, you can easily install the firefox browser to your host machine with the following:
    >`sudo apt install firefox`
    
    1. Open a browser on the host machine, and navigate to the [NVIDIA TensorRT 8.x Download repository](https://developer.nvidia.com/nvidia-tensorrt-8x-download) . 

    1. Select `TensorRT 8,0 GA Update 1`, once expanded choose the `TensorRT 8.0 GA Update 1 for Linux and CUDA 11.3, CUDA 11.2, CUDA 11.1, CUDA 11.0`.

    1. The installation package should download into your local user's `Downloads` directory. Navigate to the download location and install the package with:
    
    ```bash
    cd ~/Downloads
    sudo dpkg -i <name of downloaded package>
    ```

1. Next, we will install the `CUDA Toolkit version 11.4` by adding NVIDIA's Ubuntu based CUDA repo into our apt sources.  The CUDA toolkit allows your development environment to take advantage of GPU acceleration on device's where compatible hardware is present.  The toolkit includes special compiler tools and libraries that allow you to build and run GPU accelerated applications. It will also automatically install the compatible drivers to allow for execution of GPU accelerated applications on the host system.  

    To install the `CUDA Toolkit version 11.4`, execute the following commands on the host terminal:

    ```bash
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
    sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
    wget https://developer.download.nvidia.com/compute/cuda/11.4.1/local_installers/cuda-repo-ubuntu1804-11-4-local_11.4.1-470.57.02-1_amd64.deb
    sudo dpkg -i cuda-repo-ubuntu1804-11-4-local_11.4.1-470.57.02-1_amd64.deb
    sudo apt-key add /var/cuda-repo-ubuntu1804-11-4-local/7fa2af80.pub
    sudo apt-get update
    sudo apt-get -y install cuda
    ```

1. Next, we will install [NVIDIA cuDNN](https://developer.nvidia.com/cudnn).  This package provides a GPU-accelerated library of primitive for use in [deep neural networks](https://developer.nvidia.com/deep-learning).

    1. Open a browser on the host machine, and navigate to the [NVIDIA cuDNN Download Repository](https://developer.nvidia.com/rdp/cudnn-download) . 

    1. We will need to install both the runtime and development packages.  Select `Download cuDNN v8.2.2 (July 6th, 2021), for CUDA 11.4`.  Once this selection is expanded, choose the `cuDNN Runtime Library for Ubuntu18.04 x86_64 (Deb)` and `cuDNN Developer Library for Ubuntu18.04 x86_64 (Deb)`.

    1. These packages should download into your local user's `Downloads` directory.  Navigate to the download location and install **both** packages with:

    ```bash
    cd ~/Downloads
    sudo dpkg -i <name of downloaded package>
    ```

1. We are now ready to install the DeepStream SDK.  This will include all of the necessary libraries, development sources, and samples to get you started building custom IVA pipelines.

    1. Open a browser on the host machine, and navigate to the [NVIDIA DeepStream SDK 6.0 - Downloads Page](https://developer.nvidia.com/deepstream-sdk-6.0-early-access) 

    1. Select the `DeepStream on x86 Core - Debian` package. This should download into your local user's `Downloads` directory.  Navigate to the download location and install the package with: 

    ```bash
    cd ~/Downloads
    sudo dpkg -i <name of downloaded package>
    ```

We are now ready to begin exploring how to build Intelligent Video Applications using the NVIDIA DeepStream SDK by examining and running an included reference application.