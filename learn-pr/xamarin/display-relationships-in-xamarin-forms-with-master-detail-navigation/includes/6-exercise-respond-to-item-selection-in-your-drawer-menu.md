For this exercise, you'll return to the **Astronomy** app. You'll update the detail view when the user selects a page from the drawer menu.

## Open the starter solution

This exercise is a continuation of the completed prior exercise. Open the completed solution from **exercise1** > **final** by using **Visual Studio**.

## Create an enumeration for your app's pages

You'll define an `enum` instance that represents your app's pages. This enumeration will help your code's readability when the app raises selection events.

1. Create a new file in the **Astronomy** shared project named **PageTypes.cs**.

1. Define the `Astronomy` namespace.

1. Create a new `enum` instance named `PageType`.

1. Add values for each of your app's pages: `Sunrise`, `MoonPhase`, `Earth`, `Moon`, `Sun`, `About`.

```csharp
namespace Astronomy
{
    public enum PageType
    {
        Sunrise,
        MoonPhase,
        Earth,
        Moon,
        Sun,
        About,
    }
}
```

## Raise a selection event

Your application presents several buttons in the master page for navigation. However, they're currently not doing any work. You'll add an event to the master page and raise the event when the buttons are pressed.

1. Open **AstronomyMasterPage.xaml.cs**.

1. Create a new public event named `PageSelected` that provides a `PageType` argument. Make sure to include `using Astronomy.Astronomy;` to resolve `enum`.

1. In the constructor, add `Clicked` event handlers for each button to raise the `PageSelected` event with an appropriate `PageType` value.

```csharp
public partial class AstronomyMasterPage : ContentPage
{
    public event EventHandler<PageType> PageSelected;

    public AstronomyMasterPage()
    {
        InitializeComponent();

        btnMoonPhase.Clicked += (s, e) => PageSelected?.Invoke(this, PageType.MoonPhase);
        btnSunrise.Clicked += (s, e) => PageSelected?.Invoke(this, PageType.Sunrise);
        btnAbout.Clicked += (s, e) => PageSelected?.Invoke(this, PageType.About);

        btnEarth.Clicked += (s, e) => PageSelected?.Invoke(this, PageType.Earth);
        btnMoon.Clicked += (s, e) => PageSelected?.Invoke(this, PageType.Moon);
        btnSun.Clicked += (s, e) => PageSelected?.Invoke(this, PageType.Sun);
    }
}
```

## Present the detail page

You'll add a helper method in `AstronomyMasterDetailPage` that updates the detail page based on a passed-in `PageType` enumeration.

1. Add a new `void` method named `PresentDetailPage` that accepts a `PageType` parameter. Remember to include `using Astronomy.Pages;` to resolve `enum`.

1. Create a local `Page` variable named `page`.

1. Add a `switch` statement based on the passed-in `PageType` enumeration. For each value, instantiate the appropriate detail page and assign it to the local `page` variable.

1. After the `switch` statement, wrap `page` in a `NavigationPage` instance to ensure that the menu icon appears on Android devices.

1. Assign `page` to the `Detail` property.

1. Close the drawer by setting `IsPresented` to `false`.

```csharp
void PresentDetailPage(PageType pageType)
{
    Page page;

    switch (pageType)
    {
        case PageType.Sunrise:
            page = new SunrisePage();
            break;
        case PageType.MoonPhase:
            page = new MoonPhasePage();
            break;
        case PageType.Earth:
            page = new AstronomicalBodyPage(SolarSystemData.Earth);
            break;
        case PageType.Moon:
            page = new AstronomicalBodyPage(SolarSystemData.Moon);
            break;
        case PageType.Sun:
            page = new AstronomicalBodyPage(SolarSystemData.Sun);
            break;
        case PageType.About:
        default:
            page = new AboutPage();
            break;
    }

    Detail = new NavigationPage(page);

    IsPresented = false;
}
```

## Respond to menu selection

You're now ready to respond to selection events. You'll subscribe in the master-detail page and update the details UI.

1. In the **AstronomyMasterDetailPage.cs** constructor, subscribe to the new `MasterPageSelected` event. When the event is raised, call `PresentDetailsPage`, passing in the provided `PageType` instance.

    ```csharp
    public AstronomyMasterDetailPage()
    {
        var master = new AstronomyMasterPage();

        ...

        master.PageSelected += MasterPageSelected;
        PresentDetailPage(PageType.Sunrise);
    }

    void MasterPageSelected(object sender, PageType e)
    {
        PresentDetailPage(e);
    }
    ```

1. Run the app to test your work.
