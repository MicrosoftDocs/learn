<!-- See comment at the start of the previous unit about Navigation Pages within Tabbed Pages on Android and iOS-->

In the astronomy app, you've been asked to add pages that enable the user to select different astronomical bodies and display their details. There may any number of bodies, so creating a tab for each body isn't a feasible approach. Therefore, to enable the user to select which body to view, you decide to add another page containing a list. The user will be able to select the body from this list. The app will then display the details for that body in a new page. The list page will act as a *root page* for stack navigation. You'll add the list page as a tab in the existing user interface.

:::image type="content" source="../media/7-stack-navigation.png" alt-text="The stack navigation model for moving between pages for astronomical bodies.":::

## Open the starter solution

1. Go to the **exercise3** folder in repo that you cloned in exercise 1, and then move to the **start** folder.

1. Use Visual Studio to open the **Astronomy.sln** solution.

    > [!NOTE]
    > This solution contains additional pages that aren't in the version of the app you used in the previous exercises.

1. In the Solution Explorer window, open the **Pages** folder. As well as the **MoonPhasePage**, **SunrisePage**, and **AboutPage** files, this folder contains two additional pages:

- **AstronomicalBodiesPage**. This page contains four buttons that enable the user to select the details for the Sun, the Moon, the Earth, or Halley's Comet. The current version of the app is simply a proof of concept. In the future, this page will enable the user to select from a much bigger list.

- **AstronomicalBodyPage**. This page is used to display the information for an astronomical body. The `AstronomicalBodiesPage` runs the code shown below for each of the buttons to create an instance of `AstronomicalBodyPage` and push it onto the navigation stack.

    ```csharp
    public AstronomicalBodiesPage()
    {
        InitializeComponent();
    
        btnEarth.Clicked += (s, e) => Navigation.PushAsync(new AstronomicalBodyPage(SolarSystemData.Earth));
        btnMoon.Clicked += (s, e) => Navigation.PushAsync(new AstronomicalBodyPage(SolarSystemData.Moon));
        btnSun.Clicked += (s, e) => Navigation.PushAsync(new AstronomicalBodyPage(SolarSystemData.Sun));
        btnComet.Clicked += (s, e) => Navigation.PushAsync(new AstronomicalBodyPage(SolarSystemData.HalleysComet));
    }
    ```

    The data for each of these pages is held in the `SolarSystemData` class, in the **Data** folder of the project.

## Display astronomical bodies within the tab page

1. Open the **MainPage.xaml** file.

1. Add the `local:AstronomicalBodiesPage` page as a tab to the `TabbedPage`, before the **About** page. Wrap the page in a `NavigationPage` as shown in the example below:

    ```xml
    <TabbedPage ...
                ...>

        <TabbedPage.Children>
            <local:MoonPhasePage IconImageSource="moon.png"/>
            <local:SunrisePage Title="Daylight" IconImageSource="sun.png"/>
            <NavigationPage Title="Bodies" IconImageSource="comet.png">
                <x:Arguments>
                    <local:AstronomicalBodiesPage/>
                </x:Arguments>
            </NavigationPage>
            <local:AboutPage Title="About" IconImageSource="question.png"/>
        </TabbedPage.Children>
    </TabbedPage>
    ```

1. Build and run the app using the Android emulator. When the app starts, notice that the tab bar now includes a **Bodies** tab:

    :::image type="content" source="../media/7-app-android-with-bodies-tab.png" alt-text="The Astronomy app running on Android. The tab bar now includes a tab for astronomical bodies.":::

1. Select the **Bodies** tab. The **Astronomical Bodies** page will appear and contain a set of four buttons; one for each body that the user can select. A navigation bar should be displayed at the top of the screen:

    <!-- Image from the Android Emulator to go here -->

1. Select the Earth button. The details for the Earth should appear. The navigation bar should contain a *back arrow* that enables the user to return to the list of bodies. The remaining tabs are still visible and active:

    <!-- Image from the Android Emulator to go here -->

1. Close the app and return to Visual Studio.

## If you have time: Display astronomical bodies outside the tab page

The previous task shows how to use the navigation stack within the tabbed page. In this task, you'll navigate away from the tabbed page when the details for an astronomical body are displayed.

1. Open the **MainPage.xaml** file.

1. Remove the `NavigationPage` wrapper surrounding the `AstronomicalBodiesPage` class, and add the title and icon to the `AstronomicalBodiesPage` element:

    ```xml
    <TabbedPage ...
                ...>

        <TabbedPage.Children>
            <local:MoonPhasePage IconImageSource="moon.png"/>
            <local:SunrisePage Title="Daylight" IconImageSource="sun.png"/>
            <local:AstronomicalBodiesPage Title="Bodies" IconImageSource="comet.png"/>
            <local:AboutPage Title="About" IconImageSource="question.png"/>
        </TabbedPage.Children>
    </TabbedPage>
    ```

1. Open the **App.xaml.cs** file.

1. In the `App` constructor, wrap the `MainPage` object that is created inside a new `NavigationPage` object:

    ```csharp
    public App()
    {
        InitializeComponent();

        MainPage = new NavigationPage(new MainPage());
    }
    ```

1. Build and run the app using the Android emulator. Notice that the tab bar still includes a **Bodies** tab.

1. Select the **Bodies** tab. The **Astronomical Bodies** page should appear as before. However, this time no navigation bar is displayed at the top of the screen:

    <!-- Image from the Android Emulator to go here -->

1. Select the Earth button. The details for the Earth should appear. The navigation bar should contain a *back arrow* that enables the user to return to the list of bodies. The tab bar has disappeared.

    <!-- Image from the Android Emulator to go here -->

1. Select the *back arrow*. The **Astronomical Bodies** page should reappear, together with the tab bar.

1. Close the app and return to Visual Studio.
