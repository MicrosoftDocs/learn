Dual screen 

## NuGet

1. Add the **Xamarin.Forms.Dualscreen** NuGet to your solution.
1. In the Android project
   ```csharp
    Xamarin.Forms.DualScreen.DualScreenService.Init(this);
    ```

## DualScreenInfo

The `DualScreenInfo` class provides a number of methods

- **SpanningBounds** – when spanned across two screens, return two rectangles indicating the bounds of each visible area. If the window isn't spanned this will return an empty array.
- **HingeBounds** – the position of the hinge on the screen.
- **IsLandscape** – if the device is landscape. This is useful because native orientation APIs don't report orientation correctly when an application is spanned.
- **SpanMode** – whether the layout is in tall, wide, or single pane mode.

## TwoPaneView



```xaml
<ContentPage xmlns:dualScreen="clr-namespace:Xamarin.Forms.DualScreen;assembly=Xamarin.Forms.DualScreen">
    <dualScreen:TwoPaneView>
        <dualScreen:TwoPaneView.Pane1>
            <StackLayout>
                <Label Text="Pane1 Content" />
            </StackLayout>
        </dualScreen:TwoPaneView.Pane1>
        <dualScreen:TwoPaneView.Pane2>
            <StackLayout>
                <Label Text="Pane2 Content" />
            </StackLayout>
        </dualScreen:TwoPaneView.Pane2>
    </dualScreen:TwoPaneView>
</ContentPage>
```

By default the TwoPaneView will attempt to always render both panes, which means that when the app is running on a single-screen, the view will be split between the two panes. The following properties can be used to affect the layout when it's only rendering on one screen:

- **MinTallModeHeight** – indicates the minimum height the control must be to enter tall mode.
- **MinWideModeWidth** – indicates the minimum width the control must be to enter wide mode.
- **Pane1Length** – sets the width of Pane1 in Wide mode, the height of Pane1 in Tall mode, and has no effect in SinglePane mode.
- **Pane2Length** – sets the width of Pane2 in Wide mode, the height of Pane2 in Tall mode, and has no effect in SinglePane mode.

On the Surface Duo, applications can be spanned across two screens. The TwoPaneView control has additional properties that determine where the two panes are rendered in relation to each other (in both single- or dual-screen):

- **TallModeConfiguration** – when in tall mode, the panes can be Left/Right, Right/Left, or a single pane only can be shown.
- **WideModeConfiguration** – when in wide mode, the panes can be Top/Bottom, Bottom/Top, or a single pane only.
- **PanePriority** – whether to show Pane1 or Pane2 if in SinglePane mode is chosen for tall or wide mode.

There are three display modes:

- **SinglePane** – only one pane is currently visible.
- **Wide** – the two panes are laid out horizontally. One pane is on the left and the other is on the right. On the Surface Duo the two screens are in portrait mode.
- **Tall** – the two panes are laid out vertically. One pane is on top and the other is on bottom. On the Surface Duo the two screens are in landscape mode.

## User interface patterns

![Stylized representations of five user-interface patterns for dual-screens](media/2-dual-screen-app-patterns.png)

- Extended canvas - useful for maps or a drawing canvas
- Master-detail - hierarchical navigation through data
- Two Page - book reading experience
- Dual view - different views of the same data (such as a list and a map)
- Companion pane - tool palettes or game controllers

These are described in more detail in the [docs](https://docs.microsoft.com/dual-screen/introduction#dual-screen-app-patterns).
