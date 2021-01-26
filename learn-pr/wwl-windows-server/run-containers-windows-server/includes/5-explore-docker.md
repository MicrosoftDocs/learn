The Contoso Windows Server administrator needs to understand Docker, Docker containers, and how Docker and Docker containers can be run on Windows Server.

## Overview of Docker

*Docker* is a collection of open-source tools, solutions, and cloud-based services that provide a common model for packaging (also known as *containerizing*) app code into a standardized unit for software development. This standardized unit, called a *Docker container*, is software wrapped in a complete file system that includes everything it needs to run: code, runtime, system tools, system libraries, and anything you can install on a server.

Supporting the Docker container is the core of the Docker platform, called the *Docker Engine*. The Docker Engine is a lightweight runtime environment that runs on Linux, macOS, or Windows-based operating systems.

Another component called the *Docker Client for Windows* can be used as a command-line interface (CLI) to integrate with the engine and run commands for building and managing the Docker containers provisioned on the host computer.

> [!NOTE]
> Docker containers are based upon open standards that allow containers to run on all major Linux distributions and Microsoft operating systems with support for every infrastructure. Because they aren't tied to any specific infrastructure, Docker containers can run on any computer, on any infrastructure, and in any cloud.

## Run Docker on Windows Server

You can install Docker on Windows Server by using a variety of methods, including by using package management. For example, you can install software by using the Windows PowerShell module `PackageManagement` at a Windows PowerShell command line.

> [!NOTE]
> You can also use the `PackageManagement` module to obtain other package manager providers that you can use to install different types of software. The `PackageManagement` module is available in Windows Server 2019 and newer versions.

You can also install Docker on Windows Server by using the `DockerMicrosoftProvider` Windows PowerShell module published by Microsoft. This provider enables the **Containers** feature in Windows and installs the Docker Engine and client.

> [!TIP]
> To obtain a list of available `PackageManagement` module providers in Windows Server 2019, run the Windows PowerShell cmdlet `Find-PackageProvider`.

> [!IMPORTANT]
> If you plan to use Hyper-V isolation mode for your containers, you'll also need to install the Hyper-V server role on the host server. Also, if the host server is itself a VM, you need to enable nested virtualization before you install the Hyper-V role. Because Windows 10 runs Windows-based containers by default in Hyper-V isolation mode, to support this default mode the Hyper-V feature must be installed on the Windows 10 host environment.

To install Docker on Windows Server, perform the following tasks:

1. Open an elevated PowerShell session and install the Docker-Microsoft PackageManagement Provider from the Windows PowerShell Gallery, by running the following Windows PowerShell command:

    ```powershell
    Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
    ```

1. Use the `PackageManagement` Windows PowerShell module to install the latest version of Docker by running the Windows PowerShell command:

    ```powershell
    Install-Package -Name docker -ProviderName DockerMsftProvider`
    ```

1. When installation of the Docker Engine is complete, restart the computer by running the following Windows PowerShell command:

    ```powershell
    Restart-Computer
    ```

1. Check that the Docker service is running by running the following Windows PowerShell command:

    ```powershell
    Start-Service docker  
    ```

1. Check the Docker version that's installed in the same Windows PowerShell console session by running the following Docker command:

    ```docker
    docker version
    ```

> [!TIP]
> If you need to install a specific version of Docker, add the `-RequiredVersion` switch when running the `Install-Package` command.

> [!NOTE]
> The **Windows Server 2019 Datacenter with containers** image in Microsoft Azure comes with Hyper-V and Docker Enterprise installed, both of which are required to run containers on Windows Server.

### Overview of Docker products

There are a number Docker products which Windows Server administrators might come across. Some of the most relevant of these are:

- Docker Community Edition (CE) for Windows, which:
  - Is a free community edition of Docker that provides basic functionality.
  - You can use to build and distribute containerized applications and services. Windows 10 Professional and Enterprise edition supports the running and management of Windows containers using Docker.
  - Is available for both Mac and Windows desktop environments and is installed in Windows desktop environments.
  - Provides the Docker Engine and other tools used to test and implement a containerized app.

- Docker Enterprise Edition (EE), which builds upon Docker CE for Windows with the addition of enterprise application development and maintenance support.

Both Docker CE for Windows and Docker Enterprise Edition (EE) include the components in the following table. However, Docker Enterprise Edition (EE) provides additional support and functionality than these components.

|Docker component|Description|
|---|---|
|Docker Engine|Use *Docker Engine* as a lightweight runtime environment to build and run Docker containers.|
|Docker Compose|Use *Docker Compose* to define a multiple-container app together with any dependencies so you can run it with a single command. With Docker Compose, you can specify the images your app will use with any necessary volumes or networks.|
|Docker CLI client|*Docker CLI client* includes a command shell that's pre-configured as a Docker command-line environment used to interface with the Docker Engine.|
|Kubernetes|Use *Kubernetes* to manage and orchestrate containerized applications across multiple hosts. It helps to deploy, maintain, and scale applications.|
|Credential Helper|Use this component to help safely store Docker login credentials.|

## The Docker Hub

Containers are built on container images, and these images can be stored in *repositories*. Repositories act as a location where you can build, store, secure and share container images. The *Docker Hub* is a web-based online library service, managed by Docker, in which you can:

- Register, store, and manage your own Docker images in an online repository and then share them with others.
- Access over 100,000 container images from software vendors, open-source projects, and other community members.
- Download the latest version of Docker CE for Windows.

## Microsoft Container Registry

Microsoft provides container images through the Microsoft Container Registry (MCR) at `mcr.microsoft.com`. This is the official source of Microsoft-provided container images. Regardless of where Microsoft container images are discovered, the pull source is `mcr.microsoft.com`.

> [!NOTE]
> **Azure Container Registry** is an Azure service which you can use to build your own container image repository. You can use this repository to store and manage images for all types of container deployment.
