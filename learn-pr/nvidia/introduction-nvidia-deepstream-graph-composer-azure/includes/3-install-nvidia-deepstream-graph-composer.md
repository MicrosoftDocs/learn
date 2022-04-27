In this unit, you'll install the prerequisites and dependencies necessary to install and run the DeepStream Graph Composer.

1. Install the Docker runtime to support the *container-builder* portion of the Graph Composer. Docker allows you to build and push container images produced by using *container-builder*.

    The following instructions assume you're running in a terminal on an x86-based host running Ubuntu 18.04.

    ```Bash
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    ```

1. Install some of the base dependencies used by the Graph Composer application at runtime. These packages are need to render the user interface of the application. They also enable interaction with available hardware acceleration on the host machine.

    ```Bash
    sudo apt install \
    mesa-utils \
    vulkan-utils \
    mesa-vulkan-drivers
    ```

1. You're now ready to install the Graph Composer package. This package contains the *composer* application and associated *registry*, *graph execution engine*, and *container-builder* tooling.

    Open a browser on the host machine, and go to the [x86 release of the DeepStream 6.0 Graph Composer](https://developer.nvidia.com/graph_composer-1.0.0_x86_64deb).

    This release should download into your local user's *Downloads* directory. Go to the download location and install the package by using these commands:

    ```Bash
    cd ~/Downloads
    sudo dpkg -i <name of downloaded package>
    ```

1. Finally, install a collection of reference graphs for use in the next unit of this module.

    Open a browser on the host machine, and go to the [Graph Composer reference examples](https://developer.nvidia.com/deepstream-reference-graphs-6.0deb).

    This package should download into your local user's *Downloads* directory. Go to the download location and install the package by using these commands:

    ```Bash
    cd ~/Downloads
    sudo dpkg -i <name of downloaded package>
    ```

Now that you've installed the DeepStream Graph Composer and associated reference graphs, you can look at running one of the included DeepStream Graph Composer reference applications.
