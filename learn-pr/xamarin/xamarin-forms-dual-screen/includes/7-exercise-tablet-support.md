In this exercise, we're going to adapt the display for larger screen sizes like tablets and desktops. `TwoPaneView` can set to the two panes to specific widths or proportionally, and we can use the same 

We'll continue with the solution from the previous exercise. If you don't already have it, you can open the solution from the **exercise2 > final** folder in your copy of the cloned or downloaded [!INCLUDE [module-exercise-repo](module-exercise-repo.md)] in Visual Studio.

## Detect larger screens

We can use the Xamarin.Forms `Device` class to detect whether the app is running on a large screen.

Add the following code to both **AllFlagsPage.xaml.cs**:

```csharp
public bool DeviceIsBigScreen => (Device.Idiom == TargetIdiom.Tablet) || (Device.Idiom == TargetIdiom.Desktop);
```

## Update layout and navigation

1. Open the **AllFlagsPage.xaml.cs** codebehind.
1. Update `ListView_FlagTapped` so that the navigation is not used when the app is running on a large screen, by changing the if clause to `!DeviceIsSpanned && !DeviceIsBigScreen`. The method should look like this:

    ```csharp
    private async void ListView_FlagTapped(object sender, ItemTappedEventArgs e)
    {
        if (!DeviceIsSpanned && !DeviceIsBigScreen)
        {   // use Navigation only on phone-size single-screens
            await this.Navigation.PushAsync(new FlagDetailsPage());
        }
    }
    ```

1. Change the `UpdateLayouts` method so that the `LeftRight` configuration is used for both spanned and large screens. When the device has a large screen, also set the two panes to be sized proportionally: one third for the list and two thirds for the detail view:

    ```csharp
    public async void UpdateLayouts()
    {
        if (DeviceIsSpanned || DeviceIsBigScreen)
        {   // two panes: side by side
            twoPaneView.TallModeConfiguration = TwoPaneViewTallModeConfiguration.TopBottom;
            twoPaneView.WideModeConfiguration = TwoPaneViewWideModeConfiguration.LeftRight;
            wasSpanned = true;

            if (DeviceIsBigScreen)
            {   // proportional layout 1/3 for list, 2/3 for details
                twoPaneView.Pane1Length = new GridLength(1, GridUnitType.Star);
                twoPaneView.Pane2Length = new GridLength(2, GridUnitType.Star);
            }
        }
    // ... remainder of method unchanged
    ```

1. Run the app on a tablet or desktop computer support by Xamarin.Forms, and the layout will adapt to resemble the dual-screen size-by-side appearance:

    ![Tablet showing proportional TwoPaneView layout](../media/7-tablet-wide.png)
