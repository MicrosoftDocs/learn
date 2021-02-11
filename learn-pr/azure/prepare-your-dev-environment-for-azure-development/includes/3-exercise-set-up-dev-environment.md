::: zone pivot="vscode"

To use Visual Studio Code for Azure development, you'll need to install Visual Studio Code locally and one or more Azure extensions. In this exercise, we'll add the **Azure App Service** extension.

## Install Visual Studio Code

To install Visual Studio Code, use the appropriate steps for your operating system.

### Windows

1. [Download the Visual Studio Code installer for Windows](https://code.visualstudio.com/).

1. Run the installer.

1. Open Visual Studio Code by pressing the Windows key or clicking the Windows icon on the task bar, typing "Visual Studio Code" and clicking on the **Visual Studio Code** result.

### macOS

1. [Download Visual Studio Code for macOS](https://code.visualstudio.com/).

1. Double-click on the downloaded archive to expand the contents.

1. Drag Visual Studio Code.app to the Applications folder.

1. Open Visual Studio Code by clicking on the icon the Apps section or by searching for Visual Studio Code in Spotlight.

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
   sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > etc/yum.repos.d/vscode.repo'
   ```

1. Update the package cache, and install the package by using dnf (Fedora 22 and above):

   ```bash
   dnf check-update
   sudo dnf install code
   ```

#### openSUSE and SLE

1. The yum repository also works for openSUSE and SLE-based systems. The following script will install the key and repository:

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

## Install Azure App Service extension

1. If you haven't already, open Visual Studio Code.

1. Open the Extensions browser; it's accessed via the menu on the left.

1. Search for **Azure App Service**.

1. Select the **Azure App Service** result and click **Install**.

   The following screenshot shows the Azure App Service extension selected from the Visual Studio Code extension search results.

   ![Screenshot of Visual Studio Code showing the Extensions tab with the Azure App Service extension highlighted in the search results.](../media/3-install-azure-extension.png)

Visual Studio Code will install the extension. You're now ready to connect to your Azure subscription and deploy a web, mobile, or API app to an Azure App Service.

::: zone-end

::: zone pivot="vstudio"

Here, you'll install Visual Studio on either your Windows or your macOS development machine.

## Exercise steps

To install Visual Studio, use the appropriate steps for your operating system.

### Windows

1. Download the Visual Studio installer from https://visualstudio.microsoft.com/downloads/.

1. Run the installer.

1. On the **Workloads** tab, select the **Azure development** workload.

   The following screenshot shows the Visual Studio Installer workload selected to allow Azure development within Visual Studio.

   :::image type="content" source="../media/5-select-azure-workload.png" alt-text="Screenshot of the Visual Studio Installer with the Azure development workload highlighted." loc-scope="vs":::

1. (Optional) Install the ASP.NET and web development workload to be ready to create web applications for Azure.

1. Click **Install**, and wait for Visual Studio to install. For systems with Visual Studio already installed, this button may say **Modify**.

1. When the installation is complete, open Visual Studio.

1. Go to the View menu in Visual Studio and make sure you have the **Cloud Explorer** option.

   The following screenshot shows the Cloud Explorer menu option that will be present if you have the Azure development workload installed.

   :::image type="content" source="../media/5-verify-cloud-explorer.png" alt-text="Screenshot of the Visual Studio View menu with the Cloud Explorer menu option highlighted." loc-scope="vs":::

### macOS

1. Go to https://visualstudio.microsoft.com/ and download the Visual Studio for Mac installer.

1. Click the VisualStudioInstaller.dmg file to mount the installer, then run it by double-clicking the logo.

1. Acknowledge the Privacy and License terms when presented.

1. The installer will ask which components you wish to install. Azure components are already part of Visual Studio for Mac, but it is recommended to install the **.NET Core** platform to develop web experiences for Azure.

   The following screenshot shows the .NET Core platform required to add Azure development capabilities to Visual Studio for Mac.

   :::image type="content" source="../media/5-vsmac-install-net-core.png" alt-text="Screenshot of the Visual Studio for Mac installer with the selected .NET Core platform option highlighted." loc-scope="vs":::

1. Click **Install and Update** once you are happy with the selections, and wait for the installer to complete.

1. If you are prompted to elevate the permissions needed, use your administrator credentials to do so.

1. Once the installer is complete, start Visual Studio for Mac.

::: zone-end

::: zone pivot="eclipse"

Here you'll install Eclipse and the Azure Toolkit on your development machine. By the end of the exercise, you'll have everything you need to create a Java application connected to Azure.

## Install Eclipse IDE

1. Download the appropriate [Eclipse IDE for your operating system](https://www.eclipse.org/downloads/packages/installer).

1. Start the Eclipse installer once downloaded.

   * On Windows, double-click the downloaded file.

   * On macOS and Linux, unzip the installer from the downloaded file and run it.

   > [!NOTE]
   > The installer may prompt you to install the Java Development Kit, if it is missing.

1. Select the packages to install. For Java developers, choose either the Java or Java EE Eclipse IDE option.

1. Select the installation destination on your machine.

1. Launch Eclipse to validate that it installed correctly.

## Install Azure Toolkit for Eclipse

Installing the Azure Toolkit is the same across Windows, macOS, and Linux.

1. Start Eclipse and open a workspace.

1. Drag the following button to your running Eclipse workspace to install the Azure Toolkit for Eclipse plugin.

   [![Screenshot of the Eclipse install button.](../media/3-eclipse-install-button.png)](https://marketplace.eclipse.org/marketplace-client-intro?mpc_install=1919278 "Drag to your running Eclipse* workspace. *Requires Eclipse Marketplace Client")

1. The feature confirm dialog will open. Currently we have no optional feature, click **Confirm** to continue.

   :::image type="content" source="../media/7-eclipse-confirm-feature.png" alt-text="Screenshot of the feature confirmation dialog in Eclipse." loc-scope="third-party":::

1. Review and accept the license agreements, and click **Finish**.

1. Eclipse will download and install the Azure Toolkit.

1. Restart Eclipse if necessary.

1. Validate the Azure Toolkit installation by verifying that you can find a **Tools** > **Azure** menu option in Eclipse.

::: zone-end

::: zone pivot="intellij"

Here you'll install IntelliJ IDEA and the Azure Toolkit on your development machine. By the end of the exercise, you'll have everything you need to create a Java application connected to Azure.

## Install IntelliJ IDEA

1. Download the appropriate [IntelliJ IDEA for your operating system](https://www.jetbrains.com/idea/download/).

1. Start the IntelliJ IDEA installer once downloaded.

   * On Windows, double-click the downloaded file.

   * On macOS and Linux, unzip the installer from the downloaded file and run it.

   > [!NOTE]
   > The installer may prompt you to install the Java Development Kit, if it is missing.

1. Select the installation destination on your machine and confirm other settings.

1. Launch IntelliJ IDEA to validate that it installed correctly.

## Install Azure Toolkit for IntelliJ

Installing the Azure Toolkit is the same across Windows, macOS, and Linux.

1. Start IntelliJ IDEA and open a workspace.

1. Go to **Configure** > **Settings**.

1. The **Settings** dialog will open. Select **Plugins** on the left, search `Azure Toolkit for IntelliJ` in plugin marketplace.

   The following screenshot shows the **Plugins** dialog as described above.

   :::image type="content" source="../media/9-intellij-marketplace.png" alt-text="Screenshot of IntelliJ IDEA showing the Settings window with Plugin section selected and search results for Azure Toolkit for IntelliJ." loc-scope="third-party":::

1. Click **OK**, and **Install**.

1. Review and accept the license agreements if prompted.

1. IntelliJ IDEA will download and install the Azure Toolkit.

1. Restart IntelliJ IDEA after the installation.

1. Validate the Azure Toolkit installation by verifying that you can see a **Tools** > **Azure** menu option in IntelliJ IDEA.

::: zone-end
