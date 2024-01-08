XAML is a declarative markup language. It's designed with the idea to simplify the process of creating your UI. The elements in XAML directly represent the instantiation of objects that you access in code-behind files.

In this unit, you'll learn how to use the types available in XAML, and how to set and read properties of these types.

## Where are types defined?

.NET MAUI implements a XAML parser that parses your declared XAML elements and instantiates each element as a .NET type. The XAML dialect that the .NET MAUI parser understands is specific to .NET MAUI, although it's similar to XAML other frameworks use, such as Windows Presentation Foundation.

The .NET types that implement the items XAML code identifies are implemented by code in several .NET assemblies. Many of these assemblies are included as part of the .NET MAUI templates. You can also utilize other custom types by loading the appropriate assemblies as part of your project. Many assemblies are available as NuGet packages. Most of the common types used by a MAUI app are in the **Microsoft.Maui.Dependencies** and **Microsoft.Maui.Extensions** packages.

Each type is defined in a namespace. In your XAML code, you specify the namespaces for the types you reference. Most MAUI controls are located in the **Microsoft.Maui.Controls** namespace, while the **Microsoft.Maui** namespace defines utility types such as `Thickness`, and the **Microsoft.Maui.Graphics** namespace includes generalized types such as `Color`. The option to introduce types in this way highlights the extensibility of XAML. XAML allows you to create your app's UI with the freedom to include .NET MAUI XAML elements, .NET types, and custom types. For the most part, you don't need to worry about these namespaces as they're brought in using C#'s implicit `usings` feature that automatically adds them app-wide.

## How to instantiate types in XAML

The first step in using XAML to build a UI is instantiating the UI control types. In XAML, you can create an object of a specified type by using Object Element Syntax. Object Element Syntax is a standard, well-formed, XML syntax to declare an element. For example, if you want to create a label with a specific color, your XAML element will look like the following code:

```xml
<Label TextColor="AntiqueWhite"/>
```

the .NET MAUI XAML parser will parse this XAML element to instantiate the object in memory. Effectively, the parsed XAML label is the same as the following C# code:

```csharp
var myLabel = new Label
{
  TextColor = Color.FromRgb(255, 255, 100)
};
```

## What is a XAML namespace?

Remember that for the XAML parser to successfully parse the XAML definition of a control in a page, it must have access to the code that implements the control and defines its properties. The controls available to a .NET MAUI page are implemented in a collection of assemblies that are installed as part of the **Microsoft.Maui** NuGet package. The controls are located in a .NET namespace in these assemblies. In C# code, you bring a namespace into scope with the `using` directive. In a XAML page, you reference a namespace with the `xmlns` attribute of the page. The following code shows the namespaces the XAML page created in the previous unit uses:

```xml
<ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             ...>

    ...
</ContentPage>
```

The first namespace, `http://schemas.microsoft.com/dotnet/2021/maui`, is the page's default namespace. This URI form of namespace is typical of XML, and looks somewhat different from those with which you might be familiar in C#. However, this URI is simply an alias for one or more of the namespaces defined by the assemblies in the **Microsoft.Maui** NuGet package, so specifying this namespace at the start of the page brings all of the .NET MAUI types and controls into scope. If you omit this namespace, you won't be able to use controls such as `Button`, `Label`, `Entry`, or `StackLayout`.

The second namespace, `http://schemas.microsoft.com/winfx/2009/xaml`, references the assemblies that contain the various .NET intrinsic types such as strings, numerics, and properties. In the preceding XAML code, this namespace is assigned the alias **x**. In the XAML code for this page, you reference the types in this namespace by prefixing them with **x:**. For example, each XAML page is compiled into a class, and you specify the name of the class that is generated with the **x:Class** attribute of the page:

```xml
<ContentPage ...
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             x:Class="MauiXaml.Page1"
            ...>

    ...
</ContentPage>
```

You can reference types in your own assemblies in XAML code through a XAML namespace. For example, if you have types and methods that you want to use in your XAML code defined in a namespace named **Utils** in your project, you can add the **Utils** namespace to the page as shown in the following code. In this example, you access the types in this namespace by prefixing them with the alias **mycode**.

