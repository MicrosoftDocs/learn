For this exercise, you'll return to the planetarium **Astronomy** app. Once again, there's a starter solution for you to work with. You'll still be adding navigation to the app, but this time you'll use tabs.

## Open starter solution

Use Visual Studio to open the starter solution from the **exercise2** > **start** folder in your copy of the cloned or downloaded [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].

## Convert a ContentPage to a TabbedPage

You'll use a `TabbedPage` to switch between several pages. You can create a new `TabbedPage` manually, but it's easier and less error-prone to convert the existing `ContentPage` to a `TabbedPage`.

1. Open **MainPage.xaml**.
1. Change the root node from `ContentPage` to `TabbedPage`.

    ```xaml
    <TabbedPage ...>
    </TabbedPage>
    ```

1. Open **MainPage.xaml.cs**.
1. Change the class's base type from `ContentPage` to `TabbedPage`.
1. In the constructor, add new instances of `SunrisePage`, `MoonPhasePage`, and `AboutPage` to the page's `Children` property.

    ```csharp
    public partial class MainPage : TabbedPage
    {
        public MainPage()
        {
            InitializeComponent();

            this.Children.Add(new SunrisePage());
            this.Children.Add(new MoonPhasePage());
            this.Children.Add(new AboutPage());
        }
    }
    ```

## Add icons for the tabs

If you're running the application on iOS or Android, you can display unique images on the tabs for each page.

1. Open the **assets** > **exercise2** folder of the cloned or downloaded materials.
1. Add the images in the **Android** folder to the appropriate drawable folders in the Android head project.
1. Add the images in the **iOS** folder to the **Resources** folder in the iOS head project.
1. Verify that the new images have the correct build action: **AndroidResource** in the Android project and **BundleResource** in iOS.

## Set icons for each page

Set the `Icon` property for each page that you want an icon displayed when shown within a `TabbbedPage`. You can set an icon in the **.xaml** or **xaml.cs** files.

1. Open **SunrisePage.xaml**.
1. In the `ContentPage` declaration, set the `Icon` property to "sun.png".
1. Open **MoonPhasePage.xaml**.
1. In the `ContentPage` declaration, set the `Icon` property to "moon.png".
1. Open **AboutPage.xaml**.
1. In the `ContentPage` declaration, set the `Icon` property to "question.png". See the following example.
1. Run the application.

    ```xaml
    <ContentPage ...
        Title="About"
        Icon="question.png">
    ```

## Set safe areas for iOS

On an iOS device, the pages overlap with the iOS status bar. This overlap is especially noticeable on iPhones with the top notch.

To correct the overlapping UI, use **iOS Safe Areas** when running on **iOS**.

1. Open **SunrisePage.xaml**.
1. Add the code below to the `ContentPage` declaration.

    ```xaml
    <ContentPage ...
        xmlns:ios="clr-namespace:Xamarin.Forms.PlatformConfiguration.iOSSpecific;assembly=Xamarin.Forms.Core"
        ios:Page.UseSafeArea="true"
        ...>
    ```

1. Repeat the steps above for **MoonPhasePage.xaml** and **AboutPage.xaml**.
1. Run the application on an iOS simulator or device if available.

## Summary

In this exercise, you used tabs to navigate between several pages of content.

You can view the completed solution in the **exercise2** > **final** folder of your copy of the cloned or downloaded [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].
