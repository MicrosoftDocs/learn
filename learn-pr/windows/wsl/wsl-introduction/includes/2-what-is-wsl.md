Whether you’re a seasoned developer or a student just beginning to learn code, one of the most important choices you need to make is the type of hardware, environment, and tools to invest in using.

As a developer, you will need to access specific coding tools, languages, and frameworks. You may want to install Python and a web development framework like Django, work with JavaScript on a NodeJS backend, or install a cross-platform project that uses React. Generally speaking, these programming languages will work on all operating systems. However, there are many scenarios that may prefer one operating system to another. Building Windows native desktop apps works best using Windows, but building a web app that will be deployed to a custom Linux server or production-ready virtual machine (VM) may be best to build and test using Linux and Bash command line tools.

As the employee of a company, or a student in a school, access to productivity tools is also essential to consider. Throughout the day many of us need to use email and calendar scheduling tools (like Outlook), create Word docs, Excel spreadsheets, and PowerPoint presentations, and then need to jump on an online call or chat (using a tool like Microsoft Teams).

Rather than using separate machines to handle these needs, some developers choose to dual-boot or run virtual machines (VMs). Microsoft now offers a better solution with the Windows Subsystem for Linux (WSL).

## What is WSL?

WSL lets you install and run Linux distributions on Windows. This can be a bit confusing because Linux, like Windows, is also an operating system (OS)... so you're basically running two operating systems, integrated with one another.

## Dual-booting and Virtual Machines

In the past, running both Windows and Linux on one machine required you to install both operating systems separately and use a boot manager to choose which would run your computer during startup. There are some problems with this, like needing to restart your machine every time you wanted to switch between systems.

Virtual Machines (VM) are one way to address the pains of dual-booting two different operating systems. VMs enable you to run a virtualized instance of Linux on a device running Windows. The problem with VMs often relates to slower performance due to the amount of resources that need to be allocated to running the virtual instance, as well as a lack of integration between the two operating systems -- you're still running isolated separate systems.

WSL addresses these issues by integrating Windows and Linux with a much smaller resource footprint, requiring fewer resources (CPU, memory, storage) compared to traditional Virtual Machines.

## How WSL works - WSL 1 and WSL 2 architecture

When WSL was initially launched in August 2016 (Windows 10 version 1607), using what is now referred to as the "WSL 1" architecture. WSL 1 runs as a translation layer, using a Linux kernel interface on top of the Windows kernel. Basically a compatibility layer that handles system call emulation for running Linux binaries in the Windows environment.

In May 2019, WSL 2 was announced, introducing important changes to the WSL architecture, such as using a real Linux kernel run through a subset of Hyper-V features. The WSL 2 architecture significantly improved performance speed, enabling a more immediate reaction to system calls, with fewer limitations, and now included by default in Windows installations.

The first version of the WSL architecture, WSL 1, has been maintained because it works better for a few very specific use-cases, such as instances where files for a Linux project must be stored in the Windows file system or projects that require cross-compilation using both Windows and Linux tools on the same files. These instances are minimal, however, and the development team is working to improve version 2 of the architecture so that version 1 support can be concluded.

WSL 2 is the recommended architecture for the majority of use-cases and is the default setting when installing a Linux distribution with WSL. WSL does enable you to switch between the version 1 and version 2 architecture as needed.

## When to use WSL?

WSL is a versatile tool. It provides a great way to learn how to work with Linux tools, try different Linux distributions, or incorporate both Linux and Windows tools seamlessly into your professional workflow and development environment. WSL is designed for development and has specific issues to consider if you want to use it for production workloads, but is great for CI/CD pipelines. WSL can also be used in business enterprise settings, with the ability to create and distribute WSL images to machines used in your company, but with some specific security considerations to be aware of. We will cover this in future training modules and you can learn more in the documentation links at the end of this module.
