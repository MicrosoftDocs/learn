Here you'll install Eclipse and the Azure Toolkit on your development machine. By the end of the exercise, you'll have everything you need to create a Java application connected to Azure.

## Install Eclipse IDE

1. Download the appropriate [Eclipse IDE for your operating system](https://www.eclipse.org/downloads/packages/installer).

1. Start the Eclipse installer once downloaded.

    1. On Windows, double-click the downloaded file.

    1. On macOS and Linux, unzip the installer from the downloaded file and run it.

        > [!NOTE]
        > The installer may prompt you to install the Java Development Kit, if it is missing.

1. Select the packages to install. For Java developers, choose either the Java or Java EE Eclipse IDE option.

1. Select the installation destination on your machine.

1. Launch Eclipse to validate that it installed correctly.

## Install Azure Toolkit for Eclipse

Installing the Azure Toolkit is the same across Windows, macOS, and Linux.

1. Start Eclipse.

1. Go to **Help** > **Install New Software...**.

    The following screenshot shows the menu location of the **Install New Software...** item.

    ![Screenshot of the Install New Software option highlighted within the Help menu of Eclipse.](../media/7-eclipse-install-new-software.png)

1. The **Available Software** dialog will open. In the **Work with:** text box, type `http://dl.microsoft.com/eclipse/` and press Enter.

1. In the results, check the **Azure Toolkit for Java** option. Make sure you uncheck the **Contact all update sites during install to find required software** option, if it isn't already.

    The following screenshot shows the **Available Software** install configuration as described above.

    ![Screenshot of the Available Software window in Eclipse, with boxes highlighting the configuration necessary to find and install the Azure Toolkit for Java.](../media/7-eclipse-download-azure-toolkit-for-java.png)

1. Click **Next**.

1. Review and accept the license agreements when prompted, and click **Finish**.

1. Eclipse will download and install the Azure Toolkit.

1. Restart Eclipse if required.

1. Validate the Azure Toolkit installation by verifying that you can find a **Tools** > **Azure** menu option in Eclipse.
