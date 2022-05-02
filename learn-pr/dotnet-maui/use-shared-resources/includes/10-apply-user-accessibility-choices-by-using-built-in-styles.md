Many operating systems let users choose some device-wide preferences. The most common setting is text size. The following screenshots show how the user can adjust their preferences on iOS and Android.

:::image type="content" source="../media/10-ios-android-pref.png" alt-text="A screenshot showing the text size preference screen from both iOS and Android side-by-side.":::

Your applications should respect the user's device-wide preferences for appearance and accessibility. Ideally you'll update the application's UI immediately when the user's settings change. In this unit, you'll learn how to use built-in styles to incorporate the user's device settings into your app's UI.

## What are built-in styles?

.NET MAUI maps the user's device-wide preferences to styles called *built-in styles*. It keeps these styles updated as the user changes their settings. If the user changes their device-wide preferences, all the elements in an application that use the built-in styles will also change.

Most built-in styles target the **Label** class. The main goal is to let your application incorporate the user's choice for text size. The styles are designed around specific use cases. For example, there's a built-in style intended for titles, another one for body text, and so on. The following screenshot shows several labels with various built-in styles applied. The screenshot displays the name of the built-in style as the label text.

:::image type="content" source="../media/10-style-example.png" alt-text="A screenshot showing examples of built-in styles and how the appear differently on the screen.":::

## How to apply a built-in style

.NET MAUI defines a string to identify each of the built-in styles. For convenience, the strings are gathered together as symbolic constants in the nested **Device.Styles** class. The following code snippet shows the **Styles** class and the string fields.

```csharp
public static class Styles
{
    public static readonly string TitleStyleKey;
    public static readonly string SubtitleStyleKey;
    public static readonly string BodyStyleKey;
    public static readonly string ListItemTextStyleKey;
    public static readonly string ListItemDetailTextStyleKey;
    public static readonly string CaptionStyleKey;
    public static readonly Style TitleStyle;
    public static readonly Style SubtitleStyle;
    public static readonly Style BodyStyle;
    public static readonly Style ListItemTextStyle;
    public static readonly Style ListItemDetailTextStyle;
    public static readonly Style CaptionStyle;
}
```

You use the string fields in your code to apply one of the built-in styles. Here's an example for a label that displays a title.

```XML
<Label Text="Welcome" Style="{DynamicResource TitleStyle}" />
```

You must use the **DynamicResource** mark-up extension  to apply a built-in style. These styles are generated via code, so they might not be available immediately on startup. Using the **StaticResource** mark-up extension to attempt to access a built-in style will cause a runtime exception. These styles can change at runtime, if the user changes their preferences. 

## How to use a built-in style as a base

The **BaseResourceKey** mark-up extension lets you use a built-in style as a base style, and then extend it with your own setters. It does a dynamic lookup that keeps the property values synchronized to the user's preferences. The markup below shows an example, using a style based on the built-in **TitleStyle** style:

```XML
<ResourceDictionary>
    ...
    <Style x:Key="myTitleStyle" TargetType="Label" BaseResourceKey="TitleStyle">
        <Setter Property="TextColor" Value="Red" />
    </Style>
</ResourceDictionary>
```

The operation of **BaseResourceKey** is similar to that of **DynamicResource**. A link is maintained to the underlying style. If the style changes, the change propagates through to your derived style.

The use of **BaseResourceKey** isn't exclusive to built-in styles. You can use it with your own styles if needed. For example, suppose your base style was dynamically generated in C# code and it wasn't available at startup. Using **BasedOn** won't work, because **BasedOn** supports only **StaticResource**.

Another example is if you want your base style to change dynamically. Using **BaseResourceKey** will let you write code to remove or replace the base style in the dictionary. Your style will be updated automatically to use the new base.
