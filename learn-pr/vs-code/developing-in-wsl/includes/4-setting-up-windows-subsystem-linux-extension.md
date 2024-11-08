The VS Code WSL extension lets you use the Windows Subsystem for Linux (WSL) as your full-time development environment right from VS Code. You get all the productivity of Windows while developing with Linux-based tools, runtimes, and utilities.  

This integration allows developers to utilize the full range of Linux tools and utilities while benefiting from the rich features of VS Code. 

- **Seamless Integration:** While you can edit files in Linux using Windows-based tools, you can’t easily run or debug on Windows: you'd have to install all the same tools on Windows as you did on Linux, defeating the purpose of having an isolated Linux environment.  

- **Unified Development Experience:** With VS Code and the WSL extension combined, VS Code’s UI runs on Windows, and all your commands, extensions, and even the terminal, run on Linux. You get the full VS Code experience, including autocomplete and debugging, powered by the tools and compilers installed on Linux. 

## Installing the VS Code WSL extension

:::image type="content" source="../media/4-windows-subsystem-linux-extension.png" alt-text="Screenshot of the Visual Studio Code Extensions tab with WSL extension showing.":::

In VS Code, go to the Extensions view by clicking on the Extensions icon in the Activity Bar on the side of the window. 

1. Select Extensions from the side bar. 
2. Search for WSL in the Extensions view search bar. 
3. Find the extension published by Microsoft 
4. Click the 'Install' button 

## Connecting to WSL in VS Code 

:::image type="content" source="../media/5-connect-to-windows-subsystem-linux.png" alt-text="Screenshot of the Visual Studio Code WSL connect to WSL command.":::

1. In VS Code, open your Command Palette (Ctrl/CMD+Shift+P) and type in WSL: Connect to WSL 
    - Your VS Code will reload and connect to WSL 
    - Notice the remote indicator on the bottom right corner displays that VS Code is connected to WSL: Ubuntu 

2. Open a new terminal (Ctrl/CMD+`) and notice the path corresponds to a file path in WSL 

:::image type="content" source="../media/6-open-folder-windows-subsystem-linux.png" alt-text="Screenshot of the Visual Studio Code WSL terminal.":::

3. In the terminal type in the command `uname`, the output should be Linux. 

## Opening our Python project from WSL in VS Code 

:::image type="content" source="../media/7-python-in-windows-subsystem-linux.png" alt-text="Screenshot of a Python Project open in Visual Studio Code with WSL.":::

1. Open your Command Palette (Ctrl/CMD+Shift+P) and type in WSL: Open folder in WSL 

2. Select the helloWorld folder, if you don’t see it in the drop-down, you can type in the path /home/your-username/helloWorld/ 

3. Select OK. VS Code will reload and open your folder. 

4. In the Explorer (Ctrl/CMD+Shift+E), verify you see your hello.py file. 
    - Also notice that your terminal (Ctrl/CMD+`) displays that you are in the helloWorld folder. 

We now have our project open and ready to work with. 