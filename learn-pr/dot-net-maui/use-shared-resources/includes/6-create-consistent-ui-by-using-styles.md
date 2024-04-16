Resources are great for avoiding hard-coded, duplicate values in your XAML mark-up, but they can be tedious to apply. You assign each property value individually, which can result in cluttered and verbose XAML. This unit shows you how to group multiple settings into a style, which can help to declutter your code and make it more maintainable.

## How resources can clutter your XAML

A resource provides a value for a single property. However, using lots of resources can lead to verbose XAML. Suppose you want a customized look for your buttons. You first create resources for the values that you need. Then, you apply each resource to all your buttons. The following code shows how the XAML mark-up might look for two buttons.

```XML
<Button
    Text = "OK"
    BackgroundColor = "{StaticResource highlightColor}"
    BorderColor = "{StaticResource borderColor}"
    BorderWidth = "{StaticResource borderWidth}"
    TextColor = "{StaticResource textColor}" />

<Button
    Text = "Cancel"
    BackgroundColor = "{StaticResource highlightColor}"
    BorderColor = "{StaticResource borderColor}"
    BorderWidth = "{StaticResource borderWidth}"
    TextColor = "{StaticResource textColor}" />
```

Notice how the same five properties are set on each of the buttons. Using resources removes the need for repeated, hard-coded values. However, this type of XAML mark-up quickly gets hard to read. Additionally, if you're setting a large number of properties for each control, it's easy to accidentally omit one of them, leading to inconsistencies in the appearance of the controls. The solution is to create a style that assigns all four properties at once.

## What is a setter?

**Setters** are the key components you use to create styles.

A setter is a container for a property/value pair. You can think of a setter as representing an assignment statement. You specify which property to assign and the value to apply. You typically create **Setter** objects in your XAML mark-up. The following example creates a **Setter** object for the **TextColor** property.

```XML
<Setter Property="TextColor" Value="White" />
```

You can use a resource for the value in a setter, as shown in the following code. This technique is great when you want to use the same value in multiple setters.

```XML
<Setter Property="TextColor" Value="{StaticResource textColor}" />
```

> [!NOTE]
> The property value that you specify in a setter must be implemented as a bindable property. All properties on controls in .NET MAUI that end with the suffix *Property* are bindable properties. If you're trying to use a property such as **TextColor** in a setter, make sure there's a corresponding bindable property named **TextColorProperty** for that control. In practice, almost all the properties you'll want to use in your setters are implemented this way.

## What is a style?

A style is a collection of setters targeted at a specific type of control. .NET MAUI requires a target type so it can make sure that the properties in your setters exist on that type.

The following code shows a style that combines the four values from the previous example. Notice that **TargetType** is set to **Button** and all the properties in the setters are members of the **Button** class. You can't use this style for a label, because the **Label** class doesn't include the **BorderColor** or **BorderWidth** property.

```XML
<Style TargetType="Button">
    <Setter Property="BackgroundColor" Value="#2A84D3" />
    <Setter Property="BorderColor" Value="#1C5F9B" />
    <Setter Property="BorderWidth" Value="3" />
    <Setter Property="TextColor" Value="White" />
</Style>
```

## Define a style

You typically define styles as resources inside a **ResourceDictionary** object. A resource dictionary makes it easy to use the style across multiple controls on the same page, or even across your entire application. The following code shows how to define a style as a resource inside a dictionary. Notice that the style is given a name using the **x:Key** property. Naming a style enables you to reference it from within your XAML pages.

```XML
<ContentPage.Resources>
    <Style x:Key="MyButtonStyle" TargetType="Button">
        ...
    </Style>
</ContentPage.Resources>
```

## Apply a style

You attach a style to a control by assigning the name to the **Style** property. The assignment causes each of the **Setter** objects in the style to be applied to the target control. The following code shows how to apply a button style to two buttons.

```XML
<Button Text="OK" Style="{StaticResource MyButtonStyle}" />
<Button Text="Cancel" Style="{StaticResource MyButtonStyle}" />
```

In the previous example, you used the **StaticResource** mark-up extension to attach the style to the controls. This technique is great when you don't need the style to change at runtime. But what if you want to implement something like dynamic themes, where the UI needs to change? In this case, you can use the **DynamicResource** mark-up extension to load the style.

