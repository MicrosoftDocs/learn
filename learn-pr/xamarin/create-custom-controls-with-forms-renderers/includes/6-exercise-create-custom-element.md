In this exercise, you'll define a custom element and platform-specific renderers to create a drawing surface.

The provided **Assets** folder contains a custom control for each platform. This control presents a drawing surface, responds to pointer events, and draws lines. Your job is to consume the custom control on each platform in a renderer.

## Open the solution

This exercise continues where the previous one ended. You can use your existing solution or begin with the **exercise1** > **final** solution in your cloned or downloaded copy of the [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].

## Create a custom element

1. In the **XFDraw** shared project, create a new class named `SketchView` that derives from `View`.

1. Create a `BindableProperty` named `InkColorProperty`. Set the `propertyName` as `InkColor`, the return type as `Color`, and the declaring type as the new element: `SketchView`.

1. Create a `Color` property named `InkColor` for the bindable property. Call the `GetValue` and `SetValue` methods, passing in `InkColorProperty` in the getter/setter.

```csharp
class SketchView : View
{
    public static readonly BindableProperty InkColorProperty = BindableProperty.Create("InkColor", typeof(Color), typeof(SketchView), Color.Blue);

    public Color InkColor
    {
        get { return (Color)GetValue(InkColorProperty); }
        set { SetValue(InkColorProperty, value); }
    }
}
```

## Use the custom element

In this section, you'll add the custom element to your visual content page. Because you haven't yet added any platform-specific rendering code, the view will be blank.

1. Open **MainPage.xaml** in the shared project.

1. Add a `SketchView` to the `mainLayout` Grid. You can use the xmlns that you defined for the hyperlink label.

1. Give the `SketchView` the name `sketchView` so you can reach it in the code-behind file.

1. Set `HorizontalOptions` and `VerticalOptions` to `FillAndExpand`.

1. Set the `InkColor` property to a default color. This code uses green:

```xml
<local:SketchView x:Name="sketchView" HorizontalOptions="FillAndExpand" VerticalOptions="FillAndExpand" InkColor="Green" />
```

## Add custom controls for each platform

To create a configurable drawing control for each platform, you need to have knowledge about each platform.

To make things easier, we've included the touch-enabled and gesture-enabled drawing code for iOS and Android. You need to add the provided classes to each head-project.

1. Add the appropriate `PaintView` class to each platform-specific project.

1. If you're interested, inspect the code for each platform. Notice that the `PaintView` class shares some similarities across all platforms:
    - The class name is `PaintView`.
    - There's a public method named `SetInkColor`.
    - There's a public method named `Clear`.
    - There's an event named `LineDrawn`.

1. You'll use these classes when you create the renderer for each platform.

## Create the platform renderers

Next, you'll create the renderers to display the custom `PaintView` control on each platform. Because we've designed the `PaintView` control to expose the same public methods on each platform, the steps for creating each renderer are similar. Keep in mind that this won't be the case for all renderers.

Repeat the following steps in each platform-specific project. You'll need to add the platform-specific `using` statements when you build the renderer.

1. Create a new class named `SketchViewRenderer`.

1. Update the signature to derive from `ViewRenderer`. The first type argument is the element: use `SketchView`. The second type element is the native control: use `PaintView`.

1. Add the `ExportRenderer` assembly attribute above the namespace declaration to connect the `SketchViewRenderer` to the `SketchView`.

1. **Android only**: Create a constructor that accepts an Android `Context` and passes it to the base constructor.

```csharp
using XFDraw;
using Xamarin.Forms;
using Xamarin.Forms.Platform.[platform];
using XFDraw.[platform];

[assembly: ExportRenderer(typeof(SketchView), typeof(SketchViewRenderer))]
namespace XFDraw.[platform]
{
    class SketchViewRenderer : ViewRenderer<SketchView, PaintView>
    {

    }
}
```

## Create and set the native control

1. In each renderer, override `OnElementChanged`.

1. Create and instantiate a local `PaintView` instance named `paintView`. For Android, you'll need to pass in the context: `Android.App.Application.Context`. For the other platforms, the constructor doesn't take any parameters.

1. Set the color on `paintView` by using the `SetInkColor` method. You can reach the bindable `InkColor` property on `Element`. Android and iOS have extension methods to convert the Xamarin.Forms color to a native color: `ToUIColor` and `ToAndroid`.

1. Assign `paintView` as the native `control` by using the `SetNativeControl` method. For Android, you'll need to pass in the `Context` that you receive in the renderer's constructor.

1. The code described in this section should run only once. Surround the code in an `if` statement that runs *only* if `Control` is `null`.

1. Run the app. You should now be able to draw by dragging your finger.

    ```csharp
    protected override void OnElementChanged(ElementChangedEventArgs<SketchView> e)
    {
        base.OnElementChanged(e);

        if (Control == null)
        {
            var paintView = new PaintView();
            paintView.SetInkColor(this.Element.InkColor.ToUIColor()); // Or ToAndroid()
            SetNativeControl(paintView);
        }
    }
    ```

## Respond to color property changes

Next, you need to update the native control when properties are changed on the Xamarin.Forms element.

1. Override `OnElementPropertyChanged`.

1. The passed-in `PropertyChangedEventArgs` has a `PropertyName` property that holds exactly what you'd expect: the name of the property on the element. Compare this to the name of your `InkProperty`. You can do this in a type-safe way by checking the static `SketchView.InkColorProperty.PropertyName`.

1. If the property name is correct, update the ink property on the native control by using the `InkColor` property on the element.

```csharp
protected override void OnElementPropertyChanged(object sender, PropertyChangedEventArgs e)
{
    base.OnElementPropertyChanged(sender, e);

    if (e.PropertyName == SketchView.InkColorProperty.PropertyName)
    {
        Control.SetInkColor(this.Element.InkColor.ToUIColor()); // Or ToAndroid()
    }
}
```

## Change the color

In this section, you'll trigger a change to the ink color from your UI.

1. Open **MainPage.xaml.cs** in the shared project.

1. Set a new random color every time the pencil button is tapped. The `OnColorClicked` method is already being called when the button is tapped, but the method body is empty. Use the provided `GetRandomColor` method to assign a new color to `sketchView`'s `InkColor` property.

    ```csharp
    void OnColorClicked ()
    {
        sketchView.InkColor = GetRandomColor();
    }
    ```

1. Run the app. Tap the pencil button to change the ink color.
