The design of your app calls for the use of custom fonts for your labels and a gradient background for your button. You use Xamarin.Forms effects to achieve those behaviors. The font effect is already created.

## Open start solution

Open the starter solution from the **exercise1** > **start** folder in your copy of the cloned or downloaded [!INCLUDE [module-exercise-repo](module-exercise-repo.md)] in Visual Studio.

[!include[](../../../includes/android-windows-path-length-warning.md)]

## Browse the solution

Notice that one effect is already being used. In the .NET Standard project, `LabelFontEffect` is used twice in the `MainPage`. The first time, it's applied in XAML. The other use is in the code-behind, where you can add or remove the effect by toggling the `Switch` on the page.

`LabelFontEffect` works with the `MyCustomFontEffect` classes that are included in the iOS and Android projects. Those classes use platform-specific code to load a custom true type font and apply it to their control. The font file is also embedded in the iOS and Android projects as *Pacifico.ttf*.

In this unit, you add another effect to the app for the button.

## Create the Android PlatformEffect

To create the Android effect, you add a new `PlatformEffect` class to the Android head project and override **OnAttached** and **OnDetached** to apply and remove the gradient.

1. The exercise repository includes an **exercise1/Assets** folder. Add **Gradient.Droid.cs** to the Android head project.
1. Create a new class named **MyButtonGradientEffect** in the Android project.
1. Update the class to derive from `PlatformEffect`. You might need to add the `Xamarin.Forms.Platform.Android` using statement.
1. Override the `OnAttached` and `OnDetached` methods.
1. Add a `Drawable` field named **oldDrawable**. You use this field to cache off the existing background.

    ```csharp
    using Xamarin.Forms;
    using Xamarin.Forms.Platform.Android;

    namespace ControlExplorer.Droid
    {
        public class MyButtonGradientEffect : PlatformEffect
        {
            Drawable oldDrawable;

            protected override void OnAttached()
            {
            }

            protected override void OnDetached()
            {
            }
        }
    }
    ```

1. Create a new method named **SetGradient**.
1. Cast the `Element` property to a Xamarin.Forms `Button`, and save it to a local variable named **xfButton**.
1. Read the `BackgroundColor` property of **xfButton**, and save it to a local variable named **colorTop**.
1. Create another `Xamarin.Forms.Color` variable named **colorBottom**, and set it to black.
1. Call the static method `GetGradientDrawable` on the provided `Gradient` class, and pass in both colors. You need to call `ToAndroid` to convert them from Xamarin.Forms colors to Android colors.
1. Call the `SetBackground` method on the `Control` property, and pass in the returned `Drawable` from `GetGradientColor`.

    ```csharp
    void SetGradient()
    {
        var xfButton = Element as Xamarin.Forms.Button;

        var colorTop = xfButton.BackgroundColor;
        var colorBottom = Xamarin.Forms.Color.Black;

        var drawable = Gradient.GetGradientDrawable(colorTop.ToAndroid(), colorBottom.ToAndroid());

        Control.SetBackground(drawable);
    }
    ```

1. In `OnAttached`, check to see whether the element's property is `Button`. If it isn't, return.
1. Save the existing `Control.Background` `Drawable` to the **oldDrawable** field.
1. Call `SetGradient`.
1. In `OnDetached`, check to see whether **oldDrawable** is non-null. If it's non-null, assign it to `Control.Background`.

    ```csharp
    protected override void OnAttached()
    {
        if (Element is Xamarin.Forms.Button == false)
            return;

        oldDrawable = Control.Background;

        SetGradient();
    }

    protected override void OnDetached()
    {
        if (oldDrawable != null)
            Control.Background = oldDrawable;
    }
    ```

1. Check that the `ResolutionGroupName` assembly attribute exists in the `MainActivity` source file and that the value is set to "Xamarin".
1. Use the `ExportEffect` assembly attribute to export the effect name as **ButtonGradientEffect**.

    ```csharp
    using Xamarin.Forms;
    using ControlExplorer.Droid;
    ...
    [assembly: ExportEffect(typeof(MyButtonGradientEffect), "ButtonGradientEffect")]
    ```

## Create the iOS PlatformEffect

To create the iOS effect, you follow steps that are similar to those for the Android effect, except that you use the native iOS APIs. You add a new `PlatformEffect` class to the iOS head project and override `OnAttached` and `OnDetached` to apply and remove the gradient.

