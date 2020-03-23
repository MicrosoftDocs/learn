Now that you have Visual Studio Code installed, you'll install the Python extension for Visual Studio Code and, optionally, set up other tools and settings.

## Install the Python extension for Visual Studio Code

Visual Studio Code is a great lightweight general-purpose code editor.  Extensions provide additional functionality for only the programming languages or features that you want to enable. The Python extension for Visual Studio Code provides visual cues and tools to help you write better Python code, and to write code faster.

### Step 1 - Open Extensions view

You can browse through extenstions and install them from within Visual Studio Code. 

Bring up the Extensions view. Go to **View** and select **Extensions**, or select the **Extensions** icon in the Activity Bar on the left side of Visual Studio Code.

Extensions view will display a list of the Visual Studio Code extensions that are the most popular on the Visual Studio Code Marketplace.

### Step 2 - Search for the Python extension

To filter the list of extensions, enter **python** in the search box at the top of the Extensions view.

Select the extension that's published by Microsoft (usually the first one in the list). The details about that extension will appear in a tab in the main area to the right.

::: zone pivot="windows"

### Step 3 - Install the Python extension

In the main area, where you see the details about the Python extension, select **Install**.

When the installation is complete, the button's text will change to **Uninstall**. This lets you know that you've successfully installed the Python extension.

::: zone-end

::: zone pivot="linux"

### Step 3 - Install the Python extension

In the main area, where you see the details about the Python extension, select **Install**.

When the installation is complete, the button's text will change to **Uninstall**. This lets you know that you've successfully installed the Python extension.

::: zone-end

::: zone pivot="macos"

### Step 3 - Install the Python extension

In the main area, where you see the details about the Python extension, select **Install**.

When the installation is complete, the button's text will change to **Uninstall**.  This lets you know that you've successfully installed the Python extension.

> [!IMPORTANT]
> After you install the Python extension, you might see a dialog box that asks you whether you want to install the command-line developer tools. You should select **Install**. You'll need to agree to the Command Line Tools License Agreement. The installation process could take as long as 20 minutes or more, depending on your internet connection. After the installation is done, you'll see a dialog box stating that the software is installed. You can select **Done** to proceed.

::: zone-end

## Install Pylint

Pylint is one of the more popular Python linters. A *linter* is a useful tool that can check your code for possible bugs and coding style. If you install a linter, Visual Studio Code will check your code each time you save your code file. There are several linter tools available for Python.

The Python extension for Visual Studio Code will recommend that you install Pylint and will handle most of the installation details.

To start installation, you'll create a file with a .py file extension, which will trigger a pop-up window with an install button. We'll begin that process in the next step.

> [!NOTE]
> In this module, we'll just create a file as a way to trigger the Python extension for Visual Studio Code to display a pop-up window to start the installation of Pylint. We won't use the file in this module, but you'll learn to write and run a code file in the next module, titled "Create your first Python program."

### Step 1 - Open Explorer view in Visual Studio Code

Open Explorer view. Go to **View** and select **Explorer**, or select the **Explorer** icon in the Activity Bar on the left side of Visual Studio Code.

There are two sections in Explorer: 

- **Open Editors**, which displays all the tabs visible in the main area
- The name of the current working folder

But because this is the first time you've opened Visual Studio Code, you'll see a section titled **No Folder Opened** instead. Below this header, you'll see the message "You have not yet opened a folder" and an **Open Folder** button.

### Step 2 - Create a working folder

Select **Open Folder** to open your operating system's Open dialog box.

Create a folder in your system's Documents folder called **hello**. Select it.

After you select the new **hello** folder, back in Explorer view, you should see the title of the section change to **hello**.

### Step 3 - Create a file

To create a script file in your **hello** folder, go to **File**, and select **New File**.

In the main area, the new file appears.

You'll probably see one or more pop-up messages appear in the lower right corner of Visual Studio Code.

### Step 4 - Start Pylint installation from the pop-up window

In this step, we'll focus on the pop-up window with the message "Linter pylint is not installed."

> [!NOTE]
> Installation of Pylint is optional. If for some reason you don't want to install it, select the **x** to close the pop-up message.

To install Pylint, select **Install**. The Visual Studio Code terminal window will open below your code file. You can use a command-line tool named pip to install Pylint.

::: zone pivot="linux"

> [!IMPORTANT]
> If you see an error message stating that pip isn't installed, you can use this APT command in Linux to install pip:
>
> ```bash
> sudo apt-get install python3-pip
> ```
> If you run this command, some services might need to be restarted. We suggest you read the prompts and messages from your system and respond accordingly.
>
> After you install pip, you can use the following command in Linux to try to install Pylint manually by using pip:
>
> ```bash
> sudo pip3 install pylint
> ```

::: zone-end


### Step 5 - Address other pop-up messages

You might see other pop-up messages.

The most critical of these messages is this one: 

"No Python interpreter is selected.  You need to select a Python interpreter to enable features such as IntelliSense, linting, and debugging."

If you click **Select Python Interpreter**, you'll see a list of Python interpreters near the top of Visual Studio Code, in the command bar.  Select the most recent version that you have installed, making sure that it's version 3 or later.

Your selection will be reflected in the Visual Studio Code status bar, near the bottom left corner.

Alternatively, you might see this message: 

"Tip: you can change the Python interpreter used by the Python extension by clicking on the Python version in the status bar".

This message just lets you know that you have an interpreter selected, but you can change it if you want. You can change it by clicking the currently selected interpreter near the bottom left corner and then choosing from the list of Python interpreters displayed near the top of Visual Studio Code in the command bar.

Select **Got it!** to dismiss the tip, or select **Do not show again** to permanently disable it.

After you've addressed all the pop-up messages, you've successfully set up the Python extension for Visual Studio Code and are ready to begin writing Python code!