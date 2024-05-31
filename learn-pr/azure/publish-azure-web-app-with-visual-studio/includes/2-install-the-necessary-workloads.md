The first step in getting your new site ready is to prepare your development environment. Creating and deploying ASP.NET Core web applications requires that you have the necessary tools installed on your local machine. Here, we'll cover the development tools you need and how to install them. 

## Configure your Development environment

We'll need to install a few more tools within Visual Studio to build, debug, and deploy ASP.NET Core web applications to Azure. To install these tools, we'll install two Visual Studio *workloads*.

### What are Visual Studio workloads?

A *workload* is a preconfigured bundle of tools within Visual Studio. These bundles are grouped to allow developers to build certain types of applications, use certain development languages, or develop for specific platforms.

For example, the *Desktop development with C++* workload includes Visual Studio features that let you run and debug C++ console applications. The *Mobile development with .NET* workload installs all of the tools you need to create mobile applications with .NET.

### Visual Studio workloads for ASP.NET Core development and publishing

Visual Studio 2022 has two workloads that you need to create, publish, and deploy your website to Azure. These workloads include the templates for your ASP.NET Core site, and let you connect and deploy your site to Azure.

With Visual Studio 2022 installed, you need to make sure you have the following Visual Studio workloads installed:

- **ASP.NET and web development**: The web development workload in Visual Studio is designed to maximize your productivity in developing web applications using ASP.NET and standards-based technologies like HTML and JavaScript.

- **Azure development**: The Azure development workload in Visual Studio installs the latest Azure SDK for .NET and tools for Visual Studio. Once you've installed these items, you can create resources using Azure Resource Manager tools, build applications for Azure web and Cloud Services, and perform big-data operations using Azure Data Lake tools.

## Installing Visual Studio workloads

You can use the Visual Studio Installer to modify the components installed as part of Visual Studio including workloads.

1. To launch the Installer, from your Windows Start menu, scroll down to **V**, and then select **Visual Studio Installer**. Alternatively, while the Start menu is open, you can just type `Visual Studio Installer` to find the Installer link, then select **Enter.**

1. The Visual Studio Installer window appears. Select the **Modify** button.

1. Ensure the **ASP.NET and web development** and **Azure development** workloads are selected under the **Web & Cloud** section in the **Workloads** tab.

1. Next, select the **Modify** button on the bottom right of the Installer. The Visual Studio Installer downloads and installs the necessary components.

1. When the install completes, select **Launch** to open Visual Studio.

Workloads are added to your local Visual Studio installation, and you only need to install them once. You can launch the Visual Studio Installer in the future to add more workloads, customize installed workloads, or remove workloads.

To complete the exercises in this module, you'll need the **ASP.NET and web development** and **Azure development** workloads installed. If you haven't already, install these workloads before moving on to the next exercise.
