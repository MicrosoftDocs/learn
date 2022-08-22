Sometimes an effect doesn't need any additional information, and sometimes the element's existing properties have enough information for the effect. Earlier you saw an example of that when the drop-shadow effect responded to changes in the element's `BackgroundColor`.

But often, you'd like to provide some customization options for an effect, especially if you want to share or distribute the effect. You might want the drop shadow to have a customizable radius and offset, or you might want the color to be independently controllable.

## Add more bindable properties

You can't just add regular bindable properties to a `RoutingEffect` or `PlatformEffect` class.

For an effect to respond to a property change, the property needs to be a `BindableProperty` *on the element*. But if you're using an effect to add the behavior, it's likely you don't have the element source code to just add properties. Besides, it's a bad coding practice to put properties on an element that will be ignored except when there's an effect attached.

## Attach properties

The solution is *Attached Properties*, which are a special type of bindable property. You can define the attached property in any class and attach it to a `BindableObject`, such as an element.

To give a drop-shadow effect an independent color configuration, you could add the following to the `ShadowEffect` class:

```csharp
public class ShadowEffect : RoutingEffect
{
    ...
    public static readonly BindableProperty ColorProperty
        = BindableProperty.CreateAttached("Color", typeof(Color), typeof(ShadowEffect), Color.Black);

       public static Color GetColor(View view) {
        return (Color)view.GetValue(ColorProperty);
    }
       public static void SetColor(View view, Color color) {
        view.SetValue(ColorProperty, color);
    }
    ...
}
```

You create a static field of type `BindableProperty` by using the `CreateAttached` method, which prepares the framework to track the value for you. The parameters are:

- `propertyName`: Should be the same as the field name, without the "Property" suffix
- `returnType`: The type of the property
- `declaringType`: The class you're working in
- `defaultValue`: The default value

When you create an attached property, you must also create a "Get" method and a "Set" method. The first parameter of both these methods is the object that the value should be "attached" to. As the previous code example shows, when the "Set" method is called, the value is stored as part of the attached object by using the `SetValue` method, which is inherited from `BindableObject`. Similarly, the "Get" method uses the attached object's `GetValue` to retrieve the value.

When values are stored by using `SetValue`, the `PropertyChanged` event of `BindableObject` is raised. If that object is an element, the event calls `OnElementPropertyChanged` on any attached effects.

## Set the attached property

The "Set" methods that you create for bindable properties, like `SetColor` in the previous example, can be used as regular static methods. So, one way you can use attached properties is to call the method:

```csharp
ShadowEffect.SetColor(myButton, Color.Blue);
```

You can also set the attached property in XAML. The XAML syntax for attached properties is unique. An attached property looks like a regular property on the element, but it's prefixed with the declaring type and a dot:

```xaml
<Button local:ShadowEffect.Color="Blue">...</Button>
```

## Handle changes to an attached property

Changes to attached bindable properties are handled the same as changes to any other bindable property:

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
