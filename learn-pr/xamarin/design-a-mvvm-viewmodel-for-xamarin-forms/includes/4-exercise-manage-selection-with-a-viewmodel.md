For our exercise, we'll briefly leave behind the example of the human resources app. Instead we'll work with an application that lists famous quotes. The app already has a couple of pages and viewmodels that have some basic bindings. The two pages are a list page and a detail page. We'll  modify the selection logic so that the `ListView` and the detail page use the same viewmodel property.

## Open the starter solution

Open the starter solution from the **exercise1** > **start** folder in your copy of the cloned or downloaded [!INCLUDE [module-exercise-repo](module-exercise-repo.md)] in Visual Studio.

[!include[](../../../includes/android-windows-path-length-warning.md)]

The application displays quotes by using an XML data file as the backing storage. Build and run the app to make sure that it's working before you make changes.

## Examine the code

The *GreatQuotes* project is the common library where the Xamarin.Forms code resides. Take a few minutes to look at the existing solution and see how the viewmodels and pages are structured. If you're familiar with XAML and data-binding in Xamarin.Forms, it should all look familiar. But it's structured by using the MVVM pattern.

There's a `MainViewModel` that serves dual duty as the app's overall viewmodel and as the viewmodel for the `QuoteListPage`. The other viewmodel is `QuoteViewModel`. It also serves dual duty:  provide data for the rows in the list page and as the `BindingContext` for the `QuoteDetailPage`.

This library also contains the rest of the Xamarin.Forms content: the XAML pages, converters, and common data structures that the pass uses.

## Add selection support

The first step is to add some property support for selection.

1. Open the `MainViewModel` and add a new public property of type `QuoteViewModel` that's named **SelectedQuote**. Use a public getter and setter, and use a backing field.
1. Make sure to implement property-change notification when you set the new property. As a shortcut, you can use the `SetPropertyValue` method from the base view model. This step sets the underlying field and raises a property-change notification. It has the following form:

    ```csharp
    SetPropertyValue<T>(ref T field, T newValue);
    ```

    ```csharp
    QuoteViewModel selectedQuote;
    public QuoteViewModel SelectedQuote {
        get {
            return selectedQuote;
        }
        set {
            SetPropertyValue(ref selectedQuote, value);
        }
    }
    ```

1. Next, let's use the property. Open the **QuoteListPage.xaml** file and locate the `ListView`. Add a new property binding for the `SelectedItem` property to the view model property. Use a two-way binding (`Mode` property). Leave the `ItemTapped` event handler in place. You still need that to handle navigation in this simple app. (Most MVVM frameworks have some sort of navigation tool to handle it in the viewmodel, so we'd be able to get rid of that, too.)

    ```xml
    <ListView ItemsSource="{Binding Quotes}"
        SelectedItem="{Binding SelectedQuote, Mode=TwoWay}"
        ItemTapped="OnQuoteSelected">
    ```

1. Next, open the code-behind file (**QuoteListPage.xaml.cs**), and locate the `OnQuoteSelected` method. It currently passes the tapped item to the `QuoteDetailPage` as part of the constructor. Remove the constructor parameter. You don't need it anymore, as long as the second page has access to the view model!
1. Finally, open the **QuoteDetailPage.xaml.cs** file and fix the constructor to not take the parameter. Instead, change the `BindingContext` to be the `SelectedQuote` property of the `MainViewModel`. Remember that the view model is a singleton that's exposed by the `App` class.
1. Run the application, and make sure it still works properly. It should correctly navigate and  display the quote details on the second screen. But there's a minor but annoying bug on some platforms: When you return to the original screen, the `ListView` still shows the selection, and the cell that you tapped is highlighted. Let's fix that.
1. In the `QuoteDetailPage` constructor, clear the `SelectedQuote` property (set it to `null`) after you set the `BindingContext`. This clears the `ListView` selection.
1. Run the app again to verify the change.
