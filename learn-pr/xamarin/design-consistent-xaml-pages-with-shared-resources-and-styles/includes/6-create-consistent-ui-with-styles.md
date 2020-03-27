Resources are great to avoid hard-coded, duplicate values in your XAML. But they can be tedious to apply. You assign each property value individually, which results in cluttered and verbose XAML. This unit shows you how to group multiple settings into a style so you can apply them all at once.

## How resources clutter your XAML

A resource provides a value for a single property. Let's look at an example to help us see how resources can lead to verbose XAML. Suppose you want a customized look for your buttons. You first create resources for the values that you need. Then, you apply each resource to all your buttons. The following code shows how the XAML would look for two buttons.

```XML
<Button
    Text = "OK"
    BackgroundColor = "{StaticResource highlightColor}"
    BorderColor = "{StaticResource borderColor}"
    BorderRadius = "{StaticResource borderRadius}"
    BorderWidth = "{StaticResource borderWidth}"
    TextColor = "{StaticResource textColor}" />

<Button
    Text = "Cancel"
    BackgroundColor = "{StaticResource highlightColor}"
    BorderColor = "{StaticResource borderColor}"
    BorderRadius = "{StaticResource borderRadius}"
    BorderWidth = "{StaticResource borderWidth}"
    TextColor = "{StaticResource textColor}" />
```

Notice how the same five properties are set on each of the buttons. It's good that you're using resources so there are no repeated, hard-coded values. However, this type of XAML quickly gets hard to read. The solution is to create a style that assigns all five properties at once.

## What is a setter?

Before we can get to styles, we need to talk about setters. They're the key component you'll use to create your styles.

A _setter_ is a container for a property/value pair. You can think of a setter as representing an assignment statement. You specify which property to assign and the value to load. You'll typically create `Setter` objects in XAML. The following code shows how to create a `Setter` object for the `TextColor` property.

```xml
<Setter Property="TextColor" Value="White" />
```

You can use a resource for the value in a setter, as shown in the following code. This technique is great when you want to use the same value in multiple setters. We'll avoid resources in our examples to keep the code simple.

```xml
<Setter Property="TextColor" Value="{StaticResource textColor}" />
```

> [!NOTE]
> The `Property` value that you specify in a setter must be implemented as a bindable property (`BindableProperty`). All properties on controls in Xamarin.Forms that end with the suffix `Property` are bindable properties. If you're trying to use a property like `TextColor` in your setter, make sure there's a corresponding bindable property named `TextColorProperty` in that control. In practice, almost all the properties you'll want to use in your setters are implemented this way.

## What is a style?

A _style_ is a collection of setters targeted at a specific UI view. Xamarin.Forms requires the target type so it can make sure that the properties in your setters exist on that type.

The following code shows a style that combines the five values from the previous example. Notice that `TargetType` is set to `Button` and all the properties in the setters are part of the `Button` class. You can't use this style for a label, because the `Label` class doesn't include the `BorderColor`, `BorderRadius`, or `BorderWidth` property.

```xml
<Style TargetType="Button">
    <Setter Property="BackgroundColor" Value="#2A84D3" />
    <Setter Property="BorderColor" Value="#1C5F9B" />
    <Setter Property="BorderRadius" Value="10" />
    <Setter Property="BorderWidth" Value="3" />
    <Setter Property="TextColor" Value="White" />
</Style>
```

## Define a style

You'll typically define your styles as resources inside `ResourceDictionary`. A dictionary makes it easy to use the style across multiple controls on the same page or even across your entire application. The following code shows how you would define a style as a resource inside a dictionary. Notice how we added `x:Key`.

```xml
<Page.Resources>
    <Style x:Key="MyButtonStyle" TargetType="Button">
    ...
    </Style>
</Page.Resources>
```

## Apply a style

You apply a style by assigning to a property named `Style`. The assignment causes each of the `Setter` objects in the style to be applied to the target control. The `Style` property is defined in the `VisualElement` class. Most controls inherit from `VisualElement`, so the property is available on almost everything you'll put in your UI. The following code shows how to apply our button style to two buttons.

```xml
<Button Text="OK" Style="{StaticResource MyButtonStyle}" />
<Button Text="Cancel" Style="{StaticResource MyButtonStyle}" />
```

In the previous example, we used `StaticResource` to load the style. This technique is great when you don't need the style to change at runtime. But what if you want to implement something like dynamic themes, where the UI needs to change at runtime? In that case, you would use `DynamicResource` to load the style.

```xml
<Button Text="Cancel" Style="{DynamicResource MyButtonStyle}" />
```

`DynamicResource` listens for replacement of `x:Key` in the dictionary. If you write code that loads a new style into `ResourceDictionary` with that same `x:Key` instance, the new style will automatically get applied to your UI.

## Use an implicit style for multiple controls

Suppose your UI has 50 buttons and you want to apply the same style to all of them. With what we know so far, you'd need to assign to the `Style` property on each button. It's not that hard to do, but it's still tedious.

