Recall that XAML is a declarative markup language. It's designed with the idea to simplify the process of creating your UI. The elements in XAML directly represent the instantiation of objects that you access in code-behind files.

Xamarin.Forms implements a Xamarin.Forms specific XAML parser that parses your declared XAML elements and instantiates each element as a CLR type. The parser will use additional namespace information to locate the assemblies that provide the type definition for each XAML element. It will be your responsibility to include these namespaces. The option to introduce types in this way highlights the extensibility of XAML. XAML allows you to create your app's UI with the freedom to include Xamarin.Forms elements, CLR types, and custom types.

Let's look at the example XAML page from the previous section to see how all these concepts are put together.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ContentPage xmlns="http://xamarin.com/schemas/2014/forms"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             x:Class="Sample.MyPage">
    <ContentPage.Content>
        <StackLayout>
            <Label Text="Please log in" />
            <Label Text="Username" TextColor="Black" />
            <Entry />
            <Label Text="Password" TextColor="Black" />
            <Entry IsPassword="true" />
            <Button Text="Log in" Clicked="LoginButton_Clicked" />
        </StackLayout>
    </ContentPage.Content>
</ContentPage>
```

## How to instantiate types in XAML

The first step in using XAML to build a UI is instantiating the UI control types. In XAML, we can create types by using Object Element Syntax.

### What is Object Element Syntax?

Object Element Syntax is a standard, well-formed, XML syntax to declare the element to instantiate. For example, if you want to declare a label, your XAML element will look like the following code:

```xml
<Label />
```

This XAML element will be parsed by the Xamarin.Forms XAML parser to instantiate the object in memory. Effectively, the parsed XAML `Label` is the same as the following C# code:

```csharp
new Label ();
```

Recall that XAML is a general-purpose markup language that can be used to create user interfaces for many technologies. Since we're using XAML in Xamarin.Forms, we need to instruct the Xamarin.Forms XAML parser to use Xamarin.Forms controls. We add this instruction by using namespaces.

### What is a Namespace?

An XML namespace is used to specify the location of the information needed to instantiate the XAML elements that you declare.

Namespaces are defined by adding the `xmlns` attribute to the root element in the XAML document. Typically, the root element of a Xamarin.Forms XAML document is `ContentPage`.

```xml
<ContentPage xmlns="http://xamarin.com/schemas/2014/forms"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             x:Class="Sample.MyPage">
</ContentPage>
```

As you can see, the `xmlns` attribute has a value of `http://xamarin.com/schemas/2014/forms`, which is referencing Xamarin.Forms. This value is known as the default namespace.

The second namespace, `xmlns:x`, has a prefix. The `x` following the colon is a namespace prefix. You'll use the prefix to indicate that you want to reference a namespace other than the default namespace. For example, in this case the `x` namespace is referencing XAML itself. This namespace is where you'll find things like intrinsic CLR types such as string, integer, and double.

## How to specify property values in XAML

In XML, attributes are used to describe or provide information about an element. In Xamarin.Forms XAML, we'll use attributes to set properties on the underlying type.

For example, considering the following C# code:

```csharp
new Label {Text = "Username", TextColor = Color.Black}
```

We're simply creating a new `Label` object and setting the `Text` and `TextColor` properties. To set properties in XAML, we would use attributes and it would look like the following XAML:

```xml
<Label Text="Username" TextColor="Black" />
```

One thing that you may notice that is different in the XAML code than the C# code is the values of the properties. For example, in the C# code, we use the `Color` type for the `TextColor` property. However, in the XAML, we use a string to set `TextColor`. Since `string` is the only valid thing that you can use for an XML attribute value, there needs to be a way to convert each `string` value to its correct type. In XAML, we do this conversion by using a Type Converter.

### What is a Type Converter?

A *Type Converter* is used to convert an XML attribute value to its correct type.

To understand this concept better, let's look at an example:

```xml
<Label Text="Username" TextColor="Black" FontSize="42" FontAttributes="Bold,Italic" />
```

In the above code, we create a `Label` that is setting its `Text`, `TextColor`, `FontSize`, and `FontAttributes` properties.

Let's start with the first property, `Text`. Behind the scenes, `Text` is already a string, which means we don't need a Type Converter. As we saw before, `TextColor` uses the `Color` type, so we'll need a Type Converter. The `FontSize` property is an integer, which means we'll use a Type Converter to parse the string to an integer. Finally, `FontAttributes` is an example of a complex object. You can combine the values as a comma-delimited string, `"Bold,Italic"`. The comma-delimited string is treated as a `[Flags]` based enumeration and the appropriate Type Converter will apply the bitwise **OR** of the value to the property.

Xamarin.Forms have associated Type Converters for most of the built-in classes. However, if a specific converter doesn't exist, you can write your own and associate it to your type to make it usable in XAML.

### Complex type assignment

Type converters are great for simple property settings; however, in some cases, you need to create a full object with its own property values. The solution to this problem is to change the property assignment to use an element-based syntax. This syntax is called the **Property Element** form. This syntax involves breaking the property setter into the parent-child form where the property is expressed in an element tag as **Type.PropertyName**.

Let's assume you want to assign a gesture recognizer to a label so that the user of the app can tap on the label. The gesture recognizer is a complex object with its own properties. Typically, these properties need to be assigned to ensure proper functionality:

```xml
<TapGestureRecognizer NumberOfTapsRequired="2" />
```

If we wanted to assign this value to a `Label`, we can write our XAML this way:

```xml
<Label Text="Username" TextColor="Black" FontSize="42" FontAttributes="Bold,Italic">
    <Label.GestureRecognizers>
        <TapGestureRecognizer NumberOfTapsRequired="2" />
    </Label.GestureRecognizers>
</Label>
```

`Label` has a property called `GestureRecognizers`, by using **Property Element** form, we can add our `TapGestureRecognizer` to the `Label`'s list of gestures.

### Default content property

Some Xamarin.Forms controls have a default content property. The content property allows you to specify the value of a property on a control without explicitly stating it in XAML.

For example, take a look at the following XAML:

```xml
<StackLayout>
    <StackLayout.Children>
        <Label Text="Please log in" />
    </StackLayout.Children>
</StackLayout>
```

In this code, we create a `StackLayout` and add a `Label` as a child. Since it's common to add children to a `StackLayout`, it's `Children` property is the default content property. It means that we can add a child without using the `Children` property directly. Here is what that would look like:

```xml
<StackLayout>
    <Label Text="Please log in" />
</StackLayout>
```