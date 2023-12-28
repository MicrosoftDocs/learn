## Exercise - Implement an interface

In the previous unit, you created your first interface. Now, let's implement it and put them to use!

1. In the Visual Studio Code Explorer, open up the **Armor.cs** file located in the **Items** folder.

1. Navigate to the class definition and update it to the following code:

    ```c#
    internal class Armor : Item, IEquipable
    ```
    
    Notice that the `Armor` class inherits the `Item` class. You can combine abstract classes and interfaces.

    When you add the interface name, you might notice that it causes an error. This error occurs because the methods are not implemented yet.

1. Hover over `IEquipable` until the error message appears, then click **Quick Fix**

    :::image type="content" source="../media/m-01-03-interface-implementation-error.png" alt-text="Screenshot of an error in Visual Studio that occurs when first adding an interface to a class.":::

1. In the context menu, select **Implement interface**
   
    The interface methods should populate with a default `NotImplementedException`.

1.  Update the implemented methods with the following code:

    ```c#
    public bool Equipped { get; set; }

    public void Equip()
    {
        Equipped = true;
    }

    public void Unequip()
    {
        Equipped = false;
    }
    ```

    In this code, you update the player stats and the `Equipped` property. Next, you'll implement the same interface for the `Weapons` class.

1. In the Visual Studio Code Explorer, open up the **Weapon.cs** file located in the **Items** folder.

1. Navigate to the class definition and update it to the following code:

    ```c#
    internal class Weapon : Item, IEquipable
    ```
    
1. Implement the methods with the following code:

    ```c#
    public bool Equipped { get; set; }

    public void Equip()
    {
        Equipped = true;
    }

    public void Unequip()
    {
        Equipped = false;
    }
    ```

    Now both of these classes have "Equip" functionality, let's add some code to test our interfaces!

1. In the Visual Studio Code Explorer, open up the **Model.cs** file

    This file contains existing logic that is called by the user interface. For this exercise, you'll only focus on two simple methods.

    Be sure that the namespace at the top of the file begins with "M01_Implement_Interfaces"

1. Navigate to the `GetItemAction` method.

    This method returns available actions for a selected item in the player's inventory. At the moment, it only returns `none`, a string equal to "Select." We want this method to return the string "Equip" when an equipable object is selected.

1. Update the method with the following code:

    ```c#
    public string GetItemAction()
    {
        if (selectedItems[0] is IEquipable)
            return equip;
        
        return none;
    }
    ```

    Similar to checking if an object is an instance of a class, you can also check if an object is an interface type using the `is` keyword.

    In this code, you check if the selected item implements `IEquipable`. If the item is equipable, then you return the `equip` string. 

1. Navigate to the `GetEquipables` method.

    This method needs to return a list of all `IEquipable` objects in the player's inventory. Currently, this method doesn't contain any logic to successfully complete its task.

1. Update the method with the following code:

    ```c#
    public List<Item> GetEquipables()
    {
        List<Item> items = new();
    
        foreach (Item item in inventory)
            if (item is IEquipable)
                items.Add(item);
        
        return items;
    }
    ```

    Similar to the previous code, here you check if the inventory item is the interface type `IEquipable` using the `is` keyword before adding it to the list.

## Check Your Work

In this task, you'll run the code and verify that it's working correctly.

1. Save your work.

1. Right-click the "M01-Implement-Interfaces" folder in the Explorer and click "Open in Integrated Terminal"

1. In the terminal command prompt, enter **dotnet run**

    You should see a windows form dialog appear, populated with game assets. Be sure to check that the form title displays "M01 Inventory"
    :::image type="content" source="../media/m-01-04-example.png" alt-text="Screenshot of the inventory program for this module with a shield selected and an equip button.":::

1. Select an item that appears to be a weapon, such as an ax, wand, or sword.

    You should see the "Select" button on the right change to "Equip"

1. Select an item that appears to be a food or potion.

    You should see the button text change from "Equip" to "Select"

1. Select an item that appears to be a shield or breastplate.

    You should see the "Select" button on the right change to "Equip"

1. Click the "Equipables" button

    The inventory should update to only display items that are equipable.

1. Click the "All" button

    The inventory should update to display all items.

    If your code displays different results, review your code to find the error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results. If you get stuck, try taking a look at the solution code.

> [!IMPORTANT]
> Be sure not to delete any of the code you've written so far. You'll build on this code throughout this training module.