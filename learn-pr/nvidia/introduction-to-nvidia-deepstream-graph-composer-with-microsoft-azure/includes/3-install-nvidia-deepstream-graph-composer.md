In this section we will install the prerequsites and dependencies necessary to install and run the DeepStream Graph Composer.

1. To begin, we will need to install the Docker Runtime in order to support the `container-builder` portion of the Graph Composer.  Docker will allow us to build and push container images produced using `container-builder`.

    The following instructions assume we are running in a terminal on an x86 based host running Ubuntu 18.04.

    ```
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    ```

2. Next, we need to install some of the base dependencies used by the Graph Composer application at runtime.  This assist in drawing the user interface of the application and provide ability to interact with available hardware acceleration on the host machine.

    ```
    sudo apt install \
    mesa-utils \
    vulkan-utils \
    mesa-vulkan-drivers
    ```

3. We are now ready to install the Graph Composer package.  This will contain the `composer` application and associated `registry`, `graph execution engine`, and `container-builder` tooling.

    Open a browser on the host machine, and navigate to the [x86 release of the DeepStream 6.0 Graph Composer](https://developer.nvidia.com/assets/deepstream/secure/deepstream_6.0_ea/graph-composer-0.5.0_x86_64.deb). 
    
    This should download into your local user's `Downloads` directory. Navigate to the download location and install the package with:
    ```
    cd ~/Downloads
    sudo dpkg -i <name of downloaded package>
    ```

4. Finally, we will install a collection of reference graphs that we will use in the next section of this module.

    Open a browser on the host machine, and navigate to the [Graph Composer Reference Examples](https://developer.nvidia.com/assets/deepstream/secure/deepstream_6.0_ea/deepstream-reference-graphs-6.0.deb).

    This should download into your local user's `Downloads` directory. Navigate to the download location and install the package with:
    ```
    cd ~/Downloads
    sudo dpkg -i <name of downloaded package>
    ```

Now that we have installed the DeepStream Graph Composer and associated reference graphs, we can now look at running one of the include DeepStream Graph Composer reference applications.