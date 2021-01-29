The Contoso Windows Server administrator needs to understand and source container base images, how to determine which container base images are available and appropriate to use, and how to pull base images down locally. This enables the administrator to create and run any necessary containers.

## Download container-based images

After you install the Docker Engine, the next step is to pull a base image, which is used to provide a foundational layer of OS services for your container. You can then create and run a container, which is based upon the base image.

A container base image includes:

- The user mode OS files needed to support the provisioned application.
- Any runtime files or dependencies the application requires.
- Any other miscellaneous configuration files the app needs to provision and run properly.

Microsoft provides the base images in the following table as a starting point to build your own container image.

|Base image name|Details|
|||
|Windows Server Core|An image that contains a subset of the Windows Server application programming interfaces (APIs) such as the full .NET framework. It also includes most server roles.|
|Nano Server|The smallest Windows Server image, with support for the .NET Core APIs and some server roles.|
|Windows|Contains the full set of Windows APIs and system services; however, doesn't contain server roles.|
|Windows Internet of Things (IoT) Core|A version of Windows used by hardware manufacturers for small IoT devices that run ARM or x86/x64 processors.|

> [!TIP]
> To review a list of all available Microsoft container base images, from a Windows PowerShell console, run the command `docker search microsoft`.

> [!NOTE]
> The Windows host OS version must match the container OS version. To run a container based on a newer Windows build, you need to ensure that an equivalent OS version is installed on the host.
>
> If your host server contains a newer OS version, you can use the Hyper-V isolation mode to run an older version of Windows containers.
>
> To determine the version of Windows installed, run the `ver` command from the command prompt.

You can find base images through the Docker Hub and then download them from the Microsoft Container Registry (MCR). Use the `docker pull` command to download a specific base image.

When you enter the `docker pull` command, specify the version that matches the version of the host machine. For example, if you wanted to pull a Nano Server image based upon version 20H2, you would use the following command:

```docker
docker pull mcr.microsoft.com/windows/nanoserver:20H2
```

If you wanted to pull a 2019 LTSC Server core image, you would use the following command:

```docker
docker pull mcr.microsoft.com/windows/servercore:ltsc2019
```

After you download the base images needed for your containers, you can verify the images that are available locally and display metadata information by entering the following command:

```docker
docker image ls
```

## Run a Windows container

With Docker, you can create, remove, and manage containers. You can also browse the Docker Hub to access and download prebuilt images. In most organizations, the most common management tasks that use Docker include:

- Automating the process of creating container images by using `Dockerfile` on a Windows OS.
- Managing containers by using Docker.

## Automate container image creation by using Dockerfile on Windows

The Docker Engine includes tools for automating the process of creating container images. Although you can create container images manually, adopting an automated image-creation process provides many benefits, including:

- The ability to store container images as code.
- The rapid and precise re-creation of container images for maintenance and upgrade purposes.
- Continuous integration between container images and the development cycle.

The Docker components that drive this automation are the *Dockerfile* text file and the `docker build` command:

- The *Dockerfile* text file contains the instructions needed to create a new container image. These instructions include the identification of an existing image to use as a base, commands to run during the image creation process, and a command that runs when new instances of the container image deploy.
- The `docker build` Docker Engine command consumes a Dockerfile and then triggers the image-creation process.

## Manage containers by using Docker

You can use Docker to support and manage a container environment. After you install Docker, use the following commands to create and manage your containers:

- The `docker images` command lists the available images on your container host. One reason to do this is to use existing container images as a base for new containers:

    ```docker
    docker images
    ```

- The `docker run` command creates a container by using a container image. For example, the following command creates a container that's based on the Windows Server Core container image. Don't specify an isolation mode in the command, so Docker will use the default isolation mode, which is process isolation. Docker also assigns the name *IIS* to the container:

    ```docker
    docker run --name IIS -it windowsservercore
    ```

- The `docker commit` command commits the changes you made to a container to a new container image. The commit operation doesn't include data contained in volumes mounted within the container. By default, the container will be paused while the new container image is being created:

    ```docker
    docker commit
    ```

- The `docker stop` command stops a running container:

    ```docker
    docker stop
    ```

- The `docker rm` command removes one or more containers:

    ```docker
    docker rm
    ```

## Demonstration

The following video demonstrates how to:

- Install **Docker** on **Windows Server**.
- Install and run a Windows container.
- Use **Windows Admin Center (WAC)** to manage containers.

The main steps in the process are:

1. Install **Docker** on **Windows Server**.
1. Download a **Windows Server Core** image that contains Internet Information Services (IIS). Because the container base image version must match that of the host, use the `iis:windowsservercore-ltsc2019` container.
1. Run the following Docker command with these parameters:
    - Run the downloaded container as a background service by using the `-d` parameter.
    - Configure networking so that **port 80** of the container host maps to **port 80** of the container.

    ```docker
    Docker run -d -p 80:80 --name ContosoSite mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019 cmd
    ```

1. Obtain the container ID by using the following command:

    ```docker
    docker ps
    ```

1. Stop the container by using the following command:

    ```docker
    docker stop
    ```

1. View management information for the container by using **WAC**.

 >[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4MzHM]