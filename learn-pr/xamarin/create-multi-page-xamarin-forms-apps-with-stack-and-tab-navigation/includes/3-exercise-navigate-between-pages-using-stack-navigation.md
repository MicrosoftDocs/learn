You'll be working on the planetarium **Astronomy** app. There's some starter code to get you going. Your job is to add stack navigation by using a `NavigationPage` to let the user take a linear path through several pages, and then back again.

## Open the starter solution

1. Clone or download the [!INCLUDE [module-exercise-repo](module-exercise-repo.md)] from GitHub.

    [!include[](../../../includes/android-windows-path-length-warning.md)]

1. Open the starter solution from the **exercise1** > **start** folder by using **Visual Studio**.

## Add a NavigationPage

We'll use a `NavigationPage` to add stack navigation to the starter Astronomy app. The `NavigationPage` will be the first page your app displays.

1. Open **App.xaml.cs**.
2. Find the `App` constructor, and change the `MainPage` to a new instance of `NavigationPage`.
3. Pass in an instance of `Astronomy.MainPage` to the `NavigationPage` constructor.

```csharp
public App ()
{
    InitializeComponent();

    MainPage = new NavigationPage(new Astronomy.MainPage());
}
```

## Add the navigation UI

1. Open **MainPage.xaml**.
2. Add a new `Button` in the `StackLayout`, below the `Label`.
3. Name the button `btnSunrise`.
4. Set the button text to **Sunrise and Sunset**.
5. Add three more buttons:
    * Name: `btnMoonPhase`, Text: **Moon Phase**
    * Name: `btnSpaceInfo`, Text: **Astronomical Bodies**
    * Name: `btnAbout`, Text: **About Contoso Astronomy**

```xaml
<ContentPage ...>
    <StackLayout>
        ...
        <Button x:Name="btnSunrise" Text="Sunrise and Sunset" />
        <Button x:Name="btnMoonPhase" Text="Moon Phase" />
        <Button x:Name="btnSpaceInfo" Text="Astronomical Bodies" />
        <Button x:Name="btnAbout" Text="About Contoso Astronomy" />
    </StackLayout>
</ContentPage>
```

## Move to the selected page

You'll respond to your new buttons' `Clicked` events, and move to the appropriate page.

1. Open **MainPage.xaml.cs**.
2. Add the button `Clicked` event handlers in the page constructor for the four buttons you created in the previous step.
    * For `btnSunrise`, assign a `Navigation.PushAsync` call with a new `SunrisePage`.
    * For `btnMoonPhase`, assign a `Navigation.PushAsync` call with a new `MoonPhasePage`.
    * For `btnSpaceInfo`, assign a `Navigation.PushAsync` call with a new `AstronomicalBodiesPage`.
    * For `btnAbout`, assign a `Navigation.PushAsync` call with a new `AboutPage`.
3. Optionally, inspect **AstronomicalBodies**. Notice that it also uses stack navigation to let you move one level deeper in the content hierarchy.
4. Run the application and move forward and backward through the application content.

```csharp
public MainPage()
{
    InitializeComponent();

    btnSunrise.Clicked += (s, e) => Navigation.PushAsync(new SunrisePage());
    btnMoonPhase.Clicked += (s, e) => Navigation.PushAsync(new MoonPhasePage());
    btnSpaceInfo.Clicked += (s, e) => Navigation.PushAsync(new AstronomicalBodiesPage());
    btnAbout.Clicked += (s, e) => Navigation.PushAsync(new AboutPage());
}
```

You now have the app set up for stack navigation. You push new pages onto the stack with button click handlers, and allow the user to return to previous pages by using system-specific, back-navigation buttons or gestures.
