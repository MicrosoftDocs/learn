

## Add DualScreenInfo to AllFlagsPage

1. Create a `DeviceIsSpanned` property using `DualScreenInfo`:

    ```csharp
    using Xamarin.Forms.DualScreen;
    // ...
    public bool DeviceIsSpanned => DualScreenInfo.Current.SpanMode != TwoPaneViewMode.SinglePane;
    ```

1. Add a field `wasSpanned` to the class, which will be used to keep track of the window state:

    ```csharp
    // is notbe spanned when first viewed...
    bool wasSpanned = false;
    ```

1. Add `OnAppearing` and `OnDisappearing` overrides to respond to dual-screen property changes:

    ```csharp
    protected override void OnAppearing()
    {
        base.OnAppearing();
        DualScreenInfo.Current.PropertyChanged += Current_PropertyChanged;
        UpdateLayouts(); // for first page load
    }
    protected override void OnDisappearing()
    {
        DualScreenInfo.Current.PropertyChanged -= Current_PropertyChanged;
        base.OnDisappearing();
    }
    ```

1. Implement the method `Current_PropertyChanged` and `UpdateLayouts`.

    ```csharp
    void Current_PropertyChanged(object sender, PropertyChangedEventArgs e)
    {
        UpdateLayouts();
    }
    async void UpdateLayouts()
    {
        if (DeviceIsSpanned)
        {   //
            twoPaneView.TallModeConfiguration = TwoPaneViewTallModeConfiguration.TopBottom;
            twoPaneView.WideModeConfiguration = TwoPaneViewWideModeConfiguration.LeftRight;
            wasSpanned = true;
        }
        else
        {   // single-screen
            twoPaneView.PanePriority = TwoPaneViewPriority.Pane1;
            twoPaneView.TallModeConfiguration = TwoPaneViewTallModeConfiguration.SinglePane;
            twoPaneView.WideModeConfiguration = TwoPaneViewWideModeConfiguration.SinglePane;
            // wasSpanned check is needed, or this will open on first-run or rotation
            // stack count is needed, or we might push multiple on rotation
            if (wasSpanned && Navigation.NavigationStack.Count == 1)
            {   // open the detail page
                await Navigation.PushAsync(new FlagDetailsPage());
            }
            wasSpanned = false;
        }
    }
    ```

    The `UpdateLayouts` method will now be called whenever the app is spanned or unspanned (or the detail is rotated). When spanned, the `twoPaneView` is configured to show the two views side-by-side. When the app is on a single screen, only the list is shown.

    When the app is moved to single screen, the `if` statement checks if the app was previously spanned, and if so, pushes the flag details onto the navigation stack. This ensures the app navigation works as expected when unspanning back to a single screen.

1. Revisit the **AllFlagsView.cs** code behind to uncomment the `ListView_FlagTapped` method, and add a check for `!IsDeviceSpanned`:

    ```csharp
    private async void ListView_FlagTapped(object sender, ItemTappedEventArgs e)
    {
        if (!DeviceIsSpanned)
        {   // use Navigation on single screen
            await this.Navigation.PushAsync(new FlagDetailsPage());
        }
    }
    ```

    This method will now use the `Navigation` class to push the flag details if the app is on a single screen. This ensures the navigation works as expected on all single-screen devices.

## Run the app

Now when you start the app on a single screen, it uses the navigation stack to switch between the list and the detail page.