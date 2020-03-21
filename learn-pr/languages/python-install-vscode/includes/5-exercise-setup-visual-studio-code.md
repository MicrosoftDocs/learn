You've already seen how you can run Python code line by line by using Python's interactive mode. Interactive mode is useful when you want to experiment with a few lines of code. The downside is that once you leave interactive mode, any code you wrote is gone forever.

As an aspiring Python developer, you'll probably prefer to write a Python *script*.  A script is a text file with a .py file extension that you type all your Python code into. Once you save the code in your script file, you use the Python Interpreter to open, compile, interpret, and execute the code in that file.

## Tools to write Python code

You typically write Python syntax in a text file and save it to your local hard drive.  You can write code using a simple text file editor like Notepad on Windows.  Notepad edits ASCII text, a simple standard text file format.  

You always want to avoid any text editor that includes formatting options, like bold, underline, italics or any other program that has word-processing features.  So, you should not write code in Microsoft Word or TextEdit on macOS because it will include additional formatting instructions that the Python compiler will understand.

While you can use a text editor, you will likely want to use a tool that is better suited for the unique challenges of writing code.  There are many options, but many developers rely on **Visual Studio Code** for this purpose.  It's free and available on Windows, macOS, and Linux.  It has many features that make it easy to navigate code no matter which programming language you want to work with.

Microsoft also provides the **Python extension for Visual Studio Code**, which provides features like syntax highlighting, code navigation and code formatting support, and more.  One feature in particular named Intellisense is invaluable as you're getting started.  It will provide contextual help as you type.  We'll install that in the next unit.

::: zone pivot="windows"

## Install Visual Studio Code on Windows

This module will walk you through downloading the installer from the Visual Studio Code website.

### Step 1 - Download the installer

Open a web browser and navigate to:

[https://code.visualstudio.com/Download](https://code.visualstudio.com/Download?azure-portal=true)

The web page displays logos for Windows, Linux, and Mac.

Download the Windows installer.  Most browsers offer the opportunity to save the file to your local computer (usually in your user's `Downloads` folder) or immediately run the installer file.

### Step 2 - Launch the installer

If you downloaded the installer, you may need to open your file explorer and navigate to your `Downloads` directory, or wherever your web browser saved the installer file.

Double-click the installer file to begin the installation process.

### Step 3 - Launch Visual Studio Code

Once the installation is complete, you can immediately launch Visual Studio Code.

::: zone-end

::: zone pivot="linux"

## Install Visual Studio Code on Linux

You can either install Visual Studio Code on your Linux computer by downloading the installer from the Visual Studio Code website, or through your terminal using a package manager like `apt` or `yum`.

This module will walk you through downloading the installer from the Visual Studio Code website.

For instructions on using a package manager like `apt` or `yum` to install Visual Studio Code from a terminal session, follow the instructions here. 

[https://code.visualstudio.com/docs/setup/linux](https://code.visualstudio.com/docs/setup/linux?azure-portal=true)

### Step 1 - Download the installer using your web browser.

Open a web browser and navigate to:

[https://code.visualstudio.com/Download](https://code.visualstudio.com/Download?azure-portal=true)

The web page displays logos for Windows, Linux, and Mac.

Under the Linux logo, choose either the `.deb` installer (for `.deb` based package managers) or the `.rpm` installer (for `.rpm` based package managers).

### Step 2 - Launch the installer

If you downloaded the installer, you may need to open your file explorer and navigate to your `Downloads` directory, or wherever your web browser saved the installer file.

Double-click the installer file to begin the installation process.  On Ubuntu and Fedora, double-clicking the installer opens the "Software" application, providing a convenient way to view details about the application you're about to install.  In this case, click the `Install` button.

You may be asked to authenticate using your account password.

After a few moments, Visual Studio Code should be installed successfully.

### Step 3 - Launch Visual Studio Code

Depending on which desktop environment your distribution of Linux uses, you'll need to search through the list of applications installed on your computer.

For example, if your distribution is using the GNOME desktop, you should be able to locate the Show Applications icon (a grid of dots) docked to the left, usually near the bottom.  This will open a full-screen listing of all applications installed on your system.  The Visual Studio Code icon should be included in this list.

Click the Visual Studio Code icon to launch the application.

::: zone-end

::: zone pivot="macos"

## Install Visual Studio Code on macOS

This module will walk you through downloading the app from the website and installing Visual Studio Code.

### Step 1 - Download Visual Studio Code using your web browser.

Open a web browser and navigate to:

[https://code.visualstudio.com/Download](https://code.visualstudio.com/Download?azure-portal=true)

The web page displays logos for Windows, Linux, and Mac.

Download the Mac version.  Most browsers offer the opportunity to save the file to your local computer (usually in your user's `Downloads` folder) or immediately execute the file.

You should move the file to the Applications folder before launching it, as described in the next step.

### Step 2 - Move the app from the Downloads folder to the Applications folder.

Open Finder.  Drag the Visual Studio Code file from the Downloads stack on the Dock to the Applications folder in Finder.

### Step 3 - Launch Visual Studio Code from the Applications folder.

Double-click the Visual Studio Code app from the Applications folder.  

> [!IMPORTANT]
> You might see a warning that Visual Studio Code can't be opened because Apple cannot check it for malicious software. If this happens, click "OK" to dismiss that message, then right-click Visual Studio Code in the Applications folder and select the Open menu option from the context menu. Using the "Open" contextual menu option should open Visual Studio Code without any further issues.

::: zone-end