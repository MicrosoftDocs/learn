The ability to use Linux distributions integrated into a device running on Windows creates lots of opportunities to use whatever developer tools, command line utilities, coding languages and frameworks that best suit your needs. However, you will need to keep in mind that you are working between two different file systems and you will achieve better performance by following a few best practices when using WSL as a part of your development environment.

## Basics of a WSL development workflow

To begin, lets look at some of the standard development tools, command line utilities, code languages/frameworks, and practices involved in a WSL development workflow.

### Developer tool recommendations

Your choice of developer tools is highly dependent on what type of work you plan to use them for, but there are a few offered by Microsoft that we recommend for a WSL workflow, especially for those who may just be getting started as a developer, including:

- **Code Editor**: Visual Studio Code with the WSL extension

    VS Code is a free, open source, code editor (sometimes also called an IDE or Integrated Development Environment) with support for debugging, syntax highlighting, intelligent code completion (IntelliSense), built-in Git commands, and an expansive marketplace of extensions that enable you to install additional support tools.

    One of the reasons for recommending VS Code is the WSL extension, which enables VS Code's user interface to run on Windows, but your commands, extensions, debugging, code autocomplete, linting, etc. will all run on Linux. Without this extension, you would run into performance and compatibility issues when working between the Windows and Linux file systems. With the extension, you can run your Linux code projects in a completely encapsulated environment, isolated from Windows, with tools, languages, compilers, and extensions running in your Linux environment where it won't modify or disrupt anything installed in your Windows environment.

    :::image type="content" source="../media/wsl-in-vscode.png" alt-text="Screen capture of project code stored in Ubuntu opened in VS Code with the WSL Extension.":::

- **Command line and utilities**: Windows Terminal with customized Bash + PowerShell

    Windows Terminal is now the default command line host for Windows 11, so any Linux distributions that you install will automatically have a profile created in Windows Terminal that can be customized with whatever sort of colors, text fonts, etc. that you prefer. Bash is the command line interpreter that comes with almost all Linux distributions and can be used with utility tools for things like searching files and directories, displaying system performance information, analyzing available disk space, monitoring your network interface, as well as for automating tasks via scripts. PowerShell serves the same purposes, but for Windows. One of the great things about WSL is that you can mix both Bash and PowerShell commands and scripts together, and with Windows Terminal, you can run multiple Bash and PowerShell command lines at the same time, side-by-side in tabs or window panes.

    :::image type="content" source="../media/wsl-in-terminal.gif" alt-text="Screen capture of Windows Terminal with a PowerShell command line open, then adding a window pane for Ubuntu and Kali Linux.":::

- **Code languages and app frameworks**: Install project code on the Linux file system using a package manager

    On Windows, software has traditionally been installed using executable (.exe) files and using the Settings GUI to manage or remove software (Settings > Apps & Features). On Linux, "package managers" handle the process of installing, upgrading, configuring, and removing software. When working in Linux with WSL, you will want to use a package manager to install code languages and app framework on the Linux file system directory associated with the distribution you are using. The default WSL distribution, Ubuntu, uses the "apt" package manager (short for "Advanced Package Manager"). You should always install the languages/frameworks/tools that you'll be using on the same file system where you will create your project code.
    Tips for working between file systems, best practices for installing tools, and advice on where to store project files for the best performance is all covered in more depth in an accompanying WSL training module.

![WSL workflow diagram showing Ubuntu, VS Code, Remote-WSL extension, and web browser.](../media/wsl-workflow.png)

### A typical development workflow

Once you have installed your tools needed for your WSL development environment, a typical workflow might look like the following:

1. Open Ubuntu (or your preferred Linux distribution) in the default Windows Terminal.

2. Install your code language, framework using the package manager for your distribution. (Something like `sudo apt install <software>`).

3. You may also need to use a command line utility to download software if it's not available from the distribution's package manager. A good utility for this, which comes with many Linux distributions, is cURL (short for Client URL). It can be used for downloading software or any sort of data transfer between the command line and a server that uses URL syntax (such as user authentication, HTTP POST, SSL connections, FTP uploads, etc). It is also commonly used for automated tasks since it is design to work without user interaction.

4. Create a directory to store your app project in your Ubuntu command line (`mkdir app-project`). You can ensure that you're storing your project files on the Linux file system by enter the command `explorer.exe .` to view your directory in Windows File Explorer. The file path should look something like `\\wsl.localhost\Ubuntu\home\<username>\app-project`. Create or download your project code here.

    ![Screenshot of Windows File Explorer with Ubuntu directory open](../media/windows-file-explorer-1.png)

5. Open your project directory in Visual Studio Code using the WSL extension by entering the command: `code .`. This will start the VS Code Remote Server so that even though your project code is running on Linux and VS Code is running on Windows, you will still have access to features like Intellisense code completion, debugging, and linting, powered by the tools and compilers installed on Linux.

6. Once you have made updates to your code, you will also be able to run it in your Linux distribution, but view it using a web browser on Windows with a localhost address (ie. `localhost:3000`), including hot-reload support, so that rather than needing to reload your entire app when you make a change, you can just refresh the files that were changed without losing the state of the app.

## Common scenarios for using a WSL

A few common situations or scenarios where a developer may want to use WSL include:

- A beginner who wants to learn coding on both Windows and Linux environments.
- A professional developer who wants access to Linux and Windows tools.
- Any organization that wants to operationalize a Continuous Integration and Continuous Delivery (CICD) workflow, testing updates on a local machine before deploying code updates to the cloud.
- Anyone who wants to use Docker for creating containers, Git for version control, GPU acceleration for Machine Learning, databases (like MySQL, PostgreSQL, MongoDB, Redis, SQLite), or have access to both Linux GUI apps and Windows at the same time.
- A company that wants to create customized WSL images for distribution to all of their machines so that employees have secure access to both Windows and Linux.

There are also a few limitations to be aware of with WSL, including:

- WSL is designed for development and includes some features that may make it challenging to use in production scenarios.

- WSL uses a lightweight utility VM that starts, stops, and manages resources automatically, so if you are trying to use it as a web server, the VM could shut down to clean up it's resources because it is detecting that no users are active.

- WSL automatically gives file access to Windows files and Windows paths are appended to your path by default, which could cause unexpected behavior for certain Linux applications compared to a traditional Linux environment.

More details on these limitations are covered in the WSL documentation FAQs.

To wrap-up our introduction to WSL, let's try actually using some basic Linux commands!
