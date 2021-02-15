You can use any text editor to write Go applications, but when you use an integrated development environment (IDE) such as Visual Studio Code, you can write code faster. Without an IDE, you’d have to write every line from scratch. When you're just beginning, this could help you get familiar with the Go syntax but, in the long term, it might take you longer to write an application. 

For this reason, we recommend that you start by using Visual Studio Code, which is free and open-source and offers a Go extension to help you write code faster.

Using Visual Studio Code and the Go extension gives you numerous benefits. You can:

- Format applications following Go standards.
- Add package references as soon as you add a new line and save your code.
- Remove package references that your application isn't using anymore.
- Debug your applications by setting breakpoints and using watchers at runtime.
- Get suggested completions for code and package references.
- Use hover information to connect to the code documentation.
- Get signature help, such as listing a function's parameters.
- Navigate the project code easily even if you have multiple files.
- Enlist support for testing, such as generating test skeletons for functions.

::: zone pivot="macos"

## Install Visual Studio Code on macOS

**Step 1: Download Visual Studio Code**

On the Visual Studio Code page, select the **Mac** box to download the app. In a few seconds, you’ll be prompted to save the file locally.

**Step 2: Move the app to the Applications folder**

Locate the Visual Studio Code file you’ve just downloaded, and then drag it to the *Applications* folder in Finder.

**Step 3: Start the app from the Applications folder**

From the *Applications* folder, double-click the Visual Studio Code icon to start the app.

> [!NOTE]
> You might see a warning message that Visual Studio Code can't be opened because Apple can't check it for malicious software. If so, do the following:
> * Select **OK** to dismiss the message. 
> * In the *Applications* folder, right-click (or Control-click) the Visual Studio Code file, and then select **Open**.
> 
> If you choose this option, Visual Studio Code should open without any further issues.

Alternatively, you can install Visual Studio Code by using a package manager such as [APT (Advanced Package Tool) or YUM (Yellowdog Updater, Modified)](https://code.visualstudio.com/docs/setup/linux).

::: zone-end

::: zone pivot="linux"

## Install Visual Studio Code on Linux

**Step 1: Download the Visual Studio Code installer**

On the Visual Studio Code page, select the **Linux** box, and then select the **.deb** or **.rpm** option. Your choice depends on whether your Linux distribution uses Debian (DEB)-based or Red Hat Package Manager (RPM)-based package managers. In a few seconds, you’ll be prompted to save the file locally.

**Step 2: Start the Visual Studio Code installer**

Locate and open the file you’ve just downloaded. Follow the instructions to install the app on your workstation.

**Step 3: Start Visual Studio Code**

When the installation is complete, open Visual Studio Code to confirm that it’s working.

::: zone-end

::: zone pivot="windows"

## Install Visual Studio Code on Windows

**Step 1: Download the Visual Studio Code installer**

On the Visual Studio Code page, select the **Windows** box. In a few seconds, you’ll be prompted to save the file locally.

**Step 2: Start the Visual Studio Code installer**

Locate and open the file you’ve just downloaded. Follow the instructions to install the app on your workstation.

**Step 3: Start Visual Studio Code**

When the installation is complete, open Visual Studio Code to confirm that it’s working.
::: zone-end

## Install the Go extension for Visual Studio Code
The Go extension for Visual Studio Code can help you write Go apps more efficiently. You'll see why it’s a good idea to use an IDE for developing Go apps.

**Step 1: Open the Extensions view**

Open Visual Studio Code, and then do either of the following:
* Select **View**, and then select **Extensions**. 
* On the toolbar pane at left, select the **Extensions** icon.

**Step 2: Search for the Go extension**

In the **Search Extensions in Marketplace** box, enter **Go**.

Select the **Go** extension that's published by the “Go Team at Google” (usually the first one in the list). 

The extension details are displayed at the right.

**Step 3: Install the Go extension**

Below the extension description, select the green **Install** button to install it on your workstation. 

When the installation is complete, the button label changes to **Uninstall**, which indicates that the extension has been installed successfully.
