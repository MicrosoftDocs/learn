In the evolving landscape of software development, the ability to efficiently edit and debug code is paramount. Visual Studio Code when combined with WSL offers a versatile and powerful environment for developers.

## Install the Python extension

:::image type="content" source="../media/8-install-python-extension.png" alt-text="Screenshot of the prompt to install Python extension in Visual Studio Code.":::

When you open hello.py, you're prompted to install the [Visual Studio Code Python extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python), which enhances the Python coding experience in Visual Studio Code. The Python extension provides advanced editing features like syntax highlighting and intelligent code completion, making coding more efficient and less error prone. The extension also offers debugging tools and simplifies the management of Python environments.  

1. Select **hello.py** in the Explorer pane to open it for editing in Visual Studio Code.

1. When prompted to install the Python extension, select **Install**.

## Debug your code

:::image type="content" source="../media/9-debug-python.png" alt-text="Screenshot of debugging Python code in the Visual Studio Code.":::

1. In hello.py, set a breakpoint on line 1 by left-clicking in the gutter to the left of the line number or pressing by **F9**.

1. To start debugging, press **F5** to run your application. When prompted for a run configuration, choose **Python File**.

    - The application will start and hit the breakpoint. Here, you can inspect variables, create watches, and explore the call stack.

1. Review the output of the `print` statement in the debug console.

## End your WSL session

To disconnect from WSL, from your Command Palette (**Ctrl** + **Shift** + **P**), type *Remote: Close Remote Connection*.

Visual Studio Code disconnects from WSL and reload.

## Other Visual Studio Code WSL extension commands

In this module, we installed WSL with the `wsl --install` command. This command installs Ubuntu as the distro; however, you can install other distros and select which one to connect to in Visual Studio Code.

- From the Command Palette, you can use the `WSL: Connect to WSL using Distro` command and select the distro with which you'd like to work.

To learn about more extension commands, be sure to check out the documentation [Developing in WSL](https://code.visualstudio.com/docs/remote/wsl).
