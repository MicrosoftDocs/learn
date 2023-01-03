The Contoso Windows Server administrator needs to understand how containers run in Windows Server, and how isolation of runtime environments is achieved, primarily process isolation and Hyper-V isolation modes. The administrator also needs to understand how to run different isolation modes, and under what circumstances different isolation modes are appropriate or required.

**Isolation modes**

Windows server can run containers in one of two distinct isolation modes. Both modes support identical processes for creating, managing, and running containers. However, there's a difference between the degree of isolation that's provided for the container, and accordingly, the security between the container, other containers, and the host OS.

Windows Server supports the following container isolation modes:

- Process isolation. Containers running in process isolation mode can be referred to as Windows Server containers.

- Hyper-V isolation. Containers running in Hyper-V isolation mode can be referred to as Hyper-V containers.

**Process isolation mode for Windows Server containers**

Considered the traditional isolation mode for Windows Server containers, process isolation mode allows multiple container instances to run concurrently on a host. When running in this mode, containers share the same kernel with each other and with the host OS. Each provisioned container features its own user mode to allow Windows and app processes to run isolated from other containers. When you configure Windows containers to use process isolation mode, containers can run multiple apps in isolated states on the same computer, but they don't provide security-enhanced isolation.

> [!Note]
> Docker is a collection of open-source tools, solutions, and cloud-based services that provide a common model for packaging (also known as containerizing) app code into a standardized unit for software development. You will learn more about Docker and container runtimes in the next unit.

When you start a new container, Docker (or the default container runtime) communicates with the compute services to create a new container that's based on an image. For each container, Docker creates a Windows container. Each Windows container requires a set of system processes, which are always the same in every container. You then can use your own application process to differentiate each container. To do this, you can use an application framework such as .NET, a Windows Server component such as Internet Information Services (IIS), or a third-party framework or processes that you run in the container.

**Hyper-V isolation mode for Hyper-V containers**

When containers share the kernel and memory, there's the possibility that, should a vulnerability be explored by an attacker, an application might break out of its sandbox environment and inadvertently do something malicious. To avoid this, Windows provides an alternative method to run containers that's more secure called Hyper-V isolation mode, sometimes referred to as Hyper-V containers.

With Hyper-V isolation mode, each container runs inside a highly optimized VM. The advantage of Hyper-V isolation mode is that each container effectively has its own kernel, which provides an enhanced level of stability and security. The VM provides an additional layer of hardware-level isolation between each container and the host computer. When deployed, a container using Hyper-V isolation mode starts in seconds, which is much faster than a VM with a full Windows OS.

> [!Note]
> Windows-based containers running on Windows Server default to using the process isolation mode. Windows-based containers running on Windows 10 Pro and Enterprise default to using the Hyper-V isolation mode.

The following graphic compares the architectures of Windows Server and Hyper-V containers and their two isolation modes. The graphic illustrates that the host Windows kernel is shared by the host user mode and Windows Server. Running on that shared kernel is a virtual machine, inside of which is a Hyper-V container. The Hyper-V container has its own Windows kernel that's not shared.

![Screenshot of the architecture for Windows Server and Hyper-V containers and their two isolation modes.](../media/run-containers-on-windows-server-03.png)

> [!Caution]
> Process isolation mode in Windows 10 is intended for development and test only. Starting with the Windows 10 October 2018 update, users running a Windows 10 Pro or Enterprise host can run a Windows container in process isolation mode. Users must directly request process isolation mode by using the --isolation=process parameter. Your host must be running Windows 10 build 17763+ and you must have a Docker version with Engine 18.09 or newer.

> [!Important]
> As Windows Server container and the host operating system, share the kernel, you must ensure that your host and container image version tags match, otherwise the container might fail to start or exhibit undefined behavior. Hyper-V containers can be used as an alternative to run older container images on newer hosts - for example: A Windows Server 2019 image on a Windows Server 2022 host only works with Hyper-V isolation.

**How to specify an isolation mode using a Docker command**

We will discuss Docker and container runtimes more in the next unit, however in this context we just need to be aware that Docker provides a set of commands we can use to create containers. When you create a container using Docker, you can specify the isolation mode by using the --isolation parameter and either the process isolation mode or the Hyper-V isolation mode:

- Create a container using the process isolation mode by using this command:

```Docker
docker run -it --isolation=process mcr.microsoft.com/windows/servercore:ltsc2019 cmd
```
- Create a container using the Hyper-V isolation mode by using this command:

```Docker
docker run -it --isolation=hyperv mcr.microsoft.com/windows/servercore:ltsc2019 cmd`
```
**When to use Hyper-V containers over Windows Server containers**

Factors to consider when choosing between using Hyper-V containers and Windows Server containers are trust, security, and isolation. Consider using Hyper-V containers when:

- An application requires a dedicated Windows Kernel.

- Application trust is required because:

	- The host OS might not fully trust the application running on it.

	- Applications running alongside each other on the same host might not trust each other.

- Greater security is required.

- Greater isolation is required.

Some scenarios that might drive some of these decisions include:

- Cloud Providers. Where hardware resources are shared and utilized, all the previously mentioned factors might apply to workloads running from different customers.

- Compliance policies. You might need to adhere to security, data, or other policies that require isolation and increased security in your workloads and running applications.

- Runtime environments (also known as dev, test, or production environments). You might not require additional isolation in dev or test environments but might do so in production scenarios. You might also have a distributed application in a microservices model. Different container workloads in microservices application architecture might have different isolation needs which you might need to consider.

 

> [!Caution]
> Not all orchestration services, such as Kubernetes, support Hyper-V containers. When Hyper-V containers are not supported, but greater isolation is needed, you might need to recur to a full VM to run a set of containers that can run side-by-side.