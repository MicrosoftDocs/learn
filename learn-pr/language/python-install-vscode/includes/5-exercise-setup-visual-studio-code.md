You've already seen how you can run Python code line by line by using Python's interactive mode. Interactive mode is useful when you want to experiment with a few lines of code. The downside is that once you leave interactive mode, any code you wrote is gone forever.

As an aspiring Python developer, you'll probably prefer to write a Python *script*.  A script is a text file with a .py file extension that you type all your Python code into. After you save the code in your script file, you use the Python interpreter to open, compile, interpret, and run the code in that file.

## Tools to write Python code

You typically write Python syntax in a text file and save it to your local hard drive. You can write code by using a simple text file editor, like Notepad in Windows. Notepad edits ASCII text, a simple standard text file format.  

You always want to avoid any text editor that includes formatting options, like bold, underline, or italics, or any other program that has word-processing features. So you shouldn't write code in Microsoft Word or TextEdit on macOS. These programs will include additional formatting instructions that the Python compiler won't understand.

Although you can use a text editor, you'll probably want to use a tool that's better suited for the unique challenges of writing code. There are many options, but many developers rely on Visual Studio Code for this purpose. It's free and available on Windows, macOS, and Linux. It has many features that make it easy to navigate code, no matter which programming language you want to work with.

Microsoft also provides the Python extension for Visual Studio Code. This extension provides features like syntax highlighting, code navigation and code formatting support, and more. One feature in particular, named IntelliSense, is invaluable when you're getting started. It provides contextual help as you type. You'll install that in the next unit.

::: zone pivot="windows"

## Install Visual Studio Code on Windows

This section will walk you through downloading the installer from the Visual Studio Code website.

### Step 1 - Download the installer

Go to the [Visual Studio Code download page](https://code.visualstudio.com/Download?azure-portal=true).

The web page displays logos for Windows, Linux, and Mac.

Download the Windows installer. Most browsers give you the option to save the file to your local computer (usually in your Downloads folder) or immediately run the installer file.

### Step 2 - Start the installer

If you downloaded the installer, you might need to open File Explorer and go to your Downloads folder, or wherever your web browser saved the installer file.

Double-click the installer file to start the installation process.

### Step 3 - Start Visual Studio Code

After the installation is done, you can immediately start Visual Studio Code.

::: zone-end

::: zone pivot="linux"

## Install Visual Studio Code on Linux

You can install Visual Studio Code on your Linux computer by downloading the installer from the Visual Studio Code website. You can also install it through your terminal by using a package manager like APT or YUM.

This section will walk you through downloading the installer from the Visual Studio Code website.

For instructions on using a package manager like APT or YUM to install Visual Studio Code from a terminal session, see [Visual Studio Code on Linux](https://code.visualstudio.com/docs/setup/linux?azure-portal=true).

### Step 1 - Download the installer 

Go to the [Visual Studio Code download page](https://code.visualstudio.com/Download?azure-portal=true).

The web page displays logos for Windows, Linux, and Mac.

Under the Linux logo, select either the **.deb** installer (for .deb-based package managers) or the **.rpm** installer (for .rpm-based package managers).

### Step 2 - Start the installer

If you downloaded the installer, you might need to open your file explorer and go to your Downloads folder, or wherever your web browser saved the installer file.

Double-click the installer file to start the installation. On Ubuntu and Fedora, double-clicking the installer opens the Software application. This application provides a convenient way to view details about the application you're about to install. In this case, select the **Install** button.

You might be asked to authenticate by using your account password.

After a moment, Visual Studio Code should be installed.

### Step 3 - Start Visual Studio Code

The instructions for installing Visual Studio Code differ, depending on which desktop environment your distribution of Linux uses. You'll need to search through the list of applications installed on your computer.

For example, if your distribution uses the GNOME desktop, you should be able to locate the Show Applications icon (a grid of dots) docked on the left side of the screen, usually near the bottom. This icon will open a full-screen listing of all applications installed on your system. The Visual Studio Code icon should be included in the list.

Select the Visual Studio Code icon to start the application.

::: zone-end

::: zone pivot="macos"

## Install Visual Studio Code on macOS

This section will walk you through downloading and installing Visual Studio Code.

### Step 1 - Download Visual Studio Code

Go to the [Visual Studio Code download page](https://code.visualstudio.com/Download?azure-portal=true).

The web page displays logos for Windows, Linux, and Mac.

Download the Mac version. Most browsers give you the option to save the file to your local computer (usually in your Downloads folder) or immediately run the file.

You should move the file to the Applications folder before you open it, as described in the next step.

### Step 2 - Move the app from the Downloads folder to the Applications folder

Open Finder. Drag the Visual Studio Code file from the Downloads stack on the Dock to the Applications folder in Finder.

### Step 3 - Start Visual Studio Code from the Applications folder

Double-click the **Visual Studio Code** app from the Applications folder.  

> [!IMPORTANT]
> You might see a warning that Visual Studio Code can't be opened because Apple can't check it for malicious software. If that happens, select **OK** to dismiss the message. Then right-click **Visual Studio Code** in the Applications folder and select **Open menu**. If you select this option, Visual Studio Code should open without any further issues.

::: zone-end
