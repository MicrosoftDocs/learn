The different devices on which you can run a mobile app can have varying form factors and behaviors, which can affect the way in which the user interface is presented. For example, some devices limit the number of tabs that can be displayed, and the location of the tabs can vary. Additionally, some devices require you to confine the display to a *safe area* to avoid being cropped or partially hidden.

In this unit, you'll look at some of the platform-specific concerns you should address when implementing a user interface based on tabbed pages.

## Modifying the presentation of tabs

A tabbed user interface provides a useful way to enable an app to present multiple pages of information. However, you need to be aware of how the tabs will appear on the platforms you're targeting for your apps:

<!-- These next three paras are adapted from the doc at https://docs.microsoft.com/en-us/xamarin/xamarin-forms/app-fundamentals/navigation/tabbed-page.-->

- On iOS, the list of tabs appears at the bottom of the screen, and the detail area is above. Each tab consists of a title and an icon. In portrait orientation, tab bar icons appear above tab titles. In landscape orientation, icons and titles appear side by side. In addition, a regular or compact tab bar may be displayed, depending on the device and orientation. If there are more than five tabs, a **More** tab will appear, which can be used to access the additional tabs.

- On Android, the list of tabs appears at the top of the screen, and the detail area is below. Each tab contains a title and an icon. However, the tabs can be relocated to the bottom of the screen using a platform-specific extension. If there are more than five tabs, and the tab list is at the bottom of the screen, a **More** tab will appear that can be used to access the additional tabs.

- On Windows, the list of tabs appears at the top of the screen, and the details area is below. Each tab consists of a title. You can add an icon to each tab.

.NET MAUI provides a library of platform-specific APIs in the **Microsoft.Maui.Controls** assembly. Each set of APIs is in its own namespace. For mobile devices, these namespaces include:

- **Microsoft.Maui.Controls.PlatformConfiguration.AndroidSpecific**,
- **Microsoft.Maui.Controls.PlatformConfiguration.iOSSpecific**, and
- **Microsoft.Maui.Controls.PlatformConfiguration.WindowsSpecific**

There are also libraries for macOS, Wizen, and the GTK toolkit used by many devices.

These libraries expose platform-specific functionality that you can use to fine-tune your apps. For example, the **AndroidSpecific**, **iOSSpecific**, and **WindowsSpecific** libraries contain a `TabbedPage` class that you can use to configure tabbed pages for that platform. The code below moves the tabs for a `TabbedPage` to the bottom of the screen for an Android device, and also disables swipe-paging:

```csharp
using Microsoft.Maui.Controls;
using Microsoft.Maui.Essentials;
using android=Microsoft.Maui.Controls.PlatformConfiguration.AndroidSpecific;

namespace MyAppNamespace
{
    public partial class MainPage : TabbedPage
    {
        public MainPage()
        {
            InitializeComponent();
            if (Device.RuntimePlatform == Device.Android)
            {
                android.TabbedPage.SetToolbarPlacement(this, android.ToolbarPlacement.Bottom);
                android.TabbedPage.SetIsSwipePagingEnabled(this, false);
            }
        }
    }
}
```

> [!IMPORTANT]
> The MAUI `TabbedPage` class is defined in the `Microsoft.Maui.Controls` namespace. To reference the Android `TabbedPage` class, you should either used the fully qualified name `Microsoft.Maui.Controls.PlatformConfiguration.AndroidSpecific.TabbedPage`, or create an alias as shown in the example above. The same is true for the `TabbedPage` class defined in the other platform-specific libraries.

The iOS operating system doesn't let you relocate tabs or enable/disable swiping. However, you can set the translucency of the tabs as follows:

```csharp
using Microsoft.Maui.Controls;
using ios=Microsoft.Maui.Controls.PlatformConfiguration.iOSSpecific;

namespace MyAppNamespace
{
    public partial class MainPage : TabbedPage
    {
        public MainPage()
        {
            InitializeComponent();
            if (Device.RuntimePlatform == Device.iOS)
            {
                ios.TabbedPage.SetTranslucencyMode(this, ios.TranslucencyMode.Translucent);
            }
        }
    }
}
```

The Windows library enables you to enable or disable icons in tabs, and set size of the icons:

