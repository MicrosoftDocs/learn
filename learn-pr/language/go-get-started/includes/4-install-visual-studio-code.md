You can use any text editor to write Go applications. An integrated development environment (IDE) like Visual Studio Code helps you write code faster. An IDE provides language support, so you don't have to write every line from scratch. When you're learning a programming language, writing line-by-line helps you get familiar with the syntax. In the long term, writing code by hand takes longer to build an application. 

For this reason, we recommend you start by using Visual Studio Code, which is free and open-source. Visual Studio Code offers a Go extension to help you write code fast.

By using Visual Studio Code and the Go extension, you can:

- Format applications following Go standards.
- Add package references as soon as you add a new line and save your code.
- Remove package references that your application isn't using anymore.
- Debug your applications by setting breakpoints and using watchers at runtime.
- Get suggested completions for code and package references.
- Use hover information to connect to the code documentation.
- Get signature help, such as listing a function's parameters.
- Navigate the project code easily even if you have multiple files.
- Enlist support for testing, such as generating test skeletons for functions.

::: zone pivot="linux"

## Install Visual Studio Code on Linux

**Step 1: Download the Visual Studio Code installer**

On the Visual Studio Code page, select the **Linux** box, and then select the **.deb** or **.rpm** option. Your choice depends on whether your Linux distribution uses Debian (DEB)-based or Red Hat Package Manager (RPM)-based package managers. You're prompted to save the file locally.

**Step 2: Start the Visual Studio Code installer**

Locate and open the file you downloaded. Follow the instructions to install the app on your workstation.

- During the installation, if you're provided a choice to add the application to your $PATH system environment variable, select the option.

**Step 3: Start Visual Studio Code**

When the installation is complete, open Visual Studio Code to confirm that it's working.

::: zone-end

::: zone pivot="macos"

## Install Visual Studio Code on macOS

**Step 1: Download Visual Studio Code**

On the Visual Studio Code page, select the **Mac** box to download the app. You're prompted to save the file locally.

**Step 2: Move the app to the Applications folder**

Locate the Visual Studio Code file you downloaded. Move the file to the *Applications* folder in the **Finder**.

**Step 3: Start the app from the Applications folder**

From the *Applications* folder, double-click the Visual Studio Code icon to start the app.

> [!NOTE]
> You might see a warning message that Visual Studio Code can't be opened because Apple can't check it for malicious software. If so, do the following:

> 1. Select **OK** to dismiss the message. 
> 1. In the *Applications* folder, right-click (or Control-click) the Visual Studio Code file, and then select **Open**.
>
> If you choose this option, Visual Studio Code should open without any further issues.

You can install Visual Studio Code by using a package manager like [APT (Advanced Package Tool) or YUM (Yellowdog Updater, Modified)][APTYum].

- During the installation, if you're provided a choice to add the application to your $PATH system environment variable, select the option.

::: zone-end

::: zone pivot="windows"

## Install Visual Studio Code on Windows

**Step 1: Download the Visual Studio Code installer**

On the Visual Studio Code page, select the **Windows** box. You're prompted to save the file locally.

**Step 2: Start the Visual Studio Code installer**

Locate and open the file you downloaded. Follow the instructions to install the app on your workstation.

- During the installation, if you're provided a choice to add the application to your $PATH system environment variable, select the option.

**Step 3: Start Visual Studio Code**

When the installation is complete, open Visual Studio Code to confirm that it's working.
::: zone-end

## Install the Go extension for Visual Studio Code

The Go extension for Visual Studio Code helps you write apps more efficiently. In the module exercises, you'll learn some benefits of using an IDE to write Go code.

**Step 1: Open the Extensions view**

Open Visual Studio Code, and then open the **Extensions** view. There are two ways you can open the view:

- Select **View**, and then select **Extensions**. 
- On the left toolbar, select the **Extensions** icon.

**Step 2: Search for the Go extension**

In the **Search Extensions in Marketplace** box, enter **Go**.

Select the **Go** extension that's published by the "Go Team at Google" (usually the first one in the list). 

The extension details are displayed at the right.

**Step 3: Install the Go extension**

Below the extension description, select the **Install** button to install it on your workstation. 

When the installation is complete, the button label changes to **Uninstall**, which indicates that the extension has been installed successfully.

<!-- Links -->
[APTYUM]: https://code.visualstudio.com/docs/setup/linux?azure-portal=true
