When you create abstractions, an interface isn't your only option. Let's take a look at how to use abstract classes to define your platform-specific code abstraction.

## What's an abstract class?

An *abstract class* is a class that's decorated with the `abstract` keyword. You'll decorate your class with the `abstract` keyword to show that the class is incomplete and must be implemented in a derived class.

You can't instantiate an abstract class. That's why you'll use an abstract class to provide a common definition of a base class.

## Use an abstract class to create an abstraction

Let's revisit the example from earlier. You want to show your user a dialog box in your application. Remember, each platform implements dialog boxes in a different way.

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
        var alertDlg = (new AlertDialog.Builder(this)).Create ();
        alertDlg.SetMessage(message);
        alertDlg.SetTitle(title);
        alertDlg.SetButton(buttonText, okButton_Handler);
        alertDlg.Show();
    }

    private void okButton_Handler(object sender, DialogClickEventArgs e)
    {
        AlertDialog objAlertDialog = sender as AlertDialog;
        Button btnClicked = objAlertDialog.GetButton(e.Which);
        System.Diagnostics.Debug($"User clicked on the {btnClicked.Text} button");
    }
}
```

Let's create an abstract class and define it:

```csharp
public abstract class MessageDialog
{
    public abstract void ShowMessage(string title, string message, string buttonText);
}
```

Notice the use of the `abstract` keyword. To use the `MessageDialog` abstract class, you must derive a new class and implement the `ShowMessage` method. When you force the derived class, you ensure that you can implement the method in a platform-specific way. 

Let's refactor your platform-specific classes to implement the abstract class.

Here's the iOS example:

```csharp
class MessageDialog_iOS : MessageDialog
{
    public override void ShowMessage(string title, string message, string buttonText)
    {
        var alert = UIAlertController.Create(title, message, UIAlertControllerStyle.Alert);

        alert.AddAction(UIAlertAction.Create (buttonText, UIAlertActionStyle.Cancel, null));
        PresentViewController(alert, animated: true, completionHandler: null);
    }
}
```

Here's the Android example:

```csharp
class MessageDialog_Android : MessageDialog
{
    public override void ShowMessage(string title, string message, string buttonText)
    {
        var alertDlg = (new AlertDialog.Builder (this)).Create ();
        alertDlg.SetMessage(message);
        alertDlg.SetTitle(title);
        alertDlg.SetButton(buttonText, okButton_Handler);
        alertDlg.Show();
    }

    private void okButton_Handler (object sender, DialogClickEventArgs e)
    {
        AlertDialog objAlertDialog = sender as AlertDialog;
        Button btnClicked = objAlertDialog.GetButton(e.Which);
        System.Diagnostics.Debug($"User clicked on the {btnClicked.Text} button");
    }
}
```
