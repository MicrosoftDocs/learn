The Visual Studio Code WSL extension lets you use the Windows Subsystem for Linux (WSL) as your full-time development environment right from Visual Studio Code. You get all the productivity of Windows while developing with Linux-based tools, runtimes, and utilities.

This integration allows developers to utilize the full range of Linux tools and utilities while benefiting from the rich features of Visual Studio Code.

- **Seamless Integration**: While you can edit files in Linux using Windows-based tools, you can’t easily run or debug on Windows; you'd have to install all the same tools on Windows as you did on Linux, defeating the purpose of having an isolated Linux environment.  

- **Unified Development Experience**: With Visual Studio Code and the WSL extension combined, Visual Studio Code’s UI runs on Windows, and all your commands, extensions, and even the terminal run on Linux. You get the full Visual Studio Code experience, including autocomplete and debugging, powered by the tools and compilers installed on Linux.

## Install the Visual Studio Code WSL extension

:::image type="content" source="../media/4-windows-subsystem-linux-extension.png" alt-text="Screenshot of the Visual Studio Code Extensions tab with WSL extension showing.":::

In Visual Studio Code, go to the Extensions view by selecting the **Extensions** icon in the Activity Bar on the left side of the window.

1. Select **Extensions** from the sidebar.
2. Search for *WSL* in the Extensions view search bar.
3. Find the extension published by Microsoft.
4. Select the **Install** button.

## Connect to WSL in Visual Studio Code

:::image type="content" source="../media/5-connect-to-windows-subsystem-linux.png" alt-text="Screenshot of the Visual Studio Code WSL connect to WSL command.":::

1. In Visual Studio Code, open your Command Palette (**Ctrl** + **Shift** + **P**) and type *WSL: Connect to WSL*.
    - Your Visual Studio Code will reload and connect to WSL.
    - Notice the remote indicator on the bottom right corner displays that Visual Studio Code is connected to **WSL: Ubuntu**.

    > [!NOTE]
    > If you experience an error connecting to WSL, try opening the Command Palette and typing *WSL: Connect to WSL using Distro*, then selecting **Ubuntu**.

1. Open a new terminal (**Ctrl** + **`**) and notice the path corresponds to a file path in WSL.

:::image type="content" source="../media/6-open-folder-windows-subsystem-linux.png" alt-text="Screenshot of the Visual Studio Code WSL terminal.":::

1. In the terminal, type `uname` and press **Enter**; the output should be **Linux**.

## Open your Python project from WSL in Visual Studio Code

:::image type="content" source="../media/7-python-in-windows-subsystem-linux.png" alt-text="Screenshot of a Python Project open in Visual Studio Code with WSL.":::

1. Open your Command Palette (**Ctrl** + **Shift** + **P**) and type *WSL: Open folder in WSL*.

1. Select the helloWorld folder. If you don’t see it in the drop-down, you can type the path */home/your-username/helloWorld/*.

1. Select **OK**. Visual Studio Code will reload and open your folder.

1. In the Explorer (**Ctrl** + **Shift** + **E**), verify you see your *hello.py* file.
    - Also notice that your terminal (**Ctrl** + **`**) displays that you're in the *helloWorld* folder.

We now have our project open and ready to work with.
