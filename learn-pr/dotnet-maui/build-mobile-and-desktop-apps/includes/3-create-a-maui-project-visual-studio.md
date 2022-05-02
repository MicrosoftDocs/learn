
Once you've installed and configured the .NET MAUI tools, you can use Visual Studio to build a .NET MAUI app. 

In this unit, you'll learn about the structure of the .NET MAUI template in Visual Studio. You'll use this template for creating cross-platform mobile and desktop apps.

## How to get started

To create a new .NET MAUI project with Visual Studio, in the **Create a new project** dialog box select the .NET MAUI project type, and then choose the .NET MAUI App template:

:::image type="content" source="../media/3-create-maui-app.png" alt-text="A screenshot of the Create a new project dialog box in Visual Studio. The user has selected the .NET MAUI App template.":::

Follow the steps in the wizard to name the project and specify a location.

A newly created .NET MAUI project contains the items as shown:

:::image type="content" source="../media/3-new-solution.png" alt-text="A screenshot of the solution explorer of the default structure of a new .NET MAUI solution in Visual Studio":::

> [!IMPORTANT]
>
> By default, a MAUI project is configured for mobile development on Android and Mac devices. Uncomment the Windows Target Framework in the .csproj project file to enable windows development.
>
> :::image type="content" source="../media/3-csproj-file.png" alt-text="A screenshot of the c s p r o j file for a MAUI app, highlighting the Windows Target Framework which has been uncommented" lightbox="../media/3-csproj-file-lightbox.png":::

## .NET MAUI project structure and application startup

The project contents include the following items:

- **App.xaml**. This file defines the application resources that the app will use in the XAML layout. The default set of resources provided by the template shows how to set the background and text color for the pages that comprise the UI, along with styling for any labels and buttons that you add to the UI. You can modify these styles and add more resource definitions and styles as necessary:

    ```xml
    <Application xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
                 xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
                 xmlns:windows="clr-namespace:Microsoft.Maui.Controls.PlatformConfiguration.WindowsSpecific;assembly=Microsoft.Maui.Controls"
                 xmlns:local="clr-namespace:MyMauiApp"
                 x:Class="MyMauiApp.App"
                 windows:Application.ImageDirectory="Assets">
        <Application.Resources>
            <ResourceDictionary>
    
                <Color x:Key="PrimaryColor">#512bdf</Color>
                <Color x:Key="SecondaryColor">White</Color>
    
                <Style TargetType="Label">
                    <Setter Property="TextColor" Value="{DynamicResource PrimaryColor}" />
                    <Setter Property="FontFamily" Value="OpenSansRegular" />
                </Style>
    
                <Style TargetType="Button">
                    <Setter Property="TextColor" Value="{DynamicResource SecondaryColor}" />
                    <Setter Property="FontFamily" Value="OpenSansRegular" />
                    <Setter Property="BackgroundColor" Value="{DynamicResource PrimaryColor}" />
                    <Setter Property="Padding" Value="14,10" />
                </Style>
    
            </ResourceDictionary>
        </Application.Resources>
    </Application>
    ```

- **App.xaml.cs**. This is the code-behind for the App.xaml file. This file defines the App class. This class represents your application at runtime. The constructor in this class creates an initial window and assigns it to the `MainPage` property; this property determines which page is displayed when the application starts running. Additionally, this class enables you to override common platform-neutral application lifecycle event handlers. Events include as `OnSleep` and `OnResume`. These handlers are defined as members of the `Application` base class. The code below shows examples:

    > [!NOTE]
    > You can also override platform-specific lifecycle events when the app first starts running. This is described later.

    ```csharp
    using Microsoft.Maui;
    using Microsoft.Maui.Controls;
    using Microsoft.Maui.Controls.PlatformConfiguration.WindowsSpecific;
    using Application = Microsoft.Maui.Controls.Application;
    
    namespace MyMauiApp
    {
        public partial class App : Application
        {
            public App()
            {
                InitializeComponent();
    
                MainPage = new MainPage();
            }
        }

        protected override void OnSleep()
        {
            base.OnSleep();
            // Application has switched to the background
            ...
        }

        protected override void OnResume()
        {
            base.OnResume();
            // Application has returned to the foreground, or has just been created
            ...
        } 
    }
    ```

