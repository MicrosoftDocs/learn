You previously modified the Notes app to move the UI layout from C# code to XAML. You're now ready to add the following features to the page:

- Support customizing the label's font color and background color, buttons, and editor control. In this way, it's easy to adjust the app to make it more accessible for users that require a high-contrast UI.

- Adjust the Editor control's height on Android and iOS. When running on Windows, this control has sufficient width to allow the user to enter reasonable amount of text before it scrolls. On an Android phone or an iPhone, the narrower width results in scrolling occurring more quickly, so it's beneficial to provide more vertical space.  

## Use a static resource in XAML

You'll create a static class to hold the app's font color and background color values. You'll then use the `x:Static` markup extension to read these values from the class and apply them to the XAML markup for the controls on the page.

1. In Visual Studio, return to the Notes app you edited in the previous exercise.

    > [!NOTE]
    > A working copy of the app is available in the **exercise2** folder in exercise repository you cloned at the start of the previous exercise.

1. In the **Solution Explorer** window, right-click the **Notes** project, select **Add**, then select **Class**.

1. In the **Add New Item** dialog box, make sure the **Class** template is selected. Name the new class file **SharedResources.cs**, and then select **Add**:

    :::image type="content" source="../media/8-add-class-file.png" alt-text="A screenshot of the Add New Item dialog box. The user is adding a class named SharedResources.":::

1. In the **SharedResources.cs** file, replace the `using` directives with the following code, and mark the **SharedResources** class as `static`:

    ```csharp
    namespace Notes;
    
    static class SharedResources
    {
           
    }
    ```

1. Add the `static readonly` field **FontColor** to the **SharedResources** class. This field currently provides a value that corresponds to blue, but you can modify it using any valid combination of RGB values:

    ```csharp
    static class SharedResources
    {
        public static readonly Color FontColor = Color.FromRgb(0, 0, 0xFF);
    }
    ```

1. Add a second `static readonly` field named **BackgroundColor**, and set it to a color of your choice:

    ```csharp
    static class SharedResources
    {
        ...
        public static readonly Color BackgroundColor = Color.FromRgb(0xFF, 0xF0, 0xAD);
    }
    ```

1. Open the **MainPage.xaml** file.

1. Add the XML following namespace declaration to the `ContentPage` element, before the `x:Class` attribute. This declaration brings the classes in the C# **Notes** namespace into scope in the XAML page:

    ```xml
    <ContentPage ...
             xmlns:notes="clr-namespace:Notes"
             x:Class="Notes.MainPage"
             ...>
    ```

1. Add the `TextColor` attribute shown in the following code to the `Label` control. This markup uses the `x:Static` markup extension to retrieve the values stored in the `static` fields in the **SharedResources** class:

    ```xml
    <Label Text="Notes"
        HorizontalOptions="Center"
        FontAttributes="Bold" 
        TextColor="{x:Static Member=notes:SharedResources.FontColor}" />
    ```

1. Use the `x:Static` mark-up extension to set the `TextColor` and `BackgroundColor` attributes for the `Editor` and `Button` controls. The completed markup for your **MainPage.xaml** file should look like this:

    ```xml
    <ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             xmlns:notes="clr-namespace:Notes"
             x:Class="Notes.UIPage">

        <VerticalStackLayout Padding="30,60,30,30">
            <Label Text="Notes"
                HorizontalOptions="Center"
                FontAttributes="Bold" 
                TextColor="{x:Static Member=notes:SharedResources.FontColor}" />

            <Editor x:Name="editor"
                    Placeholder="Enter your note"
                    HeightRequest="100" 
                    TextColor="{x:Static Member=notes:SharedResources.FontColor}"/>

            <Grid Grid.Row="2" ColumnDefinitions="Auto,30,Auto">

                <Button Grid.Column="0"
                        Text="Save" 
                        WidthRequest="100"
                        TextColor="{x:Static Member=notes:SharedResources.FontColor}"
                        BackgroundColor="{x:Static Member=notes:SharedResources.BackgroundColor}"
                        Clicked="OnSaveButtonClicked" />

                <Button Grid.Column="2"
                        Text="Delete" 
                        WidthRequest="100"
                        TextColor="{x:Static Member=notes:SharedResources.FontColor}"
                        BackgroundColor="{x:Static Member=notes:SharedResources.BackgroundColor}"
                        Clicked="OnDeleteButtonClicked" />
            </Grid>
        </VerticalStackLayout>
    
    </ContentPage>
    ```

    > [!NOTE]
    > This XAML code contains repetition of the markup that sets the `TextColor` and `BackgroundColor` properties. XAML lets you define resources that can be applied globally across an app by using a resource dictionary in the **App.xaml** file. We describe this technique in a later module.

1. Rebuild the app and run it using Windows. Verify that the colors match those you specified in the **SharedResources** class. If you have time, also try running the app using the Android emulator:

    :::image type="content" source="../media/8-windows-android-app-colors.png" alt-text="A screenshot of the Notes app running on Windows and Android. The text and background colors have been updated to the changes made.":::

1. Return to Visual Studio when you're done.

## Add platform-specific customization

1. Open the **MainPage.xaml** file in Visual Studio.

1. Locate the definition of the `Editor` control, and modify the value for the **HeightRequest** property as shown in the following example:

    ```xml
    <Editor x:Name="editor"
            ...
            HeightRequest="{OnPlatform 100, Android=500, iOS=500}" 
            .../>
    ```

    This markup sets the default control height to 100 units, but increases it to 500 on Android.

1. Rebuild the app and run it using Windows, then Android. The app should look like this on each platform:

    :::image type="content" source="../media/8-windows-android-editor-screen.png" alt-text="A screenshot of the Notes app running on Windows and Android.":::
