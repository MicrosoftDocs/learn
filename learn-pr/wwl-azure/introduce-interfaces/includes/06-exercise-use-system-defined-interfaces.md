C# includes several predefined interfaces to suit various needs. Some of the most commonly used system defined interfaces include:

- `IEnumerable`: Used to provide a standard way to iterate over a collection of objects.
- `IEnumerator`: Used to provide a way to enumerate through a collection of objects.
- `IComparable`: Used to provide a default sort order for objects of a specific type.
- `IComparer`: Used to provide a custom sort order for objects of a specific type.
- `IDisposable`: Used to provide a way to release unmanaged resources when an object is no longer needed.
- `IConvertible`: Used to provide a way to convert an object to a different data type.
- `IEquatable`: Used to provide a way to determine whether two objects are equal.
- `IFormattable`: Used to provide a way to format an object as a string using a specified format.
- `IQueryable`: Used to provide a way to query a data source.
- `IServiceProvider`: Used to provide a way to retrieve services from a service container.

These examples are just a few of the commonly used system defined interfaces in C#. There are many more that are used for various purposes in the .NET Framework.

## Exercise - Sort inventory items

In this exercise, you'll gain some experience implementing a system defined interface. At first glance, sorting the inventory items may seem like a daunting task. However, using the `IComparable` interface makes sorting quick and easy. Let's get started!

1. In the Visual Studio Code Explorer, open up the **Item.cs** file located in the **Items** folder.

1. Navigate to the class definition and update it to the following code:

    ```c#
    internal class Item : IComparable<Item>
    ```

1. Hover over `IComparable` until the error message appears, then click **Quick Fix**

1. In the context menu, select **Implement interface**
    
    The interface method `CompareTo` should populate with a default `NotImplementedException`.

1.  Update the `CompareTo` method with the following code:

    ```c#
    public int CompareTo(Item? item)
    {
        if (item == null)
            return 1;

        return Name.CompareTo(item.Name);
    }
    ```

    The `CompareTo` method must return an `int` with the following value representations:
    - Less than zero: In the sort order, this instance precedes the object being compared
    - Zero: In the sort order, this instance occurs in the same position as the object being compared
    - Greater than zero: In the sort order, this instance follows the object being compared

    When implementing `CompareTo`, you should determine a property to sort by. In this code, the items are sorted by the `Name` property. In C#, many existing types already implement `CompareTo`. Rather than rewriting a type comparison, you can just return `CompareTo` from the object you're comparing.

1. In the Visual Studio Code Explorer, open up the **Model.cs** file

1. Locate the method named `GetAllItems`

1. Sort the inventory items using the following code:

    ```c#
    public List<Item> GetAllItems()
    {
        inventory.Sort();
        return inventory;
    }
    ```

    When `Sort` is called on a list, the type's `CompareTo` method is used to compare and sort the items. If you run the project and click the "All" button, you should see the inventory items sorted in alphabetical order.

## Extend the CompareTo function
 
What if you want the items organized by both type and alphabetical order? One way to do this is to specify a sort order priority and use that in the `CompareTo` logic. Let's try it out!

1. In the Visual Studio Code Explorer, open up the **Items.cs** file

1. Add the following abstract method to the class:

    ```c#
    protected abstract int InternalSortOrder { get; }
    ```

    Now each class that extends Item will override this method to determine the sort order priority.

1. Navigate to the `CompareTo` method and update the code as follows:

    ```c#
    public int CompareTo(Item? item)
        {
            if (item == null)
                return 1;

            if (InternalSortOrder == item.InternalSortOrder)
                return Name.CompareTo(item.Name);

            else 
                return InternalSortOrder.CompareTo(item.InternalSortOrder);
        }
    ```

    In this code, the alphabetical order is used if the sort order priority is the same. Otherwise, the sort order priority is used to order the items. Next, you'll override the `InternalSortOrder` method. Be sure to save your work as you complete the steps.

1. Open up the **Armor.cs** file and add the following method to the class:

    ```c#
    protected override int InternalSortOrder { get { return 1; } }
    ```

1. Open up the **Weapon.cs** file and add the following method to the class:

    ```c#
    protected override int InternalSortOrder { get { return 2; } }
    ```

1. Open up the **Food.cs** file and add the following method to the class:

    ```c#
    protected override int InternalSortOrder { get { return 3; } }
    ```

1. Open up the **Potion.cs** file and add the following method to the class:

    ```c#
    protected override int InternalSortOrder { get { return 4; } }
    ```

1. Open up the **Material.cs** file and add the following method to the class:

    ```c#
    protected override int InternalSortOrder 
    { 
        get 
        { 
            return materialType == MaterialType.Rune ? 5 : 
                   materialType == MaterialType.Herb ? 6 : 7; 
        }
    }
    ```

    In this code, you change the sort order depending on the material type to further organize the inventory items. Now let's run the code and see the sort in action!

## Check Your Work

In this task, you'll run the code and verify that it's working correctly.

1. Save your work, then run the project.

    You should see a windows form dialog appear, populated with game assets in no particular order.

1. Click the "All" button at the top of the form.

    The inventory items should reload and appear sorted by Item type in alphabetical order

    If your code displays different results, review your code to find the error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results. If you get stuck, try taking a look at the solution code.

> [!IMPORTANT]
> Be sure not to delete any of the code you've written so far. You'll build on this code throughout this training module.
