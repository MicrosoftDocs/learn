In this exercise, we'll group our smart home device list by the first letter of the `Name`. We could also group by device type if we preferred, or even create a toggle to control what we group by.

We'll continue with the solution from the previous exercise. If you don't already have it, you can open the solution from the **exercise1** > **final** folder in your copy of the cloned or downloaded [!INCLUDE [module-exercise-repo](module-exercise-repo.md)] in Visual Studio.

## Change the collection to support grouping

Because the `ItemsSource` uses a binding direct to the page's `BindingContext`, you can change the `BindingContext` in the code-behind and leave the XAML alone. You'll be grouping the items by the first letter of their names. But you'll first sort the collection so that the members are in alphabetical order within each group.

1. In the *MainPage.xaml.cs* file, change the line that sets the binding context. It should take the existing collection, sort it by `device.Name`, and then use the `ToLookup()` method with the first initial of `Device.Name` to turn it into a nested `IEnumerable<IGrouping<Device>>`.

    > [!TIP]
    > The **string** class implements `IEnumerable<char>`, so you can use `Device.Name[0].ToString()` to get the first initial as a string.

## Turn on grouping

1. Set the `ListView.IsGroupingEnabled` property to `true` in the XAML markup.
1. Add a binding for the `GroupDisplayBinding` property so it uses the `Key` property being supplied by the LINQ `GroupBy` expression that's populating the `ListView`.

    ```xaml
    <ListView ItemsSource="{Binding .}"
              ...
              IsGroupingEnabled="true"
              GroupDisplayBinding="{Binding Key}">
    ```

1. Run the application to see the results. The list should now be grouped by the first letter of each `Name`.
