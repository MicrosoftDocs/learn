The visual experience of your app will be different on each platform. You'll often need to fine-tune your UI for each platform based on the visual elements you use. Xamarin.Forms provides a way for you to manage the layout of your app based on these device properties.

The default behavior in an Xamarin.Forms iOS app is that content added to a page overlaps the iOS status bar. Assume you want to change this behavior. There are two ways you could fix your layout: either add a navigation bar or shift the content down in the page. The problem is that your app's design doesn't specify a navigation bar for this specific page, and the problem only manifest on iOS. Shifting content on any other operating system will show an incorrect design.

## What is Device.RuntimePlatform?

The `Device.RuntimePlatform` property allows you to select a unique value for each platform. The property is available from the `OnPlatform` class. `Device.RuntimePlatform` is set at runtime by Xamarin.Forms to allow you to determine the OS the app is running on. You can use the `Device` class to check the `Device.RuntimePlatform` and decide which code path to execute.

You can use this technique to solve the display problem by padding the top of the page by 20 units. The iOS status bar's height is about 20 units. Your code will look like the following code:

```csharp
if (Device.RuntimePlatform == Device.iOS)
{
    Padding = new Thickness(0, 20, 0, 0);
}
```

This code works, but it's in the code-behind file of the page. Padding is a UI-specific value. Arguably, it's more appropriate and convenient to do it from XAML instead of from code-behind.

## What is OnPlatform?

The `OnPlatform` class is part of the Xamarin.Forms infrastructure. `OnPlatform` allows you to set properties on XAML elements and is used at runtime for iOS, Android, and other supported Xamarin.Forms platforms. You specify different values, and then, at runtime, `OnPlatform` does that switch statement for you. It's just a type converter that returns the appropriate value for the runtime platform.

`OnPlatform` is generic. You must specify what type `T` will be. Specifying the type in code is easy, but your goal is to specify the type from XAML, not from code. The XAML specification has a way to specify generic type arguments with the `<x:TypeArguments />` directive. Here's an example for setting a layout background color:

```xml
<StackLayout.BackgroundColor>
    <OnPlatform x:TypeArguments="Color">
        <On Platform="iOS" Value="Silver" />
        <On Platform="Android" Value="Green" />
    </OnPlatform>
</StackLayout.BackgroundColor>
```

Let's see how to solve the page padding problem from earlier.

First, you're resetting the padding property of the page. Padding is of type `Thickness`, which has a type converter to handle all the padding side values. This shorthand means that your XAML will look like the following code:

```xml
<ContentPage Padding="0,20,0,0">
```

However, your goal is to set the top padding to 20 units only for iOS. You use an `OnPlatform` object again. In this case, with padding, set the type to `Thickness`:

```xml
<ContentPage.Padding>
    <OnPlatform x:TypeArguments="Thickness">
        <On Platform="iOS" Value="0,20,0,0" />
        <On Platform="Android" Value="0,0,0,0" />
    </OnPlatform>
</ContentPage.Padding>
```

For Android, you use all **0** values, and that turns out to be the default for a `Thickness` object. You don't have to specify these default values. You can simplify your XAML further:

```xml
<ContentPage.Padding>
    <OnPlatform x:TypeArguments="Thickness">
        <On Platform="iOS" Value="0,20,0,0" />
    </OnPlatform>
</ContentPage.Padding>
```
