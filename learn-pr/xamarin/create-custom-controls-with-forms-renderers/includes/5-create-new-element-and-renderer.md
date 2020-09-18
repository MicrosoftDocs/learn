Deriving from existing renderers and enhancing their built-in behavior works great when there's a Xamarin.Forms element that already does most of what we need. But if we want a control that doesn't exist in Xamarin.Forms at all yet, the steps are a little different and there's a bit more work.

We'll need a Xamarin.Forms element and renderer. We'll also need a native control to use on each platform. For example, we want a control that allows the user to draw on the screen, but there's no built-in native control in either iOS or Android that does that. So we have to either create them or find third-party implementations in both platforms.

In this unit, we're going to create a custom Xamarin.Forms element and renderer to build a drawing app.

## Create an element

When we customized an element and renderer, we used the existing implementation as a base class. But now we're creating a brand new element. Because `View` is the most basic Xamarin.Forms element, we'll use it as our new element's base class:

```csharp
public class SketchView : View
{
...
}
```

### Add element properties

Most elements will have some configuration options or values that need to be shared with the native control. Built-in controls tend to have many properties that can be set. `Label`, for example, has `Text`, `FontSize`, and many others. For custom elements, we'll need to decide what properties make sense. For example, our implementation of `SketchView` will have an `InkColor` property to change the color of the line that's drawn.

When we create properties for elements, we should use `BindableProperty`. With bindable properties, we can use data binding in the pages that use our new element. But the more important advantage of bindable properties is that the renderer is notified whenever a value is changed:

```csharp
public class SketchView : View
{
    public static readonly BindableProperty MultiTouchEnabledProperty = BindableProperty.Create("MultiTouchEnabled", typeof(bool), typeof(SketchView), false);

    public bool MultiTouchEnabled
    {
        get => GetValue(MultiTouchEnabledProperty);
        set => SetValue(MultiTouchEnabledProperty, value);
    }
}
```

## Create renderers for a custom element

To create renderers for a new element, we'll derive from the `ViewRenderer<TView, TNativeView>` base class. The type parameters will be set to our new Xamarin.Forms element (`TView`) and our native control (`TNativeView`), respectively.

Assuming we have an Android control named `AndroidPaintView`, our Android renderer's class declaration for the `SketchView` would look like this:

```csharp
public class SketchViewRenderer : ViewRenderer<SketchView, AndroidPaintView>
{
...
}
```

### Create the native object in OnElementChanged

In the `OnElementChanged` method, we need to create the native control. This is a bit different from the customization workflow, where we could rely on the base class to create it. First, we'll instantiate the native object. Then we'll call `SetNativeControl`, which will populate the renderer's `Control` property.

`OnElementChanged` might be called by the platform more than once, but our renderer *should not* instantiate controls more than once, so we'll have a guard clause around that part of the code to check if `Control` is already set:

```csharp
protected override void OnElementChanged(...)
{
    ...

    if (Control == null) // Create native control only if it hasn't been done before
    {
        SetNativeControl(new AndroidPaintView());
    }
}
```

The renderer automatically has access to the Xamarin.Forms element through the `Element` property. After we've called `SetNativeControl`, it also has access to the native control through the `Control` property.

### Handle changes in bindable properties

If we've designed our elements with any bindable properties, our renderer will need to handle changes to those properties caused by app code. We can handle these changes by overriding the `OnElementPropertyChanged` method. The override will be called anytime a `BindableProperty` on the `Element` is changed. It will be called for *all* bindable properties, so we'll need to check the `PropertyName` and use custom logic for each property that our renderer cares about. Our logic will do whatever is needed to convert and copy the value to the native object:

```csharp
protected override void OnElementPropertyChanged(object sender, PropertyChangedEventArgs e)
{
    base.OnElementPropertyChanged(sender, e);

    if (e.PropertyName == SketchView.InkColorProperty.PropertyName)
    {
        Control.SetInkColor(Element.InkColor.ToAndroid());
    }
}
```