Azure IoT Edge moves your existing business logic to devices operating at the edge. To prepare your applications and workloads to run as IoT Edge modules, you need to build them as containers. The first step is to configure your development environment so that you can successfully create an IoT Edge solution. Once you have your development environment set up, then you can learn how to Develop your own IoT Edge modules.

In any IoT Edge solution, there are at least two machines to consider. One is the IoT Edge device (or devices) itself, which runs the IoT Edge module. The other is the development machine that you use to build, test, and deploy modules. For testing purposes, the two machines can be the same. You can run IoT Edge on your development machine and deploy modules to it.

> [!NOTE]
> This topic is focused on the tools that you use (on your development machine) to build, test, and deploy modules.

## Operating system

Azure IoT Edge runs on a specific set of supported operating systems. For developing for IoT Edge, you can use most operating systems that can run a container engine. The container engine is a requirement on the development machine to build your modules as containers and push them to a container registry.

If your development machine can't run Azure IoT Edge, see the section below to learn about testing tools that help you test and debug locally.

The operating system of your development machine doesn't have to match the operating system of your IoT Edge device. However, the container operating system must be consistent between development machine and IoT Edge device. For example, you can develop modules on a Windows machine and deploy them to a Linux device. The Windows machine needs to run Linux containers to build the modules for the Linux device.

## Container engine

The central concept of IoT Edge is that you can remotely deploy your business and cloud logic to devices by packaging it into containers. To build containers, you need a container engine on your development machine.

The only supported container engine for IoT Edge devices in production is Moby. However, any container engine compatible with the Open Container Initiative, like Docker, is capable of building IoT Edge module images.

## Development tools

Both Visual Studio and Visual Studio Code have add-on extensions to help develop IoT Edge solutions. These extensions provide language-specific templates to help create and deploy new IoT Edge scenarios. The Azure IoT Edge extensions for Visual Studio and Visual Studio Code help you code, build, deploy, and debug your IoT Edge solutions. You can create an entire IoT Edge solution that contains multiple modules, and the extensions automatically update a deployment manifest template with each new module addition. With the extensions, you can also manage your IoT devices from within Visual Studio or Visual Studio Code. Deploy modules to a device, monitor the status, and view messages as they arrive at IoT Hub. Both extensions use the IoT EdgeHub dev tool to enable local running and debugging of modules on your development machine as well.

If you prefer to develop with other editors or from the CLI, the Azure IoT Edge dev tool provides commands so that you can develop and test from the command line. You can create new IoT Edge scenarios, build module images, run modules in a simulator, and monitor messages sent to IoT Hub.

### Visual Studio Code extension

The Azure IoT Edge extension for Visual Studio Code provides IoT Edge module templates built on programming languages including C, C\#, Java, Node.js, and Python. The extension also includes Azure Functions in C\#.

In addition to the IoT Edge extensions, you may find it helpful to install other extensions that support code development. For example, you can use Docker Support for Visual Studio Code to manage your images, containers, and registries. Additionally, all the major supported languages have extensions for Visual Studio Code that can help when you're developing modules.

#### Prerequisites

The module templates for some languages and services have prerequisites that are necessary to build the project folders on your development machine with Visual Studio Code.

:::row:::
  :::column:::
    **Module template**
  :::column-end:::
  :::column:::
    **Prerequisite**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Functions
  :::column-end:::
  :::column:::
    .NET Core 2.1 SDK
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    C
  :::column-end:::
  :::column:::
    Git
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    C\#
  :::column-end:::
  :::column:::
    .NET Core 2.1 SDK
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Java
  :::column-end:::
  :::column:::
    Java SE Development Kit 10
Set the JAVA\_HOME environment variable.
Maven
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Node.js
  :::column-end:::
  :::column:::
    Node.js
Yeoman
Azure IoT Edge Node.js module generator.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Python
  :::column-end:::
  :::column:::
    Python
Pip
Git
  :::column-end:::
:::row-end:::


### Visual Studio 2017/2019 extension

The Azure IoT Edge tools for Visual Studio provide an IoT Edge module template built on C\# and C.

For more information and to download, see the following:

 -  Azure IoT Edge Tools for Visual Studio 2017 https://marketplace.visualstudio.com/items?itemName=vsc-iot.vsiotedgetools
 -  Azure IoT Edge Tools for Visual Studio 2019 https://marketplace.visualstudio.com/items?itemName=vsc-iot.vs16iotedgetools

### IoT Edge dev tool

The Azure IoT Edge dev tool simplifies IoT Edge development with command-line abilities. This tool provides CLI commands to develop, debug, and test modules. The IoT Edge dev tool works with your development system, whether you've manually installed the dependencies on your machine or are using the IoT Edge dev container.

