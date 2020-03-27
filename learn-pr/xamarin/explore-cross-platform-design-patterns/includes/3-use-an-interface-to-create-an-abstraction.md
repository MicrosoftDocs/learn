You can use abstractions to represent a platform feature that's implemented in platform-specific code. Your abstraction typically addresses anything that directly deals with the platform or its services. For example, the abstraction addresses notifications, dealing with the file system, or working with the UI thread.

Let's assume you use a class to implement a platform-specific feature to display a dialog box. The code for a dialog box on iOS looks different than the code on Android. If you don't thoughtfully plan your design, you might end up with duplicate code. The solution is to create an abstraction that describes the dialog box's behavior. Then, at runtime, you can switch out the abstraction with its concrete implementation.

In this unit, you'll use a C# interface to create an abstraction for your platform-specific code.

## What's an interface?

An *interface* is a code contract that contains definitions for related functionalities. An interface can include behavior from multiple sources in a single class. Defining multiple behaviors is a significant benefit because C# doesn't support multiple class inheritances. 

To define an interface in C#, you'll use the interface keyword.

## Use an interface to create an abstraction

Assume you want to show your user a dialog box in your application. You want your box to have a title, a comment, and a button. Unfortunately, each platform implements dialog boxes differently.

In iOS you'll use the `UIAlertController` class:

```csharp
class MessageDialog_iOS
{
    public void ShowMessage(string title, string message, string buttonText)
    {
        var alert = UIAlertController.Create(title, message, UIAlertControllerStyle.Alert);

        alert.AddAction(UIAlertAction.Create (buttonText, UIAlertActionStyle.Cancel, null));
        PresentViewController(alert, animated: true, completionHandler: null);
    }
}
```

In Android you'll use the `AlertDialog` class:

```csharp
class MessageDialog_Android
{
    public void ShowMessage(string title, string message, string buttonText)
    {
        new AlertDialog.Builder(this)
            .SetMessage(message)
            .SetTitle(title)
            .SetButton(buttonText, okButton_Handler)
            .Show();
    }

    private void okButton_Handler(object sender, DialogClickEventArgs e)
    {
        AlertDialog objAlertDialog = sender as AlertDialog;
        Button btnClicked = objAlertDialog.GetButton(e.Which);
        System.Diagnostics.Debug($"User clicked on the {btnClicked.Text} button");
    }
}
```

Notice how both code blocks have something in common. Each class declares a method called `ShowMessage`. Also, the signatures of both instances of `ShowMessage` are the same.

You can now create an interface to define the similar functionality in these two classes. Here's an example:

```csharp
public interface IMessageDialog
{
    void ShowMessage(string title, string message, string buttonText);
}
```

Now refactor your iOS and Android classes to implement your interface.

The implementation for iOS:

```csharp
class MessageDialog_iOS : IMessageDialog
{
    ...
}
```

The implementation for Android:

```csharp
class MessageDialog_Android : IMessageDialog
{
    ...
}
```
