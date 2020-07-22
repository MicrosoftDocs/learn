The `TwoPaneView` control includes adaptive layout features that can intelligently lay out the two panes on tablets and desktops.

The following properties affect the layout when it's only rendering on one screen (whether it's a phone, tablet, or desktop):

- **MinTallModeHeight** – indicates the minimum height the control must be to enter tall mode.
- **MinWideModeWidth** – indicates the minimum width the control must be to enter wide mode.
- **Pane1Length** – sets the width of Pane1 in Wide mode, the height of Pane1 in Tall mode, and has no effect in SinglePane mode.
- **Pane2Length** – sets the width of Pane2 in Wide mode, the height of Pane2 in Tall mode, and has no effect in SinglePane mode.

Using these properties you can create a layout that can be scaled onto large screens while displaying both panes. The following code snippets show how to configure a large-screen layout that proportionally distributes the two panes using either C# or XAML.

```csharp
twoPaneView.Pane1Length = new GridLength(1, GridUnitType.Star);
twoPaneView.Pane2Length = new GridLength(3, GridUnitType.Star);
twoPaneView.TallModeConfiguration = TwoPaneViewTallModeConfiguration.TopBottom;
twoPaneView.WideModeConfiguration = TwoPaneViewWideModeConfiguration.LeftRight;
```

```xaml
<dualScreen:TwoPaneView
    Pane1Length="1*"
    Pane2Length="3*"
    TallModeConfiguration="TopBottom"
    WideModeConfiguration="LeftRight">
```

You can also use the minimum width or height properties to control how the two panes are displayed.

When both panes are visible your application code should manage the navigation between the panes (versus using the navigation stack on smaller screens).
