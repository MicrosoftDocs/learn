A resource is like a symbolic constant from a programming language. You define it in one place and reference it everywhere you need it. Your code will be easier to read because you use a descriptive name instead of a "magic" value. If you need to change the value, you only need to update the definition. Here, you'll see how to use resources to eliminate hard-coded values from your XAML.

## What is a resource?

A *resource* is any object that can be shared across your UI. The most common examples are fonts, colors, and sizes. However, you can also store complex objects such as `Style` and `OnPlatform` instances as resources.

You define a resource in either XAML or code. Then you apply it in either XAML or code. Typically, you'll work entirely in XAML, although we'll see a few cases later where code is useful.

Let's look at an example. Suppose you want to use the same `TextColor` values across the controls on a page. If you used hard-coded values, your XAML would look like the following. Notice how the value for the text color is repeated in the two controls.

```xml
<Label TextColor="Blue" FontSize="14">
<Button TextColor="Blue" FontSize="14">
```

Instead of repeating the text color, you can define it as a resource. The definition looks like this XAML.

```xml
<Color x:Key="PageControlTextColor">Blue</Color>
```

Notice how the defined element has `x:Key`. This key is what you'll use to look up the resource in your XAML. We're not done, though. You need to store that new resource in a dictionary before you can use it.

## What is ResourceDictionary?

`ResourceDictionary` is a Xamarin.Forms library class that's customized for use with UI resources. It's a dictionary, so it stores key/value pairs. The type of the key is limited to `String`, while the value can be any object.

Every Xamarin.Forms page has a property named `Resources` that can hold a `ResourceDictionary` object. The property is `null` by default, so you'll need to create a dictionary instance before you can use it. The following code shows how you would create a `ResourceDictionary` object and assign it to the `Resources` property of `Page`.

```xml
<Page.Resources>
    <ResourceDictionary>
        ...
    </ResourceDictionary>
</Page.Resources>
```

Xamarin.Forms has a built-in convenience that creates the dictionary instance automatically whenever you start using the `Resources` property. The previous example can be simplified to the following code.

```xml
<Page.Resources>
    ...
</Page.Resources>
```

This setup means that every page in your app can have its own dictionary. You use these page-specific dictionaries to store resources that will be used exclusively on that page.

## Create a resource

To create a resource, you declare it inside a `Resources` property. Here's an example that creates the text-color resource that we discussed earlier. Notice that we're taking advantage of the fact that Xamarin.Forms will automatically create the `ResourceDictionary` object for us to keep our XAML minimal.

```xml
<Page.Resources>
    <Color x:Key="PageControlTextColor">Blue</Color>
</Page.Resources>
```

When you're selecting a key for your resource, we recommend that you choose something based on _use_ rather than on _value_. For example, let's say you want to set a label's background to `Red`. Don't use `RedColor` for the key. Imagine the situation if you need to change the color from `Red` to `Blue`. You'll have a resource with a key of `RedColor` that maps to the value `Blue`. That name would be confusing. Instead, choose a key like `BackgroundColor`. This key will still be intuitive even if you change the color later.

## Apply a resource by using StaticResource

`StaticResource` is a markup extension for looking up resources in a resource dictionary. You provide the key of the resource, and the markup extension returns the corresponding value.

Let's see how this works. Your goal is to create a `Color` resource and then use it to set the `TextColor` property. You define the color in a dictionary and then use the markup extension to retrieve the value.

```xml
<Page.Resources>
    <Color x:Key="PageControlTextColor">Blue</Color>
</Page.Resources>

...

<Label TextColor="{StaticResource PageControlTextColor}" ... />
```

It's called `StaticResource` because the extension is evaluated only once. The dictionary lookup happens when the target object is created. The target property isn't updated if the resource value in the dictionary changes.

> [!WARNING]  
> `StaticResource` throws a runtime exception if the key isn't found.

## XAML intrinsic types

Let's look again at our previous example. We already defined the text color as a resource. Notice that the value for the font size is also repeated.

```xml
<Label TextColor="Blue" FontSize="14">
<Button TextColor="Blue" FontSize="14">
```

`FontSize` has type `Double`. To create a resource for this value, we need to use one of the XAML _intrinsic types_. That is, we need to use a type defined in the XAML specification.

The XAML specification gives us type names for many of the C# simple types. The following code shows an example resource for each of the intrinsic types.

```xml
<Page.Resources>
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
</Page.Resources>
```

## OnPlatform as a resource

It's common to need to adjust your app's UI slightly between platforms. The standard way to define the platform-specific values is by using an `OnPlatform` object.

Because `ResourceDictionary` maps strings to objects, you can put an `OnPlatform` instance in a dictionary. For example, the following code shows how to use different text colors on iOS and Android.

```xml
<Page.Resources>
    <OnPlatform x:Key="textColor"
                x:TypeArguments="Color"
                iOS="Silver"
                Android="Green" />
</Page.Resources>

...

<Label TextColor="{StaticResource textColor}" ... />
```