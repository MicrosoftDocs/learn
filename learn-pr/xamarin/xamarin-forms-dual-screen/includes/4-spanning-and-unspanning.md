The TwoPaneView can be dynamically configured by responding to changes in the device and application configuration, including:

- Device rotation
- Device folding and unfolding (especially if one of the screens gets turned off)
- Application spanning and unspanning

## Property changed event

The `DualScreenInfo` helper class provides a `PropertyChanged` event that you can subscribe to, and then update your controls appropriately. 

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
private void DualScreen_PropertyChanged(object sender, PropertyChangedEventArgs e)
{
    // Update layout to respond to changes like rotation or spanning
    UpdateLayouts();
}
```

## Determining if the application is spanned

The `DualScreenInfo.Current.SpanMode` property can be used to check whether the application is spanned. This property can be added to your app:

```csharp
public bool DeviceIsSpanned => DualScreenInfo.Current.SpanMode != TwoPaneViewMode.SinglePane;
```

## Changing the layout dynamically

Using the `PropertyChanged` event and the `DeviceIsSpanned` property we can write a method that adapts to application spanning. The example below ensures that when the application is spanned across both screens, the `TwoPaneView` displays both panes (`TopBottom` or `LeftRight`) regardless of orientation. When on a single screen, only the first pane is shown.

```csharp
public async void UpdateLayouts()
{
    if (DeviceIsSpanned)
    {
        twoPaneView.TallModeConfiguration = TwoPaneViewTallModeConfiguration.TopBottom;
        twoPaneView.WideModeConfiguration = TwoPaneViewWideModeConfiguration.LeftRight;
    }
    else
    {   // single-screen
        twoPaneView.PanePriority = TwoPaneViewPriority.Pane1;
        twoPaneView.TallModeConfiguration = TwoPaneViewTallModeConfiguration.SinglePane;
        twoPaneView.WideModeConfiguration = TwoPaneViewWideModeConfiguration.SinglePane;
    }
}
```

Because the second pane is only shown when the application is spanned, you should write additional code to manage navigation to that view when required.