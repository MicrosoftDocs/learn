Azure Pipelines provides a predefined agent pool named **Azure Pipelines** with Microsoft-hosted agents. This pool offers an easy way to run jobs without configuring build infrastructure.

## Available virtual machine images

The following virtual machine images are provided by default:

- Windows Server 2022 with Visual Studio 2022.
- Windows Server 2019 with Visual Studio 2019.
- Ubuntu 20.04.
- Ubuntu 18.04.
- macOS 11 Big Sur.
- macOS X Catalina 10.15.

## Default permissions

By default, all contributors in a project are members of the User role on each hosted pool. This allows every contributor to create and run build and release pipelines using Microsoft-hosted pools.

## Usage

These pools are designed to run jobs efficiently. Learn about [specifying pools for jobs](/azure/devops/pipelines/process/phases) to get started.

> [!NOTE]
> See Microsoft-hosted agents documentation for the most up-to-date list of agent pool images and the complete list of software installed on each machine.
