
A container is an isolated, lightweight silo for running an application on the host operating system. Containers build on top of the host operating system's kernel (which can be thought of as the buried plumbing of the operating system), and contain only apps and some lightweight operating system APIs and services that run in user mode.
While a container shares the host operating system's kernel, the container doesn't get unfettered access to it. Instead, the container gets an isolated–and in some cases virtualized–view of the system. For example, a container can access a virtualized version of the file system and registry, but any changes affect only the container and are discarded when it stops. To save data, the container can mount persistent storage such as an Azure Disk or a file share (including Azure Files).

You need [Docker](https://www.docker.com/) in order to work with Windows Containers. Docker consists of the Docker Engine (dockerd.exe), and the Docker client (docker.exe). 

### How it works
A container builds on top of the kernel, but the kernel doesn't provide all of the APIs and services an app needs to run–most of these are provided by system files (libraries) that run above the kernel in user mode. Because a container is isolated from the host's user mode environment, the container needs its own copy of these user mode system files, which are packaged into something known as a base image. The base image serves as the foundational layer upon which your container is built, providing it with operating system services not provided by the kernel.

> [!div class="mx-imgBorder"]
> ![Diagram of the Docker architecture](../media/az500-docker.png)

Because containers require far fewer resources (for example, they don't need a full OS), they're easy to deploy and they start fast. This allows you to have higher density, meaning that it allows you to run more services on the same hardware unit, thereby reducing costs.

As a side effect of running on the same kernel, you get less isolation than VMs.

### Features of Containers

| **Features** | **Description**|
| --| ---|
| **Isolation** | Typically provides lightweight isolation from the host and other containers, but doesn't provide as strong a security boundary as a VM. (You can increase the security by using Hyper-V isolation mode to isolate each container in a lightweight VM).|
| **Operating System** | Runs the user mode portion of an operating system, and can be tailored to contain just the needed services for your app, using fewer system resources.|
| **Deployment** | Deploy individual containers by using Docker via command line; deploy multiple containers by using an orchestrator such as Azure Kubernetes Service.|
| **Persistent storage** | Use Azure Disks for local storage for a single node, or Azure Files (SMB shares) for storage shared by multiple nodes or servers.|
| **Fault tolerance** | If a cluster node fails, any containers running on it are rapidly recreated by the orchestrator on another cluster node. |
| **Networking** | Uses an isolated view of a virtual network adapter, providing a little less virtualization–the host's firewall is shared with containers–while using less resources. |

In Docker, each layer is the resulting set of changes that happen to the filesystem after executing a command, such as, installing a program.
So, when you view the filesystem after the layer has been copied, you can view all the files, including the layer when the program was installed.
You can think of an image as an auxiliary read-only hard disk ready to be installed in a "computer" where the operating system is already installed.
Similarly, you can think of a container as the "computer" with the image hard disk installed. The container, just like a computer, can be powered on or off.

