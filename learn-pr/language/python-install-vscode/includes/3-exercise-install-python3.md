> [!CAUTION]
> This article references CentOS, a Linux distribution that is nearing End Of Life (EOL) status. Please consider your use and plan accordingly. For more information, see the [CentOS End Of Life guidance](/azure/virtual-machines/workloads/centos/centos-end-of-life).

In the previous exercise, you ran a command to determine whether you had Python 3 installed. If you need to install Python 3, choose your operating system at the top of this page, and then follow the instructions below.

Once you're certain that Python 3 is installed, you can scroll to the bottom of this page and select **Continue**.

When this module was written, Python 3.11 was the latest version available, so instructions here refer to that version. Install the latest version of Python that is available for your operating system. If you install a different version, the button labels and the filenames may differ slightly from the installation instructions.

::: zone pivot="windows"

> [!NOTE]
> These instructions are specifically for Windows 10 and Windows 11. For more information about installation instructions on different versions of Windows, see the [official Python downloads page](https://www.python.org/downloads/?azure-portal=true).

## Install Python on Windows from the Microsoft Store

1. Open the Microsoft Store by selecting *Start*, and then typing *start Microsoft Store*.

1. Once open, search for **Python**.

    You'll find a list of various options.

1. Select the most recent version of Python.

    :::image type="content" source="../media/windows-install-python-search.png" alt-text="Screenshot of search results screen from Microsoft Store for Python, highlighting Python 3.11.":::

1. On the Home tab, select *Get or Install*.

    :::image type="content" source="../media/windows-install-python-splash.png" alt-text="Screenshot of the Python Home tab in the Microsoft Store with Install highlighted.":::

    
    > [!NOTE]
    > If you're unable to use the installer because you don't have administrator privileges, download the embeddable package (zip file) of Python from the [Python website](https://www.python.org/getit/), and then extract the zip file to a local folder, such as C:\Python311.

    Python installs in the background. The installation may take a couple of minutes depending on the speed of your system.

    :::image type="content" source="../media/windows-install-python-progress.png" alt-text="Screenshot of installation progress for Python from the Microsoft Store.":::

1. After Python installs, return to the command prompt.

1. Enter the following command `python --version` and then select <kbd>Enter</kbd> to see the version of Python:

    ```console
    python --version
    ```

::: zone-end

::: zone pivot="linux"

## Install Python on Linux

The package manager you use depends on the version of Linux. Most popular Linux distributions include either APT (an acronym for "Advanced Packaging Tool") or YUM (an acronym for "Yellowdog Updater, Modified").

We provide instructions for APT and YUM in this unit. If your distribution of Linux uses a different package manager, you might need to search for **\<your Linux distribution> install python 3**.

### Install by using APT

If you use APT, you can use these instructions to install Python 3.

1. Open a terminal window.

1. Enter the following command to update APT package indexes.

    ```bash
    sudo apt-get update
    ```

    The `apt-get update` command updates the list of packages (the package indexes) from the repositories and Personal Package Archives (PPAs) that it's aware of. This update enables `apt-get` to find the latest versions of the packages that you want to install and their dependencies.

    > [!NOTE]
    > The `sudo` command temporarily elevates your permissions to root, the most powerful level of the system. When you use `sudo`, you'll usually be asked for your user account's password.

    `apt-get update` displays all the items it will update. It might prompt you to approve by entering `y` or `yes`, and then pressing <kbd>Enter</kbd>.

1. Run the following command to install Python 3 at a Bash prompt

    ```bash
    sudo apt-get install python3.10
    ```

    > [!NOTE]
    > `apt-get install` locates the appropriate packages from the package index, downloads the necessary files, and installs the files into the appropriate folders.

1. Run the `python3`command to confirm that Python 3 installed correctly:

    ```bash
    python3.10 --version
    ```

   The output should contain the word `Python` with a set of numbers separated by `.` characters. The following example shows the output you might see.

    ```output
    Python 3.10.0
    ```

    As long as the first number is `3`, Python 3 installed successfully.

    If the installation failed, you might see an error message. Enter the exact error message into browser to find possible causes and solutions.

### Install by using YUM

The YUM package manager is used mainly by Red Hat systems, like Red Hat Enterprise Linux and Fedora, and by CentOS. If APT isn't installed on your system, you can try YUM instead.

1. Open a Terminal window

1. Run `sudo yum update`, to update the YUM package indexes

    ```bash
    sudo yum update
    ```

    `yum update` will make sure all packages and their dependencies are up to date. It's a good idea to update the package list before you install new software.

1. Run the following command `yum install` to install Python 3

    ```bash
    sudo yum install rh-python3.10
    ```

1. Run `python3.10 --version` to verify installation:

    ```bash
    python3.10 --version
    ```

    The output includes the word `Python` with a set of numbers separated by `.` characters, for example:

    ```output
    Python 3.10.0
    ```

    As long as the first number is `3`, Python 3 installed successfully.

    If the installation failed, you might see an error message; step 5 will help your resolve any error message.

#### (Optional) Enable the Software Collections feature in Bash

Software Collections enables you to install multiple versions of the same software components on your Red Hat system. When you run the SCL tool, it creates a child process (subshell) of the current shell. Running the command again then creates a subshell of the subshell. When the Software Collections tool is enabled, you need to specify which version of Python you want to run in the shell.

1. Run the `scl enable` command at a Bash prompt:

    ```bash
    scl enable rh-python3.10 bash
    ```

1. Again, verify that everything is OK by running `python3.10 --version`.

    ```bash
    python3.10 --version
    ```

    The output of that command should resemble the following format:

    ```output
    Python 3.10.0
    ```

    As long as the first number is `3`, Python 3 installed successfully, in the context of a Software Collection.

    `scl enable python36` starts a new Bash session, setting Python 3.6 as the default Python version. But Python 3.6 is the default version only for the current shell session. If you exit the session or open a new session from another terminal, Bash will revert to the default Python version.

    For more information, see
    [Red Hat Software Collections 3.8](https://access.redhat.com/documentation/en-us/red_hat_software_collections/3/html/3.8_release_notes/chap-rhscl#sect-RHSCL-About).

    > [!IMPORTANT]
    > If you needed to use `scl enable` to run `python3.10 --version`, you might need to run that command every time you want to work in Python. There are workarounds, but this is the intended functionality of Software Collections. See [Make a Red Hat Software Collection persist](https://access.redhat.com/solutions/527703?azure-portal=true) for a possible workaround.

::: zone-end

::: zone pivot="macos"

## Install Python on macOS

Follow these steps to download the Python installer from the Python website.

> [!NOTE]
> You can use Homebrew to install Python and Visual Studio Code. For instructions, see
[Homebrew documentation](https://docs.brew.sh/Homebrew-and-Python?azure-portal=true).

1. Download the installer from [Python download page](https://www.python.org/downloads/macos).

    The website should automatically direct you to a page specifically for macOS. Select the latest release.

    You may see a dialog box prompting you to allow downloads from python.org. Select **Allow**.

    After a moment, a file named _python-3.10.2-macos11.pkg_ (or similar) should download to the Downloads stack in your Dock.

1. To start the installer, double-click the _.pkg_ file that you downloaded. The Python installer prompts you to install, verify, and accept various options and license agreements. Take the time to read through these prompts to understand what the installer will do to your computer.

    When the installation process finishes, a Finder window showing the contents of the Python folder and a congratulations screen appear. Select **Close** to close these windows.

    If you're prompted to move the Python installer to the trash, you can do so.

1. Verify installation by running `python3.10 --version` in a terminal window:

    ```bash
    python3.10 --version
    ```

    The output includes the word `Python` with a set of numbers separated by `.` characters, for example:

    ```output
    Python 3.10.0
    ```

    As long as the first number is `3`, Python 3 installed successfully.

::: zone-end

You have now successfully installed Python on your local system.