For more information and to get started, see IoT Edge dev tool wiki [https://github.com/Azure/iotedgedev/wiki](https://github.com/Azure/iotedgedev/wiki).

## Testing tools

Several testing tools exist to help you simulate IoT Edge devices or debug modules more efficiently. The following table shows a high-level comparison between the tools, and then individual sections describe each tool more specifically.

Only the IoT Edge runtime is supported for production deployments, but the following tools allow you to simulate or easily create IoT Edge devices for development and testing purposes. These tools aren't mutually exclusive, but can work together for a complete development experience.

:::row:::
  :::column:::
    **Tool**
  :::column-end:::
  :::column:::
    **Also known as**
  :::column-end:::
  :::column:::
    **Supported platforms**
  :::column-end:::
  :::column:::
    **Best for**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT EdgeHub dev tool
  :::column-end:::
  :::column:::
    iotedgehubdev
  :::column-end:::
  :::column:::
    Windows, Linux, macOS
  :::column-end:::
  :::column:::
    Simulating a device to debug modules.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT Edge dev container
  :::column-end:::
  :::column:::
    microsoft/iotedgedev
  :::column-end:::
  :::column:::
    Windows, Linux, macOS
  :::column-end:::
  :::column:::
    Developing without installing dependencies.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT Edge runtime in a container
  :::column-end:::
  :::column:::
    iotedgec
  :::column-end:::
  :::column:::
    Windows, Linux, macOS, Arm
  :::column-end:::
  :::column:::
    Testing on a device that may not support the runtime.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT Edge device container
  :::column-end:::
  :::column:::
    toolboc/azure-iot-edge-device-container
  :::column-end:::
  :::column:::
    Windows, Linux, macOS, Arm
  :::column-end:::
  :::column:::
    Testing a scenario with many IoT Edge devices at scale.
  :::column-end:::
:::row-end:::


### IoT EdgeHub dev tool

The Azure IoT EdgeHub dev tool provides a local development and debug experience. The tool helps start IoT Edge modules without the IoT Edge runtime so that you can create, develop, test, run, and debug IoT Edge modules and solutions locally. You don't have to push images to a container registry and deploy them to a device for testing.

The IoT EdgeHub dev tool was designed to work in tandem with the Visual Studio and Visual Studio Code extensions, and it works with the IoT Edge dev tool. It supports inner loop development and outer loop testing, so it integrates with the DevOps tools.

For more information and to install, see Azure IoT EdgeHub dev tool [https://pypi.org/project/iotedgehubdev/](https://pypi.org/project/iotedgehubdev/).

### IoT Edge dev container

The Azure IoT Edge dev container is a Docker container that has all the dependencies that you need for IoT Edge development. This container makes it easy to get started with whichever language you want to develop in, including C\#, Python, Node.js, and Java. All you need to install is a container engine, like Docker or Moby, to pull the container to your development machine.

For more information, see Azure IoT Edge dev container [https://hub.docker.com/r/microsoft/iotedgedev/](https://hub.docker.com/r/microsoft/iotedgedev/).

### IoT Edge runtime in a container

The IoT Edge runtime in a container provides a complete runtime that takes your device connection string as an environment variable. This container enables you to test IoT Edge modules and scenarios on a system that may not support the runtime natively, like macOS. Any modules that you deploy will be started outside of the runtime container. If you want the runtime and any deployed modules to exist within the same container, consider the IoT Edge device container instead.

For more information, see Running Azure IoT Edge in a container [https://github.com/Azure/iotedgedev/tree/master/docker/runtime](https://github.com/Azure/iotedgedev/tree/master/docker/runtime).

### IoT Edge device container

The IoT Edge device container is a complete IoT Edge device, ready to be launched on any machine with a container engine. The device container includes the IoT Edge runtime and a container engine itself. Each instance of the container is a fully functional self-provisioning IoT Edge device. The device container supports remote debugging of modules, as long as there is a network route to the module. The device container is good for quickly creating large numbers of IoT Edge devices to test at-scale scenarios or Azure Pipelines. It also supports deployment to kubernetes via helm.

For more information, see Azure IoT Edge device container [https://github.com/toolboc/azure-iot-edge-device-container](https://github.com/toolboc/azure-iot-edge-device-container).

## DevOps tools

When you're ready to develop at-scale solutions for extensive production scenarios, take advantage of modern DevOps principles including automation, monitoring, and streamlined software engineering processes. IoT Edge has extensions to support DevOps tools including Azure DevOps, Azure DevOps Projects, and Jenkins. If you want to customize an existing pipeline or use a different DevOps tool like CircleCI or TravisCI, you can do so with the CLI features included in the IoT Edge dev tool.
