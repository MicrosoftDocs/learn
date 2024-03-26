A resource is like a symbolic constant from a programming language. You define it in one place and reference it everywhere you need it. Your code is easier to read because you use a descriptive name instead of a "magic" value. If you need to change the value, you only need to update the definition. 

In this module, you see how to use resources to eliminate hard-coded values from your XAML.

## What is a resource?

A resource is any object that can be shared across your UI. The most common examples are fonts, colors, and sizes. However, you can also store complex objects such as **Style** and **OnPlatform** instances as resources.

You define a resource in either XAML or code. Then you apply it in either XAML or code. Typically, you work entirely in XAML, although we show you a few cases later where code is useful.

Consider an example. Suppose you want to use the same **TextColor** values across the controls on a page. If you used hard-coded values, your XAML would look like the following. Notice how the value for the text color is repeated in the two controls.

```XML
<Label TextColor="Blue" FontSize="14">
<Button TextColor="Blue" FontSize="14">
```

Instead of repeating the text color, you can define it as a resource. The definition looks like this XAML:

```XML
<Color x:Key="PageControlTextColor">Blue</Color>
```

Notice how the defined element has an **x:Key** property that gives the resource a name. You use this key to look up the resource in your XAML. 

Before you can use a resource, you must store it in a resource dictionary.

## What is ResourceDictionary?

**ResourceDictionary** is a .NET MAUI library class customized for use with UI resources. It's a dictionary, so it stores key/value pairs. The type of the key is limited to **String**, while the value can be any object.

Every .NET MAUI XAML page has a property named **Resources** that can hold a **ResourceDictionary** object. The property is null by default, so you need to create a dictionary instance before you can use it. The following code shows how you would create a **ResourceDictionary** object and assign it to the **Resources** property of a **ContentPage**:

```XML
<ContentPage.Resources>
    <ResourceDictionary>
        ...
    </ResourceDictionary>
</ContentPage.Resources>
```

.NET MAUI XAML has a built-in convenience syntax that creates the dictionary instance automatically whenever you start using the **Resources** property. The previous example can be simplified to the following code:

```XML
<ContentPage.Resources>
    ...
</ContentPage.Resources>
```

Every page in your app can have its own dictionary. You use these page-specific dictionaries to store resources that are used exclusively on that page.

> [!NOTE]
> Each control on a page can also have its own resource dictionary. For example, you can add a resource directory to a **Label** control like this:
>
> ```xml
> <Label Text="Hello, World!"
>         ...
>         <Label.Resources>
>            ...
>         </Label.Resources>
></Label>
> ```
>
> Apart from layouts and views, which can hold child elements, it's not common to do this at the control level.

## Create a resource

To create a resource, you declare it inside the **Resources** property for a page. The following example creates the text-color resource described earlier

```XML
<ContentPage.Resources>
    <Color x:Key="PageControlTextColor">Blue</Color>
</ContentPage.Resources>
```

When you select a key for your resource, choose a name that reflects the use rather than the value of the resource. For example, to set a label's background to Red, don't use **RedColor** as the key, use **BackgroundColor** instead.

## Apply a resource by using StaticResource

**StaticResource** is a markup extension for looking up resources in a resource dictionary. You provide the key of the resource, and the markup extension returns the corresponding value. The following XAML mark-up shows an example that creates and uses a `Color` resource named **PageControlTextColor**. The XAML mark-up for the label control in the example uses the **StaticResource** markup extension to retrieve the value.

```XML
<ContentPage.Resources>
    <Color x:Key="PageControlTextColor">Blue</Color>
</ContentPage.Resources>

...

<Label TextColor="{StaticResource PageControlTextColor}" ... />
```

The extension is called **StaticResource** because the extension is evaluated only once. The dictionary lookup happens when the target object is created. The target property isn't updated if the resource value in the dictionary changes.

> [!WARNING]
> **StaticResource** throws a runtime exception if the key isn't found.

## XAML intrinsic types

The original example presented at the start of this unit sets the **TextColor** property and the **FontSize** property:

```XML
<Label TextColor="Blue" FontSize="14">
<Button TextColor="Blue" FontSize="14">
```

The **FontSize** has the type **Double**. To create a resource for this value, you use one of the XAML intrinsic types defined in the XAML specification. The XAML specification defines type names for many of the C# simple types. The following code shows example resources for each of the intrinsic types.

```XML
<ContentPage.Resources>
    <x:String x:Key="...">Hello</x:String>
    <x:Char x:Key="...">X</x:Char>
    <x:Single x:Key="...">31.4</x:Single>
    <x:Double x:Key="...">27.1</x:Double>
    <x:Byte x:Key="...">8</x:Byte>
    <x:Int16 x:Key="...">16</x:Int16>
    <x:Int32 x:Key="...">32</x:Int32>
    <x:Int64 x:Key="...">64</x:Int64>
    <x:Decimal x:Key="...">12345</x:Decimal>
    <x:TimeSpan x:Key="...">1.23:5959</x:TimeSpan>
    <x:Boolean x:Key="...">True</x:Boolean>
</ContentPage.Resources>
```

## Set platform-specific values for a resource

It's common to need to adjust your app's UI slightly between platforms. The standard way to define the platform-specific values is by using an **OnPlatform** object when you define a resource. For example, the following code shows how to create a resource that references different text colors on iOS, Android, macOS (Mac Catalyst), and Windows (WinUI).

```XML
<ContentPage.Resources>
    <OnPlatform x:Key="textColor" x:TypeArguments="Color">
        <On Platform="iOS" Value="Silver" />
        <On Platform="Android" Value="Green" />
        <On Platform="WinUI" Value="Yellow" />
        <On Platform="MacCatalyst" Value="Pink" />
    </OnPlatform> 
</ContentPage.Resources>
...

<Label TextColor="{StaticResource textColor}" ... />
```
