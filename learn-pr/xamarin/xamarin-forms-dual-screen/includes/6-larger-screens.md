The `TwoPaneView` control includes adaptive features that allow you to customize the layout of the two panes, whether on phones, tablets, or desktops.

The following properties affect the layout of the two panes:

- **Pane1Length** – sets the width of Pane1 in wide mode, the height of Pane1 in tall mode, and has no effect in SinglePane mode.
- **Pane2Length** – sets the width of Pane2 in wide mode, the height of Pane2 in wall mode, and has no effect in SinglePane mode.
- **MinWideModeWidth** – indicates the minimum width the control must be to enter wide mode.
- **MinTallModeHeight** – indicates the minimum height the control must be to enter tall mode.

Using these properties you can create a layout that can be scaled onto large screens while displaying both panes.

## Set pane length

The following code snippets show how to configure a large-screen layout that proportionally distributes the two panes using either C# or XAML.

```csharp
twoPaneView.Pane1Length = new GridLength(1, GridUnitType.Star);
twoPaneView.Pane2Length = new GridLength(3, GridUnitType.Star);
```

```xaml
<dualScreen:TwoPaneView
    Pane1Length="1*"
    Pane2Length="3*">
```

The panes will be laid out in either wide or tall mode, and sized according to the pane length values. In addition to proportional (`Star`) values, you can also use fixed sizes.

When the app is spanned across two screens, these properties are ignored. Each pane will fill an entire screen unless forced into `SinglePane` mode.

## Change pane order

The following code snippets show how to configure the order that the panes appear, using either C# or XAML.

```csharp
// set the location of both views
twoPaneView.TallModeConfiguration = TwoPaneViewTallModeConfiguration.TopBottom;
twoPaneView.WideModeConfiguration = TwoPaneViewWideModeConfiguration.LeftRight;
// or force only a single view to appear
twoPaneView.TallModeConfiguration = TwoPaneViewTallModeConfiguration.SinglePane;
twoPaneView.WideModeConfiguration = TwoPaneViewWideModeConfiguration.SinglePane;
twoPaneView.PanePriority = TwoPaneViewPriority.Pane1; // or Pane2
```

```xaml
<dualScreen:TwoPaneView
    TallModeConfiguration="TopBottom"
    WideModeConfiguration="LeftRight">
```

or

```xaml
<dualScreen:TwoPaneView
    TallModeConfiguration="SinglePane"
    WideModeConfiguration="SinglePane"
    TwoPaneViewPriority="Pane1">
```

The default values are `TopBottom` and `LeftRight` respectively, but you can choose `BottomTop` or `RightLeft` to switch the two views around.

You can also choose `SinglePane` mode for either tall mode, or wide mode, or both. In that case, you can control which view is shown using `TwoPaneViewPriority`.

## Set minimum width or height

The two properties `MinTallModeHeight` and `MinWideModeWidth` determine whether the panes are shown side by side, or one above the other, when shown on a single screen (including large screens). The properties are evaluated in this order:

1. If the width of the screen exceeds `MinWideModeWidth`, the panes will be positioned side by side (dual-portrait or "wide mode"). This is the default on the Surface Duo.
1. If the screen width is smaller than the `MinWideModeWidth` _and_ the screen height exceeds `MinTallModeHeight`, the panes will be positioned one above the other (dual-landscape or "tall mode").
1. If neither the screen width nor height exceeds the minimums required, only a single pane will be shown.

When the app is spanned across both screens of a dual-screen device, these properties are ignored. Each pane will fill an entire screen unless forced into `SinglePane` mode.

## Navigation

When both panes are visible your application code should manage the communication between the panes (versus using the navigation stack on smaller screens).