```csharp
using Microsoft.Maui.Controls;
using windows=Microsoft.Maui.Controls.PlatformConfiguration.WindowsSpecific;

namespace MyAppNamespace
{
    public partial class MainPage : TabbedPage
    {
        public MainPage()
        {
            InitializeComponent();
            if (Device.RuntimePlatform == Device.UWP)
            {
                windows.TabbedPage.SetHeaderIconsSize(this, new Microsoft.Maui.Graphics.Size(75));
            }
        }
    }
}
```

Note that changing the icon size doesn't affect the size of the labels on the tabs.

You can also set platform-specific settings for tabbed pages in XAML. Add the appropriate namespaces to the `TabbedPage` element, and then provide values for the required properties. The following XAML fragment shows how to change the translucency for iOS, and the position of the tabs for Android:

```xml
<TabbedPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
            xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
            ...
            xmlns:android="clr-namespace:Microsoft.Maui.Controls.PlatformConfiguration.AndroidSpecific;assembly=Microsoft.Maui.Controls"
            xmlns:ios="clr-namespace:Microsoft.Maui.Controls.PlatformConfiguration.iOSSpecific;assembly=Microsoft.Maui.Controls"
            ...
            ios:TabbedPage.TranslucencyMode="Translucent"
            android:TabbedPage.ToolbarPlacement="Bottom">

    <TabbedPage.Children>
        ...
    </TabbedPage.Children>
</TabbedPage>
```

## Setting the safe area for an app

On a mobile device, the *safe area* is the area of the screen that an app can use to display information. Many mobile devices have rounded device corners, a *home indicator*, and sensor housing (known as a *notch* on an iPhone). An app should size its display area so as not to encroach on these items, otherwise the view will be cropped and important information could be obscured or lost.

On an iOS device, you can set the `UseSafeArea` property of a page to `true` to ensure that an app only uses the part of the screen that will be unobscured. This property is part of the device-specific API for iOS. The images below show the effects of this property:

:::image type="content" source="../media/3-safe-area-layout.png" alt-text="Images of an iPhone app running with and without using the safe area.":::

By default, the `UseSafeArea` property is set to false. There may be occasions when you want your app to run *full screen*, but much of the time you may want to set this property to true. You can change the value of the `UseSafeArea` property in code, or by using XAML, as shown by the examples below. Note that `UseSafeArea` is a property of the `Page` class, so it can be applied to all types of pages and not just tabbed pages:

```csharp
using Microsoft.Maui.Controls;
using ios=Microsoft.Maui.Controls.PlatformConfiguration.iOSSpecific;

namespace MyAppNamespace
{
    public partial class MainPage : TabbedPage
    {
        public MainPage()
        {
            InitializeComponent();
            if (Device.RuntimePlatform == Device.iOS)
            {
                ios.Page.SetUseSafeArea(this, true); // Enable the safe area
            }
        }
    }
}
```

```xml
<TabbedPage ...
            xmlns:ios="clr-namespace:Microsoft.Maui.Controls.PlatformConfiguration.iOSSpecific;assembly=Microsoft.Maui.Controls"
            ios:Page.UseSafeArea="True"
            ...>
```

On an Android device, the *safe area* for an app is the main body of the screen, leaving space for the navigation bar at the bottom and the system bar at the top. Unlike iOS, an app is restricted to this area by default. You can disable these bars and enable the app to run using the entire screen, effectively disabling the safe area, by setting a series of platform-specific flags for Android. You can do this when the Android main activity is created, on startup. To do this, edit the **MainActivity.cs**  in the **Platforms/Android** folder for the project. Add `using` directives for the using **Android.Views** and **AndroidX.Core.View** namespaces, and then in the `MainActivity` class override the `OnCreate` method inherited from `MauiAppCompatActivity` with the code shown in the example below:

```csharp
protected override void OnCreate(Bundle? savedInstanceState)
{
    ...
    this.Window.AddFlags(Android.Views.WindowManagerFlags.LayoutNoLimits | Android.Views.WindowManagerFlags.Fullscreen);
    this.Window.DecorView.SystemUiVisibility = (StatusBarVisibility)SystemUiFlags.HideNavigation;
    WindowCompat.SetDecorFitsSystemWindows(this.Window, false);
    this.Window.InsetsController.Hide(WindowInsetsCompat.Type.SystemBars());
    this.Window.InsetsController.SystemBarsBehavior = WindowInsetsControllerCompat.BehaviorShowTransientBarsBySwipe;
}
```

This code also enables the user to access the hidden status bar and navigation bar by swiping from the top of the screen.
