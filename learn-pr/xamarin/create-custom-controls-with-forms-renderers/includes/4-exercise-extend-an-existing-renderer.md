In this exercise, you'll extend the provided label renderers to create a "shadowed label."

## Open the starter solution

Open the **XFDraw** starter solution from the **exercise1** > **start** folder in your cloned or downloaded copy of the [!INCLUDE [module-exercise-repo](module-exercise-repo.md)]. There's also a **final** folder that contains a solution that you can use to check your work. Make sure you have these folders before you begin.

[!include[](../../../includes/android-windows-path-length-warning.md)]

## Create a derived element

You'll create a new element in your shared code that derives from `Label`. Later, when you create the renderers, you'll apply them to this element.

1. In the **XFDraw** shared project, create a new class named `ShadowedLabel`.

2. Update the signature to derive from `Label`.

```csharp
using Xamarin.Forms;

namespace XFDraw
{
    public class ShadowedLabel : Label
    {
    }
}
```

## Use the custom element

1. Open **MainPage.xaml** in the **XFDraw** shared project.

2. Notice the XML namespace named `local`, which is used to reach the `XFDraw` namespace.

3. Replace the existing `Label` with your new `ShadowedLabel`. Leave all existing properties as they are.

```xml
<ContentPage ...
    xmlns:local="clr-namespace:XFDraw">
    <Grid x:Name="mainLayout" Padding="10">
        <local:ShadowedLabel Text="Microsoft Learn" HorizontalOptions="Center" VerticalOptions="End" />
    </Grid>
</ContentPage>
```

## Create the Android renderer

1. In the Android head-project, create a new class named `ShadowedLabelRenderer` that derives from `LabelRenderer`.

2. Add a constructor that takes an Android `Context` and passes it to the base constructor. This step is required for Android renderers.

3. Override `OnElementChanged`.

4. The `Label` renderer creates an Android `TextView` that's reachable from the `Control` property. Call `SetShadowLayer` on the `TextView`. Use these parameter values: `Control.SetShadowLayer(10, 5, 5, Android.Graphics.Color.DarkGray)`.

5. Add the `ExportRenderer` assembly attribute above the namespace declaration to connect the `ShadowedLabelRenderer` to the `ShadowedLabel` element that you created earlier.

```csharp
[assembly: ExportRenderer(typeof(ShadowedLabel), typeof(ShadowedLabelRenderer))]
namespace XFDraw.Droid
{
    class ShadowedLabelRenderer : LabelRenderer
    {
        public ShadowedLabelRenderer(Context context) : base (context)
        {
        }

        protected override void OnElementChanged(ElementChangedEventArgs<Label> e)
        {
            base.OnElementChanged(e);

            Control.SetShadowLayer(10, 5, 5, Android.Graphics.Color.DarkGray);
        }
    }
}
```

## Create the iOS renderer

1. In the iOS head-project, create a new class named `ShadowedLabelRenderer` that derives from `LabelRenderer`.

1. Override `OnElementChanged`.

1. The `Label` renderer creates an iOS `UILabel` that's reachable from the `Control` property. The `UILabel` has a `Layer` property that can be used to control the shadow properties. Set the values on the `Layer` as shown in the following code block.

1. Add the `ExportRenderer` assembly attribute above the namespace declaration to connect the `ShadowedLabelRenderer` to the `ShadowedLabel` element that you created earlier.

```csharp
[assembly: ExportRenderer(typeof(ShadowedLabel), typeof(ShadowedLabelRenderer))]
namespace XFDraw.iOS
{
    class ShadowedLabelRenderer : LabelRenderer
    {
        protected override void OnElementChanged(ElementChangedEventArgs<Label> e)
        {
            base.OnElementChanged(e);

            Control.Layer.ShadowColor = UIColor.DarkGray.CGColor;
            Control.Layer.ShadowOpacity = 1.0f;
            Control.Layer.ShadowRadius = 2f;
            Control.Layer.ShadowOffset = new CGSize(4, 4);
            Control.Layer.MasksToBounds = false;
        }
    }
}
```

Run the app. Notice the drop shadow below the label.
