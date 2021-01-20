
You decide to automate the post-installation configuration for Windows Server servers being deployed in Contoso. You can use Windows SIM to create answer files that contain the settings you need to complete the configuration of Contoso's Windows Server servers. 

## What are answer files?

Answer files are .xml text files that contain settings that enable you to customize and automate the deployment process of Windows. Although you can use a text editor to create and edit your .xml files, this can be challenging. So, it's usually easier to download and install the [Windows Assessment and Deployment Kit](https://docs.microsoft.com/windows-hardware/get-started/adk-install?azure-portal=true), and then use the Windows SIM tool to create and edit your unattend answer files.  

Answer files are organized into two sections, as described in the following table.

| Section    | Description                                                  |
| ---------- | ------------------------------------------------------------ |
| Components | Contains all the component settings that your answer file applies during setup. This section is further divided into configuration passes, each of which represents a different setup phase. These phases are: windowsPE, offlineServicing, generalize, specialize, auditSystem, auditUser, and oobeSystem. |
| Packages   | Defines the packages that are used to distribute updates and language packs. You use this section to enable or disable selected Windows features. |

> [!TIP]
> When you create your answer file, you can specify to which setup phase to add your settings.

The following graphic displays the default console for an untitled answer file project in Windows SIM.

:::image type="content" source="../media/m3-windows-sim-1.png" alt-text="A screenshot of Windows System Image Manager. An untitled answer file is open. Displayed are details of the Distribution Share,the Windows Image, the Answer File, and both the Properties and Messages panes.":::

> [!IMPORTANT]
> Most settings that are relevant to post-installation configuration reside in the **specialize** installation phase.

## Create and distribute answer files

The first step in creating answer files is to download the Windows ADK and perform a custom installation. When prompted, choose the **Deployment Tools** option (which includes Deployment Image Servicing and Management (DISM) tools, Windows SIM, and related components).

Then, use the following procedure:

1. Open **Windows SIM**. From the menu, select **File** and then select **New Answer File**.

2. In the **Windows System Image Manager** dialog box, select **Yes** when prompted to open a new Windows image now.

3. Browse and locate an image file.

   > [!TIP]
   > You can use the **install.wim** image file from the Windows Server product DVD (located in the \sources folder). Alternatively, you can use a custom image which you have previously created and generalized.

4. Next, if prompted in the **Select an Image** dialog box, choose the image you want to install and select **OK**.

5. In the **Windows System Image Manager** dialog box, select **Yes** to create a catalog file. This file is required.

   > [!NOTE]
   > It takes around five minutes to create the catalog file.

After the catalog file is created, you can begin to configure the answer file. The basic process is as follows:

1. For each element you want to include in the answer file, in the Windows Image pane, locate the element (either in **Components** or **Packages**), right-click or activate the context menu for the element, and then select **Add to Answer File**. This procedure adds the required setting(s) to the answer file pane, from where you can configure that setting to the required value using the **Properties** pane.

2. When all required items are added to the answer file, you should use the **Properties** pane to configure the desired values.

3. Next, you should verify the answer file. On the menu, select **Tools**, and then select **Validate Answer File**. Any problems are displayed in the Messages pane.

4. Then save the file. Select **File**, and then select **Save Answer File**.

5. Select an appropriate location, and then select **Save**.

   > [!TIP]
   > You can save the file with any name, and you can place it in a number of locations. However, if you save the file as **Autounattend.xml** in the root of a removable storage device, setup can find the file without further configuration.

### Typical settings to include

Although there are many settings you can configure in an answer file, only a subset of these deal with post-installation configuration.

:::image type="content" source="../media/m3-windows-sim-2.png" alt-text="A screenshot of Windows System Image Manager. An answer file called Autounattend.xml is being edited. Numerous components are added to the Answer File section. The administrator is editing values in the Properties section.":::

In the **Components** node, some of the more common settings are:

- **Microsoft-Windows-TCPIP**. Configures the TCP/IP networking settings.
- **Microsoft-Windows-DNS-Client**. Contains settings for name resolution using DNS.
- **Microsoft-Windows-UnattendedJoin**. Enables you to add a computer to an AD DS domain.
- **Microsoft-Windows-Shell-Setup**. Provides access to a number of settings, including computer name.

In the **Packages** node, add the **Product** settings to the answer file.

The end result is a simple text file that contains the XML syntax required to customize your Windows Server installation.

:::image type="content" source="../media/m3-windows-sim-3.png" alt-text="A screenshot of a sample XML file in Notepad.":::
