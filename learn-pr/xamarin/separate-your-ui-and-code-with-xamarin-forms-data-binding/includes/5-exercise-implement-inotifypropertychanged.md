In this exercise, you add change notifications to your `Flag` data-source class. Raising an event enables the bindings to update the UI immediately when your data changes.

This exercise is a continuation of the previous one. You can use your existing solution or begin from the **exercise1** > **final** solution in your copy of the cloned or downloaded [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].

## Change the underlying data

Let's first see how the app behaves when your source type *doesn't* implement `INotifyPropertyChanged`. This code isn't meant to be realistic. It's simply an easy way for you to see the need for change notifications.

1. Open **MainPage.xaml.cs**, and locate the `OnShow` method.

1. Add a year to the `Flag.DateAdopted` property by calling `.AddYears(1)` and assigning the returned value to the `DateAdopted` property. _Note that you must assign the property because `DateTime` is immutable_. This code simulates new data that arrives from the web because it's a data change that's not done by the user through the UI.

    ```csharp
    private async void OnShow(object sender, EventArgs e)
    {
        CurrentFlag.DateAdopted = CurrentFlag.DateAdopted.AddYears(1);

        await DisplayAlert(CurrentFlag.Country,
            $"{CurrentFlag.DateAdopted:D} - {CurrentFlag.IncludesShield}: {CurrentFlag.MoreInformationUrl}",
            "OK");
    }
    ```

1. Run the application, and note the current date displayed. Select **Show** on the toolbar. It displays the flag details, but the year is incremented in the alert dialog box. Make note of the year that displays.

1. Dismiss the alert dialog box. Notice that the UI displays the _original_ year, even though the data changes in the underlying model.

## Implement INotifyPropertyChanged

The `OnShow` method changes the data in your `Flag` object, but Xamarin.Forms is unaware that the property was changed. Here, you fix this problem by implementing `INotifyPropertyChanged` on the `Flag` class.

1. Open **Flag.cs** in the **FlagData** project.

1. Modify the `Flag` class to implement `System.ComponentModel.INotifyPropertyChanged`. The implementation requires a single event named `PropertyChanged`.

    ```csharp
    public class Flag : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        ...
    }
    ```

1. Create a helper method named `RaisePropertyChanged` to raise the `PropertyChanged` event. The method accepts a `string` parameter that's the text name of the property that changed.

    * .NET 4.5 includes an attribute `CallerMemberNameAttribute` in the `System.Runtime.CompilerServices` namespace that you can use to get the compiler to identify the property that changed. For an example, see the following code. You also can have the caller pass the name by using the C# `nameof()` compiler feature.
    * Make sure to test the event for `null` before you raise it. Use the built-in C# null check support. For earlier versions of C#, test the event for `null`, or assign the event to an empty delegate.

    ```csharp
    using System.Runtime.CompilerServices;
    ...
    public class Flag : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        ...
        private void RaisePropertyChanged([CallerMemberName] string propertyName = "")
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
    ```

1. Change the existing `DateAdopted` auto-implemented property into a field-backed property. Call the `RaisePropertyChanged` method from the setter.

    Hints:

    * Make sure that the new value is different from the old value. It's inefficient to raise a property change notification if the value hasn't changed.
    * Assign the new value.
    * Raise the property change notification by using your new method.

    ```csharp
    private DateTime _dateAdopted;
    ...
    public DateTime DateAdopted
    {
        get { return _dateAdopted; }
        set
        {
            if (_dateAdopted != value)
            {
                _dateAdopted = value;
                // Can pass the property name as a string,
                // -or- let the compiler do it because of the
                // CallerMemberNameAttribute on the RaisePropertyChanged method.
                RaisePropertyChanged();
            }
        }
    }
    ```

1. You can repeat the previous step for the other properties if you want to. You aren't changing any of them, but they all need to raise the `PropertyChanged` notification to properly notify the UI in a production application. The completed project included with the lab materials takes this extra step.

1. Run the application, scroll down to the **Current Design was Adopted On** `DatePicker`, and select **Show**. You see the date change when it's changed in the underlying `Flag` object.

1. You also can remove the `x:Name` attributes off all the XAML objects you're now binding. The private field mapped to the control is now removed, which reduces the IntelliSense clutter.
