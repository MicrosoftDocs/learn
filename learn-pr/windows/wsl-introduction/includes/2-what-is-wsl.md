Whether you’re a seasoned developer or a student just beginning to learn code, one of the most important choices you need to make is the type of hardware, environment, and tools to invest in using.

:::image type="content" source="../media/wsl-juggling-tools.png" alt-text="Illustration of a person juggling 7 different software applications.":::

As a developer, you will need to access specific coding tools, languages, and frameworks. You may want to install Python and a web development framework like Django, work with JavaScript on a Node.js backend, or install a cross-platform project that uses React. Generally speaking, these programming languages work on all operating systems. However, there are many scenarios that may favor one operating system over another. Building Windows native desktop apps works best using Windows. Building a web app that will be deployed to a custom Linux server or production-ready Linux virtual machine (VM) works best using a Linux environment. We call this having parity between your local development environment and production deployment environment.

:::image type="content" source="../media/wsl-tools-decision.png" alt-text="Illustration of a screen with multiple types of software applications running and a person making a decision.":::

As the employee of a company, or a student in a school, access to productivity tools is also essential to consider. Throughout the day many of us need to use email and calendar scheduling tools (like Outlook), create Word docs, Excel spreadsheets, and PowerPoint presentations, and then need to jump on an online call or chat (using a tool like Microsoft Teams).

Rather than using separate computers to handle these needs, some developers choose to dual-boot or run virtual machines (VMs). Microsoft now offers a better solution with the Windows Subsystem for Linux (WSL). With WSL, you can run all of your favorite developer tools and productivity tools in one place, running Linux and Windows side-by-side!

## What is WSL?

WSL lets you install and run Linux distributions on Windows. This can be a bit confusing because Linux, like Windows, is also an operating system (OS)... so you're basically running two operating systems, integrated with one another.

## Dual-booting and Virtual Machines

In the past, running both Windows and Linux on one computer required you to install both operating systems separately and use a boot manager to choose which would run your computer during startup. There are some problems with this, like needing to restart your computer every time you want to switch between systems.

Virtual machines (VM) are one way to address the pain of dual-booting two different operating systems. VMs let you run a virtualized instance of Linux on a computer running Windows. But VMs often deliver slower performance due to the amount of resources required to run the virtual instance, as well as a lack of integration between the two operating systems -- you're still running isolated separate operating systems.

WSL addresses these issues by integrating Windows and Linux with a much smaller resource footprint, requiring fewer resources (CPU, memory, storage) compared to traditional virtual machines. Run your favorite Windows office apps, dev tools, games, etc. right alongside your Linux development environment with incredibly fast and efficient performance.

:::image type="content" source="../media/windows-linux.png" alt-text="Illustration of a laptop with puzzle pieces representing Windows and Linux fitting together.":::

## How it works - WSL architecture

WSL was initially launched in August 2016 (Windows 10 version 1607), using what is now referred to as the "WSL 1" architecture. WSL 1 runs as a translation layer, using a Linux kernel interface on top of the Windows kernel. You could think of WSL 1 as a compatibility layer that emulates system calls to run Linux binaries in the Windows environment.

Microsoft announced WSL 2 in May 2019, introducing important changes to the WSL architecture, including a real Linux kernel run through a subset of Hyper-V features. The WSL 2 architecture significantly improved performance, delivering faster system calls, and fewer limitations. WSL 2 is now the default architecture used when installing a Linux distribution on Windows.

:::image type="content" source="../media/wsl1-wsl2.png" alt-text="Screenshot of Ubuntu running on a WSL 1 architecture next to the same instance running on WSL 2.":::

The current WSL architecture uses a custom-built Linux kernel. This custom Linux kernel includes a small initialization script in the startup process that establishes connections between Windows and Linux. The kernel is open-source and users are invited to report bugs or request features.

The WSL architecture lets any Linux distribution run on your Windows computer and supports running GUI apps (not just command-line tools) if you follow [the tutorial in the documentation](/windows/wsl/tutorials/gui-apps) to add the necessary drivers. The WSL architecture also supports systemd, a Linux init system and service manager. These recent updates make WSL even more similar to running Linux distributions on a bare metal computer, without the Windows operating system.

## When to use WSL?

WSL is a versatile tool. It provides a great way to learn how to work with Linux tools, try different Linux distributions, or incorporate both Linux and Windows tools seamlessly into your workflow and development environment. WSL is designed for development and has specific issues to consider if you want to use it for production workloads, but is great for CI/CD pipelines. WSL can also be used in business enterprise settings, with the ability to create and distribute WSL images to computers used in your company, but with some specific security considerations to be aware of. We will cover all of this in future training modules and you can learn more in the documentation links at the end of this module.