- **MainPage.xaml**. This file contains the user interface definition. The sample app generated by the MAUI App template comprises three labels, a button, and an image. The controls are arranged using a `StackLayout` enclosed in a `ScrollView`. The `StackLayout` control causes the controls to be arranged vertically (in a stack), and the `ScrollView` provides a scrollbar if the view is too large to be displayed on the device. The intention is that you replace the contents of this file with your own UI layout. You can also define more XAML pages if you have a multi-page app.

    ```xml
    <ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
                 xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
                 x:Class="MyMauiApp.MainPage"
                 BackgroundColor="{DynamicResource SecondaryColor}">
    
        <ScrollView Padding="{OnPlatform iOS='30,60,30,30', Default='30'}">
            <Grid RowSpacing="25" RowDefinitions="Auto,Auto,Auto,Auto,*">
    
                <Label 
                    Text="Hello, World!"
                    Grid.Row="0"
                    SemanticProperties.HeadingLevel="Level1"
                    FontSize="32"
                    HorizontalOptions="Center" />
    
                <Label 
                    Text="Welcome to .NET Multi-platform App UI"
                    Grid.Row="1"
                    SemanticProperties.HeadingLevel="Level1"
                    SemanticProperties.Description="Welcome to dot net Multi platform App U I"
                    FontSize="18"
                    HorizontalOptions="Center" />
    
                <Label 
                    Text="Current count: 0"
                    Grid.Row="2"
                    FontSize="18"
                    FontAttributes="Bold"
                    x:Name="CounterLabel"
                    HorizontalOptions="Center" />
    
                <Button 
                    Text="Click me"
                    FontAttributes="Bold"
                    Grid.Row="3"
                    SemanticProperties.Hint="Counts the number of times you click"
                    Clicked="OnCounterClicked"
                    HorizontalOptions="Center" />
    
                <Image Grid.Row="4"
                    Source="dotnet_bot.png"
                    SemanticProperties.Description="Cute dot net bot waving hi to you!"
                    WidthRequest="250"
                    HeightRequest="310"
                    HorizontalOptions="Center" />
    
            </Grid>
        </ScrollView>
    </ContentPage>
    ```

- **MainPage.xaml.cs**. This is the code-behind for the page. In this file, you define the logic for the various event handlers and other actions that are triggered by the controls on the page. The example code implements a handler for the `Clicked` event for the button on the page. The code simply increments a counter variable and displays the result in a label on the page. The Semantic service provided as part of the MAUI Essentials library supports accessibility. The static `Announce` method of the `SemanticScreenReader` class specifies the text announced by a screen reader when the user selects the button:

    ```csharp
    using Microsoft.Maui.Controls;
    using Microsoft.Maui.Essentials;
    using System;
    
    namespace MyMauiApp
    {
        public partial class MainPage : ContentPage
        {
            int count = 0;
    
            public MainPage()
            {
                InitializeComponent();
            }
    
            private void OnCounterClicked(object sender, EventArgs e)
            {
                count++;
                CounterLabel.Text = $"Current count: {count}";
    
                SemanticScreenReader.Announce(CounterLabel.Text);
            }
        }
    }
    ```

- **MauiProgram.cs**. Each native platform has a different starting point that creates and initializes the application. You can find this code under the **Platforms** folder in the project. This code is platform-specific, but at the end it  calls the `CreateMauiApp` method of the static `MauiProgram`class. You use the `CreateMauiApp` method to configure the application by creating an app builder object. At a minimum, you need to specify which class describes our application. You do this with the `UseMaiuApp` generic method of the app builder object; the type parameter specifies the application class. The app builder also provides methods for tasks such as registering fonts, configuring services for dependency injection, registering custom handlers for controls, and registering Xamarin.Forms renderers for .NET MAUI controls. The following code shows an example of using the app builder to register a font:

    ```csharp
    using Microsoft.Maui;
    using Microsoft.Maui.Controls.Compatibility;
    using Microsoft.Maui.Controls.Hosting;
    using Microsoft.Maui.Hosting;
    
    namespace MyMauiApp
    {
        public static class MauiProgram
        {
            public static MauiApp CreateMauiApp()
            {
                var builder = MauiApp.CreateBuilder();
                builder
                    .UseMauiApp<App>()
                    .ConfigureFonts(fonts =>
                    {
                        fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
                    });
    
                return builder.Build();
            }
        }
    }
    ```