1. Add the provided **Gradient.iOS.cs** file from the **exercise1/Assets** folder to the iOS head project.
1. Create a new class named **MyButtonGradientEffect** in the iOS project.
1. Update the class to derive from `PlatformEffect`. You might need to add the `Xamarin.Forms.Platform.iOS` using statement.
1. Override the `OnAttached` and `OnDetached` methods.
1. Add a `CAGradientLayer` field named **gradLayer**. You use this field to cache the control's prior gradient.

    ```csharp
    using Xamarin.Forms;
    using Xamarin.Forms.Platform.iOS;
    using CoreAnimation;

    namespace ControlExplorer.iOS
    {
        public class MyButtonGradientEffect : PlatformEffect
        {
            CAGradientLayer gradLayer;

            protected override void OnAttached()
            {
            }

            protected override void OnDetached()
            {
            }
        }
    }
    ```

1. Create a new method named **SetGradient**.
1. In the new method, check to see whether **gradLayer** is non-null. If it's non-null, remove it by using its `RemoveFromSuperLayer` method.
1. Cast the `Element` property to a Xamarin.Forms `Button`, and save it to a local variable named **xfButton**.
1. Read the `BackgroundColor` property of **xfButton**, and save it to a local variable named **colorTop**.
1. Create another `Color` variable named **colorBottom**, and set it to **black**.
1. Call the static method `GetGradientLayer` on the provided `Gradient` class, and pass in both colors and the `xfButton` width and height. Call `ToCGColor` to convert the colors from Xamarin.Forms colors to CGColors. (This is an extension method. To access it, include a `using` statement for `Xamarin.Forms.Platform.iOS`.)
1. Insert the returned `CAGradientLayer` at position 0 of `Control.Layer`.

    ```csharp
    void SetGradient()
    {
        gradLayer?.RemoveFromSuperLayer();

        var xfButton = Element as Button;
        var colorTop = xfButton.BackgroundColor;
        var colorBottom = Color.Black;

        gradLayer = Gradient.GetGradientLayer(colorTop.ToCGColor(), colorBottom.ToCGColor(), (float)xfButton.Width, (float)xfButton.Height);

        Control.Layer.InsertSublayer(gradLayer, 0);
    }
    ```

1. In `OnAttached`, check to see whether the element's property is `Button`. If it isn't, return.
1. Call `SetGradient`.
1. In `OnDetached`, check to see whether **gradLayer** is non-null. If it's non-null, remove it by using its `RemoveFromSuperLayer` method.

    ```csharp
    protected override void OnAttached()
    {
        if (Element is Button == false)
            return;

        SetGradient();
    }

    protected override void OnDetached()
    {
        if(gradLayer != null)
            gradLayer.RemoveFromSuperLayer();
    }
    ```

1. Check that the `ResolutionGroupName` assembly attribute exists in the `AppDelegate` source file and that the value is set to "Xamarin".
1. Use the `ExportEffect` assembly attribute to export the effect name as **ButtonGradientEffect**.

    ```csharp
    [assembly: ExportEffect(typeof(MyButtonGradientEffect), "ButtonGradientEffect")]
    ```

## Create the RoutingEffect

1. In the **ControlExplorer** Xamarin.Forms library project, create a new class named **ButtonGradientEffect**.
1. Update the class to derive from `RoutingEffect`.
1. Create or update the constructor to accept no parameters.
1. Call the base constructor that passes in the custom font effect's ID, **Xamarin.ButtonGradientEffect**.

```csharp
using Xamarin.Forms;
...
class ButtonGradientEffect : RoutingEffect
{
    public ButtonGradientEffect() : base("Xamarin.ButtonGradientEffect")
    {
    }
}
```

## Use the gradient effect

Apply the effect programmatically in preparation for the next exercise. Remember that, to create the gradient layer, the iOS effect needs the width and height of the button. For this reason, to ensure that the visual tree has been rendered before applying the effect, use one of the ContentPage lifecycle methods.

1. Open **MainPage.xaml.cs** in the Xamarin.Forms library project.
1. Override `OnAppearing`.
1. In the method, apply the effect by instantiating an instance of `ButtonGradientEffect` and adding it to the **buttonClick** effects collection.

    ```csharp
    public partial class MainPage : ContentPage
    {
        ...
        protected override void OnAppearing()
        {
            base.OnAppearing();

            buttonClick.Effects.Add(new ButtonGradientEffect());
        }
    ```

## Run the project

To verify that the button has a gradient applied, run the application in a simulator or emulator.
