Polymorphism is a programming concept that allows objects to take on multiple forms. Polymorphism can be achieved through inheritance or interfaces. When a class implements an interface, that class can be treated as if they're the interface type. This concept may be difficult to grasp at first, so let's get plenty of practice! In this exercise, you'll achieve polymorphism and write code that is adaptable to different types of objects. Let's get started!

## Exercise - Cast objects to an interface type

1. In the Visual Studio Code Explorer, open up the **Model.cs** file.

    This file contains existing logic that is called by the user interface.

1. Navigate to the `GetItemAction` method.

    Previously, you added logic to check if two items are selected and the first one is an `ICombinable` type. Now, you'll add logic to check if the items can be successfully combined before returning the "Craft" string.

1. Update the method with the following code:

    ```c#
    if (selectedItems.Count == 2 && selectedItems[0] is ICombinable material)
    {
        if (material.CanCombine(selectedItems[1]))
            return craft;
    }
    ```

    The `is` keyword checks if an object is an instance of a class or interface type, and assigns the object to a variable of that type. Using an `ICombinable` variable allows you to call the `CanCombine` method on that object, so you can check if the items can successfully be combined before returning the "Craft" string.

    You could also use the `as` keyword to cast the object to the interface type. The `as` keyword attempts to cast an object to the specified interface type and returns null if the cast fails. For example:

    ```c#
    ICombinable? material = selectedItems[0] as ICombinable;
    if (selectedItems.Count == 2 && material != null)
    {
        if (material.CanCombine(selectedItems[1]))
            return craft;
    }
    ```

    Both the `is` and `as` keywords are helpful tools when working with abstract types. Next, you'll update the `GetItemAction` method to return "Unquip" when an equipped item is selected.

1. Update the code as follows:

    ```c#
     if (selectedItems[0] is IEquipable equipable)
        return equipable.Equipped ? unequip : equip;
    ```

    Similar to the previous step, you assign the selected item to a variable of the interface type. Afterwards, you can reference the implemented properties and methods of the interface. The "Select" button should now display "Unequip" for an equipped item. 
    
    Now that you're comfortable casting objects as interface types, you're ready to add functionality to the "Select" button.

1. Navigate to the `DoItemAction` method.

    This method is executed when the "Select" button is clicked. Let's add logic here to make the inventory items useable.

1. Update the `IEquipable` check as follows:

    ```c#
    if (selectedItems[0] is IEquipable equipable)
    {
        if (equipable.Equipped)
            equipable.Unequip();
        else
            equipable.Equip();
    }
    else if (selectedItems[0] is IConsumable consumable)
    {
        consumable.Consume();
    }
    ```

    Similar to the previous code, you assign the item to an `IEquipable` type to use its properties and methods, likewise for the `IConsumable` item. Let's do the same with `ICombinable`.

1. Update the "combine" portion of the code as follows:

    ```c#
    else if (selectedItems.Count == 2 && selectedItems[0] is ICombinable material)
    {
        material.Combine(selectedItems[1]);
    }
    ```

    In this code, you assign the `ICombinable` item to a variable and call the `Combine` method using the second selected item. Since `ICombinable.Combine` returns the new combined item, you need to capture the new item and add it to the player's inventory.

1. Update the code with the following logic:

    ```c#
    else if (selectedItems.Count == 2 && selectedItems[0] is ICombinable material)
    {
        Item? newItem = material.Combine(selectedItems[1]);
    
        if (newItem != null)
            inventory.Add(newItem);
    
        return newItem;
    }
    ```

    Great work! Now you're ready to test your logic!

## Check your work

In this task, you'll run the code and verify that it's working correctly.

1. Save your work, then build and run the project.

    You should see a windows form dialog appear, populated with game assets.

1. Click the "Equipables" button

    The inventory should update to only display items that are equipable.

1. Click any item and select "Equip"

    The "Equip" button should display "Unequip." The player stats are also updated.

1. Click the "Consumables" button
   
    The inventory should update to only display items that are consumable.

1. Click any item and select "Consume"

    The player hp stat should update.

1. Click two food ingredients such as "bread," "bell pepper," "tomato," "mushroom," etc.

    The "Consume" button should display "Craft."

1. Click the "Craft" button.

    A new food item should appear in the inventory.
    :::image type="content" source="../media/05-check-your-work.png" alt-text="Screenshot of the inventory program for this module with a new food item selected and a consume button.":::

> [!IMPORTANT]
> Be sure not to delete any of the code you've written so far. You'll build on this code throughout this training module.