- **Platforms**. This folder contains platform-specific initialization code files and resources. There are folders for Android, iOS, MacCatalyst, and Windows. At runtime, the app starts up in a platform-specific way. Much of the start-up process is abstracted out by the internals of the MAUI libraries, but the code files in these folders provide a mechanism for hooking up your own custom initialization. The important point is that when initialization is complete, the platform-specific code calls the `MauiProgram.CreateMauiApp` method which then creates and runs the `App` object, as described earlier. For example, the **MainApplication.cs** file in the **Android** folder, the **AppDelegate.cs** file in the **iOS** and **MacCatalyst** folder, and the **App.xaml.cs** file in the **Windows** folder all contain the overrides:

    ```csharp
    protected override MauiApp CreateMauiApp() => MauiProgram.CreateMauiApp();
    ```

The following image illustrates the flow of control when a .NET MAUI app starts up:

:::image type="content" source="../media/3-startup-flow.png" alt-text="A diagram of the flow of control when a .NET MAUI app starts up. It flows from the native specific startup, to the create MAUI app function, to finally the app object constructor. ":::

## Project resources

The **.csproj** file for the main project includes several noteworthy sections. The initial `PropertyGroup` specifies the platform frameworks that the project targets, as well as items such as the application title, ID, and version number. You can amend these properties as necessary:

<!-- To be updated as new previews are released -->

```xml
<Project Sdk="Microsoft.NET.Sdk">

    <PropertyGroup>
        <TargetFrameworks>net6.0-ios;net6.0-android;net6.0-maccatalyst</TargetFrameworks>
        <TargetFrameworks Condition="$([MSBuild]::IsOSPlatform('windows')) and '$(MSBuildRuntimeType)' == 'Full'">$(TargetFrameworks);net6.0-windows10.0.19041</TargetFrameworks>
        <OutputType>Exe</OutputType>
        <RootNamespace>MyMauiApp</RootNamespace>
        <UseMaui>true</UseMaui>
        <SingleProject>true</SingleProject>
        <EnablePreviewMsixTooling>true</EnablePreviewMsixTooling>

        <!-- Display name -->
        <ApplicationTitle>MyMauiApp</ApplicationTitle>

        <!-- App Identifier -->
        <ApplicationId>com.companyname.MyMauiApp</ApplicationId>

        <!-- Versions -->
        <ApplicationVersion>1.0</ApplicationVersion>
        <AndroidVersionCode>1</AndroidVersionCode>

        <!-- Required for C# Hot Reload -->
        <UseInterpreter Condition="'$(Configuration)' == 'Debug'">True</UseInterpreter>
    </PropertyGroup>

    ...

</Project>
```

The `ItemGroup` section below the initial property group enables you to specify an image and color for the splash screen that appears while the app is loading, prior to the first window appearing. You can also set the default locations for fonts and images used by the app.

```xml
<Project Sdk="Microsoft.NET.Sdk">

    ...

    <ItemGroup>
        <!-- App Icon -->
        <MauiImage
            Include="Resources\appicon.svg"
            ForegroundFile="Resources\appiconfg.svg"
            IsAppIcon="true"
            Color="#512BD4" />

        <!-- Splash Screen -->
        <MauiSplashScreen Include="Resources\appiconfg.svg" Color="#512BD4" />

        <!-- Images -->
        <MauiImage Include="Resources\Images\*" />

        <!-- Custom Fonts -->
        <MauiFont Include="Resources\Fonts\*" />
    </ItemGroup>

    ...

</Project>
```

In the Solution Explorer window in Visual Studio, you can expand the **Resources** folder to see these items. You can add any other fonts, images, and other graphical resources required by the application to this folder and subfolders.

:::image type="content" source="../media/3-resources-folder.png" alt-text="A screenshot of the resources folder in the main project with a rectangle around it in the Visual Studio solution explorer. Inside the folder are font and image files.":::

You should register any fonts added to the fonts folder with the app builder object when your app starts running. Recall that the **CreateMauiApp** method in the **MauiProgram** class does this with the `ConfigureFonts` method:

```csharp
public static class MauiProgram
{
    public static MauiApp CreateMauiApp()
    {
        var builder = MauiApp.CreateBuilder();
        builder
            ...
            .ConfigureFonts(fonts =>
            {
                fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
            });

        ...
    }
}
```

In this example, the `AddFont` method associates the font with the name `OpenSansRegular`. You can specify this font when you format items in the XAML description of a page or in the application resource dictionary:

```xml
<Application ...">
    <Application.Resources>
        <ResourceDictionary>
            ...
            <Style TargetType="Button">
                ...
                <Setter Property="FontFamily" Value="OpenSansRegular" />
                ...
            </Style>

        </ResourceDictionary>
    </Application.Resources>
</Application>
```

Use the **Resources** folders in the **Android**, and **iOS** folders under the **Platforms** folder for Android and iOS platform-specific resources.