```XML
<Button Text="Cancel" Style="{DynamicResource MyButtonStyle}" />
```

**DynamicResource** listens for replacement of the **x:Key** property in the resource dictionary. If you write code that loads a new style into ResourceDictionary with that same **x:Key** value, the new style is automatically applied to your UI.

## Use an implicit style for multiple controls

Suppose your UI has 50 buttons and you want to apply the same style to all of them. With what we know so far, you'd need to assign to the **Style** property on each button manually. It's not that hard to do, but it's still tedious.

An *implicit style* is a style that you add to a resource dictionary without giving it an **x:Key** identifier. Implicit styles are automatically applied to all controls of the specified **TargetType** object.

The following code shows the previous example declared as an implicit style. This style is applied to every button on the page.

```XML
<ContentPage.Resources>
    <Style TargetType="Button">
        <Setter Property="BackgroundColor" Value="Blue" />
        <Setter Property="BorderColor" Value="Navy" />
        ...
    </Style>
</ContentPage.Resources>
```

> [!IMPORTANT]
> The matching of implicit styles to controls requires an exact match to the specified **TargetType**. Controls that inherit from the target type will not receive the styles. To affect inherited controls, you can set the **Style.ApplyToDerivedTypes** attribute to **True** when you define the style. For example, to apply a style to the **Button** type and have it affect any of your buttons that inherit from **Button** (such as an **ImageButton**, **RadioButton**, or a custom type that you create), you could use a style such as this.

```XML
<ContentPage.Resources>
    <Style TargetType="Button"
           ApplyToDerivedTypes="True">
        <Setter Property="BackgroundColor" Value="Black" />
    </Style>
</ContentPage.Resources>
```

## Override a style

You can think of a style as providing a set of default values for controls. An existing style might be close to your requirements, but contain one or two setters that you don't want. In that case, you can apply the style and then override the value by setting properties directly. The explicit setting is applied after the style, so it will override the value from the style.

Suppose you want to use the following style for several buttons on your page.

```XML
<Style x:Key="MyButtonStyle" TargetType="Button">
    <Setter Property="BackgroundColor" Value="Blue" />
    <Setter Property="BorderRadius" Value="10" />
    <Setter Property="BorderWidth" Value="3" />
</Style>
```

This style works for all your buttons except Cancel, which needs a red background. You can use the same style for the Cancel button as long as you also set the **BackgroundColor** property directly. The following code shows how to override the color setting.

```XML
<Button
    Text="Cancel"
    Style="{StaticResource MyButtonStyle}"
    BackgroundColor="Red"
    ... />
```

## Target an ancestor type

Suppose you want a custom background color for your buttons and labels. You can create separate styles for each type, or you can create one style with **TargetType** set to VisualElement. This technique works because **VisualElement** is a base class for both **Button** and **Label**.

The following code shows a style that targets a base class that's being applied to two different derived types.

```XML
<Style x:Key="MyVisualElementStyle" TargetType="VisualElement">
    <Setter Property="BackgroundColor" Value="#2A84D3" />
</Style>
...
<Button Style="{StaticResource MyVisualElementStyle}" ... />
<Label Style="{StaticResource MyVisualElementStyle}" ... />
```

This example identifies the style by using **x:Key** and the controls apply it explicitly. An implicit style doesn't work here because **TargetType** for an implicit style must be an exact match to the control type.

## Use BasedOn to inherit from a style

Suppose you want to create a cohesive look for your UI. You decide that all controls should use a consistent background color. The background color setting is likely to appear in more than one of your styles. The following code shows two styles with a repeated setter.

```XML
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

You can use style inheritance to factor out the duplicate setter into a base style. To create a derived style, set its **BasedOn** property to reference the base style. The new style inherits all the setters from its base style. The derived style can also add new setters or replace an inherited setter with one that contains a different value.

The following code shows the previous example styles refactored into a hierarchy. The common setter appears only in the base style rather than being repeated. Notice that you use the **StaticResource** mark-up extension to look up the base style. You can't use **DynamicResource** in this situation.

```XML
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

The **TargetType** value of the base and derived styles must be compatible. For the styles to be compatible, they must either have the same **TargetType** property, or the **TargetType** of the derived style is a descendent of the **TargetType** of the base style.
