Sometimes the data you're using doesn't match the data type of the control property displaying the data. For example, you might have a monetary value stored in a `decimal` type that you want to display on a `Label` control, formatted as a currency. A more complicated example would be with the weather app presented in the module. An image is supposed to be displayed based on the weather forecast's `Sunny` or `Cloudy` enumeration value, but you can't bind the source's enumeration value to a target's image property. This unit looks at ways you can convert data.

## String formatting

A common type mismatch is an intrinsic type that you want to display as a formatted string. Like when you want to display parts of a `DateTime` value, or you want to format a `decimal` type as currency.

Suppose you want to display the amount due on a bill and you have this property on your data object:

```csharp
public decimal BillAmount { get; set; }
```

The amount owed ends up being **22.0304**. You might use two label controls to display some text and the dollar amount as demonstrated in the following snippet:

```xaml
<HorizontalStackLayout>
    <Label Text="You owe" Margin="0,0,5,0" />
    <Label Text="{Binding BillAmount}" />
    <Label Text="to the bank" Margin="5,0,0,0" />
</HorizontalStackLayout>
```

This outputs a string to the UI that looks like `You owe 22.0304 to the bank`, but it's missing the currency symbol and there might be too many or too few decimal places based on the local currency. Normally you would process the value as a string with the "C" (or currency) format specifier in code, like so:

```csharp
string formattedBillAmount = string.Format("{0:C}", BillAmount);
```

But to use formatting in data binding, you have to either have the data object provide you that formatted string as a different property, or intercept it somehow and format it yourself. Fortunately, .NET MAUI bindings provide a way to format strings with the `StringFormat` binding property. The format string follows the same rules as the `String.Format` method. Enclose the format string in single quotes so that the XAML parser doesn't get confused by the curly braces. String format parameter `0` is the property value processed by the binding.

```xaml
<Label Text="{Binding BillAmount, StringFormat='You owe {0:C} to the bank'}" />
```

Consider the following XAML, which demonstrates displaying the `BillAmount` using both ways:

```xaml
<VerticalStackLayout Padding="10">
    <HorizontalStackLayout>
        <Label Text="You owe" Margin="0,0,5,0" />
        <Label Text="{Binding BillAmount}" />
        <Label Text="to the bank" Margin="5,0,0,0" />
    </HorizontalStackLayout>
    <HorizontalStackLayout>
        <Label Text="{Binding BillAmount, StringFormat='You owe {0:C} to the bank'}" />
    </HorizontalStackLayout>
</VerticalStackLayout>
```

The following image illustrates what the XAML output produces on the screen:

:::image type="content" source="../media/5-databinding-mismatched-types/string-format.png" alt-text="Screenshot of a .NET MAUI Android app displaying two different label controls with text related to owing a bill. One label's text is formatted with USD currency.":::

The XAML using the `StringFormat` binding property is simpler than the other XAML, and you have access to the .NET's powerful string formatting system.

## Custom type conversion

The `StringFormat` binding property is convenient when displaying a value as a string, but not when you want to convert something like a `Color` or `Image` from another type. In these cases, you need to write custom conversion code.

Suppose you're prompting the user to choose a password, and you want to use a color in the UI to indicate the strength of the password. There are three levels of strength: weak, good, strong. The strength is based on how many characters are in the password. To give immediate feedback to the user about their password strength, you want the background of the `Entry` control containing the password to change based on the strength. The following image demonstrates those three levels of strength: weak, good, and strong.

:::image type="complex" source="../media/5-databinding-mismatched-types/password-strength.png" alt-text="Screenshot of a .NET MAUI Android app with three entry controls, each with a different colored background.":::

Of the three entry controls in the screenshot, the first has four characters entered and features a red background. The second has nine characters entered and features a yellow background. The last entry control has 15 characters and features a blue background.

:::image-end:::

These levels are assigned to the `Strength` enumeration:

```csharp
private enum Strength
{
    Weak,
    Good,
    Strong
}
```

