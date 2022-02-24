The first pattern we'll look at is the *factory pattern*. The factory pattern routes the client through an intermediary, called a *factory*, to create its dependency.

![Diagram showing a factory pattern, where a client uses a factory to create a service.](../media/6-factory-pattern.png)

The platform-specific code and the cross-platform code share the factory. The factory is defined in your shared code assembly. It's responsible for creating the platform-specific dependency. Only the factory class knows how to create the dependency.

You can create the dependency in the factory in several ways. You might decide to use a delegate or use a partial class. Keep in mind that no matter which option you choose, the dependency must be created in platform-specific code.

## What is a delegate?

A *delegate* is a data structure that references a method. The method can be a static method or an instance method from a class instance. It's easiest to think of a delegate as something that points to a method.

To use a delegate, you'll define your custom delegate and then instantiate it. You'll pass the method you want to execute as a constructor parameter to the new delegate. You're also allowed to assign a method without any parameters directly to a delegate.

This example uses a delegate and a method with no parameters:

```csharp
using System;
using System.IO;

delegate bool LoggerMethod();

public class TestDelegate
{
   public static void Main()
   {
      OutputProcess outputProcess = new OutputProcess();
      LoggerMethod loggerCall = outputProcess.SendToLogger;

      if (loggerCall())
         Console.WriteLine("Success!");
      else
         Console.WriteLine("Logger operation failed.");
   }
}

public class OutputProcess
{
   public bool SendToLogger()
   {
        try {
            ...
            return true;
        }
        catch
        {
            ...
            return false;
        }
   }
}
```

The delegate type is named `LoggerMethod`. An instance of that type named `loggerCall` is assigned the instance method `outputProcess.SendToLogger`. You can execute `loggerCall` like you would any other method.

## What is Func\<TResult\>?

`Func<TResult>` represents a method that has no parameters and returns a value of the type specified by the `TResult` parameter.

Notice the similarity between using a `Func` and using a delegate. The difference is that you don't need to explicitly define a custom delegate and instantiate it. Think of `Func<TResult>` as shorthand for a delegate that points to a method with no parameters and that returns a value.

This example uses `Func<TResult>` with the same method with no parameters, as before:

```csharp
using System;
using System.IO;

public class TestDelegate
{
   public static void Main()
   {
      OutputProcess outputProcess = new OutputProcess();
      Func<bool> loggerCall = () => outputProcess.SendToLogger;

      if (loggerCall())
         Console.WriteLine("Success!");
      else
         Console.WriteLine("Logger operation failed.");
   }
}

public class OutputProcess
{
   public bool SendToLogger()
   {
        try {
            ...
            return true;
        }
        catch
        {
            ...
            return false;
        }
   }
}
```

Using `Func` saves you time because you don't have to define your own delegate.

## Create the factory

You're going to use the delegate concept to create the factory. Remember, something must instantiate the dependency. Using a method to instantiate the dependency is a good idea. But you must define the method needs in platform-specific code and not in an abstract class. Because a delegate can point to any method, you can create the delegate in your abstract class and then configure the delegate somewhere else.

Let's have a look at an example from earlier. You might notice a couple of changes to this code:

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
            MessageDialog messageDialog = MessageDialog.Create();
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

Did you notice the new `Create` property in the abstract `MessageDialog` class?

The `Create` property will return a delegate, `Func<MessageDialog>`. That delegate is responsible for creating a concrete instance of the `MessageDialog` when it's invoked. Notice that the property is defined as static. That's important because it means you can access the property from anywhere within your code, without an instance of `MessageDialog`.

Because you can reference the static property from anywhere in your code, you can configure the delegate in your platform-specific code. Let's look at how this configuration will work.

Here's an example for iOS:

```csharp
public partial class AppDelegate : global::Xamarin.Forms.Platform.iOS.FormsApplicationDelegate
{
    public override bool FinishedLaunching(UIApplication application, NSDictionary launchOptions)
    {
        ...
        MessageDialog.Create = () => new MessageDialog_iOS();
        ...
    }
}
```

Here's an example for Android:

```csharp
public class MainActivity : global::Xamarin.Forms.Platform.Android.FormsAppCompatActivity
{
    protected override void OnCreate(Bundle savedInstanceState)
    {
        ...
        MessageDialog.Create = () => new MessageDialog_Android();
        ...
    }
}
```

In the initialization code for both of your platforms, you can assign the `MessageDialog.Create` property. Remember, this property is static, and it's typed to return a `Func<MessageDialog>` delegate. You'll assign that property to a lambda expression to return a new instance of your `MessageDialog`.

Anywhere you need to display an alert, you'll go to the MessageDialog factory, which is your static property in this case. You'll use this factory to get an instance of the MessageDialog.

## What are the advantages of the factory pattern?

The factory pattern has the following advantages:

- The dependency's implementation is hidden from the client. The client doesn't need to know how the dependency is created or where the dependency comes from.
- The pattern is easy to understand.
- You can decide what the implementation should be at runtime and return a specific version based on your environment.

## What are the disadvantages of the factory pattern?

The factory pattern has the following disadvantages:

- The pattern requires a separate "factory" for each abstraction. If you have several factories, your code maintenance will increase.
- Even though the client doesn't know how the dependency is created, it still needs to take a dependency against the factory.
- Missing dependencies aren't known until runtime because dependencies are resolved only when the application runs.
