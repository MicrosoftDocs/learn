You've seen how to get data from your viewmodels to your UI, and how you can use two-way binding to get data back into your viewmodels.

Using two-way bindings like that is the preferred way to react to changes from the UI whenever **data** changes. Many things that we would handle as **events** can be handled by using two-way bindings and MVVM. Other examples are things like `Switch.IsToggled` and `Slider.Value`, which can be reflected in our viewmodel as a boolean or integer value, without having to use events.

But there are some things, like a `Button` or `MenuItem` activation, that aren't directly tied to changing data. These interactions still require event-like handling. Since these UI components usually invoke some sort of logic with the data, we want that logic on the viewmodel. But we don't want to handle them as `Clicked` and `Selected` events in the code-behind, if possible. We want as much as possible to be in the viewmodel, that way it's testable.

## Use the command pattern

Many of the .NET MAUI controls that have this kind of interaction support binding to a property that exposes an `ICommand` interface. This property is most likely named `Command`. The button is one example:

```xaml
<Button Text="Give Bonus" Command="{Binding GiveBonus}" />
```

The control knows when to invoke the command. For example, a button invokes the command when it's pressed. The command in this example is bound to the `GiveBonus` property of the viewmodel. The property type has to implement the `ICommand` interface. The code would look something like this:

```csharp
public class EmployeeViewModel : INotifyPropertyChanged
{
    public ICommand GiveBonus {get; private set;}
    ...
}
```

The `ICommand` interface has an `Execute` method that's called when the button is clicked. In this way, the `ICommand.Execute` directly replaces `Button.Click` event-handling code.

The full `ICommand` interface has two more methods: `CanExecute` and `CanExecuteChanged` that are used to determine whether a control should appear enabled or disabled.

A button, for example, might appear dimmed if `CanExecute` returns false.

Here's what the `ICommand` interface looks like in C#:

```csharp
public interface ICommand
{
    bool CanExecute(object parameter);
    void Execute(object parameter);
    event EventHandler CanExecuteChanged;
}
```

## Use the Command class

This command pattern lets you maintain clean separation of UI behavior from UI implementation. But it can complicate your code if you need to create a separate class to implement each event handler.

Instead of creating several custom classes that implement the interface, it's common to use `Command` or `Command<T>`. These classes implement `ICommand` but expose its behavior as properties in your viewmodel that you can set. This allows you to implement the `GiveBonus` property described earlier entirely within our viewmodel class:

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

## Commands with parameters

The `ICommand` interface accepts an `object` parameter for the `CanExecute` and `Execute` methods. .NET MAUI implements this interface without any type checking through the `Command` class. The delegates you attach to the command must do their own type-checking to ensure that the correct parameter is passed. .NET MAUI also provides the `Command<T>` implementation where you set the type of parameter expected. When you create a command that accepts a single type of parameter, use `Command<T>`.

.NET MAUI controls that implement the command pattern provide the `CommandParameter` property. By setting this property, you can pass a parameter to the command when it's invoked with `Execute`, or when it checks the `CanExecute` method for status.

In this example, the string value 25 is sent to the command:

```xaml
<Button Text="Give Bonus" Command="{Binding GiveBonus}" CommandParameter="25" />
```

The command would need to interpret and convert that string parameter. There are many ways to provide a strongly typed parameter.

- Instead of using attribute syntax to define `CommandParameter`, use XAML elements.

  ```xaml
  <Button Text="Give Bonus" Command="{Binding GiveBonus}">
      <Button.CommandParameter>
          <x:Int32>25</x:Int32>
      </Button.CommandParameter>
  </Button>
  ```

- Bind the `CommandParameter` to an instance of the correct type.

- If the `CommandParameter` is bound to the incorrect type, apply a converter to convert the value to the correct type.
