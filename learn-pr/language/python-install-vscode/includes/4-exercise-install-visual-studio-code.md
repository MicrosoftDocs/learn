With Python installed on your system, you can turn your attention to a tool for writing Python code. As mentioned in the introduction to this module, although you can use a plain text editor to create or edit Python applications, a code editor, such as Visual Studio Code, provides a greater level of support.

Let's explore the toolkit available through Visual Studio Code, and how to install it.

## Tools to write Python code

You typically write Python syntax in a text file and save it to your local hard drive.

You can write code by using a simple text file editor, such as Notepad in Windows. Notepad edits ASCII text, a standard text file format.

You want to avoid any text editor that has formatting options, like bold, underline, or italics, or any other program with word-processing features. So you shouldn't write code in Microsoft Word or TextEdit on macOS. These programs incorporate formatting instructions that the Python compiler can't understand.

You'll want to use a tool that's best suited for the unique challenges of writing code. There are plenty of options to choose from, but many developers rely on Visual Studio Code, or VS Code. It's free and available on Windows, macOS, and Linux. It has many features that make it easy to navigate and compile code for all programming languages.

Microsoft provides a Python extension for Visual Studio Code. This extension offers features like syntax highlighting, code navigation, code formatting support, and more. One feature in particular, named IntelliSense, is invaluable when you're getting started. Intellisense provides autocomplete and contextual help as you type. You'll install that in the next unit.

::: zone pivot="windows"

## Install Visual Studio Code on Windows

In this section, you'll learn how to download the Visual Studio Code installer from the Visual Studio Code website.

1. In your browser, navigate to [Visual Studio Code download page](https://code.visualstudio.com/Download?azure-portal=true).

    The web page displays logos for Windows, Linux, and Mac.

1. Select and download the Visual Studio Code installer for Windows. Most browsers give you the option to either save the file to your local computer (usually in your Downloads folder) or immediately run the installer file.

    > [!NOTE]
    > After downloading the installer, you may need to open File Explorer and navigate to the location your web browser installed it. The most common location is the _Downloads_ folder.

1. Double-click the installer file to start the installation process and run through the setup.

    After the installation is complete, Visual Studio Code launches automatically.

::: zone-end

::: zone pivot="linux"

## Install Visual Studio Code on Linux

You can install Visual Studio Code on your Linux computer either by downloading the installer from the Visual Studio Code website or installing it via a terminal session by using package managers like APT or YUM.

This section walks you through downloading the installer from the Visual Studio Code website.

For instructions for using a package manager, such as APT or YUM, to install Visual Studio Code from a terminal session, see [Visual Studio Code on Linux](https://code.visualstudio.com/docs/setup/linux?azure-portal=true).

1. In your browser, navigate to [Visual Studio Code download page](https://code.visualstudio.com/Download?azure-portal=true).

    The web page displays logos for Windows, Linux, and Mac.

1. Under the Linux logo, select either the **.deb** installer (for .deb-based package managers) or the **.rpm** installer (for .rpm-based package managers).

    > [!NOTE]
    > After downloading the installer, you may need to open File Explorer and navigate to the location your web browser installed it. The most common location is the _Downloads_ folder.

1. Double-click the installer file to start the installation. On Ubuntu and Fedora, double-clicking the installer opens the software application. This application provides a convenient way to view details about the application you're about to install. In this case, select **Install**.

    You may be asked to authenticate by using your account password.

    After a moment, Visual Studio Code should be installed.

    > [!NOTE]
    > The instructions for installing Visual Studio Code differ, depending on which desktop environment your distribution of Linux uses. You'll need to search through the list of applications installed on your computer.
    > For example, if your distribution uses the GNOME desktop, you should be able to locate the Show Applications icon (a grid of dots) docked on the left side of the screen, usually near the bottom. This icon opens a full-screen listing of all applications installed on your system. The Visual Studio Code icon should be included in the list.
    
1. Select the Visual Studio Code icon to start the application.

::: zone-end

::: zone pivot="macos"

## Install Visual Studio Code on macOS

This section walks you through downloading and installing Visual Studio Code.

1. In your browser, navigate to [Visual Studio Code download page](https://code.visualstudio.com/Download?azure-portal=true).

    The web page displays logos for Windows, Linux, and Mac.

1. Download the Mac version. Most browsers give you the option to save the file to your local computer (usually in your Downloads folder), or immediately run the file.

    You should move the file to the Applications folder before you open it, as described in the next step.

1. Open Finder. Drag the Visual Studio Code file from the Downloads stack on the Dock to the Applications folder in Finder.

1. Double-click the **Visual Studio Code** app from the Applications folder.  

    > [!IMPORTANT]
    > You may see a warning that Visual Studio Code can't be opened because Apple can't check it for malicious software. If that happens, select **OK** to dismiss the message, and then right-click **Visual Studio Code** in the Applications folder, and select **Open menu**. Visual Studio Code should open without any further issues.

::: zone-end
