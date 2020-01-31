All the exercises in this module relate to the prebuilt FlagFacts application. You'll modify and improve this app throughout this module. In this exercise, you'll create a `ListView` control and populate it with string data. You'll also use the `ItemTapped` event to display a details page.

## Open the starter solution

1. Clone or download the [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].

    [!include[](../../../includes/android-windows-path-length-warning.md)]

1. Open the **exercise1** > **start** folder.

1. Open the **FlagFacts.sln** solution.

## Test the application behavior

Run the application on either iOS or Android. Spend a few minutes exploring the app to get familiar with its behavior. The application displays a single flag, allows you to edit the details of the flag, and lets you switch between flags by using toolbar buttons.

## Create a XAML content page

Here we're going to replace the current startup page with a new `ContentPage` instance.

1. Add a new XAML `ContentPage` to the **FlagFacts** project. Name it `AllFlagsPage`.

1. Open the **AllFlagsPage.xaml** file and set the `Title` property to **"Fun with Flags"**.

1. Delete any existing UI from the XAML.

1. Open the **App.xaml.cs** file and locate the constructor.

1. Create an instance of your `AllFlagsPage` content page.

1. Create a new `NavigationPage` (or reuse the existing code), passing in the `AllFlagsPage` instance.

1. Assign the `NavigationPage` (that contains the `AllFlagsPage` page) to the `MainPage` property.

1. Build and run the app. It should display an empty page.

Here's the code for the **App.xaml.cs** constructor:

```csharp
public App()
{
    DependencyService.Register();

    InitializeComponent();
    MainPage = new NavigationPage(new AllFlagsPage());
}
```

## Add a ListView

Now that you've created a content page, add a `ListView` control to display the flags.

1. Open **AllFlagsPage.xaml**.

1. Add a `ListView` control as the root tag inside the `ContentPage` instance.

    ```xaml
    <ContentPage xmlns="http://xamarin.com/schemas/2014/forms"
            xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
            Title="Fun with Flags"
            x:Class="FlagFacts.AllFlagsPage">

        <ListView />

    </ContentPage>
    ```

1. Open **AllFlagsPage.xaml.cs**.

1. In the constructor, set the page's `BindingContext` property to `FlagFactsViewModel`. You can get an instance of the view model by using the `DependencyService.Get<FlagFactsViewModel>()` method.

    ```csharp
    public AllFlagsPage()
    {
        BindingContext = DependencyService.Get<FlagDetailsViewModel>();
        ...
    }
    ```

1. Open **AllFlagsPage.xaml**.

1. Set the `ItemSource` property of the `ListView` control to the `Flags` collection.

    ```xml
    <ListView ItemsSource="{Binding Flags}" />
    ```

1. Run the application. It should display a list of items. Each item shows the class name **FlagData.Flag**. To customize the string, we need to override the `ToString` method for our `Flag` class.

1. Open the **Flag.cs** file in the **FlagData** project. There, override the `ToString` method. Have the method return the value of the `Country` property.

    ```csharp
    public override string ToString()
    {
        return Country;
    }
    ```

1. Run the application and verify that your `ListView` control is populated with the name of the countries.

## Bind to SelectedItem

Our application now displays a `ListView` control populated with the name of countries. Let's start adding some interactivity by letting our users select a country. We'll start off defining a two-way binding to the `CurrentFlag` property. This binding will allow us to keep track of which country was selected and let us change the currently selected country from code.

Add a binding in the XAML for the `ListView.SelectedItem` property to connect it to the `CurrentFlag` property. Make sure it's marked as a two-way binding.

   ```xml
   <ListView ItemsSource="{Binding Flags}" SelectedItem="{Binding CurrentFlag, Mode=TwoWay}" />
   ```

## Go to the details page

Finally, we're going to handle the tapped action and display a details screen.

1. Subscribe to the `ItemTapped` event on the `ListView` control. You can subscribe in XAML or in code-behind (if the element has a name).

1. In your handler, use the page's `Navigation` property to go to a new instance of the details page. Use the `PushAsync` method; you can use the C# `async` and `await` support to ensure you see exceptions.

    ```csharp
    async void OnItemTapped(object sender, ItemTappedEventArgs e)
    {
        await this.Navigation.PushAsync(new FlagDetailsPage());
    }
    ```

1. Run the application. Tap an item to go to the details page. Change the current flag on the details page by using the up button or down button. Then go back to the `ListView` and note that it tracks the current selection.