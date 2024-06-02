In the sample scenario, you have a MAUI app that contains pages for displaying information about astronomical bodies, the phases of the moon, and sunrise/sunset times. The app also includes an About page. Currently, these pages are all stand-alone, but you want to provide a logical way for the user to move between them.

In this exercise, you add flyout navigation to the app.

[!include[](../../../includes/dotnet8-sdk-version.md)]

## Open the starter solution

1. Clone or download the [exercise repo](https://github.com/MicrosoftDocs/mslearn-dotnetmaui-create-multi-page-apps).

    > [!NOTE]
    > It is best to clone or download the exercise content to a short folder path, such as C:\dev\, to avoid build-generated files exceeding the maximum path length.

1. Go to the **exercise1** folder in the cloned repo, and then move to the **start** folder.

1. Use Visual Studio to open the **Astronomy.sln** solution or the folder in Visual Studio Code.

1. In the **Solution Explorer** window, in the **Astronomy** project, expand the **Pages** folder. This folder contains the following pages:

    - **AboutPage**. This page displays *about* information for the app.
    - **MoonPhasePage**. This page displays specific information about the phases of the Moon as seen from Earth.
    - **SunrisePage**. This page displays sunrise and sunset times for locations on Earth. The data is provided by the [Sunrise Sunset web service](https://sunrise-sunset.org/api).

1. Build and run the app. When the app starts, the **MoonPhasePage** displays, but currently there's no means provided to enable the user to navigate to the other pages.

    The following image shows the app running on the Android emulator:

    :::image type="content" source="../media/3-initial-moonphase.png" alt-text="A screenshot of the Astronomy app running on Android. The functionality required to navigate to pages is missing.":::

1. Close the app and return to Visual Studio or Visual Studio Code.

## Add flyout navigation

1. In the Solutions Explorer window, open up the **AppShell.xaml** page.

1. In the XAML markup editor, surround the existing `<ShellContent>` item with a `<FlyoutItem>`. Set the `Title` property of the `<Flyout>` item to be **Moon Phase**. The markup should look like this:

    ```xaml
    <FlyoutItem Title="Moon Phase">
        <ShellContent
            ContentTemplate="{DataTemplate local:MoonPhasePage}"/> 
    </FlyoutItem>
    ```

1. Add a `FlyoutIcon` property to the `<Shell>` node to display an image. By default it displays three horizontal bars, but we can change it to be whatever we like. The markup should look like this:

    ```xaml
    <Shell
        x:Class="Astronomy.AppShell"
        xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
        xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
        xmlns:local="clr-namespace:Astronomy.Pages"
        FlyoutIcon="moon.png">
    ```

1. Run the application. You should now see a moon image in the upper left corner of the app.

    :::image type="content" source="../media/3-app-with-flyout-icon.png" alt-text="A screenshot of the app running on Android with the moon icon indicating a flyout is available.":::

    Tap on the icon and the flyout appears.

    :::image type="content" source="../media/3-flyout-shown.png" alt-text="A screenshot of the app running on Android with the flyout displayed.":::

1. Now add in more flyout options. Create a new `<FlyoutItem>` below the one you just made and set its `Title` to **Sunrise**. Its `ShellContent` should point to the `SunrisePage` page.
1. Add another `<FlyoutItem>`, set its title to **About**. This time set the `ShellContent` to `AboutPage`. The XAML for these two items should look like this:

    ```xaml
    <FlyoutItem Title="Sunrise">
        <ShellContent
            ContentTemplate="{DataTemplate local:SunrisePage}"/>
    </FlyoutItem>

    <FlyoutItem Title="About">
        <ShellContent
            ContentTemplate="{DataTemplate local:AboutPage}"/>
    </FlyoutItem>
    ```

1. Run the app again, and now there are three options in the flyout. Tapping on the flyout item displays its respective page.

    :::image type="content" source="../media/3-flyout-all-options.png" alt-text="A screenshot of the app running on Android with the flyout open showing three flyout items.":::

    > [!NOTE]
    > If you are running on a platform other than Windows, you may need to enable Location permission for your app on that platform for the **Sunrise/Sunset Times** page to work. For example, on an Android device, set Location access to **Allow only while using the app**.

## Adding icons

You might have noticed the flyout items look a bit empty. You can add icons to the flyout items by using the `Icon` property.

Some images have already been added to the **Resources\Images** folder for you to use.

1. Set the `Icon` property of the first `FlyoutItem` to **moon.png**.

    ```xaml
    <FlyoutItem Title="Moon Phase" Icon="moon.png">
        <ShellContent
            ContentTemplate="{DataTemplate local:MoonPhasePage}" />
    </FlyoutItem>
    ```

1. Repeat for the other 2 flyout items, using **sun.png** and **question.png** respectively.

    ```xaml
    <FlyoutItem Title="Sunrise" Icon="sun.png">
        <ShellContent
            ContentTemplate="{DataTemplate local:SunrisePage}"/>
    </FlyoutItem>

    <FlyoutItem Title="About" Icon="question.png">
        <ShellContent
            ContentTemplate="{DataTemplate local:AboutPage}"/>
    </FlyoutItem>
    ```

1. Run the app and open the flyout. Each flyout item now has an icon associated with it.

    :::image type="content" source="../media/3-flyout-with-icons.png" alt-text="Screenshot of app running on Android with the flyout open and each flyout item has an icon.":::

## Add a flyout header

The flyout items are at the top of the flyout menu, making them difficult to distinguish. We can add some space to the top, and even an entire `View` by using the `<Shell.FlyoutHeader>`.

1. Add a flyout header as a child of the `<Shell>` node:

    ```xaml
    <Shell.FlyoutHeader>
    </Shell.FlyoutHeader>
    ```

1. You can create any view hierarchy you wish within the `<Shell.FlyoutHeader>`. Let's put in a `Grid` with an `Image`.

    ```xaml
    <Shell.FlyoutHeader>
        <Grid HeightRequest="100" BackgroundColor="DarkSlateBlue">
            <Image Source="moon.png" />
        </Grid>
    </Shell.FlyoutHeader>
    ```

    :::image type="content" source="../media/3-flyout-with-moon.png" alt-text="Screenshot of the app running with the flyout open, this time there's a header on the flyout with an icon of the moon.":::
