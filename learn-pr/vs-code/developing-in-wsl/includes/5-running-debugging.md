In the evolving landscape of software development, the ability to efficiently edit and debug code is paramount. VS Code when combined with WSL offers a versatile and powerful environment for developers.  

## Installing the Python extension

:::image type="content" source="../media/8-install-python-extension.png" alt-text="Screenshot of the prompt to install Python extension in Visual Studio Code.":::

When you open hello.py, you will be prompted to install the [VS Code Python extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python). It enhances the Python coding experience in VS Code. It provides advanced editing features like syntax highlighting and intelligent code completion, making coding more efficient and less error prone. The extension also offers debugging tools and simplifies the management of Python environments.  

1. Click on hello.py to open it for editing in VS Code. 

2. On the prompt to install the Python extension. Select Install. 

## Debugging your code 

:::image type="content" source="../media/9-debug-python.png" alt-text="Screenshot of debugging Python code in the Visual Studio Code.":::


1. Set a Breakpoint: In hello.py, set a breakpoint on line 1 by clicking in the gutter next to the line number or pressing F9. 

2. Start Debugging: Press F5 to run your application. When prompted for a run configuration, choose Python File. 

    - The application will start and hit the breakpoint. Here, you can inspect variables, create watches, and explore the call stack. 

3. Review the output of the print statement in the debug console. 

## Ending your WSL session 

To disconnect from WSL, from your Command Palette (Ctrl/CMD+Shift+P), type Remote: Close Remote Connection 

VS Code will now disconnect from WSL and reload. 

## Other VS Code WSL extension commands 

In this module, we installed WSL with the `wsl --install` command. This command installs Ubuntu as the distro however you can install other distros and select which one to connect to in VS Code. 

- From the Command Palette, you can use the `WSL: Connect to WSL using Distro` command and select the distro you’d like to work with. 

To learn about more extension commands, be sure to check out the documentation [Developing in the Windows Subsystem for Linux with Visual Studio Code](https://code.visualstudio.com/docs/remote/wsl)