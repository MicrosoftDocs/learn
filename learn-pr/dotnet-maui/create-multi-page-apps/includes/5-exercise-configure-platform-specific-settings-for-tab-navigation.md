In the sample app, you've been asked to ensure consistency in the user interface between the iOS and Android versions. Specifically, user feedback suggests that the tab bar should be at the bottom of the screen in both cases (this is the default on iOS). Additionally, users have reported accidentally moving between tabs by swiping, and want to disable this feature. Finally, you want the app to run using the full screen.

> [!NOTE]
> You can continue using the app from the previous exercises, or you can open the starter solution in the exercise2/start/Astronomy folder in the repo that you cloned at the start of the previous exercise. This solution is a copy of the completed project from the previous exercise.

## Relocate the tab bar on Android

1. In the Solution Explorer window, open the **MainPage.xaml** file.

1. Add a namespace to make the platform-specific library for Android available in the XAML markup:

    ```xml
    <TabbedPage ...
        xmlns:android="clr-namespace:Microsoft.Maui.Controls.PlatformConfiguration.AndroidSpecific;assembly=Microsoft.Maui.Controls"
        ...>
    ```

1. Using the platform-specific library, set the `ToolbarPlacement` property of the tab page to `Bottom`:

    ```xml
    <TabbedPage ...  
        android:TabbedPage.ToolbarPlacement="Bottom">
    ```

1. Build and run the app using the Android emulator. When the app starts, the **MainPage** appears, notice that the tab bar now appears at the bottom of the page:

    :::image type="content" source="../media/5-app-android-tabbar-bottom.png" alt-text="The Astronomy app running on Android. The tab bar is now at the bottom of the page.":::

1. Select any page in the tab bar, and then swipe or right. You should be able to use the swipe gesture to change tabs.

1. Close the app and return to Visual Studio.

## Prevent the swipe gesture from changing tabs

1. In the **MainPage.xaml** file, add the markup shown below to the `TabbedPage` element. This markup uses the platform-specific library to disable swiping:

    ```xml
    <TabbedPage ...  
        android:TabbedPage.IsSwipePagingEnabled="False">
    ```

1. Build and run the application on the Android emulator.

1. Attempt to swipe between tab pages. Swiping should now have no effect.

1. Close the app and return to Visual Studio.

## Enable the app to run using the full screen

1. In the Solution Explorer window, in the **Platforms/Android** folder, open the **MainActivity.cs** file.

1. Add the following `using` directives to the list at the top of the file:

    ```csharp
    ...
    using Android.Views;
    using AndroidX.Core.View;
    ```

1. In the `MainActivity` class, in the `OnCreate` method inherited from the `MauiAppCompatActivity` class, set the platform-specific flags that enable the application to use the entire screen. The completed class and method should look like this:

    ```csharp
    public class MainActivity : MauiAppCompatActivity
    {
        protected override void OnCreate(Bundle? savedInstanceState)
        {
            base.OnCreate(savedInstanceState);
            Microsoft.Maui.Essentials.Platform.Init(this, savedInstanceState);
            this.Window.AddFlags(Android.Views.WindowManagerFlags.LayoutNoLimits | Android.Views.WindowManagerFlags.Fullscreen);
            this.Window.DecorView.SystemUiVisibility = (StatusBarVisibility)SystemUiFlags.HideNavigation;
            WindowCompat.SetDecorFitsSystemWindows(this.Window, false);
            this.Window.InsetsController.Hide(WindowInsetsCompat.Type.SystemBars());
            this.Window.InsetsController.SystemBarsBehavior = WindowInsetsControllerCompat.BehaviorShowTransientBarsBySwipe;
        }
    }
    ```

1. Build and run the app using the Android emulator. When the app starts, it should now occupy the entire screen of the device:

    :::image type="content" source="../media/5-app-android-app-fullscreen.png" alt-text="The Astronomy app running on Android. The app is using the entire screen.":::

1. Close the app and return to Visual Studio.
