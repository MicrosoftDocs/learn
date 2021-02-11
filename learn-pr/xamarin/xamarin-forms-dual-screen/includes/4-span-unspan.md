Previously we showed how `TwoPaneView` can be used to create a split layout, but it did not adapt well to display on a single screen.

The `TwoPaneView` can be dynamically configured by responding to changes in the device and application configuration, including:

- Device rotation
- Device folding and unfolding (eg. if one of the screens gets turned off or on)
- Application spanning and unspanning across two screens

When any of these events occurs, you may want the application layout to change to adjust to the new orientation, or the number of screens available.

## Property changed event

The `DualScreenInfo` helper class provides a `PropertyChanged` event that you can subscribe to, and then update your controls appropriately. Use content page lifecycle methods to set and remove an event handler:

```csharp
protected override void OnAppearing()
{
    base.OnAppearing();
    DualScreenInfo.Current.PropertyChanged += DualScreen_PropertyChanged;
}
protected override void OnDisappearing()
{
    DualScreenInfo.Current.PropertyChanged -= DualScreen_PropertyChanged;
    base.OnDisappearing();
}
void DualScreen_PropertyChanged(object sender, PropertyChangedEventArgs e)
{
    // Update layout to respond to changes like rotation or spanning
    UpdateLayouts();
}
```

## Determining if the application is spanned

`DualScreenInfo.Current.SpanMode` can be used to check whether the application is spanned. You can create a property to check for spanning like this:

```csharp
bool DeviceIsSpanned => DualScreenInfo.Current.SpanMode != TwoPaneViewMode.SinglePane;
```

## Changing the layout dynamically

Using the `PropertyChanged` event and the `DeviceIsSpanned` property we can write a method that adapts to application spanning. The example below ensures that when the application is spanned across both screens, the `TwoPaneView` displays both panes (`TopBottom` or `LeftRight`) regardless of orientation. When on a single screen, only the first pane is shown.

```csharp
void UpdateLayouts()
{
    if (DeviceIsSpanned)
    {   // dual-screen: list and detail appear side-by-side
        twoPaneView.TallModeConfiguration = TwoPaneViewTallModeConfiguration.TopBottom;
        twoPaneView.WideModeConfiguration = TwoPaneViewWideModeConfiguration.LeftRight;
    }
    else
    {   // single-screen: only show the list view
        twoPaneView.PanePriority = TwoPaneViewPriority.Pane1;
        twoPaneView.TallModeConfiguration = TwoPaneViewTallModeConfiguration.SinglePane;
        twoPaneView.WideModeConfiguration = TwoPaneViewWideModeConfiguration.SinglePane;
    }
}
```

Because the second pane is only shown when the application is spanned, you should write additional code to manage navigation to that view when required.

`DualScreenInfo` has additional properties that you could use to update your own custom layouts for single- or dual-screen display:

- **SpanningBounds** – when spanned across two screens, return two rectangles indicating the bounds of each visible area. If the window isn't spanned this will return an empty array.
- **HingeBounds** – the position of the hinge on the screen. You can use this information to ensure your custom layouts don't get obscured by the hinge.