```xml
<ContentPage ...
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             xmlns:mycode="clr-namespace:Utils"
            ...>

    ...
</ContentPage>
```

> [!NOTE]
> You'll see more examples of this technique later on in this module.

## How to specify property values in XAML

In XML, you use attributes to describe or provide information about an element. In XAML, you use attributes to set properties on the underlying type. For example, considering the following C# code:

```csharp
var label = new Label { Text = "Username", TextColor = Color.Black };
```

This statement creates a new `Label` object and sets the `Text` and `TextColor` properties. To set properties in XAML, you use attributes. The corresponding XAML code looks like this:

```xml
<Label Text="Username" TextColor="Black" />
```

One thing that you might notice that is different in the XAML code than the C# code is the values of the properties. For example, in the C# code, you use the `Color` type for the `TextColor` property. However, in the XAML definition, you set `TextColor` with a string value. This is because a string is the only valid element that you can use for an XML attribute value. Therefore, there needs to be a way to convert each string value to its correct type. In XAML, you can do this conversion by using a **Type Converter**.

## What is a type converter?

A type converter converts an XML attribute specified as a string value to its correct type. To understand this concept better, consider the following example:

```xml
<Label Text="Username" TextColor="Black" FontSize="42" FontAttributes="Bold,Italic" />
```

This code creates a `Label` and sets its `Text`, `TextColor`, `FontSize`, and `FontAttributes` properties.

Start with the first property, `Text`. The text is already a string, which means the XAML page doesn't need a type converter. Next, `TextColor` uses the `Color` type, so XAML requires a type converter to translate the string into the corresponding `Color` value. The `FontSize` property is an integer, so XAML requires a type converter to parse the string to an integer. Finally, `FontAttributes` is an example of a complex object. You can combine the values as a comma-delimited string: "Bold,Italic". The comma-delimited string is treated as a [Flags]-based enumeration and the appropriate type converter will apply the bitwise `OR` of the value to the property.

.NET MAUI has type converters for most of the built-in classes, and it uses these type converters automatically. However, if a specific converter doesn't exist, you can write your own and associate it to your type to make it usable in XAML.

## Complex type assignment

Type converters are great for simple property settings; however, in some cases, you need to create a full object with its own property values. The solution to this problem is changing the property assignment to use an element-based syntax. This syntax is called the **Property Element** form. This syntax involves breaking the property setter into the parent-child form, where the property is expressed in an element tag of the form **Type.PropertyName**. Suppose you want to assign a gesture recognizer to a label so that the app user can tap on the label. The gesture recognizer is a complex object with its own properties. Typically, these properties need to be assigned to ensure proper functionality:

```xml
<TapGestureRecognizer NumberOfTapsRequired="2" />
```

If you need to assign this value to a `Label`, you can write the XAML like this:

```xml
<Label Text="Username" TextColor="Black" FontSize="42" FontAttributes="Bold,Italic">
    <Label.GestureRecognizers>
        <TapGestureRecognizer NumberOfTapsRequired="2" />
    </Label.GestureRecognizers>
</Label>
```

The `Label` type has a property named `GestureRecognizers`. By using the **Property Element** form, you can add a `TapGestureRecognizer` to the list of gestures for the `Label`.

### Default content property

Some .NET MAUI controls have a default content property. The content property allows you to specify the value of a property on a control without explicitly stating it in XAML. Take a look at the following XAML fragment:

```xml
<VerticalStackLayout>
    <VerticalStackLayout.Children>
        <Label Text="Please log in" />
    </VerticalStackLayout.Children>
</VerticalStackLayout>
```

This code creates a `VerticalStackLayout` and adds a `Label` as a child element. Because it's common to add children to a `VerticalStackLayout`, its `Children` property is the default content property. This means that you can add a child without explicitly specifying the `Children`, as follows:

```xml
<VerticalStackLayout>
    <Label Text="Please log in" />
</VerticalStackLayout>
```
