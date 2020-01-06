When your XAML UI is defined, you'll add code to respond to user interaction. Xamarin.Forms notifies you of user input through standard .NET events. 

With UI objects, keep in mind is that the instantiated object graph that's created by XAML is the same as the object graph that's created when you use a code-behind class. You can navigate through the relationships and code by accessing the `Content` property and by casting it to the type that you want it to be.

Let's look at an example:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ContentPage xmlns="http://xamarin.com/schemas/2014/forms"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             x:Class="Sample.MyPage">
    <ContentPage.Content>
        <StackLayout>
            ...
            <Button Text="Log in" />
        </StackLayout>
    </ContentPage.Content>
</ContentPage>
```

You can write code like the following associated partial class:

```csharp
public partial class MyPage : ContentPage {
    public MyPage() {
        InitializeComponent();

        var content = (StackLayout) this.Content;
    }
}
```

In this code, the idea is to access the `StackLayout` object and potentially gain access to the button. You listen for user interaction. Because the `Content` property on the `ContentPage` is of type `View`, you cast the object to a `StackLayout` type.

You could pick off any object you like by casting the `Content` property, but it's a fragile way to identify objects, and *we don't recommend it*.  You're depending on the structure of the XAML without any guarantee or compile-time verification that your assumption about the object type is correct.

## Name elements in XAML

The proper way to find elements that are created in the XAML is to name the object. Use the XAML attribute `x:Name`. The `x:Name` attribute does two things:

- A private field is added to the generated code-behind file that is mapped to this element. Use the field to interact with the visual element to set runtime properties and to handle events.
- The element is made known to XAML through a name. You can refer to these elements from other elements that defined in the same XAML file.

You can't use any arbitrary string when you name the element. The value assigned to the name attribute is used to create a field in code. Instead, it must conform to the naming conventions for a variable. The name also must be unique because it's compiled into the code-behind definition.

After you provide a name for an element, you can interact with that element in the code-behind file.

Let's look at the updated example:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ContentPage xmlns="http://xamarin.com/schemas/2014/forms"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             x:Class="Sample.MyPage">
    <ContentPage.Content>
        <StackLayout>
            ...
            <Button x:Name="loginButton" Text="Log in" />
        </StackLayout>
    </ContentPage.Content>
</ContentPage>
```

```csharp
public partial class MyPage : ContentPage {
    public MyPage() {
        InitializeComponent();

        loginButton.Clicked += (sender, e) => {
            Debug.WriteLine("Clicked !");
        };
    }
}
```

The code deals with the `Clicked` event via an exposed `loginButton` field. This code approach is much more robust.

It's important to remember that the field won't be initialized until the `InitializeComponent` method is executed. This method is part of the XAML parsing and object instantiation process. Place any code that interacts with an element that's defined in XAML after this call.

> [!TIP]
> The exception is the `ContentPage` class itself. You can access all properties on the class, prior to the execution of the `InitializeComponent` method. However, if you set any properties on this class in XAML, these property values will update any values you might have set when `InitializeComponent` executes.

## Use an attribute to wire up events

Another way to wire up events is by using an attribute in XAML. You can use attributes to set properties or to wire up events. The event must be public because the XAML syntax adds an event handler in the generated code-behind.

The actual handler specified in XAML must be placed into your code-behind file for the same reason, because it's wired up into the partial class definition. The handler itself can be any visibility, but you can make this public, protected, internal, or any other valid value.

Let's look at how to update the example to use an attribute to specify the event handler in XAML.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ContentPage xmlns="http://xamarin.com/schemas/2014/forms"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             x:Class="Sample.MyPage">
    <ContentPage.Content>
        <StackLayout>
            ...
            <Button Clicked="LoginButton_Clicked" Text="Log in" />
        </StackLayout>
    </ContentPage.Content>
</ContentPage>
```

```csharp
public partial class MyPage : ContentPage {
    public MyPage() {
        InitializeComponent();
    }

    void LoginButton_Clicked(object sender, EventArgs e) {
        Debug.WriteLine("Clicked !");
    }
}
```

> [!TIP]
> You don't need to name the element when you use a XAML attribute to specify the event handler.

## Separation of Concerns

Wiring up events in XAML is convenient but it mixes the behavior of the control with the UI definition.

Many developers prefer to keep those things distinct and do all the event handler subscriptions in the code behind to named elements. It's easier to see what is hooked up and where the behavior is mapped to. It also makes it harder to accidentally break the code by removing a handler in the XAML without realizing it. A removed handler is not caught by the compiler and will only show itself as an issue when the code doesn't perform that behavior properly. By contrast, if you remove a name off a referenced element the compiler will complain, and it will immediately be obvious that the code behind and the XAML is out of sync.

You can use either approach.