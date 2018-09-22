To use Visual Studio Code for Azure development, you'll need to install Visual Studio Code locally and one or more Azure extensions. In this exercise, we'll add the **Azure App Service** extension.

## Install Visual Studio Code

::: zone pivot="windows"

### Windows

1. [Download the Visual Studio Code installer for Windows](https://code.visualstudio.com/).

1. Run the installer.

1. Open Visual Studio Code by pressing the Windows key or clicking the Windows icon on the task bar, typing "Visual Studio Code" and clicking on the **Visual Studio Code** result.

::: zone-end

::: zone pivot="macos"

### macOS

1. [Download Visual Studio Code for macOS](https://code.visualstudio.com/).

1. Double-click on the downloaded archive to expand the contents.

1. Drag Visual Studio Code.app to the Applications folder.

1. Open Visual Studio Code by clicking on the icon the Apps section or by searching for Visual Studio Code in Spotlight.

::: zone-end

::: zone pivot="linux"

### Linux 

#### Debian and Ubuntu

1. Download and install the [.deb package (64-bit)](https://go.microsoft.com/fwlink/?LinkID=760868) through the graphical software center, if it's available, or through the command line (replacing `<file>` with the .deb filename you downloaded):

    ```bash
    sudo dpkg -i <file>.deb
    sudo apt-get install -f # Install dependencies
    ```

#### RHEL, Fedora, and CentOS

1. Use the following script to install the key and repository:

    ```bash
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    ```

1. Update the package cache, and install the package by using dnf (Fedora 22 and above):

    ```bash
    dnf check-update
    sudo dnf install code
    ```

#### openSUSE and SLE

1. The yum repository also works for openSUSE and SLE based systems. The following script will install the key and repository:

    ```bash
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/zypp/repos.d/vscode.repo'
    ```

1. Update the package cache and install the package by using:

    ```bash
    sudo zypper refresh
    sudo zypper install code
    ```

> [!NOTE]
> For further details about installing or updating Visual Studio Code on various Linux distributions, please see the [Running Visual Studio Code on Linux documentation](https://code.visualstudio.com/docs/setup/linux).

::: zone-end

## Install Azure App Service extension

1. If you haven't already, open Visual Studio Code.

1. Open the Extensions browser; it's accessed via the menu on the left.

1. Search for **Azure App Service**.

1. Select the **Azure App Service** result and click **Install**.

    The following screenshot shows the Azure App Service extension selected from the Visual Studio Code extension search results.

    ![Screenshot of Visual Studio Code showing the Extensions tab with the Azure App Service extension highlighted in the search results.](../media/3-install-azure-extension.png)

This will install the extension. You're now ready to connect to your Azure subscription and deploy a web, mobile, or API app to an Azure App Service.
