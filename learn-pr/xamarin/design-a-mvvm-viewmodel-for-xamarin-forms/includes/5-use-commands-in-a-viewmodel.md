You've seen how to get data from your viewmodels to your UI. And you can use two-way binding to get data back from the UI to your viewmodels. You've already seen an example that saves the current `ListView` selection.

Using two-way bindings like that is the preferred way to react to changes from the UI whenever *data* changes. Many things that we would handle as *events* can be handled by using two-way bindings and MVVM. Other examples are things like `Switch.IsToggled` and `Slider.Value`, which can be reflected in our viewmodel *without* having to use events.

But there are some things, like a `Button` or `MenuItem` activation, that aren't directly tied to changing data. These interactions still require *event-like* handling. But we do *not* want to handle them as `Clicked` and `Selected` events in the code-behind, if possible. We want to handle them in our viewmodel and in a way that's testable.

## Use the command pattern

Many of the Xamarin.Forms controls that have this kind of interactions support binding to an `ICommand` property. The button is one example:

```xml
<Button Text="Give Bonus" Command="{Binding GiveBonus}">
```

The `Command` has a binding to `GiveBonus`, which implies that this property exists on our viewmodel. The type of that property has to be `ICommand` or at least implement it. The code would look something like this:

```csharp
public class EmployeeViewModel : INotifyPropertyChanged
{
    public ICommand GiveBonus {get; private set;}
    ...
}

```

The `ICommand` interface has an `Execute` method that's called when the button is clicked. In this way, the `ICommand.Execute` directly replaces `Button.Click` event-handling code.

The full `ICommand` interface has two more methods: `CanExecute` and `CanExecuteChanged` can be used to determine whether a control should appear enabled or disabled.

 A button, for example, might appear dimmed if `CanExecute` returns false.

Here's what the ICommand interface looks like in C# code:

```csharp
public interface ICommand
{
    bool CanExecute(object parameter);
    void Execute(object parameter);
    event EventHandler CanExecuteChanged;
}
```

## Use Command\<T\>

This command pattern lets you maintain clean separation of UI behavior from UI implementation. But it can complicate your code if you need to create a separate class to implement each event handler.

Instead of creating several custom classes that implement the interface, it's common to use `Command<T>`. This class implements `ICommand` but exposes its behavior as properties that you can set. This allows you to implement the `GiveBonus` property that we described earlier entirely within our viewmodel class:

```csharp
public class EmployeeViewModel : INotifyPropertyChanged
{
    public ICommand GiveBonus {get; private set;}
    public EmployeeViewModel(Employee model)
    {
        GiveBonus = new Command(GiveBonusExecute, GiveBonusCanExecute)
    }

    void GiveBonusExecute()
    {
        //logic for giving bonus
    }

    bool GiveBonusCanExecute()
    {
        //logic for deciding if "give bonus" button should be enabled.
    }
}
```

In this code, the `Execute` behavior is provided by the method `GiveBonusExecute`. And `CanExecute` is provided by `GiveBonusCanExecute`. Delegates to those methods are passed to the `Command` constructor. In this example, there's no implementation for `CanExecuteChanged`.
