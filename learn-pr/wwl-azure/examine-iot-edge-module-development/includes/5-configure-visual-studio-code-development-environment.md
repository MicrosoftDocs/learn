Visual Studio Code can be used as the primary tool to develop and debug modules, but there are several other tools that will be used when developing an IoT solution.

There are two ways to debug modules written in C\#, Node.js, or Java in Visual Studio Code: You can either attach a process in a module container or launch the module code in debug mode. To debug modules written in Python or C, you can only attach to a process in Linux amd64 containers.

## Computer and OS configuration requirements

You can use a computer or a virtual machine running Windows, macOS, or Linux as your development machine. On Windows computers, you can develop either Windows or Linux modules.

 -  To develop Windows modules, use a Windows computer running version 1809/build 17763 or newer.
 -  To develop Linux modules, use a Windows computer that meets the requirements for Docker Desktop.
    
     -  Windows 10 64-bit: Pro, Enterprise, or Education (Build 15063 or later).
     -  Hyper-V and Containers Windows features must be enabled. The following hardware prerequisites are required to successfully run Client Hyper-V on Windows 10:
        
         -  64-bit processor with Second Level Address Translation (SLAT).
         -  4 GB system RAM.
         -  BIOS-level hardware virtualization support must be enabled in the BIOS settings.

## Visual Studio Code configuration requirements

Install Visual Studio Code first and then add the following extensions:

 -  Azure IoT Tools.
 -  Docker extension.
 -  Visual Studio extension(s) specific to the language you're developing in:
    
     -  C\#, including Azure Functions: C\# extension.
     -  Python: Python extension.
     -  Java: Java Extension Pack for Visual Studio Code.
     -  C: C/C++ extension.

## Language-specific tools

You'll also need to install some other, language-specific tools to develop your module:

 -  C\#, including Azure Functions: .NET Core 2.1 SDK.
 -  Python: Python and Pip for installing Python packages (typically included with your Python installation).
 -  Node.js: Node.js. You'll also want to install Yeoman and the Azure IoT Edge Node.js Module Generator.
 -  Java: Java SE Development Kit 10 and Maven. You'll need to set the JAVA\_HOME environment variable to point to your JDK installation.

## Container tools

To build and deploy your module image, you need Docker to build the module image and a container registry to hold the module image:

 -  Docker Community Edition on your development machine.
 -  Azure Container Registry or Docker Hub.

> [!TIP]
> You can use a local Docker registry for prototype and testing purposes instead of a cloud registry.

## Debug tools

Unless you're developing your module in C, you also need the Python-based Azure IoT EdgeHub Dev Tool in order to set up your local development environment to debug, run, and test your IoT Edge solution. If you haven't already done so, install Python (2.7/3.6+) and Pip and then install iotedgehubdev by running this command in your terminal.

```cmd
pip install --upgrade iotedgehubdev

```

> [!NOTE]
> If you have multiple Python versions installed, including pre-installed python 2.7 (for example, on Ubuntu or macOS), make sure you are using the correct \`pip\` or \`pip3\` to install \*\*iotedgehubdev\*\*

To test your module on a device, you'll need an active IoT hub with at least one IoT Edge device. To use your computer as an IoT Edge device, follow the steps in the quickstart:

 -  For Linux - Quickstart: Deploy your first IoT Edge module to a virtual Linux device: [https://docs.microsoft.com/azure/iot-edge/quickstart-linux](/azure/iot-edge/quickstart-linux)
 -  For Windows - Quickstart: Deploy your first IoT Edge module to a virtual Windows device: [https://docs.microsoft.com/azure/iot-edge/quickstart](/azure/iot-edge/quickstart).

If you are running IoT Edge daemon on your development machine, you might need to stop EdgeHub and EdgeAgent before you move to next step.
