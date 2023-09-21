In this exercise, you'll start to build the .NET MAUI app for the grocery-store chain. You'll use the template to generate the default app and run it on Windows and in the Android emulator. You'll modify this app in a later exercise to customize the user interface and add the functionality required by the grocery store chain app.

## Create a new project

1. Open Visual Studio and create a new solution. This action opens the New Project wizard in Visual Studio.

    > [!TIP]
    > Make sure you have the .NET MAUI workload installed with Visual Studio 2022 v17.3 or later. [More info here.](/dotnet/maui/get-started/first-app)

1. Select the **MAUI** project type, select the **.NET MAUI App** template, and select **Next**.

    :::image type="content" source="../media/4-create-maui-app .png" alt-text="A screenshot of the Create a new project dialog box. The user has selected the .NET MAUI App template.":::

1. On the **Configure your new project** page, name the project **Phoneword**, and save it in a location of your choice. Select **Next**. 

    :::image type="content" source="../media/4-configure-project.png" alt-text="A screenshot of the Configure your new project dialog box. The user has named the project Phoneword and selected a location on their hard drive to store it.":::

1. Select **.NET 6.0 (Long Term Support)** in the **Framework** drop-down, then select **Create** to create the app.

## Examine the solution structure

1. In the Solution Explorer window, expand the **Phoneword** project. Expand the **Resources** folder and its subfolders, expand the **App.xaml** node, **AppShell.xaml** node, and the **MainPage.xaml** node.

    :::image type="content" source="../media/4-phoneword-project.png" alt-text="A screenshot of the Phoneword project in the Visual Studio solution explorer window.":::

1. In the project, note the following items:

    - The **Resources** folder contains shared fonts, images, and assets used by all platforms.

    - The **MauiProgram.cs** file contains the code that configures the app and specifies that the **App** class should be used to run the application.

    - The **App.xaml.cs** file, the constructor for the **App** class, creates a new instance of the **AppShell** class, which is then displayed in the application window.

    - The **AppShell.xaml** file contains the main layout for the application and starting page of **MainPage**.

    - The **MainPage.xaml** file contains the layout for the page. This layout includes the XAML code for a button with the caption **Click me** and an image that displays the **dotnet_bot.png** file. There are two other labels as well.

    - The **MainPage.xaml.cs** file contains the application logic for the page. Specifically, the **MainPage** class includes a method named `OnCounterClicked` that runs when the user taps the **Click me** button.

## Build and run the application on Windows

1. In the Visual Studio toolbar, select the **Windows Machine** profile. Select the **.net6.0-windows** framework from the list in the frameworks drop-down list box.

    :::image type="content" source="../media/4-set-startup-profile.png" alt-text="A screenshot of the target runtime dropdown in Visual Studio. The user has set the Windows.Machine profile as the startup profile for the solution.":::

1. On the **Debug** menu, select **Start Debugging**. This action will build, deploy, and run the app on Windows:

    :::image type="content" source="../media/4-start-debugging.png" alt-text="A screenshot of the Visual Studio debug menu. The user has started debugging the app using the Windows Machine profile.":::

1. Verify that the Windows version of the app starts up. Select the **Click me** button several times. The button text should update with the count being incremented with each tap.

    :::image type="content" source="../media/4-winui-app.png" alt-text="A screenshot of the Windows UI app running. The user has tapped the 'Click me' button four times.":::

1. On the **View** menu, select **Solution Explorer**. In the Solution Explorer window, expand the **MainPage.xaml** node and open the **MainPage.xaml.cs** code-behind file.

1. In the **OnCounterClicked** method, change the statement that increments the *count* variable to add 5 to this variable instead:

    ```csharp
    private void OnCounterClicked(object sender, EventArgs e)
    {
        count+=5; // update this

        if (count == 1)
            CounterBtn.Text = $"Clicked {count} time";
        else
            CounterBtn.Text = $"Clicked {count} times";

        SemanticScreenReader.Announce(CounterBtn.Text);
    }
    ```

1. In the Visual Studio toolbar, select the **Hot Reload** button:

    :::image type="content" source="../media/4-hot-reload-button.png" alt-text="A screenshot of the Visual Studio toolbar. The Hot Reload button is highlighted.":::

1. Switch back to the app and select the **Click me** button. Verify that the count is now incremented by 5.

    > [!NOTE]
    > Visual Studio's *Hot Reload* feature allows you to modify your code while the app is running in Debug mode. You don't need to stop the app to see the changes. As well as modifying code, you can also make changes to the XAML markup for a page, and these changes will become visible in the running app.

1. Close the app and return to Visual Studio.

## Build and run the application on Android

1. In the Visual Studio toolbar, select the **Phoneword** project.

1. On the **Tools** menu, select **Android** and then select **Android Device Manager**. If you're prompted to let Android Device Manager make changes to your computer, select **Yes**.

    :::image type="content" source="../media/4-visual-studio-tools-menu.png" alt-text="A screenshot of the Visual Studio tools menu. The user has selected the Android Device Manager option.":::

1. In the **Android Device Manager** window, select **+ New**. In the **New Device** window select the **Pixel 3a (+ Store)** base device, select the **API 30** OS, and select **Create**. Wait while the various libraries are downloaded and the device is configured.

    :::image type="content" source="../media/4-new-device.png" alt-text="A screenshot of the New Device window from the Android SDK. The user is creating a new Pixel 3 device with API 30 selected.":::

1. When the device is created, return to Visual Studio.

1. In the Visual Studio toolbar, in the **Debug** configuration drop-down list box, select the **Android Emulators** profile, and select the **pixel_3a-api_30** device. This is the device you just created.

    :::image type="content" source="../media/4-select-android-emulator.png" alt-text="A screenshot of the Visual Studio toolbar. The user has specified the Pixel 3 with the API 30 profile for the Android emulator to start debugging with.":::

1. Start debugging use the **pixel_3a-api_30** profile. This action will build, deploy, and run the app on the Android device.

    :::image type="content" source="../media/4-debug-using-emulator.png" alt-text="A screenshot of the Visual Studio toolbar. It shows the pixel 3 a p i 30 profile has been selected and ready to start debugging with as soon as the user presses the play button.":::

1. When the app starts running on the emulator (this can take several minutes), select the **Click me** button and check that the app runs in exactly the same way that it did on Windows.

    :::image type="content" source="../media/4-android-app.png" alt-text="A screenshot of the Android version of the Phoneword application running in the selected emulator.":::

1. Return to Visual Studio and stop debugging.
