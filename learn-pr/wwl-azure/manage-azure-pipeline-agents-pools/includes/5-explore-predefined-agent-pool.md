Azure Pipelines provides a pre-defined agent pool-named **Azure Pipelines** with Microsoft-hosted agents.

It will often be an easy way to run jobs without configuring build infrastructure.

The following virtual machine images are provided by default:

 -  Windows Server 2022 with Visual Studio 2022.
 -  Windows Server 2019 with Visual Studio 2019.
 -  Ubuntu 20.04.
 -  Ubuntu 18.04.
 -  macOS 11 Big Sur.
 -  macOS X Catalina 10.15.

By default, all contributors in a project are members of the User role on each hosted pool.

It allows every contributor to the author and runs build and release pipelines using a Microsoft-hosted pool.

Pools are used to run jobs. Learn about [specifying pools for jobs](/azure/devops/pipelines/process/phases).

> [!NOTE]
> See Microsoft-hosted agents for the most up-to-date list of Agent Pool Images. Also, the complete list of software installed on these machines.
