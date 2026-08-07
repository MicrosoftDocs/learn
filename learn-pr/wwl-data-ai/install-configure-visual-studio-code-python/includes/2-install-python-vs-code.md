
::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=8737c40c-2359-447e-96e3-8dc510fe56a2]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

To write and run Python programs on your own machine, you need two things: the Python interpreter and a code editor. In this unit, you install both.

## Install Python

Python doesn't come preinstalled on all machines, so the first step is to download it from the official website.

1. Go to [python.org/downloads](https://www.python.org/downloads/).
1. Download the latest stable version for your operating system.
1. Run the installer. On Windows, make sure to check **Add Python to PATH** before clicking **Install Now**.

Once installed, confirm the installation was successful by opening a terminal and running:

```bash
python --version
```

You should see a version number such as `Python 3.12.10`.

> [!NOTE]
> If you're not sure which terminal to use, you can search for "Terminal" in the Start menu on Windows, or use the built-in Terminal app on macOS and Linux.

## Install Visual Studio Code

Visual Studio Code (VS Code) is a free, lightweight code editor from Microsoft that works on Windows, macOS, and Linux. It has excellent Python support through extensions.

1. Go to [code.visualstudio.com](https://code.visualstudio.com/).
1. Download and run the installer for your operating system.
1. Open VS Code after installation completes.

## Install the Python extension

VS Code uses extensions to add language support. The Python extension adds features like syntax highlighting, error detection, and the ability to run Python files directly in the editor.

1. In VS Code, open the **Extensions** panel (Ctrl+Shift+X).
1. Search for **Python** and select the extension published by **Microsoft**.
1. Click **Install**.

Once installed, VS Code can detect your Python installation and provide intelligent code assistance.

::: zone-end
