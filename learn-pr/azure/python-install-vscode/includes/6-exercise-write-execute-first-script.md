Now that you have Visual Studio Code installed, let's install the Python extension for Visual Studio Code, then write and execute our first Python script.

## Install the Python extension for Visual Studio Code

Visual Studio Code is a great light-weight general purpose code editor.  Extensions provide additional functionality for only those programming languages or features you want to enable.  The Python extension for Visual Studio Code provides visual cues and tools to help you write helps you write better Python code faster.

### Step 1 - Open the Extensions view

You can browse and install extensions from within Visual Studio Code. Bring up the Extensions view by clicking on the Extensions icon in the Activity Bar on the left side of Visual Studio Code or the keyboard shortcut `ctrl` + `shift` + `X`.

This will show you a list of the most popular VS Code extensions on the VS Code Marketplace.

### Step 2 - Search for the Python Extension

In the search bar at the top of the Extensions view, type `python`.

You will see a long list of possible extensions.  Select the extension that is published by Microsoft (usually first in the list).

Selecting an extension from the list will open the details about that extension in a tab in the main area to the right.

::: zone pivot="windows"

### Step 3 - Install the Python Extension

In the main area where you see the details about the Python extension, click the green `Install` button.  

When complete, the button's text will change to `Uninstall`.  This lets you know that you've successfully installed the Python extension.


::: zone-end

::: zone pivot="linux"

### Step 3 - Install the Python Extension

In the main area where you see the details about the Python extension, click the green `Install` button.  

When complete, the button's text will change to `Uninstall`.  This lets you know that you've successfully installed the Python extension.


::: zone-end

::: zone pivot="macos"

### Step 3 - Install the Python Extension

In the main area where you see the details about the Python extension, click the green `Install` button.  

When complete, the button's text will change to `Uninstall`.  This lets you know that you've successfully installed the Python extension.

![Important]
It's possible that once you install the Python extension, you'll see a dialog appear that will ask you whether you want to install the command line developer tools.  You should click the "Install" button.  You will be required to agree to the Command Line Tools License Agreement.  The download and installation process could take as much as 20 minutes or more, depending on the speed of your internet connection.  Once it is complete, you'll see a dialog stating that the software was installed.  You can click the "Done" button to proceed.

::: zone-end


## Write and execute Python code in a script

With the Python extension for Visual Studio Code installed, let's write our first Python script and go through the process of executing it right from within Visual Studio Code.

### Step 4 - Open Visual Studio Code's Explorer and open a new folder

Bring up the Explorer view by clicking on the Explorer icon in the Activity Bar on the left side of Visual Studio Code or the keyboard shortcut `ctrl` + `shift` + `E`.

The Explorer displays two sections: 

- `Open Editors` displaying all of the tabs visible in the main area.
- The name of the current working folder

However, since this is the first time you've open Visual Studio Code, you will see a section called `No Folder Openend` instead.  Below this header, you'll see the message `You have not yet opened a folder` and an `Open Folder` button.

Click the `Open Folder` button to reveal your operating system's Open dialog.

You should create a folder in your system's `Documents` folder called `hello` and select it.

Once you select the new `hello` folder, back in the Explorer view, you should see the title of the section change to `hello`.

### Step 5 - Create a new file

To create a new script file in your `hello` folder, either:

- Hover your mouse cursor over the `hello` section of the Explorer view, then select the `New File` icon, or ...
- Use the keyboard shortcut `ctrl` + `n`
- Select the `File` menu's `New File (Ctrl + N)` option

In the main area, the new file appears.

### Step 6 - Handling the pop-up messages

It's likely that you'll see one or more pop-up messages appear in the lower right-hand corner.

For now, you can safely ignore them and continue to Step 7, below.

Optionally, you can address each one.

#### No python interpreter is selected

The most critical of these messages is the following:

`No Python interpretter is selected.  You need to select a Python interpreter to enable features such as IntelliSense, linting, and debugging.`