A data object is assigned as the page's `BindingContext`, which contains the password's strength with the `PasswordStrength` property. As the user types in a password, the `PasswordStrength` property is changed according to the length of the password. Because the data object contains the `PasswordStrength` property, you bind that property to the `BackgroundColor` of the `Entry` control:

```xaml
<Entry BackgroundColor="{Binding PasswordStrength} ... />
```

There's a problem here though. The `PasswordStrength` is of type `Strength` while `BackgroundColor` is a `Color`. These types aren't compatible with each other. .NET MAUI provides a way to fix these type-mismatch problems, the binding's `Converter` property.

A binding converter does just what its name says, converts between the binding source and target. Converters are implemented through the `IValueConverter` interface.

### Implement IValueConverter

You create your conversion logic into a class that implements the `IValueConverter` interface. Typically, the names of these classes end with the name `Converter` to make its purpose clear.

The `IValueConverter` interface defines two methods:

- `Convert`&mdash;Converts from the binding source's property to the binding target's UI property.
- `ConvertBack`&mdash;Converts from the binding target's UI property back to the binding source's property.

  This method is rarely used and isn't used in this scenario. Most converters throw a `NotSupportedException` to indicate that this conversion isn't supported.

Here's the interface's contract:

```csharp
public interface IValueConverter
{
    object? Convert(object? value, Type targetType, object? parameter, CultureInfo culture);
    object? ConvertBack(object? value, Type targetType, object? parameter, CultureInfo culture);
}
```

Recall that the scenario we're working with is binding the `Entry.BackgroundColor` property to the data object's `PasswordStrength` property, which is a `Strength` enumeration.

```xaml
<Entry BackgroundColor="{Binding PasswordStrength} ... />
```

The `Strength` enumeration needs to be converted to a `Color`. So the converter needs to evaluate which `Strength` value is provided, and return a different `Color`. The following code demonstrates this conversion:

```csharp
namespace MyProject.Converters;

class StrengthToColorConverter : IValueConverter
{
    public object? Convert(object? value, Type targetType, object? parameter, CultureInfo culture)
    {
        return (Strength)value! switch
        {
            Strength.Weak => Colors.OrangeRed,
            Strength.Good => Colors.Yellow,
            Strength.Strong => Colors.LightBlue,
            _ => Colors.LightBlue
        };
    }

    public object? ConvertBack(object? value, Type targetType, object? parameter, CultureInfo culture) =>
        throw new NotImplementedException();
}
```

Let's breakdown this code:

- The `Convert` method has four parameters. You can generally discard the last two parameters unless you have a specific reason to use them.
- The `value` parameter contains the incoming value. In this example, it's a `Strength` enumeration value.
- The `targetType` parameter is ignored. But you could use this parameter to validate that the type of property the converter is being used with is a `Color`. This is omitted in this example for simplicity.
- A switch expression is used to return a different color based on the `Strength` value.

### Use the converter in XAML

With the converter class created, you need to create an instance of it and reference it in the binding. The standard way to instantiate the converter is in the root element's resource dictionary.

First, map an XML namespace to the .NET namespace that contains the converter. In the following code example, the `cvt` XML namespace maps to the `MyProject.Converters` .NET namespace:

```xaml
<ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             xmlns:cvt="clr-namespace:MyProject.Converters"
             ...
```

Next, create an instance in the `ContentPage.Resources`:

```xaml
<ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             xmlns:cvt="clr-namespace:MyProject.Converters"
             x:Class="MyProject.PasswordExample">
    <ContentPage.Resources>
        <cvt:StrengthToColorConverter x:Key="StrengthToColorConverter" />
    </ContentPage.Resources>
```

Now an instance of the converter is in the resource dictionary with the key `StrengthToColorConverter`, which happens to be the same name as the type. This is a typical way of naming converters, as you generally just have a single converter you reuse throughout the XAML. If you, for some reason, required multiple converter instances, the keys would have to be different between them.

Lastly, reference the converter on the binding. Since the converter is in a resource dictionary, you use the `{StaticResource}` markup extension to reference it. The converter is assigned to the `Converter` binding property:

```csharp
<Entry BackgroundColor="{Binding PasswordStrength, Converter={StaticResource StrengthToColorConverter}}" ... />
```
