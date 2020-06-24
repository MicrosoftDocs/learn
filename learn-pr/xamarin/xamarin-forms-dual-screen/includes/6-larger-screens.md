The `TwoPaneView` control includes adaptive layout features that can intelligently lay out the two panes on tablets and desktops.

The following properties affect the layout when it's only rendering on one screen:

- **MinTallModeHeight** – indicates the minimum height the control must be to enter tall mode.
- **MinWideModeWidth** – indicates the minimum width the control must be to enter wide mode.
- **Pane1Length** – sets the width of Pane1 in Wide mode, the height of Pane1 in Tall mode, and has no effect in SinglePane mode.
- **Pane2Length** – sets the width of Pane2 in Wide mode, the height of Pane2 in Tall mode, and has no effect in SinglePane mode.

Using these properties you can create a layout that can be 

```csharp
twoPaneView.MinWideModeWidth = 600;
twoPaneView.Pane1Length = new GridLength(1, GridUnitType.Star);
twoPaneView.Pane2Length = new GridLength(3, GridUnitType.Star);
twoPaneView.TallModeConfiguration = TwoPaneViewTallModeConfiguration.TopBottom;
twoPaneView.WideModeConfiguration = TwoPaneViewWideModeConfiguration.LeftRight;
```

```csharp
<dualScreen:TwoPaneView
    MinWideModeWidth="600"
    Pane1Length="1*"
    Pane2Length="3*"
    TallModeConfiguration="TopBottom"
    WideModeConfiguration="LeftRight">
```
