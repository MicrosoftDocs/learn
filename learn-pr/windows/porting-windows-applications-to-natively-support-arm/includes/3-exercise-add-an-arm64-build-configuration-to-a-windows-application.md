Recall that you are a developer for a company with a popular Windows Forms accounting application. The usage analytics show an increase in Windows on Arm devices using the application. However, because an Arm build hasn’t been provided, you know the application runs using emulation and could benefit from an Arm-native build for performance reasons.

In practice, Windows apps can be created using various languages, frameworks, and tools, including C/C++ Win32, .NET Framework, MAUI, Java, Python, or Node (among others). All of these frameworks provide Arm-native compilation options and runtimes. However, this exercise will focus on a Windows Forms application written with .NET. From a developer tooling perspective, if you use an Arm-based device, you can take advantage of Arm-native versions of Visual Studio, Visual Studio Code, and the .NET 6 and .NET 7 SDKs.

## Add an Arm build to a Windows Forms application

In this exercise, you’ll add an Arm64 build to a Windows Forms application using Visual Studio. The Arm version of Visual Studio is not required to complete this exercise.

1. Open Visual Studio 2022.

1. In the opening dialog, select the **Create a new project** tile.

    :::image type="content" source="../media/vs-2022-create-new-project.png "Create a new project"" alt-text="The Visual Studio 2022 opening dialog displays with the Create a new project tile highlighted.":::

1. In the **Create a new project** dialog, search for `Windows` and select **Windows Forms App**. Select **Next**.

    :::image type="content" source="../media/vs-2022-create-new-windows-forms-app.png "Create new Windows Forms App"" alt-text="The Create a new project dialog displays with Windows entered as a search criteria and the Windows Forms App item selected from the search results. The Next button is highlighted.":::

1. In the **Configure your new project** dialog, enter a `Project name` and select your desired `Location` for the files. Select **Next**.

    :::image type="content" source="../media/vs-2022-configure-new-project-dialog.png "Project name and Location"" alt-text="The Configure your new project dialog displays with a Project name and Location populated. The Next button is highlighted.":::

1. On the **Additional information** dialog, select **.NET 7.0(Standard Term Support)**. Select **Create**.

    :::image type="content" source="../media/vs-2022-additional-information-dialog.png "Additional information dialog"" alt-text="The Additional information dialog displays with .NET 7 selected as the framework. The Create button is highlighted.":::

1. Once the project has been created, expand the **Build** menu and select **Configuration Manager**.

    :::image type="content" source="../media/vs-2022-build-menu-configuration-manager.png "Open Build Configuration Manager"" alt-text="The Visual Studio 2022 Build menu expands with the Configuration Manager item selected.":::

1. On the **Configuration Manager** window, expand the **Active solution configuration** dropdown and select **New**.

    :::image type="content" source="../media/vs2022-configuration-manager-new-configuration.png "New active solution configuration"" alt-text="The Visual Studio 2022 Configuration Manager window displays with the Active solution configuration menu expanded and the New item highlighted.":::

1. In the **New Solution Configuration** dialog, enter a name for the configuration, in this case `ArmBuild` was entered. For the **Copy settings from** dropdown select the **Release** config. Select **OK**.

    :::image type="content" source="../media/vs-2022-new-solution-configuration.png "New solution configuration"" alt-text="The New Solution Configuration dialog displays with ArmBuild entered for the Name and the Copy settings from value set to Release. The OK button is highlighted.":::

1. Back on the **Configuration Manager** screen, expand the **Platform** dropdown next to the **ArmBuild** configuration and select **New**.

    :::image type="content" source="../media/vs-2022-configuration-manager-new-platform.png "New platform"" alt-text="The Configuration Manager screen displays with the Platform dropdown expanded next to the ArmBuild configuration. The New item is highlighted form the list.":::

1. On the **New Project Platform** dialog, expand the **New platform** dropdown and select the **Arm64** item. For the **Copy settings from** select the **Any CPU** item. Select **OK**.

    :::image type="content" source="../media/vs-2022-new-project-platform.png "New Project Platform"" alt-text="The New Project Platform dialog displays with ARM64 selected from the New platform dropdown and Any CPU chosen in the Copy settings from dropdown. The OK button is highlighted.":::

1. If you are using an x86/x64 device, you may see an error indicating an out-of-process designer for the Arm64 platform is supported only on ARM64 devices. It is safe to dismiss this dialog by selecting **OK**. If you were to use Visual Studio 2022 for Arm on an Arm device, you would not see this message.

    :::image type="content" source="../media/vs-2022-arm64-designer-error.png "Visual Studio Error"" alt-text="A Visual Studio error message displays indicating out-of-process designer support for the ARM64 platform is supported only on ARM64 devices.":::

1. Close the **Configuration Manager** window

    :::image type="content" source="../media/vs-2022-close-configuration-manager.png "Close Configuration Manager window"" alt-text="The Configuration Manager window displays with the Close button highlighted.":::

1. On the toolbar, ensure the **ArmBuild** configuration is chosen with the **ARM64** platform selected.

    :::image type="content" source="../media/vs-2022-armbuild-arm64-toolbar.png "Visual Studio 2022 toolbar"" alt-text="The Visual Studio 2022 toolbar displays with the ArmBuild and ARM64 options highlighted.":::

1. Expand the **Build** menu item and select **Build Solution**.

    :::image type="content" source="../media/vs-2022-build-solution.png "Build Solution"" alt-text="The Visual Studio 2022 Build menu item is expanded with the Build Solution item highlighted.":::

1. Wait until the taskbar indicates the **Build succeeded**, at the lower-left of the screen.

    :::image type="content" source="../media/vs-2022-build-succeeded.png "Build succeeded"" alt-text="The Visual Studio 2022 taskbar displays with the Build succeeded message.":::

Congratulations! You've added an Arm64 build to a Windows Forms application! Let's validate this by checking the output of the build. To ensure that you've successfully added an Arm64 build to the Windows Forms application, perform the following steps:

1. In the **Solution Explorer**, right-click on the project file and select **Open Folder in File Explorer**.

    :::image type="content" source="../media/vs-2022-open-folder-in-file-explorer.png "Open Folder in File Explorer"" alt-text="The Visual Studio Solution Explorer displays with the context menu on the project file expanded with the Open Folder in File Explorer item highlighted.":::

1. In **File Explorer**, navigate into the **bin/ARM64/ArmBuild/net7.0-windows** folder. These are the production Arm64 build assets for the Windows Forms application, and validates that you've successfully added an Arm64 build to the Windows Forms application.

    :::image type="content" source="../media/arm64-production-build-files.png "Arm64 build files"" alt-text="File Explorer is open to the file location of the Arm64 build assemblies.":::

Now that you know how to add an Arm-native build to a Windows Forms application, you can repeat these steps to add an Arm64 build to the company's accounting application. An Arm-native build allows users of Arm-based devices to experience the optimal performance from the accounting application exceeding their current experience of running the x64 version under emulation.

## Next steps

The next step is to verify the build with testing. As there are multiple ways to approach testing, we will leave it to you to determine which path is best for you. It is best to test Arm builds directly on Arm hardware, here are a couple of options that make testing possible. Testing and debugging are available locally if you build the application using Arm-native developer tooling, such as Visual Studio for Arm directly on an Arm device such as the Surface Pro 9 with 5G or Surface Pro X. Another option is to use a virtual machine, such as Microsoft Windows 11 Preview arm64 or the Ampere Altra virtual machine, and leverage the remote debugging feature of Visual Studio 2022.
