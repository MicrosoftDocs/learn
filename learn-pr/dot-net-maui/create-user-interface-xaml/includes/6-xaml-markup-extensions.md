Much of your XAML definition will be settled at compile time. You often know where elements should be positioned, what colors and fonts will be used, and which literal values should be assigned to properties.

However, sometimes you need to set a property value to a value that can't be determined at compile time. These values are only known when the program is running. In these situations, you can create an object that provides a value to XAML at runtime. XAML supports **Markup Extensions** for this purpose.

In this unit, you'll learn how to create and use markup extensions.

## What is a markup extension?

A markup extension is a class that you use in XAML to access runtime values. Suppose you have many labels defined in your XAML UI and you want to set the `FontSize` property to the same value throughout the app to ensure that all label styling is consistent. You can set the `FontSize` property using XAML as shown in the following example:

```xml
<Label Text="Hello, World!"
            Grid.Row="0"
            SemanticProperties.HeadingLevel="Level1"
            FontSize="28"
            HorizontalOptions="CenterAndExpand"/>
```

You can repeat this same setting for every label, but what if you later want to change this value? You need find every instance of this property and make the change. Also, suppose you don't know what value to use; it could be calculated at runtime based on factors, such as device orientation, screen resolution, or other considerations. In these cases, you need something more sophisticated than a hard-coded literal. This is where a markup extension is useful. Markup extensions give you flexibility in how you obtain a value that gets used in XAML.

## Creating a markup extension

A markup extension is a class that implements the **Microsoft.Maui.Controls.Xaml.IMarkupExtension** interface. This interface defines one method, named **ProvideValue**, with the following signature:

```csharp
public object ProvideValue(IServiceProvider serviceProvider)
{
    ...
}
```

This method's purpose is to supply a value to your XAML markup. Notice that the return type is `object`, so the value can be of any type as long as it's appropriate to the place in which it's being used. For example, in a markup extension that calculates and returns a font size, the return type should be a `double`.

The **serviceProvider** parameter contains contextual information about where the markup extension is being used in your XAML code; among other pieces of information, it identifies the control to which the extension is being applied.

You can keep the markup extension for the `FontSize` property simple. In the following example, the **MainPage** class exposes a `double` field named **MyFontSize**. The **GlobalFontSizeExtension** class implements the **IMarkupExtension** interface, and the **ProvideValue** method returns the value of **MyFontSize** variable:

```csharp
namespace MyMauiApp;

public partial class MainPage : ContentPage
{
    public const double MyFontSize = 28;

    public MainPage()
    {
        InitializeComponent();
        ...
    }
    ...
}

public class GlobalFontSizeExtension : IMarkupExtension
{
    public object ProvideValue(IServiceProvider serviceProvider)
    {
        return MainPage.MyFontSize;
    }
}
```

> [!NOTE]
> The **MyFontSize** field must be a `static` member of the **MainPage** class to allow it to be referenced in the **ProvideValue** method in this way. Good practice implies that in this case, the variable should also be a constant. A `const` value is `static`.
>
> The **ProvideValue** method could also make adjustments to the value returned, depending on the orientation and device form factor.

## Applying the markup extension to a control in XAML

To use the markup extension in your XAML code, add the namespace containing the **GlobalFontSizeExtension** class to the list of namespaces in the `ContentPage` tag. In the following example, this namespace is given the alias **mycode**:

```xml
<ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             xmlns:mycode="clr-namespace:MyMauiApp"
             x:Class="MyMauiApp.MainPage">
```

You can use the markup extension to set the `FontSize` property like this. Note the convention is that a markup extension has the suffix **Extension** in its name. XAML recognizes this suffix, and you don't need to include it when you call the extension from your XAML code. In the following example, the **GlobalFontSizeExtension** class is referenced simply as **GlobalFontSize**:

```xml
<Label Text="Hello, World!"
            Grid.Row="0"
            SemanticProperties.HeadingLevel="Level1"
            FontSize="{mycode:GlobalFontSize}"
            HorizontalOptions="CenterAndExpand"/>
```

You can apply the same markup extension throughout your XAML code for any control that needs to specify the font size. Later, if you decide to change the font size, you only need to modify the definition of the **MyFontSize** variable in the **MainPage** class.

## The StaticExtension class

As useful as the **GlobalFontSize** markup extension is, it's unlikely that you'd create such an extension. The reason for this is simple; .NET MAUI already provides a more generalized extension that allows you to reference any static value in your code. This extension is named **StaticExtension**, or **Static** for short. The following code shows this extension class's basic outline:

```csharp
[ContentProperty ("Member")]
public class StaticExtension : IMarkupExtension
{
    public string Member {get; set;}
    public object ProvideValue (IServiceProvider serviceProvider)
    {
        ...
    }
}
```

> [!NOTE]
> The purpose of custom markup extensions is to allow you to handle more complex situations rather than the simple static case. For example, you might need to dynamically change the font size based on device form factor.

To use this class in your XAML code, provide the name of the static variable you want to reference in the **Member** property, and the **ProvideValue** method returns value in this variable. The following example illustrates how to use it:

```xml
<Label Text="Hello, World!"
            Grid.Row="0"
            SemanticProperties.HeadingLevel="Level1"
            FontSize="{x:Static Member=mycode:MainPage.MyFontSize}"
            HorizontalOptions="CenterAndExpand"/>
```

.NET MAUI provides a set of other markup extension classes, which you can use for scenarios such as data binding, referencing dynamic resources and styles, and handling arrays of data.
