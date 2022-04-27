In this section, we'll access our virtual machine remotely to update the currently installed packages.  We'll also install a Python development environment and configure it with prerequisite software to enable execution of the ONNX runtime.  To satisfy the NVIDIA Triton Inference Server, we'll pull a container with a full installation of the tooling to allow us to execute an inference workload on our virtual machine.

## Install prerequisites and NVIDIA Triton Inference Server

1. Open your terminal emulator of choice. For illustration, we’ll be using Windows Terminal, as it allows for multiple windows to be simultaneously connected concurrently to the virtual machine. We’ll be using one window to start the Triton Server, one window to execute a Python script and one to copy images to a directory for processing via the CLI. With Windows Terminal, you also have your choice of CLI experience, PowerShell, Command Prompt, Ubuntu-18.04 (if WSL-2 is installed) or Azure Cloud Shell.

1. Copy the username you used to set up the virtual machine in the previous stage, and in the command line run:

    ```bash
        ssh <username>@<your VM IP address>
    ```

    This will prompt you for the password you saved previously to your text editor.  Copy this value, and right click in the command line to paste. If logging in for the first time, you’ll see the following message:

    :::image type="content" source="../media/3-vm-logged-in.png" alt-text="A screenshot showing a successful log into the virtual machine." lightbox="../media/3-vm-logged-in.png":::

1. Now we’re going to load in a few packages that our Python script will need to execute properly.  On the command line, enter:

    ```bash
    sudo apt update
    sudo apt install -y python3-pip python3-dev nano wget
    ```

    Prior to installing the Python packages required, we’ll want to add ‘/home/\<your username\>/.local/bin’ to the PATH by taking the following steps in the CLI:

    ```bash
    sudo nano ~/.bashrc
    ```

    Arrow to the bottom of this file in the editor, and add the following line:
    
    ```bash
    export PATH=/home/<your username>/.local/bin:$PATH
    ```
    
    Press *Ctrl + O* and press enter to save the file, then press *Ctrl + X* to exit.  On the command line, run:
    
    ```bash
    source ~/.bashrc
    ```

    This will reload the configuration for the server to include .local/bin in the PATH. 

1. Now that we’ve loaded the Ubuntu package requirements and added the directory to PATH, we’re going to install the required Python packages.  Copy each line individually to run in the terminal window.

    ```bash
    python3 -m pip install --upgrade pip wheel setuptools

    python3 -m pip install numpy>=1.19.0 opencv-contrib-python-headless tritonclient geventhttpclient

    python3 -m pip install
 
    torch torchvision pandas tqdm PyYAML scipy seaborn requests pybind11 pytest protobuf objdict onnxruntime

    ```
    
    If you're using a Nvidia GPU-capable VM, you can use onnxruntime-gpu instead of onnxruntime to take advantage of the CUDA/cuDNN acceleration.

1. To run the Triton Server container from Nvidia, we’re going to need a container engine. Microsoft has a distribution of this container runtime, which can be installed using the following commands:

    ```bash
    wget https://packages.microsoft.com/config/ubuntu/18.04/multiarch/packages-microsoft-prod.deb -O packages-microsoft-prod.deb

    sudo dpkg -i packages-microsoft-prod.deb

    rm packages-microsoft-prod.deb
    ```

    Now we can install Moby:
    
    ```bash
    sudo apt update

    sudo apt install -y moby-engine

    sudo apt update
    ```

1. Now, we’re ready to pull the container for the Triton Server from the NVIDIA NGC repository.  You can also pull the container during the 'docker run' command when we get to that step, but for simplicity, we'll do the pull now.  In the terminal emulator, run:

    ```bash
    sudo docker pull nvcr.io/nvidia/tritonserver:20.11-py3
    ```
    
    This process will take some time to download the container layers and extract them.

    :::image type="content" source="../media/3-docker-pull.png" alt-text="A screenshot showing the docker pull command in progress." lightbox="../media/3-docker-pull.png":::

1.	Now we’re ready to copy the ‘demo’ directory over to the virtual machine.  Download the [demo.zip file](https://github.com/microsoft/Develop-Custom-Object-Detection-Models-with-NVIDIA-and-Azure-ML-Studio/raw/main/demo.zip) from the repository, then unzip this file locally on your PC.  Open a command prompt window, either in the utility, or open another window in Windows Terminal.  Depending on where you unzipped the files, run the following command in the CLI:

    ```bash
    scp -r <path to unzipped>/demo <your username>@<x.x.x.x vm IP address>:/home/<your username>/
    ```
    :::image type="content" source="../media/3-upload-demo.png" alt-text="A screenshot showing the scp command running successfully." lightbox="../media/3-upload-demo.png":::

1. Once we have these files copied over to the virtual machine, let’s switch back over to the terminal window connected to the virtual machine and set the permissions for this directory.  In the CLI, enter:

    ```
    sudo chmod -R 777 demo
    ```