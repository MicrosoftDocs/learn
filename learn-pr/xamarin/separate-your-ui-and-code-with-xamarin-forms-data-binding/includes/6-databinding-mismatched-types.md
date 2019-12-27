Sometimes your data doesn't exactly match the data type of the UI control. For example, you might have a value of type `double` that you want to display as currency in a `Label`. A more complicated example is an image URL in your data that needs to show the actual image in the UI. Here, we look at two techniques to help you deal with these cases.

## String formatting in a binding

A common type mismatch is an intrinsic type that you want to display as a formatted string. The example where you have a `double` value that must be formatted as currency fits in this category. This situation is so common that it's worth the time to be precise about what you need to do. Suppose you want to show this property in your UI:

```csharp
    public double BillAmount { get; set; }
```

The following mockup shows the goal of displaying the `BillAmount` property as currency. Notice how the localized currency symbol is included and the value is rounded to two decimal places.

![An illustration of a UI showing the amount of a bill formatted as currency.](../media/formattedString.png)

Xamarin.Forms bindings give you access to the `String.Format` method. For example, you can tell the binding to take the value for the `BillAmount` and send it to the `String.Format` method by using a format of `C` to create a currency string. The binding then loads the formatted string into your UI.

With the binding's `StringFormat` property, you can invoke `String.Format`. The format string follows the same rules as the `String.Format` method. Enclose the format string in single quotes so that the XAML parser doesn't get confused by the curly braces. In our example, we want to format as currency, so we use the following binding:

```xml
<Label Text="{Binding BillAmount, StringFormat='You Owe: {0:C}'}"/>
```

## Custom type conversion

The `StringFormat` property is convenient when your target type is a string. If you convert to something like a `Color` or an `Image`, you need to write custom conversion code.

For example, suppose you have a property in your data named `PasswordStrength` of type `PasswordStrengthEnum`. You want to use the `PasswordStrength` to control a color in the UI. A weak password shows red, and a strong password shows green. Write conversion code to map from a `PasswordStrengthEnum` value to a `Color`.

The following code won't work yet, but it shows the goal. Notice the type mismatch: `PasswordStrength` is of type `PasswordStrengthEnum` while `BackgroundColor` is a `Color`.

```xml
<Entry BackgroundColor="{Binding PasswordStrength}" ... />
```

Xamarin.Forms gives you a standard way to package and apply this kind of type-conversion code:

* Your conversion code goes in a class that implements the `IValueConverter` interface.
* You apply the converter by using the binding's `Converter` property.

### Implement IValueConverter

Best practice is to implement your converters as standalone utility classes. Most people use a class name that ends in `Converter` to make its purpose clear.

The `IValueConverter` interface has two methods:

* `Convert`: Converts from code-behind data to a UI value. We use this method in the password-strength example.

* `ConvertBack`: Converts from a UI value to code-behind data. This method is rarely needed, and we won't  use it in our examples. Most converters throw `NotSupportedException` to indicate that it's not implemented.

The `Convert` method takes four parameters. Here's the signature:

```csharp
public object Convert(object value, Type targetType, object parameter, CultureInfo culture);
```

Recall that our goal is to get something like the following code to work:

```xml
<Entry BackgroundColor="{Binding PasswordStrength}" ... />
```

In our example, the `value` is `PasswordStrength` and the `targetType` is `Color`. We don't need to use `Convert`'s last two parameters. The following code shows a simple implementation of the converter:

```csharp
public class PasswordStrengthToColorConverter : IValueConverter
{
    public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
    {
        var strength = (PasswordStrengthEnum)value;

        if (strength == PasswordStrengthEnum.Strong)
            return Color.Green;
        else
            return Color.Red;
    }
    ...
}
```

### Create a converter instance

Create an instance of your converter. The instance must be available in your XAML so that you can apply it in your bindings. The standard way to instantiate your converter is in your `Page`'s resource dictionary.

First, define a prefix that maps to the code-behind namespace that contains your converter class. The following code shows an example:

```xml
<ContentPage ... xmlns:cvt="clr-namespace:MyProject.MyConverters">
```

Then you create an instance of your converter inside the resource dictionary.

```xml
<Page.Resources>
    <cvt:PasswordStrengthToColorConverter x:Key="pwcolorConverter" />
</Page.Resources>
```

### Apply a converter in a binding

You use the `Converter` property of a binding to apply your type converter. Typically, your converter instance is in a resource dictionary, so you use `StaticResource` to access it.

The following code shows our example. The binding automatically invokes the `Convert` method and passes `PasswordStrength` as the `value` and `Color` as the `targetType`.

```xml
<Entry BackgroundColor="{Binding PasswordStrength, Converter={StaticResource pwcolorConverter}}" ... />
```