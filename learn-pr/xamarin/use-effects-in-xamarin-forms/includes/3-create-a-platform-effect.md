To use an effect in shared Xamarin.Forms code, there needs to be an implementation in platform-specific code.

In this unit, you create an effect, implement the required methods, and expose it to Xamarin.Forms.

## Create an effect

Effects classes derive from the `PlatformEffect` base class. You need to create a class for each platform for every effect. For example, to have a drop-shadow effect on both iOS and Android, you need a `IOSShadowEffect` and an `AndroidShadowEffect`.

The `PlatformEffect` base class defines the life-cycle methods of the effect. You'll override these methods to give the effect its functionality. The methods are:

- `OnAttached`
- `OnDetached`
- `OnElementPropertyChanged`

The `PlatformEffect` base class also provides properties that you can use to interact with both the Xamarin.Forms and native sides. The properties are as follows:

- `Element`: The Xamarin.Forms element
- `Control`: The native control
- `Container`: The renderer

These properties are set for us before the life-cycle methods are called.

## Implement OnAttached

The `OnAttached` method is called by the framework when an effect is associated with an element. This call is often immediately after the renderer runs and creates the native control. But because effects can be removed and added at runtime, `OnAttached` can be called at other times (and sometimes multiple times) as well.

This method is where you modify the native control to do whatever your effect is supposed to do. For example, the `OnAttached` for a drop shadow on `Android` might look like the following:

```csharp
protected override void OnAttached()
{
    ...
    // Do the work.
    (Control as TextView).SetShadowLayer(5,2,2,Color.DarkGray);
}
```

### Check the element type

Effects are designed to be flexible. You could, for example, design a background-animation effect that can add an animation to either a `Label` or a `Button`. This means you wouldn't need to create a `ButtonBackgroundAnimationEffect` and a `LabelBackgroundAnimationEffect` separately.

However, to support this flexibility, `PlatformEffects` are relatively loosely typed. When your effect is added to an element (and `OnAttached` is called), you're responsible for explicitly checking to ensure that your effect handles that element type. With this additional check, in Android, `OnAttached` looks something like the following:

```csharp
protected override void OnAttached()
{
    // Check the element type.
    // Because SetShadowLayer is a TextView-specific Android method,
    // and that's the only API you're using, we support only TextView.
    TextView textView = Element as TextView;
    if (textView is null)
        return;

    //Do the work
    textView.SetShadowLayer(5,2,2,Color.DarkGray);
}
```

### Cache the previous element state

Effects are designed to be able to be removed at runtime. Therefore, before your effect changes the `Control`, you cache the original values. Then, if your effect is removed from the element, you can set the `Control` values back to the previous values.

The effect instance remains in memory for as long as it's attached to the element, so you can hold these values as fields in your effect class.

For the Android `AndroidShadowEffect`, the `SetShadowLayer` method changes four properties, so you cache them like this:

```csharp
public class AndroidShadowEffect : PlatformEffect
{
    float _shadowDx, _shadowDy, _shadowRadius;
    Color _shadowColor;

    protected override void OnAttached()
    {
        // Check the element type.
        ...

        // Cache the previous state.
        _shadowDx = Control.ShadowDx;
        _shadowDy = Control.ShadowDy;
        _shadowRadius = Control.ShadowRadius;
        _shadowColor = Control.ShadowColor;

        // Do the work.
        ...
    }
    // Other class methods
    ...
}
```

## Implement OnDetached

The `OnDetached` method is called by the framework when the effect is removed from the element. Your code here should set the control to the state that it would be in if the effect had never been attached at all. This is where you use the values that were cached as part of `OnAttached`. For the example of the `AndroidShadowEffect`, you could do this:

```csharp
protected override void OnDetached()
{
    (Control as TextView).SetShadowLayer(_shadowRadius, _shadowDx, _shadowDy, _shadowColor);
}
```

## Implement OnElementPropertyChanged

If any bindable properties on the element change while your effect is attached, the framework calls the `OnElementPropertyChanged` method of the effect.

The `PropertyChangedEventArgs` parameter has a `PropertyName` that tells us which bindable property was changed. If it's a property that's relevant to your effect, you modify the `Control` appropriately. For example, you might change your shadow color if the `BackgroundColor` changes as shown here:

```csharp
protected override void OnElementPropertyChanged(PropertyChangedEventArgs e)
{
    ...
    if (e.PropertyName == VisualElement.BackgroundColorProperty.PropertyName)
    {
        Color newShadowColor = ((VisualElement)Element).BackgroundColor.ToAndroid();

        (Control as TextView).SetShadowLayer(..., newShadowColor);
    }
}
```

## Expose the effect to Xamarin.Forms

The shared Xamarin.Forms code finds `PlatformEffect`-derived classes with an identifier string that's passed to `Effect.Resolve`. You register each effect class with the assembly level attribute `ExportEffect`, which pairs a string to an effect type:

```csharp
// In Android
[assembly: ExportEffect(typeof(AndroidShadowEffect), "ShadowEffect")]

// In iOS
[assembly: ExportEffect(typeof(IosShadowEffect), "ShadowEffect")]
```

It's important to have Android and iOS expose the same name.

In addition to registering each effect with the preceding attributes, you give the entire assembly an identifying string with the `ResolutionGroupName` attribute:

```csharp
// In Android
[assembly: ResolutionGroupName("MyCompany")]

// In iOS
[assembly: ResolutionGroupName("MyCompany")]
```

Again, you have Android and iOS use the same string.

> [!IMPORTANT]
> There should be only one `ResolutionGroupName` attribute per assembly. For example, your iOS executable project and your Android executable project each have only one `ResolutionGroupName` regardless of how many effects they contain.

When your Xamarin.Forms code needs to use "Shadow Effect" behavior, it looks for the combined string "MyCompany.ShadowEffect".
