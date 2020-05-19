Now you add the ability to configure the gradient effect from your Xamarin.Forms code. You create an attached property and control it from a slider on the app.

## Open solution

This exercise is a continuation of the previous exercise. You can use your existing solution or begin from the **exercise1** > **final** solution in the cloned or downloaded copy of the [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].

## Add an attached property

1. Open **ButtonGradientEffect.cs** in the **ControlExplorer** Xamarin.Forms library project.
1. Add a `public static readonly BindableProperty` named **GradientColorProperty**.
1. Assign **GradientColorProperty** by using the static `BindableProperty.CreateAttached` method: set the property name to `"GradientColor"`, the type to `Color`, the declaring type to `ButtonGradientEffect`, and the default value to `Color.Black`.

    ```csharp
    public class ButtonGradientEffect : RoutingEffect
    {
        public static readonly BindableProperty GradientColorProperty = BindableProperty.CreateAttached("GradientColor", typeof(Color), typeof(ButtonGradientEffect), Color.Black);
        ...
    }
    ```

1. Add a `public static void` setter method named **SetGradientColor** that accepts a `VisualElement` and a `Color`.
1. Within the setter method, call the `SetValue` method on the passed-in `VisualElement`. The parameters are `BindableProperty` and the passed-in `Color`.
1. Add a `public static Color` getter method named **GetGradientColor** that accepts a `VisualElement`.
1. Within the getter method, call the `GetValue` method of `VisualElement`, and pass in `BindableProperty`. Cast the return value to a `Color` instance and return it.

    ```csharp
    public static void SetGradientColor(VisualElement view, Color color)
    {
        view.SetValue(GradientColorProperty, color);
    }

    public static Color GetGradientColor(VisualElement view)
    {
        return (Color) view.GetValue(GradientColorProperty);
    }
    ```

## Set the attached property

Use the existing slider to adjust the second color of the button's gradient. When the slider position changes, create a color and assign it to the button via the attached property.

1. Open **MainPage.xaml.cs**, and find the `OnSliderColorValueChanged` method.
1. Use the slider position to generate a color. The slider has been configured with Min/Max values of 0 and 255, which can be read by using the `NewValue` property of the passed in `ValueChangedEventArgs`. Generate a grey `Color` by using `NewValue` for the RGB color values.
1. Set the new color as the gradient color-attached property onto the button named **buttonClick**. Use the static `ButtonGradientEffect.SetGradientColor` method.

    ```csharp
    private void OnSliderColorValueChanged(object sender, ValueChangedEventArgs e)
    {
        Color gradColor = new Color(e.NewValue / 255.0, e.NewValue / 255.0, e.NewValue / 255.0);
        ButtonGradientEffect.SetGradientColor(buttonClick, gradColor);
    }
    ```

## Read the attached property

The instructions in this section are the same for each platform-specific head project. For each platform that you want to support, do the following:

1. Open **MyButtonGradientEffect** in the head project and find the `SetGradient` method.
1. Update the **colorBottom** assignment to read the attached property by calling the `static` `ButtonGradientEffect.GetGradientColor` method. Remember, the property is attached to the button that's defined in Xamarin.Forms, so pass in **xfButton**.

    ```csharp
    void SetGradient()
    {
        ....
        var colorBottom = ButtonGradientEffect.GetGradientColor(xfButton);
    }
    ```

1. You also need to respond to property changes: override `OnElementPropertyChanged`.
1. Within the method, check to see whether the `Element` property is a `Button`; if it isn't, return.
1. Check for updates to the attached property by comparing the `PropertyName` property on the passed in `PropertyChangedEventArgs`. You can use the **PropertyName** property on **GradientColorProperty** to compare.
1. If `PropertyName` matches your gradient property, call `SetGradient`.

    ```csharp
    using System.ComponentModel;
    ...
    protected override void OnElementPropertyChanged(PropertyChangedEventArgs e)
    {
        base.OnElementPropertyChanged(e);

        if (Element is Xamarin.Forms.Button == false)
            return;

        if (e.PropertyName == ButtonGradientEffect.GradientColorProperty.PropertyName)
            SetGradient();
    }
    ```

## Final touches

1. Right now, the effect responds only when the added gradient color changes, but the gradient also uses the button's background color. Update `OnElementPropertyChanged` in each effect to also respond when the background color is changed.

1. On iOS, the gradient layer uses a fixed height and width. You can use `OnElementPropertyChanged` to respond to size changes on the element. On the iOS `PlatformEffect` only, call `SetGradient` if the height or width changes.

    ```csharp
    protected override void OnElementPropertyChanged(PropertyChangedEventArgs e)
    {
        ...

        if (e.PropertyName == ButtonGradientEffect.GradientColorProperty.PropertyName
         || e.PropertyName == VisualElement.BackgroundColorProperty.PropertyName
         || e.PropertyName == VisualElement.WidthProperty.PropertyName
         || e.PropertyName == VisualElement.HeightProperty.PropertyName)
        {
            SetGradient();
        }
    }
    ```

1. Run the application and move the slider. The bottom color of the gradient on the button should change from black to white.
