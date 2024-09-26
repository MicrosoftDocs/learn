Your app's visual experience will be different on each platform. You'll often need to fine-tune your UI for each platform based on the visual elements you use. .NET MAUI enables you to manage your app's layout based on these device properties.

In this unit, you'll learn about the features that .NET MAUI provides to allow you to tweak the UI for your apps according to the platform on which they're running.

## Using the Device class

The `DeviceInfo` class is a utility class that provides device-specific information for the device on which your app is running. It exposes this information through a set of properties. The most important property is `DeviceInfo.Platform`, which returns a string indicating the type of device currently in use: `Android`, `iOS`, `WinUI`, or `macOS`.

Consider the following scenario as an example of when you might use this feature. A .NET MAUI iOS app's default behavior is that content added to a page encroaches on the iOS status bar at the top of the screen. You want to change this behavior. The simplest solution is to shift the content down in the page. The Notes solution you created in the previous exercise addresses this problem by setting the `Padding` property of the `VerticalStackLayout` control to move the content down by 60 points:

```xml
<VerticalStackLayout x:Name="MyStackLayout" Padding="30,60,30,30">
    ...
</VerticalStackLayout>
```

The issue is that this problem is only applicable on iOS. Shifting the content down this much on Android and WinUI results in a waste of screen real estate at the top of the page.

You can query the `DeviceInfo.Platform` property to solve this display problem. You can add the following code to your app's page constructor to expand the padding at the top of the page, but only for iOS:

```csharp
MyStackLayout.Padding = 
    DeviceInfo.Platform == DevicePlatform.iOS
        ? new Thickness(30, 60, 30, 30) // Shift down by 60 points on iOS only
        : new Thickness(30); // Set the default margin to be 30 points
```

> [!NOTE]
> `DevicePlatform.iOS` is a `DevicePlatform` struct that returns the string value `iOS`. There are equivalent properties for the other supported platforms. You should use these properties rather than comparing against hard-coded strings; it's good practice, and it future-proofs your code if some of these string values change in the future.

This code works, but it's in the page's code-behind file. The padding is a user-interface-specific value. Arguably, it's more appropriate and convenient to do it from XAML instead of in the code-behind.

## Using the OnPlatform markup extension

.NET MAUI XAML provides the `OnPlatform` markup extension, which allows you to detect the runtime platform from within your XAML code. You can apply this markup extension as part of the XAML code that sets a property value. The extension requires you to provide the property type, together with a series of `On Platform` blocks in which you set the property value according to the platform.

> [!NOTE]
> The `OnPlatform` markup extension is generic; it takes a type parameter. The type specified by the `TypeArguments` attribute ensures the correct type of extension is used.

You can set the `Padding` property like this. Notice that the type of the `Padding` property is `Thickness`:

```xml
<VerticalStackLayout>
    <VerticalStackLayout.Padding>
        <OnPlatform x:TypeArguments="Thickness">
            <On Platform="iOS" Value="30,60,30,30" />
        </OnPlatform>
    </VerticalStackLayout.Padding>
    <!--XAML for other controls goes here -->
    ...
</VerticalStackLayout>
```

For platforms other than iOS, the padding will remain set to its default value of "0,0,0,0". For WinUI and Android, you can set the padding to 30 points with additional `OnPlatform` blocks:

```xml
<VerticalStackLayout>
    <VerticalStackLayout.Padding>
        <OnPlatform x:TypeArguments="Thickness">
            <On Platform="iOS" Value="30,60,30,30" />
            <On Platform="Android" Value="30" />
            <On Platform="WinUI" Value="30" />
        </OnPlatform>
    </VerticalStackLayout.Padding>
    ...
</VerticalStackLayout>
```

You can apply this same technique to other properties. The following example changes the stack layout's background color on a page to Silver on iOS, to Green on Android, and to Yellow on Windows.

```xml
<VerticalStackLayout>
    ...
    <VerticalStackLayout.BackgroundColor>
        <OnPlatform x:TypeArguments="Color">
            <On Platform="iOS" Value="Silver" />
            <On Platform="Android" Value="Green" />
            <On Platform="WinUI" Value="Yellow" />
        </OnPlatform>
    </VerticalStackLayout.BackgroundColor>
    ...
</VerticalStackLayout>
```

This syntax is a little verbose, but there's a reduced syntax available for the `OnPlatform` extension. You can simplify the example that sets the padding, as follows:

```xml
<VerticalStackLayout Padding="{OnPlatform iOS='30,60,30,30', Default='30'}">
    <!--XAML for other controls goes here -->
</VerticalStackLayout>
```

You can specify a default value for a property, together with any platform-specific values. In this form, the type parameter is inferred from the property to which the `OnPlatform` attribute is applied.

To set the background color, you can use this XAML fragment in place of the second preceding example:

```xml
<VerticalStackLayout BackgroundColor="{OnPlatform WinUI=Yellow, iOS=Silver, Android=Green}">
    ...
</VerticalStackLayout>
```
