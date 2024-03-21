Recall that you're a developer for a company with a popular Windows  accounting application. The usage analytics show an increase in Windows on Arm devices using the application. However, because an Arm build isn't provided, you know the application runs using emulation and could benefit from an Arm-native build for performance reasons.

In practice, Windows apps can be created using various languages, frameworks, and tools, including C/C++ Win32, .NET Framework, MAUI, Java, Python, or Node (among others). All of these frameworks provide Arm-native compilation options and runtimes. However, this exercise focuses on a Windows application written with .NET. From a developer tooling perspective, if you use an Arm-based device, you can take advantage of Arm-native versions of Visual Studio, Visual Studio Code, and the .NET 6 and .NET 7 SDKs.

## Add an Arm build to an existing Windows Application

In this exercise, you add an Arm64 build to an existing Windows application using Visual Studio. The Arm version of Visual Studio isn't required to complete this exercise.

1. Download the project files for this exercise from the [GitHub repository](https://github.com/MicrosoftDocs/mslearn-add-arm64-windows-app/archive/refs/heads/main.zip).

1. Extract the contents of the downloaded zip file to a folder on your computer.

1. Open Visual Studio 2022.

1. Open the **HelloWorldArm.sln** solution file located in the HelloWorldArm folder of the extracted files.

1. Once the project loads, expand the **Build** menu and select **Configuration Manager**.

    :::image type="content" source="../media/vs-2022-build-menu-configuration-manager.png" alt-text="The Visual Studio 2022 Build menu is expanded with the Configuration Manager item selected.":::

1. On the **Configuration Manager** dialog, ensure the **Debug** Active solution configuration and the **ARM64** Active solution platform are selected. In the **Project contexts** section next to the **HelloWorldArm** project, expand the **Platform** drop-down list and select **ARM64**. Also, ensure that the **Build** checkbox is checked.

    :::image type="content" source="../media/vs-2022-configuration-manager-new-platform.png" alt-text="The Visual Studio 2022 Configuration Manager dialog displays with the Debug Active solution configuration selected and the Platform drop-down list expanded with the New item selected.":::

1. Confirm that your selections in the **Configuration Manager** dialog match the following image, then select **Close**.

    :::image type="content" source="../media/vs-2022-configuration-manager-close.png" alt-text="The Visual Studio 2022 Configuration Manager dialog displays with the Close button highlighted.":::

1. In the taskbar, ensure the **Debug** configuration and the **ARM64** platform options are selected.

    :::image type="content" source="../media/vs-2022-debug-arm64.png" alt-text="The Visual Studio 2022 taskbar displays with the Debug configuration and ARM64 platform options selected.":::

1. Expand the **Build** menu and select **Rebuild Solution**.

    :::image type="content" source="../media/vs-2022-rebuild-menu-build-solution.png" alt-text="The Visual Studio 2022 Build menu is expanded with the Rebuild Solution item selected.":::

1. Watch the Build **Output** window for the build progress. Once the build completes, the **Output** window should display the following message:

    ```text
    ========== Rebuild All: 1 succeeded, 0 failed, 0 skipped ==========
    ```

    :::image type="content" source="../media/vs-2022-output-window-build-complete.png" alt-text="The Visual Studio 2022 Build Output window displays with the Rebuild All: 1 succeeded, 0 failed, 0 skipped message.":::

Congratulations! You added an Arm64 build to a Windows application! Let's validate your success by checking the output of the build. To ensure that you successfully added an Arm64 build to the Windows application, perform the following steps:

1. In the **Solution Explorer**, right-click on the project file and select **Open Folder in File Explorer**.

    :::image type="content" source="../media/vs-2022-open-folder-in-file-explorer.png" alt-text="The Visual Studio Solution Explorer displays. The context menu on the project file is expanded with the Open Folder in File Explorer item highlighted.":::

1. In **File Explorer**, navigate into the **bin/ARM64/Debug/net6.0** folder. These files are the production Arm64 build assets for the Windows application, validating that you successfully added an Arm64 build!

    :::image type="content" source="../media/arm64-production-build-files.png" alt-text="File Explorer is open to the file location of the Arm64 build assemblies.":::

1. Keep **File Explorer** open, as you'll need to copy the Arm64 build assets to a Windows on Arm device in the next exercise.

Now that you know how to add an Arm-native build to a Windows application, you can repeat these steps to add an Arm64 build to the company's accounting application. An Arm-native build allows users of Arm-based devices to experience the optimal performance from the accounting application exceeding their current experience of running the x64 version under emulation.

In the next exercise, we'll copy the Arm64 build assets to a Windows on Arm device and run the application.
