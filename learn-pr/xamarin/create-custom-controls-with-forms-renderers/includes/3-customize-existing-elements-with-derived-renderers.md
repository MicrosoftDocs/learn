Let's consider the requirement for a `Label` with a drop shadow. Because there's already a built-in `Label`, one of our options is to customize the existing renderer. In a real app, we'd also consider using a Xamarin.Forms **Effect**, which is the best way to handle small changes to built-in controls. Customizing a renderer is the best choice when there are many changes or when the changes are such that **Effects** won't work. For now, we'll use the customized renderer option.

In this unit, we'll look at how we can customize the existing `Label` renderer to add a drop-shadow feature.

## Create a derived element

Usually, when we customize existing behavior, we'll want to create a new element that uses the existing element as its base class, for example:

```csharp
public class ShadowLabel : Xamarin.Forms.Label{
}
```

 We can then use the new element anywhere we'd normally use a `Label`. Deriving a new element class isn't *required*, but it lets us keep the simpler implementation when we only need a regular `Label`. It also makes troubleshooting easier if we have problems with our customization.

## Create derived renderers

Because renderers are platform specific, we need to customize the renderer for each of the platforms. We'll create custom renderer classes that derive from the original renderers.

In Android, our renderer class will look like this:

```csharp
public class ShadowLabelRenderer : Xamarin.Forms.Platform.Android.LabelRenderer
{
    ...
}
```

In iOS, our renderer class will look like this:

```csharp
public class ShadowLabelRenderer : Xamarin.Forms.Platform.iOS.LabelRenderer
{
    ...
}
```

### Add behavior to renderers

The life cycle of a renderer starts with a call to the `OnElementChanged` method. This method is called when the renderer is first paired with a Xamarin.Forms element. One of the things `OnElementChanged` does is create the native control. In this case, because we're customizing an existing implementation, we can rely on our base class's implementation:

```csharp
protected override void OnElementChanged(...)
{
    base.OnElementChanged(e);
    ...
}
```

The call to `base.OnElementChanged` will create the native control and set the `base.Control` property. Our custom renderer can then do whatever customization is required by using the native API.

Here's an iOS example:

```csharp
public class ShadowLabelRenderer : Xamarin.Forms.Platform.iOS.LabelRenderer
{
    protected override void OnElementChanged( ... )
    {
        base.OnElementChanged(e); // The base class will set the Control property

        UIKit.UILabel theControl = base.Control; // base.Control is strongly typed to the native object (UILabel)

        theControl.Layer.ShadowOpacity = 1.0f; // Use native API to customize
        ...
    }
}
```

### Register and use the customized renderer

Now we need to make sure that Xamarin.Forms uses our derived renderer whenever it renders our derived element. We do this by registering the pair with the assembly attribute `ExportRenderer`:

```csharp
[assembly: ExportRenderer(typeof(ShadowLabel), typeof(ShadowLabelRenderer))]
```

We then use the new derived element the same way we'd use a built-in element, in code or in XAML:

```csharp
var shadowyLabel = new ShadowLabel();
mainGrid.Children.Add(shadowyLabel);
```

```xaml
<ContentPage xmlns:local="clr-namespace:NoteApp" ...>
    <local:ShadowLabel Text="I'm shadowy" />
</ContentPage>
```