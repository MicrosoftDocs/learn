The NVIDIA DeepStream SDK requires some prerequisite software.  We'll walk through the installation of these dependencies and explain their roles.

1. Install the `build-essential` meta-package that will provide tools to compile C and C++ applications from source. We'll also install a few helper programs that are required to compile certain sources that will be referenced after this step. To start, run these commands on the host terminal:

    ```bash
    sudo apt install \
    build-essential \
    pkg-config \
    libglvnd-dev
    ```

1. Install the extra packages that might be referenced at runtime when a DeepStream application is run. Notice that multiple `gstreamer`-based plug-ins are included. They're needed because NVIDIA DeepStream uses the [GStreamer](https://gstreamer.freedesktop.org/) library for media handling and graph composition in DeepStream applications. Use the following commands to install these requirements on the host terminal:

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
       libnvinfer-plugin-dev=8.0.1-1+cuda11.3 
       libnvparsers-dev=8.0.1-1+cuda11.3 \
       libnvonnxparsers-dev=8.0.1-1+cuda11.3 \
       libnvinfer-samples=8.0.1-1+cuda11.3 \
       libnvinfer-doc=8.0.1-1+cuda11.3
       ```

1. Install the DeepStream SDK. The SDK includes all the libraries, development sources, and samples to get you started with building custom IVA pipelines.

    1. Open a browser on the host machine. Go to the [NVIDIA DeepStream Getting Started - Downloads page](https://developer.nvidia.com/deepstream-getting-started).

    1. Select the **DeepStream 6.0 for Servers and Workstations** package. It should download to your local user's *Downloads* folder. Go to the download location and install the package by using these commands:

    ```bash
    cd ~/Downloads
    sudo dpkg -i <name of downloaded package>
    sudo apt --fix-broken install'
    ```

You're now ready to start exploring how to build Intelligent Video Analytics applications by using the NVIDIA DeepStream SDK. We'll examine and run a sample application.
