Stacking views in a vertical or horizontal list is a common design for user interfaces. Think about some common pages in applications. Examples include sign in, register, and settings pages. All these pages typically contain stacked content. In this unit, you'll learn how to arrange views in a vertical or horizontal list by using `StackLayout` and with the new optimized `VerticalStackLayout` and `HorizontalStackLayout`.

## What is a StackLayout, VerticalStackLayout, and HorizontalStackLayout?

`StackLayout` is a layout container that organizes its child views left-to-right or top-to-bottom. The direction is based on its `Orientation` property, and the default value is top-to-bottom. The following illustration shows a conceptual view of a vertical `StackLayout`.

:::image type="content" source="../media/4-stack-layout.png" alt-text="Illustration showing four blocks stacked vertically from top to bottom of the screen.":::

- `StackLayout` has a list of `Children` that it inherits from its base class `Layout<T>`. The list stores views, which are good because most UI elements you'll work with in .NET MAUI derive from `View`. Layout panels are also derived from `View`, which means you can nest panels if you need to.

- `VerticalStackLayout` and `HorizontalStackLayout` are the preferred layouts to use when you know that your orientation will not change as they are optimized for performance.

## How to add views to a StackLayout

In .NET MAUI, you can add views to a `StackLayout` in C# code or in XAML. Here's an example of three views added using code:

```xaml
<StackLayout x:Name="stack">
</StackLayout>
```

```csharp
public partial class MainPage : ContentPage
{
    public MainPage()
    {
        InitializeComponent();

        var a = new BoxView { BackgroundColor = Colors.Silver, HeightRequest = 40 };
        var b = new BoxView { BackgroundColor = Colors.Blue, HeightRequest = 40 };
        var c = new BoxView { BackgroundColor = Colors.Gray, HeightRequest = 40 };

        stack.Children.Add(a);
        stack.Children.Add(b);
        stack.Children.Add(c);
    }
}
```

You can add the views to the `Children` collection and `StackLayout` automatically positions the views in a vertical list. Here's what it will look like on an Android device:

:::image type="content" source="../media/4-stack-layout-rendered.png" alt-text="Screenshot showing three boxes stacked vertically at the top of the screen on an Android device.":::

To do the same thing in XAML, nest the children inside the `StackLayout` tags. The XAML parser adds the nested views to the `Children` collection automatically because `Children` is the `ContentProperty` for all layout panels. Here's an example of the same three views being added to a `StackLayout` in XAML:

```xaml
<StackLayout>
    <BoxView Color="Silver" />
    <BoxView Color="Blue" />
    <BoxView Color="Gray" />
</StackLayout>
```

## How views are ordered in a StackLayout

The order of the views in the `Children` collection determines their layout order when they're rendered. For views added in XAML, the textual order is used. For children added in code, the layout order is determined by the order in which you called the `Add` method.

## How to change the space between views in a StackLayout

It's common to want some space between the children of a `StackLayout`. `StackLayout` automatically adds a bit of room between each child, but you can control the space by using the `Spacing` property. The default value is six units, but you can set it to whatever looks good to you. Here's an example of setting the `Spacing` property to `30` in XAML:

```xaml
<StackLayout Spacing="30">
    <BoxView Color="Silver" />
    <BoxView Color="Blue" />
    <BoxView Color="Gray" />
</StackLayout>
```

The following screenshot shows how the UI would render on Android:

:::image type="content" source="../media/4-stack-layout-rendered-spacing.png" alt-text="Sreenshot showing three boxes stacked vertically on an Android device with 30 spacing between each.":::

## How to set the orientation of a StackLayout

`StackLayout` lets you arrange children in either a column or a row. You control this behavior by setting its `Orientation` property. So far, we've been showing only a vertical `StackLayout`.

`Vertical` is the default. Whether you explicitly set the `Orientation` to `Vertical` is up to you. Some programmers prefer an explicit setting to make the code more self-documenting.

Here's an example of setting the `Orientation` to `Horizontal` in XAML:

```xaml
<StackLayout x:Name="stack" Orientation="Horizontal">
    <BoxView Color="Silver" WidthRequest="40"/>
    <BoxView Color="Blue" WidthRequest="40"/>
    <BoxView Color="Gray" WidthRequest="40"/>
</StackLayout>
```

> [!NOTE]
> As described in the previous exercise, the change in orientation of the `StackPanel` causes it to ignore the `HeightRequest` properties of each `BoxView`. Instead, you set the `WidthRequest`.
The following screenshot shows how the UI would render on an Android device:

:::image type="content" source="../media/4-stack-layout-rendered-horizontal.png" alt-text="Screenshot showing three boxes stretching the full screen vertically, each stacked horizontally from left to right.":::

## Set a view's LayoutOptions in a StackLayout

Every view has a `VerticalOptions` and `HorizontalOptions` property. You can use these properties to set the position of the view within the rectangular display area provided by the layout panel.

As noted above, with `StackLayout`, the behavior of the `LayoutOptions` properties depends on the `Orientation` property of the `StackLayout`. `StackLayout` uses the `LayoutOptions` property in the direction opposite to its `Orientation`. By default, an element in a stack layout will not be allocated any extra space in the same direction as the `Orientation` of the stack layout. Assigning a position for that direction in this default case will not change the rendering of the element. There is a change in the rendering, though, when position is combined with expansion.

## What is expansion?

Recall from an earlier unit that the `LayoutOptions` struct contains a `bool` property called `Expands`. This property is designed specifically for `StackLayout` and allows a child view to request extra space if there's any available. Here's an example of how the `Expands` property works:

:::image type="content" source="../media/4-expands-property.png" alt-text="Illustration showing a StackLayout expansion with three boxes: the top and bottom boxes request extra space and are given a split of the remaining vertical whitespace.":::

Notice that there's extra space available in the `StackLayout`. The extra space will be divided evenly among all views that request additional space.

## How to request extra space

Every view has two `LayoutOptions` properties called `VerticalOptions` and `HorizontalOptions`. So far, you've seen four values for these properties: `Start`, `Center`, `End`, and `Fill`. If you want to request extra space, you replace the `LayoutOptions` value with one of these values: `StartAndExpand`, `CenterAndExpand`, `EndAndExpand`, or `FillAndExpand`.

Here's how each of these values works:

:::image type="content" source="../media/4-layout-options-expands.png" alt-text="Illustration showing a box in StackLayout using four expansion settings: StartAndExpand, CenterAndExpand, EndAndExpand, and FillAndExpand.":::

The orange box is the view and the gray rectangle represents the extra space given to it by the `Expands` property. The view fills the extra space only when you use the `FillAndExpand` value. When you use the other values, the extra space remains empty, but it can't be used by other views in the `StackLayout`.

## Optimized StackLayouts
Mentioned earlier, the `VerticalStackLayout` and `HorizontalStackLayout` are optimized `StackLayout` controls with pre-defined orientations. It is recommended to use these controls when possible for the best layout performance. These layouts have the functionality of `LayoutOptions` and `Spacing` that the regular `StackLayout` has.

```xaml
<VerticalStackLayout Spacing="30">
    <BoxView Color="Silver" />
    <BoxView Color="Blue" />
    <BoxView Color="Gray" />
</VerticalStackLayout>

<HorizontalStackLayout Spacing="30">
    <BoxView Color="Silver" />
    <BoxView Color="Blue" />
    <BoxView Color="Gray" />
</HorizontalStackLayout>
```

