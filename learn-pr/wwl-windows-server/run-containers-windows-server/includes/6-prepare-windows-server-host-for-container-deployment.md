> [!Note]
> For the purpose of this Microsoft Learn module, all examples will be performed with the Docker CLI. These commands should work on Windows 10 and 11 with Docker Desktop, as well as on Windows Server with Moby or MCR. Environments with containerd will have other CLI options and the commands will differ.

 

The Contoso Windows Server administrator needs to understand and source container base images, how to determine which container base images are available and appropriate to use, and how to pull base images down locally. This enables the administrator to create and run any necessary containers.

**Download container-based images**

After you install the container runtime of choice, the next step is to pull a base image, which is used to provide a foundational layer of OS services for your container. You can then create and run a container, which is based upon the base image.

A container base image includes:

- The user mode OS files needed to support the provisioned application.

- Any runtime files or dependencies the application requires.

- Any other miscellaneous configuration files the app needs to provision and run properly.

Microsoft provides the base OS images in the following table as a starting point to build your own container images.

| **Base image name**| **Details** |
| - | - |
| Server Core| An image that contains a subset of the Windows Server application programming interfaces (APIs) such as the full .NET framework. It also includes most server roles. This image is ideal for scenarios on which an existing application is being "containerized". |
| Nano Server| The smallest Windows Server image, with support for the .NET APIs and some server roles. This image requires the application to be written for Nano Server and is ideal for new applications that rely on Windows. |
| Windows| Contains the full set of Windows APIs and system services; however, doesn't contain server roles. This image was replaced by the Server image starting with Windows Server 2022. |
| Server| Similar to the Windows image, this base image contains the full set of Windows Server APIs and system services. This results in a larger container image, but higher application compatibility. This image is ideal for scenario on which an existing application is being containerized, but the Server Core image does not provide the necessary dependencies for the application. |


> [!Note]
> The Windows host OS version must match the container OS version. To run a container based on a newer Windows build, you need to ensure that an equivalent OS version is installed on the host.

If your host server contains a newer OS version, you can use the Hyper-V isolation mode to run an older version of Windows containers.

For more information about host and container image compatibility, check out [Windows container version compatibility](/virtualization/windowscontainers/deploy-containers/version-compatibility?tabs=windows-server-2022%2Cwindows-11-21H2).

You can find and download base images through the Microsoft Container Registry. Use the docker pull command to download a specific base image.

> [!Important]
> OS base images provide the Windows Server OS components and its server roles. Microsoft also provides specific images for different frameworks already installed, such as IIS, .Net Framework and .Net.

When you enter the docker pull command, specify the version that matches the version of the host machine. For example, if you wanted to pull a Nano Server image based upon Windows Server 2022, you would use the following command:

```docker
docker pull mcr.microsoft.com/windows/nanoserver:ltsc2022
```
If you wanted to pull a Windows Server 2019 Server Core image, you would use the following command:

```docker
docker pull mcr.microsoft.com/windows/servercore:ltsc2019
```
After you download the base images needed for your containers, you can verify the images that are available locally and display metadata information by entering the following command:

```docker
docker images
```
**Run a Windows container**

On large-scale, production environments you most likely interact with containers via a container orchestrator, such as Kubernetes or Docker Swarm. On smaller and dev/test environments, you can create, remove, and manage containers on Windows Server via CLI.

You can also browse the Docker Hub or Microsoft Container Registry to access and pull prebuilt images. There are two main alternatives to build a container image to host your application:

- Build a container image using developer tools. When the application is being written by a developer, it can be packaged directly from the developer IDE, such as Visual Studio.

- Build a container image with a dockerfile. A dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image. Tools such as Visual Studio build the dockerfile natively for a new application, but you have the option to build your own dockerfile manually.

> [!Note]
> There's an additional option to create container images based on a running container. This is similar to creating a Golden Image from a running VM. This method is not recommended. More details will be provided in the next section.

**Automate container image creation by using dockerfile on Windows**

The Docker Desktop engine and MCR include tools for automating the process of creating container images. Although you can create container images manually, adopting an automated image-creation process provides many benefits, including:

- The ability to store container images as code.

- The rapid and precise re-creation of container images for maintenance and upgrade purposes.

- Continuous integration between container images and the development cycle.

> [!Note]
> Moby and containerd don't include a native image build solution. Alternatively, you can use a container image build service, such as Azure Container Registry (ACR) Tasks.

The Docker components that drive this automation are the dockerfile text file and the docker build command:

- The dockerfile text file contains the instructions needed to create a new container image. These instructions include the identification of an existing image to use as a base, commands to run during the image creation process, and a command that runs when new instances of the container image deploy.

- The docker build command consumes a dockerfile and then triggers the image-creation process.

**Manage containers by using the CLI**

Use the following commands to create and manage your containers and container images:

- The docker images command lists the available images on your container host. One reason to do this is to use existing container images as a base for new containers:

```docker
docker images
```
- The docker run command creates a container by using a container image. For example, the following command creates a container that's based on the Windows Server Core container image. Don't specify an isolation mode in the command, so Docker will use the default isolation mode, which is process isolation. The --name parameter is used to set a name to the container. The -it is used to have an interactive session with the container (as opposed to -d to run detached) and the PowerShell instruction opens a PowerShell session:

```docker
docker run --name IIS -it mcr.microsoft.com/windows/servercore:ltsc2022 powershell
```
- The docker commit command commits the changes you made to a container to a new container image. The commit operation doesn't include data contained in volumes mounted within the container. By default, the container will be paused while the new container image is being created: (keep in mind this option is not recommended as a best practice to create new container images)

```docker
docker commit
```
- The docker stop command stops a running container:

```docker
docker stop <container name or ID>
```
- The docker rm command removes one or more containers:

```docker
docker rm <container name or ID>
```
**Demonstration**

The following video demonstrates how to:

- Install **Docker CE/Moby** on **Windows Server**.

- Pull a container image and run a new container interactively.

- Deploy an IIS container instance and validate webpage on browser.

The main steps in the process are:

1. Install **Docker CE/Moby** on **Windows Server**.

2. Download a **Windows Server Core** image that contains Internet Information Services (IIS). Because the container base image version must match that of the host, use the iis:windowsservercore-ltsc2022 container.

3. Run the following Docker command with these parameters:

	- Run the downloaded container as a background service by using the -d parameter.

	- Configure networking so that **port 80** of the container host maps to **port 80** of the container.

```docker
Docker run -d -p 80:80 mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022
```
4. Obtain the container ID by using the following command:

```docker
docker ps
```
5. Stop the container by using the following command:

```docker
docker stop <container ID>
```

 > [!VIDEO https://www.microsoft.com/videoplayer/embed/RE5cqLo]


**Quick review** 