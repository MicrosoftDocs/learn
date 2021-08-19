In SQL Server 2019, you can choose to run a database server on Linux or Windows. Also, you can decide to run a database on a physical server, or in a virtual environment like a Virtual Machine (VM) or a container.

Suppose you want to make it easier to deploy database servers into the testing environment for your photo-sharing application. You need to provide clean sample databases for integration and acceptance testing as quickly as possible. Because the production environment is hosted on Linux servers, you want the testing environment to run Linux too.

In this unit, you'll learn about running SQL Server 2019 in a container system, such as Docker or CRI-O, and why such an environment is advantageous for many systems.

## What are containers?

Until a few years ago, when database administrators created a new database server, they did so by installing an operating system on a new physical computer, and then installing a database engine such as Microsoft SQL Server on it.

This approach changed with the arrival of VMs. By using a virtualization host such as Hyper-V or VirtualBox, you could host multiple virtual computers on a single server. When you use VMs to host databases, each VM includes a complete operating system, database server, and a set of virtual hard drives where the database files are stored.

VMs make things much more flexible. Not only can you create new database servers without necessarily investing in new hardware, you can also create them in cloud environments, such as Microsoft Azure. You might also create a Linux VM on a Windows host or a Windows VM on a Linux host. This happens because the VM includes its own operating system that's independent of the host operating system.

However, because each VM is a complete virtual computer, with a separate operating system and virtualized hardware, it consumes many resources on the physical host computer. This demand for resources limits the scalability of VMs.

Containers provide a solution to this problem. The operating system and the virtual hardware in a container are shared with the host computer. Only the software is unique to the container. The software within the container is isolated, as it is in a VM, and interacts with the operating system as it does when installed on a physical computer. But you don't need to run separate copies of the operating system and hardware for each container.

![Comparing VMs and Containers.](../media/2-compare-vms-containers.png)

This architecture makes containers much smaller and more scalable than VMs. It also means that a container is easier and quicker to deploy or move. Containers are, however, dependent on the host operating system. For example, you can't run a Linux container on a Windows host, as you could with VMs.

## What is a container host?

To run containers on your server, you need a container host package to manage the interaction of the container and its software with the host operating system and hardware. There are several container host systems available, including CRI-O, rkt, and LXD. In this module, we'll use the Docker container host system.

Docker is an open-source software package that runs on Windows, Linux, macOS, and other operating systems. To use containers, install Docker on your physical host computer.

Two editions of Docker are available:

- **Docker Community Edition**. This edition is ideal for developers and small teams who want to get started with Docker and experiment with container-based apps. It's free but includes no technical support.
- **Docker Enterprise Edition**. This edition is intended for enterprises that build, ship, and run business-critical applications in production and at scale in containers. Docker EE is integrated, certified, and supported to provide enterprises with the most secure container platform in the industry.

> [!NOTE]
> If you use many containers, you may find them difficult to manage. You might also want to respond automatically to changes in demand, by spinning up or halting containers. Container orchestrator packages, such as Kubernetes or Docker Swarm, can take this role. 

## Images and registries

After you've installed a container host, you can start to create and run containers.

The first step is to choose an image. An image is a read-only template with a set of instructions for creating a container. The image, for example, could add:

- Files to the virtual hard drives, such as a database backup file or Transact-SQL scripts.
- Software applications, such as SQL Server 2019 or a web server, such as Internet Information Services (IIS) or Apache.

When you create an image, you must specify a parent image. For example, you could use a parent image that already has SQL Server 2019 installed but add a unique database backup file to it in your child image.

In Docker, images are stored in registries. Docker is configured to look for images in the public Docker Hub registry by default. This registry includes many useful images you can use as parents. You can configure Docker to look for images in other registries, including private registries that you set up and run as well as the Microsoft image registries.

## How to choose between VMs and containers for a database server

If you've chosen to use virtualization for your database server, instead of a physical server, you must ask several questions to ensure you have the best system:

- Can you share an operating system? If you want complete flexibility, including the ability to run different operating systems from a host computer, you must use VMs.
- Are hardware resources restricted? If you want to maximize the number of virtual environments that run on a limited physical host computer, use containers.
- Is it important to deploy quickly? Because containers are smaller than VMs, you can deploy them faster. Rapid deployment can be helpful, for example, when you want to respond rapidly to an increase in demand.

If you choose to use containers, consider whether to use Linux or Windows for the host operating system. A container host can be installed on both these systems but the operating system you choose will be shared by all containers you run on that physical host computer.

Because SQL Server 2019 can run on both Windows and Linux operating systems, your choice is no longer determined by your database system. Instead you can choose the operating system that your administrative team have more experience with.

Next, consider the images available in public registries, such as the Docker registries and Microsoft registries. If there's an image that includes some or all of the software you need, use it as it is or create a child image from it. This approach reduces the complexity of the image you create.

For example, if you want to run SQL Server 2019 on a Linux Docker host, consider using the **mcr.microsoft.com/mssql/server:2019-latest** from the Microsoft registry. With this parent image, you already have SQL Server 2019 installed.

## An example scenario

You want to choose a testing environment for your photo-sharing application. The production environment is hosted on Linux servers and you want to reflect this setup in the testing environment. So there's no need to mix operating systems on one physical host server. You have no particular restriction on hardware resources but, because a clean testing environment must be deployed for each testing cycle, rapid deployment would be a distinct advantage. It would reduce the time taken to set up the test environment for all integration and acceptance tests.

You also have the **mcr.microsoft.com/mssql/server:2019-latest** base image in the Microsoft container registry. If you base a custom image on this parent, you only need to copy a sample database into the image before booting and restoring that database.

For these reasons, containers make sense for your testing environment, and should realize significant advantages over VMs.