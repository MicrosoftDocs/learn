Much of your XAML definition will be known at compile time. You often know where elements should be positioned and what colors and fonts will be used, set literal values onto the properties, or let the platform make those decisions for you. 

Sometimes you want to set a property value to something that can't be determined at compile time. These values are only known when the program is running. You'll need to use an object that can provide a value to XAML at runtime. Microsoft has defined the **Markup Extension** for this purpose.

## What are markup extensions?

Markup extensions are classes that you use in XAML to access runtime values. Assume you have a button defined in XAML and you want to set the `BorderWidth` to the same value throughout the app. The idea is to create a value in XAML and use it as the attribute value.

```xml
<Button Text="OK" BorderWidth="2.5" BackgroundColor="Navy" />
```

Setting the `BorderWidth` will be hard to do without setting a constant runtime value or if you don't know the border width value until runtime. In those cases, you need something more sophisticated than a hard-coded literal and that's what markup extensions are for. Markup extensions give you flexibility in how you obtain a value that gets used in XAML.

## What is IMarkupExtension?

The interface `IMarkupExtension` is implemented by all markup extensions. `IMarkupExtension` supply the `object ProvideValue (IServiceProvider serviceProvider)` method.

```csharp
public interface IMarkupExtension {
    object ProvideValue (IServiceProvider serviceProvider);
}
```

 The `ProvideValue` method is called during the XAML load process. The markup extension produces a value and whatever value returns get assigned to the attribute in your XAML. Notice the difference, you're not hard coding a value at compile time, instead you're computing a value at runtime.

## Available markup extensions

There are several markup extensions that are predefined by Xamarin.Forms. Some of these extensions come from the XAML specification, some come from WPF and one extension is unique to Xamarin.Forms.

| XAML 2009 Spec | WPF             | Xamarin.Forms        |
| -------------- | --------------- | -------------------- |
| x:Static       | StaticResource  | ConstraintExpression |
| x:Type         | DynamicResource |                      |
| x:Array        | Binding         |                      |
| x:Reference    |                 |                      |
| x:Null         |                 |                      |

In this section, you're going to learn about `x:Static`. Some of the other extensions are covered in later modules.

### Static extension

A static extension is a markup extension that allows you to specify a symbolic constant in your code-behind and write XAML that's going to reach into the code-behind and access that symbolic constant. The symbolic constant could be a static property, a static field or any `new` value.

Let's look at a solution to your button's `BorderWidth` problem from earlier. First, you'll create a constant.

```csharp
namespace MyNamespace
{   ...
    public partial class MainPage : ContentPage
    {   ...
        public const double MyBorderWidth = 3.5;
    }
}
```

Notice the declared constant `MyBorderWidth`.  You want to access this value from XAML. Before we look at the XAML part of the solution, let's explore the `StaticExtension` class.

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

The following aspects of the class are important to note.

- Most markup extensions follow a naming convention. The class uses the `Extension` suffix as part of the class name. This naming convention is almost universally followed.
- Extensions have properties. You can think of extension properties as arguments that get passed to the extension to help it do its job. You're asking the extension to go to the code-behind and look up a member for you. You'll tell it what member to look up and that's what that property is for.

You'll use `x:Static` to access the `MyBorderWidth` from the XAML. Here's the finished code about how you would do that.

```xml
<ContentPage ...
             xmlns:me="clr-namespace:MyNamespace;assembly=MyApp">

    <Button BorderWidth="{x:StaticExtension Member=me:MainPage.MyBorderWidth}" />
    ...
</ContentPage>
```

The extension is assigned to the `BorderWidth` attribute right in XAML. The markup extension is used inline with the attribute syntax.

The expression starts with a curly brace. After the double quotes, you have an open curly brace and that's what tells the XAML parser that you're using a markup extension. The open curly brace tells the parser that any text that follows doesn't represent a literal value. Instead you have an expression that needs to get evaluated in order to produce the value.

Then we have an assignment to `Member=`. This assignment tells the static extension which member in the code-behind you want to access. Recall that `Member` is the property defined in the `StaticExtension` class and you need to assign it a value. This value is processed by the extension and the return value is assigned to the `BorderWidth` attribute.

The assigned value is identified by a namespace declaration. By using this namespace, you can specify actual name of the code-behind element as `me:MainPage.MyBorderWidth`.

### Simplify the extension declaration in XAML

When using an extension class in your XAML, you can omit any **Extension** suffix on the class name. The XAML parser still determines the class to use. The parser knows that it's looking for a markup extension, because of the open curly brace. The system looks behind the scenes for a class named `Static` or a class named `StaticExtension`. It finds the appropriate class.

If the markup extension defines a `Content` property, you can leave the member identified off from the XAML declaration. Your final XAML declaration looks like the following code:

```xml
<ContentPage ...
             xmlns:me="clr-namespace:MyNamespace;assembly=MyApp">

    <Button BorderWidth="{x:Static me:MainPage.MyBorderWidth}" />
    ...
</ContentPage>
```
