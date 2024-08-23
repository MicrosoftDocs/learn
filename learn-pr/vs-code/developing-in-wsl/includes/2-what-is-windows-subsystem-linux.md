
Windows Subsystem for Linux (WSL) is a feature from Microsoft that allows developers to run a GNU/Linux environment directly on Windows, without the need for a traditional virtual machine (VM) or dual-boot setup. Essentially, WSL provides a layer for running Linux binary executables natively on Windows. 

The primary purpose of WSL is to enable developers who need to run a Linux-based computing environment alongside their Windows applications and tools. It's useful for those developers who code, build, test, or run applications that are designed for Linux systems. 

:::image type="content" source="../media/1-windows-subsystem-linux-intro.png" alt-text="Illustration of a laptop running Windows with the Linux penguin named Tux sitting next to it.":::

## Benefits of using WSL for developers 

WSL brings several benefits to developers:

- **Seamless Integration:** WSL integrates with Windows to provide a near-native Linux experience. This means developers can use Windows apps and Linux tools on the same set of files, enhancing productivity. 

- **Access to Linux Tools:** It opens a whole new world of Linux tools and utilities for Windows users. These tools and utilities are especially beneficial for scripting, programming, and running applications that are more suited to a Linux environment.

- **Resource Efficiency:** Unlike running a full VM, WSL is lightweight and resource-efficient, ensuring that your system's performance remains smooth. 

- **Improved Workflow:** For developers who work on cross-platform applications, WSL simplifies the workflow significantly. There's no need to switch between different systems or manage separate sets of files. 

- **Enhanced Development Environment:** With support for popular programming languages and frameworks, WSL is an excellent environment for development, especially when combined with powerful editors like Visual Studio Code. 

### Brief history and versions of WSL 

:::image type="content" source="../media/2-windows-subsystem-linux-versions.png" alt-text="Illustration of a laptop running with divisions for both Windows and Linux.":::


- **WSL 1:** The first iteration of WSL, introduced in 2016, was groundbreaking in its approach to running Linux binaries on Windows. It translated Linux system calls to Windows system calls in real-time. However, it had some performance limitations, particularly with file system operations. 

- **WSL 2:** This version launched in 2019, WSL 2 represents a significant leap forward. It uses a real Linux kernel through a lightweight VM, which drastically improves performance. This change means better compatibility with Linux applications and more efficient use of system resources. WSL 2 also introduced full system call compatibility, enhancing the range of Linux applications that could run on Windows. 


In summary, WSL evolved into an essential tool for developers who need a Linux environment along with their Windows workflow. Its development from WSL 1 to WSL 2 shows Microsoft's commitment to supporting cross-platform development, making it a versatile choice for modern software development needs. 

Let's now look at how we can set up WSL on our Windows machine. 
