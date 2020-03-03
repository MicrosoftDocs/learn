Now that you have Visual Studio Code installed, let's install the Python extension for Visual Studio Code and optionally setup other tools and settings.

## Install the Python extension for Visual Studio Code

Visual Studio Code is a great light-weight general purpose code editor.  Extensions provide additional functionality for only those programming languages or features you want to enable.  The Python extension for Visual Studio Code provides visual cues and tools to help you write helps you write better Python code faster.

### Step 1 - Open the Extensions view

You can browse and install extensions from within Visual Studio Code. 

Bring up the Extensions view.  Go to **View** and select  **Extensions**, or click **Extensions** in the Activity Bar on the left side of Visual Studio Code.

The Extensions view will display a list of the most popular Visual Studio Code extensions on the Visual Studio Code Marketplace.

### Step 2 - Search for the Python Extension

To filter the list of extensions, type `python` in the search bar at the top of the Extensions view,

Select the extension that is published by Microsoft (usually first in the list).  This will display the details about that extension in a tab in the main area to the right.

::: zone pivot="windows"

### Step 3 - Install the Python Extension

In the main area where you see the details about the Python extension, select **Install**.

When complete, the button's text will change to **Uninstall**.  This lets you know that you've successfully installed the Python extension.

::: zone-end

::: zone pivot="linux"

### Step 3 - Install the Python Extension

In the main area where you see the details about the Python extension, select **Install**.

When complete, the button's text will change to **Uninstall**.  This lets you know that you've successfully installed the Python extension.

::: zone-end

::: zone pivot="macos"

### Step 3 - Install the Python Extension

In the main area where you see the details about the Python extension, select **Install**.

When complete, the button's text will change to **Uninstall**.  This lets you know that you've successfully installed the Python extension.

> [!IMPORTANT]
> It's possible that once you install the Python extension, you'll see a dialog appear that will ask you whether you want to install the command line developer tools.  You should select **Install**.  You will be required to agree to the Command Line Tools License Agreement.  The installation process could take as much as 20 minutes or more, depending on the speed of your internet connection.  Once complete, you'll see a dialog stating that the software was installed.  You can select **Done** to proceed.

::: zone-end

## Install pylint

pylint is one of the more popular Python linters.  A *linter* is a useful tool that can check your code for possible bugs and coding style.  By installing a linter, Visual Studio Code will check your code each time you save your code file.  There are several linter tools available for Python.

The Python extension for Visual Studio Code will recommend you install pylint and will handle most of the details required for installation.

To initiate installation, you'll create a new file with a .py file extension which will trigger a pop up message with an easy install button.  We'll begin that process in the next step.

> [!NOTE]
> In this module, we'll merely create a file as a means of triggering the Python extension for Visual Studio Code to display a pop up message to initiate the installation of pylint.  We will not use the file in this module, but will learn how to write and execute a code file in the next module titled "Create your First Python Program".

### Step 4 - Open the Explorer view in Visual Studio Code

Bring up the Explorer view.  Go to **View**, and select **Explorer**, or click the Explorer icon in the Activity Bar on the left side of Visual Studio Code.

The Explorer displays two sections: 

- `Open Editors` displaying all of the tabs visible in the main area.
- The name of the current working folder

However, since this is the first time you've open Visual Studio Code, you will see a section titled "No Folder Openend" instead.  Below this header, you'll see the message "You have not yet opened a folder" and an **Open Folder** button.

### Step 5 - Create a new Working folder

Click the **Open Folder** button to reveal your operating system's Open dialog.

You should create a folder in your system's Documents folder called **hello** and select it.

Once you select the new **hello** folder, back in the Explorer view, you should see the title of the section change to "hello".

### Step 6 - Create a new file

To create a new script file in your **hello** folder, go to **File**, and select **New File**.

In the main area, the new file appears.

It's likely that you'll see one or more pop-up messages appear in the lower right-hand corner of Visual Studio Code.

### Step 7 - Initiate the pylint installation from the pop up

In this step, we'll focus on the pop up with the message "Linter pylint is not installed".

> [!NOTE]
> Installing pylint is optional.  If you have a specific reason to not install it, use the `x` icon to close the pop-up message.

To install pylint click **Install**.  Visual Studio Code's terminal window will open below your code file.  A command-line utility named **pip** is used to install pylint.

::: zone pivot="linux"

> [!IMPORTANT]
> If you get an error that pip is not installed, you can use the following `apt` command in Linux to install pip.

```bash
sudo apt-get install python3-pip
```
It's possible that running this command will require certain services be restarted.  We suggest you read the prompts and messages from your system and respond accordingly.

After installing pip, you can manually attempt to install pylint using pip with the following command in Linux.

```bash
sudo pip3 install pylint
```

::: zone-end


## Step 8 - Address other pop up messages

You may see other pop up messages appear.

The most critical of these messages is: "No Python interpretter is selected.  You need to select a Python interpreter to enable features such as IntelliSense, linting, and debugging."

If you click **Select Python Interpreter**, you will see a list of Python interpreters displayed near the top of Visual Studio Code in the command bar.  Click on the most recent version you have installed, making sure that it is at least version 3.

Your select will be reflected in Visual Studio Code's status bar near the bottom left-hand corner.

Alternatively, you might see the following message: "Tip: you can change the Python interpreter used by the Python extension by clicking on the Python version in the status bar".

This message just alerts you to the fact that you have an interpreter selected, but you can change it if you want by clicking the currently selected interpreter near the bottom left-hand corner, then choosing from the list of Python interpreters displayed near the top of Visual Studio Code in the command bar.

Click **Got it!** to dismiss, or **Do not show again** to permanently disable this tip.

Once you've addressed all of the pop up messages, you've successfully set up the Python extension for Visual Studio Code and are ready to begin writing Python code!