In the astronomy app, you've been asked to combine tabs with the flyout to help with navigation between the different pages.

The first thing you decide to do is remove all the pages from the flyout and add them to a `TabBar`, so you can see how the app feels.

## Adding a TabBar

1. In the Solution Explorer window, open the **AppShell.xaml** page.
1. In the XAML markup page, delete everything inside of the `<Shell>`.
1. Create a `<TabBar>` and an empty `<Tab>`.

    ```xaml
    <?xml version="1.0" encoding="UTF-8" ?>
    <Shell
        x:Class="Astronomy.AppShell"
        xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
        xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
        xmlns:local="clr-namespace:Astronomy.Pages"
        FlyoutIcon="moon.png">
    
        <TabBar>
            <Tab>
                
            </Tab>
        </TabBar>
    </Shell>
    ```

1. Next, add a `ShellContent` to the `Tab` and set its content to the `MoonPhasePage`.

    ```xaml
    <TabBar>
        <Tab>
            <ShellContent ContentTemplate="{DataTemplate local:MoonPhasePage}" />
        </Tab>
    </TabBar>
    ```

1. Now give the tab a title to be displayed and an icon using the `Title` and `Icon` properties.

    ```xaml
    <Tab Title="Moon Phase" Icon="moon.png">
    ```

1. Add in another `Tab` for the `SunrisePage`. Set its `Title` to **sunrise** and its `Icon` to **sun.png**. The finished XAML looks like this:

    ```xaml
    <?xml version="1.0" encoding="UTF-8" ?>
    <Shell
        x:Class="Astronomy.AppShell"
        xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
        xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
        xmlns:local="clr-namespace:Astronomy.Pages"
        FlyoutIcon="moon.png">  
       
        <TabBar>
            <Tab Title="Moon Phase" Icon="moon.png">
                <ShellContent ContentTemplate="{DataTemplate local:MoonPhasePage}" />
            </Tab>
            <Tab Title="Sunrise" Icon="sun.png">
                <ShellContent ContentTemplate="{DataTemplate local:SunrisePage}"/>
            </Tab>
        </TabBar>
    </Shell>
    ```

1. Run the app to see how it looks.

    :::image type="content" source="../media/5-app-with-two-tabs.png" alt-text="Screenshot of app running with two tabs instead of using flyout menu.":::

## Combine tab pages with a flyout

You decide it makes sense to have the moon phase and sunrise pages in the same tab page. It also makes sense to keep the about page separate. So you decide to add the flyout back in. The first flyout item displays the tab page, and the second the about page.

1. Delete the `TabBar` and all of the child items contained in it.

1. In its place, add in a `<FlyoutItem>`. Set its `Title` property to **Astronomy** and its icon to **moon.png**.

    ```xaml
    <FlyoutItem Title="Astronomy" Icon="moon.png">
        
    </FlyoutItem>
    ```

1. Within the `<FlyoutItem>`, add a `<ShellContent>` that points to the `MoonPhasePage`. Set its `Title` property to **Moon Phase** and `Icon` property to **moon.png**.

    ```xaml
    <FlyoutItem Title="Astronomy" Icon="moon.png">
        <ShellContent Title="Moon Phase" Icon="moon.png"
            ContentTemplate="{DataTemplate local:MoonPhasePage}"/>
    </FlyoutItem>
    ```

1. Within the same `<FlyoutItem>`, add another `<ShellContent>` to point to the `SunrisePage`. Set its `Title` property to **Sunrise** and `Icon` property to **sun.png**.

    ```xaml
    <FlyoutItem Title="Astronomy" Icon="moon.png">
        <ShellContent Title="Moon Phase" Icon="moon.png"
            ContentTemplate="{DataTemplate local:MoonPhasePage}"/>

        <ShellContent Title="Sunrise" Icon="sun.png"
            ContentTemplate="{DataTemplate local:SunrisePage}"/>
    </FlyoutItem>
    ```

    Now, tapping on this flyout item displays a tab page with two tabs.

1. To create a new flyout item that points to the `AboutPage`, add a new `<FlyoutItem>`. Set its `Title` property to **About** and `Icon` property to **question.png**.
1. Within that `<FlyoutItem>`, add a `<ShellContent>` that points to the `AboutPage`.

    ```xaml
    <FlyoutItem Title="About" Icon="question.png">
        <ShellContent
            ContentTemplate="{DataTemplate local:AboutPage}"/>
    </FlyoutItem>
    ```

1. Run the app again. You should see two items in the flyout. The first one opens up a tab page that contains the `MoonPhasePage` and `SunrisePage`. The second displays the `AboutPage` by itself.

## Need help?

The final XAML code for **AppShell.xaml** should look like this example:

```xaml
<?xml version="1.0" encoding="UTF-8" ?>
<Shell
    x:Class="Astronomy.AppShell"
    xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
    xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
    xmlns:local="clr-namespace:Astronomy.Pages"
    FlyoutIcon="moon.png">

    <!-- You can add this back in for the header -->
    <!--<Shell.FlyoutHeader>
        <Grid HeightRequest="100" BackgroundColor="DarkSlateBlue">
            <Image Source="moon.png"/>
        </Grid>
    </Shell.FlyoutHeader>-->

    <FlyoutItem Title="Astronomy" Icon="moon.png">
        <ShellContent Title="Moon Phase" Icon="moon.png"
            ContentTemplate="{DataTemplate local:MoonPhasePage}"/>

        <ShellContent Title="Sunrise" Icon="sun.png"
            ContentTemplate="{DataTemplate local:SunrisePage}"/>
    </FlyoutItem>

    <FlyoutItem Title="About" Icon="question.png">
        <ShellContent
            ContentTemplate="{DataTemplate local:AboutPage}"/>
    </FlyoutItem>
</Shell>
```
