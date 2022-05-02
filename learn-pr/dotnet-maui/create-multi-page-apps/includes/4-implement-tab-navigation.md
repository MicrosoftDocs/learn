Tab navigation is a navigation pattern where a tab strip (a row of touchable controls) is permanently displayed at the top or bottom of the screen. Tab navigation provides a mechanism for a user to select between pages in a multi-page app.

In this unit, you'll learn how to create an app that implements tab navigation.

## What is tab navigation?

In an app that uses tab navigation, each tab represents a specific section or page of the app. Users select tabs within the tab strip to move between content in the application. As an example, the following illustration shows the use of tab navigation in the iOS Clock app. The icons highlighted at the base of the page enable you to switch between different view. These icons correspond to tabs, and the views are tabbed pages:

:::image type="content" source="../media/2-tab-navigation-example-world-clock.png" alt-text="Screenshot of the iOS Clock app showing the bottom tab bar containing various time-related tabs: World Clock, Alarm, Bedtime, Stopwatch, and Timer.":::

Because the tab strip is always visible, tab navigation allows users to quickly switch between content in an application. Tab navigation is ideal when an application has several sections that a user is likely to use frequently. Clock applications are an excellent example. The clock, alarm, and stopwatch sections are likely to be frequently used.

On mobile devices, the tab strip typically has a limited amount of space and can display only a fixed number of tabs, depending on the device size and orientation. The recommendation is to use only three to four tabs. If you include more tabs, you're not guaranteed to have enough space to show all of the tabs on all devices. The operating systems supported by .NET MAUI do allow for an overflow area. This area provides more area to access tabs that don't fit on screen. However, navigating to these overflow tabs requires additional steps by the user. These sections are less discoverable.

If you need more than four tabs, consider using another navigation pattern. Additionally, tab navigation isn't the best option if your data forms a natural, master-detail hierarchy. In these cases, you should consider stack navigation.

## Tab navigation in a .NET MAUI app

You use the `TabbedPage` layout to implement tab navigation in .NET MAUI app. The `TabbedPage` class displays a set of tabs and automatically switches the displayed content when the user selects a tab. The following illustration shows the UI areas provided by a `TabbedPage` layout.

:::image type="content" source="../media/2-tabbed-page-diagram.png" alt-text="Illustration showing an example TabbedPage with a content area and a bottom tab bar containing three children pages: Globe, Compass, and Map.":::

To use this layout, create an instance of `TabbedPage` class, and then assign it to the `MainPage` property of the `App` class. The `TabbedPage` instance holds child pages in its `Children` property. A tab is automatically displayed for each child page.

> [!IMPORTANT]
> The `TabbedPage` should be the root page in your application. Don't nest a `TabbedPage` inside another page.

## Create a TabbedPage

You can create a `TabbedPage` instance in the constructor of the `App` class. You can then instantiate the child pages and add them to the `Children` collection. Then, you can assign your populated `TabbedPage` as the `MainPage` for the app. The code below shows an example of this approach. Typically, you populate all of the children at application startup. This approach differs from stack navigation, where you instantiate pages as they're needed.

```csharp
public partial class App : Application
{
    public App()
    {
        var tabbedPage = new TabbedPage();

        tabbedPage.Children.Add(new GlobePage());
        tabbedPage.Children.Add(new CompassPage());
        tabbedPage.Children.Add(new MapPage());

        MainPage = tabbedPage;
    }
}
```

Alternatively, you could use XAML to create a `TabbedPage` and assign the child pages using XAML markup. You would then use this page as your app's MainPage.

```xml
<TabbedPage ...
    x:Class="WorldTraveler.HomePage">
    <TabbedPage.Children>
        <local:GlobePage ... />
        <local:CompassPage ... />
        <local:MapPage ... />
    </TabbedPage.Children>
</TabbedPage>
```

### Customize the tabs

Tabs are automatically created for each child page using the `Title` property of each child page. You can override the page title and provide your own title for a tab by setting `Title` property of the tab. Optionally, you can add an icon to the tabs. Set the `ImageIconSource` property to the name of an image file in the **Resources** folder of the project. Tab icons are only used on platforms that support them.

```xml
<TabbedPage.Children>
    <local:GlobePage Title="Globe" ImageIconSource="globe.png" />
    <local:CompassPage Title="Compass" ImageIconSource="compass.png" />
    <local:MapPage Title="Map" ImageIconSource="map.png" />
</TabbedPage.Children>
```

You can also customize the colors used for your tab strip by using the `BarBackgroundColor` and `BarTextColor` properties of the `TabbedPage`.

```xml
<TabbedPage ...>
   ...
   BarBackgroundColor="Blue"
   BarTextColor="White">
   ...
</TabbedPage>
```

If you want to help the user distinguish between the currently selected tab and the unselected tabs, you can set the `SelectedTabColor` and `UnselectedTabColor` properties instead or the text color.
