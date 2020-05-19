The typical project structure of a Xamarin.Forms application normally includes two or more platform-specific head projects and a shared code project.

Let's assume you have iOS and Android head projects. Your shared code library is a .NET Standard library. The head projects will reference the shared code project because their behavior depends on the shared code. Each head project controls which objects are instantiated. For example, the project controls the instantiation of the Xamarin.Forms Application class.

In your application, you want to use your custom dialog box in a ContentPage called AboutPage. You have a choice to use either the interface or the abstract class. Both options will allow you to implement the behavior of the ContentPage.

## Use an interface to implement a custom dialog box

Let's look at an example that uses the interface `IMessageDialog`.

```csharp
using System;
using System.Collections.Generic;
using Xamarin.Forms;

namespace MyApplication
{
    public partial class AboutPage : ContentPage
    {
        public AboutPage()
        {
            InitializeComponent();
        }

        void Handle_Clicked(object sender, EventArgs e)
        {
            IMessageDialog messageDialog = null;
            messageDialog.ShowMessage("About", "Some information ...", "Ok");
        }
    }

    public interface IMessageDialog
    {
        void ShowMessage(string title, string message, string buttonText);
    }
}
```

The preceding code will compile without errors. But notice that `messageDialog` has a value of `null`. You need to decide which concrete class to instantiate, either `new MessageDialog_iOS()` or `new MessageDialog_Android()`. Because your application needs to run on both platforms, you want to instantiate both classes. Which class you instantiate, depends on which platform your application is executing. Choosing a platform specific class also means that AboutPage now has a dependency on platform code.

## Use an abstract class to implement a custom dialog box

Let's have a look at an example that uses an abstract class.

```csharp
using System;
using System.Collections.Generic;
using Xamarin.Forms;

namespace MyApplication
    {
    public partial class AboutPage : ContentPage
    {
        public AboutPage()
        {
            InitializeComponent();
        }

        void Handle_Clicked(object sender, EventArgs e)
        {
            MessageDialog messageDialog = null;
            messageDialog.ShowMessage("About", "Some information ...", "Ok");
        }
    }

    public abstract class MessageDialog
    {
        public static Func<MessageDialog> Create { get; set; }
        public abstract void ShowMessage(string title, string message, string buttonText);
    }
}
```

In this example, the `MessageDialog` class has a new property named `Create`. The `Create` property will return a delegate, `Func<MessageDialog>`. The delegate is responsible for creating a concrete instance of the `MessageDialog` when it's invoked. Notice that the property is defined as static. That's important because it means you can access the property without an instance of `MessageDialog`.

The preceding code will also compile without errors. But you still need to write platform-specific code to assign an instance of a derived class to the `messageDialog` variable. Your abstract class, just like the interface, has a dependency on something that's platform specific.

In both cases, the `AboutPage` class has an object whose instantiation it can't control. Remember, you can't add a reference to the head project in the shared library. Doing so will cause a circular reference in your solution.

## What is IoC?

*Inversion of control* (IoC) is a design pattern that describes the scenario where control over the instantiation of an object is the responsibility of another class.

The previous code examples show that the shared class doesn't control the instantiation of dependencies. Instantiation of dependencies happens in the platform-specific projects that reference the shared library. That's why we say control is inverted for the shared library.

## Solve the IoC problem

You can solve the IoC problem by using:

- The factory pattern.
- The service-locator pattern.
- The dependency-injection pattern with a container.

Keep in mind that your solution choice often depends on several factors. Think about your experience, size and composition of the development team, and sometimes your own preferences.