An _implicit style_ is a style that you add to `ResourceDictionary` without giving it an `x:Key` instance. Implicit styles are automatically applied to all controls of the `TargetType` object. 

Here's the previous example declared as an implicit style. This style will be loaded onto every `Button` instance on the page.

```xml
<Page.Resources>
    <Style TargetType="Button">
        <Setter Property="BackgroundColor" Value="Blue" />
        <Setter Property="BorderColor" Value="Navy" />
        ...
    </Style>
</Page.Resources>
```

Here's one last detail to keep in mind. The matching of implicit styles to controls requires an exact match to `TargetType`. Controls that inherit from the target type will not receive the styles. To affect inherited controls, you can set the `Style.ApplyToDerivedTypes` attribute to `True`. You could apply a style to `ContentPage` and have it affect any of your pages that inherit from it. If you wanted all your pages to have a black background, you could use a style such as this.

```xml
<Page.Resources>
    <Style TargetType="ContentPage"
           ApplyToDerivedTypes="True">
        <Setter Property="BackgroundColor" Value="Black" />
    </Style>
</Page.Resources>
```

## Override a style

Let's assume you want to use a style that someone else has written. That style might not be perfect for what you need. For example, the style might have three setters and two of them do exactly what you want, but the third one doesn't. Can you still use the style?

Think of a style as providing default values. You can use a style and then override the inappropriate value by setting that property directly. The explicit setting is applied after the style, so it will override the value from the style. 

Let's look at an example. Suppose you want to use the following style for several buttons on your page.

```xml
<Style x:Key="MyButtonStyle" TargetType="Button">
    <Setter Property="BackgroundColor" Value="Blue" />
    <Setter Property="BorderRadius" Value="10" />
    <Setter Property="BorderWidth" Value="3" />
</Style>
```

Let's assume that this style works for all your buttons except  **Cancel**, which needs a red background. You can use the style for the **Cancel** button as long as you also set `BackgroundColor` directly. The following code shows how to override the color setting.

```xml
<Button
    Text="Cancel"
    Style="{StaticResource MyButtonStyle}"
    BackgroundColor="Red"
    ... />
```

### Target an ancestor type

Suppose you want a custom background color for your buttons and labels. You can create separate styles for each type. Or, you can create one style with `TargetType` set to `VisualElement`. This technique works because `VisualElement` is a base class for both `Button` and `Label`.

The following code shows a style that targets a base class that's being applied to two different derived types.

```xml
<Style x:Key="MyVisualElementStyle" TargetType="VisualElement">
    <Setter Property="BackgroundColor" Value="#2A84D3" />
</Style>

<Button Style="{StaticResource MyVisualElementStyle}" ... />
<Label Style="{StaticResource MyVisualElementStyle}" ... />
```

We have to define the style by using `x:Key` and apply it explicitly to use this technique. An implicit style won't work here because `TargetType` for an implicit style must be an exact match to the object type.

## Use BasedOn to inherit from a style

Suppose you want to create a cohesive look for your UI. You decide that all controls should use a consistent background color. The background color setting will then likely appear in more than one of your styles. The following code shows two styles with a repeated setter.

```xml
<Style x:Key="MyButtonStyle" TargetType="Button">
    <Setter Property="BackgroundColor" Value="Blue" />
    <Setter Property="BorderColor" Value="Navy" />
    <Setter Property="BorderWidth" Value="5" />
</Style>

<Style x:Key="MyEntryStyle" TargetType="Entry">
    <Setter Property="BackgroundColor" Value="Blue" />
    <Setter Property="TextColor" Value="White" />
</Style>
```

You can use style inheritance to factor out that duplicate setter into a base style. To create a derived style, you set its `BasedOn` property. The new style inherits all the setters from its base. It can also add new setters or replace an inherited setter with one that contains a different value.

The following code shows the previous example styles refactored into a hierarchy. The common setter appears only in the base style rather than being repeated. Notice that you use `StaticResource` to look up the base style. That's the only option, because `DynamicResource` isn't allowed.

```xml
<Style x:Key="MyVisualElementStyle" TargetType="VisualElement">
    <Setter Property="BackgroundColor" Value="Blue" />
</Style>

<Style x:Key="MyButtonStyle" TargetType="Button" BasedOn="{StaticResource MyVisualElementStyle}">
    <Setter Property="BorderColor" Value="Navy" />
    <Setter Property="BorderWidth" Value="5" />
</Style>

<Style x:Key="MyEntryStyle" TargetType="Entry" BasedOn="{StaticResource MyVisualElementStyle}">
    <Setter Property="TextColor" Value="White" />
</Style>
```

There's one last thing worth mentioning. The `TargetType` value of the base and derived styles must be compatible. There are two options for what "compatible" means here:

- The `TargetType` objects are the same.
- The base style's `TargetType` object is a base class of the derived style's `TargetType` object.