If you click the button `Select Python Interpreter`, you will see a list of Python interpreters displayed near the top of Visual Studio Code in the command bar.  Click on the most recent version you have installed, making sure that it is at least version 3.

Your select will be reflected in Visual Studio Code's status bar near the bottom left-hand corner.

#### Change the interpreter

Alternatively, you might see the following message:

`Tip: you can change the Python interpreter used by the Python extension by clicking on the Python version in the status bar`.

This message just alerts you to the fact that you have an interpreter selected, but you can change it if you want by clicking the currently selected interpreter near the bottom left-hand corner, then choosing from the list of Python interpreters displayed near the top of Visual Studio Code in the command bar.

Click the `Got it!` button, or the `x` icon to remove the tip for this session, or the `Do not show again` to permanently disable this tip.

#### Linter pylint is not installed

The third message you might see is:

`Linter pylint is not installed.`  

A **linter** is a useful tool that can check your code for possible bugs and coding style.  By installing a linter, Visual Studio Code will check your code each time you save your code file.  There are several linter tools available for Python.  We'll talk about bugs and coding style in depth in other modules.  

`pylint` is one of the more popular Python linters.  Installing it is optional. If you like, you can (optionally) choose to install pylint by clicking the `Install` button.  Otherwise, use the `x` icon to close the pop-up message.

If you click the `Install` button, Visual Studio Code's terminal window will open below your code file.  A command-line utility named `pip` is used to install `pylint`.

If you get an error that `pip` is not installed, you can use the following APT command in Linux.

```bash
sudo apt-get install python3-pip
```

### Step 7 - Add the following lines of code in the hello.py script file

Place your cursor in the `hello.py` file tab, and add the following code:

```python
print('Hello World!')
```

Save the changes to this file by either:

- Using the `ctrl` + `s` keyboard shortcut
- Using the `File` menu's `Save` option

![Note]
You can see if you have changes that need to be saved in your script file if you see a white dot next to the file name in the tab.  Once you save your changes, the white dot will be replaced by an `x` icon.

Next, you will want to execute the code in your script.  You'll do that using Visual Stuidio Code's terminal.

### Step 8 - Open the terminal

Visual Studio Code includes a built-in terminal so you can conveniently switch between editing your code file, then performing some operation on your code, like compiling and running it.

By default, the terminal will open into the folder you opened in Step 4, above.

To open your code file, use the `ctrl` + ``` `` keyboard shortcut, or select the `View` menu's ``Terminal [Ctrl+`] `` option.

![Note]
You can use the `ctrl` + ``` `` keyboard shortcut to toggle between the last code file you worked in and the terminal window.  This is a useful shortcut to memorize and use frequently.

### Step 8 - Execute your script

To execute your script, you'll use a different command depending on your operating system.

::: zone pivot="windows"

#### Execute a Python script in Windows

Type the following command at the DOS prompt followed by the `Enter` key on your keyboard:

```console
py hello.py
```

![Important]
You will want to memorize this format to execute your Python scripts in Windows: `py [name of your code file]`.  In upcoming modules, we may simply say "execute the code", which implies that we want you to use this command.

::: zone-end

::: zone pivot="linux"

#### Execute a Python script in Linux

```bash
python3 hello.py
```

![Important]
You will want to memorize this format to execute your Python scripts in Linux: `python3 [name of your code file]`.  In upcoming modules, we may simply say "execute the code", which implies that we want you to use this command.

::: zone-end

::: zone pivot="macos"

#### Execute a Python script in macOS

```bash
python3 hello.py
```

![Important]
You will want to memorize this format to execute your Python scripts in macOS: `python3 [name of your code file]`.  In upcoming modules, we may simply say "execute the code", which implies that we want you to use this command.

::: zone-end

If you successfully execute the `hello.py` script, you should see the following output:

```output
Hello World!
```