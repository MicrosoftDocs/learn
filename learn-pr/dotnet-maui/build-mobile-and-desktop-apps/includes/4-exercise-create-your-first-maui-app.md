In this exercise, you'll start to build the .NET MAUI app for the grocery store chain. You'll use the template to generate the default app and run it on Windows and in the Android emulator. You'll modify this app in a later exercise to customize the user interface and add the functionality required by the grocery store chain app.

## Create a new project

1. Open Visual Studio and create a new solution. This action opens the New Project wizard in Visual Studio.

1. Select the **MAUI** app type, select the **.NET MAUI App template**, and then tap **Next**

    :::image type="content" source="../media/4-create-maui-app .png" alt-text="The Create a new project dialog box. The user has selected the .NET MAUI App template.":::

1. On the **Configure your new project** page, name the project **Phoneword**, and save it in a location of your choice. Tap **Create** to create the app.

    :::image type="content" source="../media/4-configure-project.png" alt-text="The Configure you new project dialog box. The user has named the project Phoneword.":::

## Examine the solution structure

1. In the Solution Explorer window, expand the **Phoneword** project. Expand the **Resources** folder and its subfolders, expand the **App.xaml** node and the **MainPage.xaml** node.

    :::image type="content" source="../media/4-phoneword-project.png" alt-text="The Phoneword project in the Solution Explorer window":::

1. In the project, note the following items:

    - The **Resources** folder contains shared fonts and images used by all platforms.

    - The **MauiProgram.cs** file contains the code that configures the app and specifies that the **App** class should be used to run the application. Select the Startup.cs file to view the code.

    - In the **App.cs** file, the  constructor for the **App** class creates a new instance of the **MainPage** class, which is then displayed in the application window.

    - The  **MainPage.xaml** file contains the layout for the page. This layout includes the XAML code for a button with the caption **Click me**, a label with the text **Current count: 0**, and an image that displays the **dotnet_bot.png** file. There are two other labels as well.

    - The **MainPage.xaml.cs** file contains the application logic for the page. Specifically, the **MainPage** class includes a method named **OnCounterClicked** that runs when the user taps the **Click me** button.

## Build and run the application on Windows

1. On the **Project** menu, select **Edit Project File**.

    :::image type="content" source="../media/4-edit-project-file.png" alt-text="The Project menu in Visual Studio. The user has selected the Edit Project File command":::

1. In the **\<PropertyGroup\>** element near the start of the file, uncomment the line that enables the target framework for .NET 6.0 running on Windows:

    ```xml
    <Project Sdk="Microsoft.NET.Sdk">

    <PropertyGroup>
        <TargetFrameworks>net6.0-ios;net6.0-android;net6.0-maccatalyst</TargetFrameworks>
        <TargetFrameworks Condition="$([MSBuild]::IsOSPlatform('windows')) and '$(MSBuildRuntimeType)' == 'Full'">$(TargetFrameworks);net6.0-windows10.0.19041</TargetFrameworks>
        ...
    </PropertyGroup>
    ```

1. Save the project file.

1. In the Visual Studio toolbar, select the **Windows Machine** profile. Select the **.net6.0-windows** framework from the list in the frameworks drop-down list box.

    :::image type="content" source="../media/4-set-startup-profile.png" alt-text="The Solution Explorer window. The user has set the Windows.Machine profile as the startup profile for the solution.":::

1. On the **Debug** menu, select **Start Debugging**. This action will build, deploy, and run the app on Windows:

    :::image type="content" source="../media/4-start-debugging.png" alt-text="The Visual Studio Debug menu. The user has started debugging the app using the Windows Machine profile.":::

1. Verify that the WinUI version of the app starts up. Select the **Click me** button several times. The count displayed in the window should increment with each tap.

    :::image type="content" source="../media/4-winui-app.png" alt-text="The WinUI app running. The user has tapped the 'Click me' button four times.":::

1. While the app is still running, return to Visual Studio. You should see the **XAML Live Preview** window displaying the app while it is running.

1. On the **View** menu, select **Solution Explorer**. In the Solution Explorer window expand the **MainPage.xaml** node and open the **MainPage.xaml.cs** code-behind file.

1. In the **OnCounterClicked** method, change the statement that increments the *count* variable to add 5 to this variable instead:

    ```csharp
    private void OnCounterClicked(object sender, EventArgs e)
    {
        count += 5;
        CounterLabel.Text = $"Current count: {count}";

        SemanticScreenReader.Announce(CounterLabel.Text);
    }
    ```

1. In the Visual Studio toolbar, select the **Hot Reload** button:

    :::image type="content" source="../media/4-hot-reload-button.png" alt-text="The Visual Studio toolbar. The Apply Code Changes button is highlighted.":::

1. Switch back to the app and select the **Click me** button. Verify that the count is now incremented by 5.

    > [!NOTE]
    > The *Hot Reload* feature of Visual Studio enables you to modify your code while the app is running in Debug mode. You don't need to stop the app to see the changes. As well as modifying code, you can also make changes to the XAML markup for a page, and these changes will become visible the next time the page is redisplayed on the screen as well as in the Live Preview window.

1. Close the app and return to Visual Studio.

## Build and run the application on Android

1. In the Visual Studio toolbar,select the **Phoneword** project.

1. On the **Tools** menu, select **Android** and then select **Android Device Manager**.

    :::image type="content" source="../media/4-visual-studio-tools-menu.png" alt-text="The Visual Studio tools menu. The user is starting the Android Device Manager.":::

1. In the **Android Device Manager** window, select **+ New**. In the **New Device** window select the **Pixel 3a (+ Store)** base device, select the **API 30** OS, and then tap **Create**. Wait while the various libraries are downloaded and the device is configured.

    :::image type="content" source="../media/4-new-device.png" alt-text="The New Device window. The user is creating a new Pixel 3 device.":::

1. When the device has been created return to Visual Studio.

1. In the Visual Studio toolbar, in the **Debug** configuration drop-down list box, select the **Android Emulators** profile, and select the **pixel_31-api_30** device. This is the device you just created.

    :::image type="content" source="../media/4-select-android-emulator.png" alt-text="The Visual Studio toolbar. The user has specified the pixel 31 a p i 30 profile for the Android emulator":::

1. Start debugging use the **pixel_31-api_30** profile. This action will build, deploy, and run the app on the Android device.

    :::image type="content" source="../media/4-debug-using-emulator.png" alt-text="The Visual Studio toolbar. The user has selected the pixel 31 a p i 30 profile.":::

1. When the app starts running on the emulator, tap the **Click me** button and check that the app runs in exactly the same way that it did on Windows.

    :::image type="content" source="../media/4-android-app.png" alt-text="The Android version of the app running in the emulator.":::

1. Return to Visual Studio and stop debugging.
