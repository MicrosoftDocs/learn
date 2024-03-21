One of the key features of interfaces is that classes can implement many of them. Multiple interfaces allow a class to support different behaviors that are independent of each other. To implement multiple interfaces, a class only needs to list each interface it wants to implement, separated by commas. For example:

```c#
public class MyClass : IMyInterface1, IMyInterface2
{
    // implementation of methods and properties from IMyInterface1 and IMyInterface2
}
```

Implementing multiple interfaces is useful when you need a class to have multiple independent behaviors that may not be related to each other. In this exercise, you'll extend certain item classes so that they implement a "Combine" behavior that can be used to craft new items.

## Prepare your coding environment

This module includes hands-on activities that guide you through the process of building and running demonstration code. You're encouraged to complete these activities using Visual Studio Code as your development environment. Using Visual Studio Code for these activities can help you to become more comfortable writing and running code in a developer environment that's used by professionals worldwide.

> [!IMPORTANT]
> You must have .NET Framework 8.0 installed and a Github account to complete these steps.

> [!NOTE]
> If you completed previous modules in this Learning Path, you can skip these steps. Instead, close any open files and expand the **M02-Implement-Interface** folder.

1. Open Visual Studio Code.

    You can use the Windows Start menu (or equivalent resource for another OS) to open Visual Studio Code.

1. Under the Visual Studio Code **Start** section, select **Clone Git Repository**.

1. In the URL bar, enter `https://github.com/MicrosoftLearning/MSLearn-Implement-interfaces-in-CSharp`

1. In the File Explorer, create a new folder in a location that is easy to find and remember, such as a folder in your Desktop.

1. Click the **Select as Repository Destination** button.

    You need to be signed in to GitHub to successfully clone the project.

1. Open the project in Visual Studio Code

1. In Explorer, right-click the **M02-Implement-Interfaces** folder and click **Open in Integrated Terminal**

1. Expand the **M02-Implement-Interfaces** folder.

    You should see a list of folders and files, including an Items folder and a Model.cs file.

## Exercise - Implement multiple interfaces

In this exercise, you'll update existing classes to implement multiple interfaces. You'll create an interface that allows some items to be combined to create new ones. The player should be able to combine runes and weapons, food ingredients, and herbs with containers to create new items. Let's get started!

:::image type="content" source="../media/04-demo.png" alt-text="Screenshot of the inventory program for this module with craftable items.":::

1. In the Explorer, right click on the **Items** folder.

1. In the context menu, select "New File"

1. In the textbox, enter "ICombinable.cs"

1. Open the new file and type the following code:

    ```c#
    namespace M02_Implement_Interfaces.Items
    {
        internal interface ICombinable
        {
            public bool CanCombine(Item item);
            public Item? Combine(Item item);
        }
    }
    ```

    This interface allows an item to check if it can be combined with another and perform a combination. The `Combine` method returns the new combined item or `null` if there was no combination. Now you're ready to implement the interface.

1. In the Visual Studio Code Explorer, open up the **Weapon.cs** file located in the **Items** folder.

1. Navigate to the class definition and update it to the following code:

    ```c#
    internal class Weapon : Item, IEquipable, ICombinable
    ```

    Notice that the Weapon class now inherits an abstract class and two interfaces. Abstract classes and interfaces are a great way to provide flexibility in your code. 
    
    This class contains a method `CreateRandomWeapon` that returns a new weapon. You can use this method for the `Combine` implementation.
    
1. Hover over `ICombinable` until the error message appears, then click **Quick Fix**

1. In the context menu, select **Implement interface**
   
    The interface methods should populate with a default `NotImplementedException`. You want to allow the player to combine a weapon with a rune to create a new type of weapon.

1.  Update the `CanCombine` method with the following code:

    ```c#
    public bool CanCombine(Item item)
    {
        if (item == null) 
            return false;
    
        if (item is Material material) 
            return material.GetMaterialType() == MaterialType.Rune;
    
        return false;
    }
    ```

    In this method, you first check if the item is `null`. Afterwards, you check if the given item is a rune material. You only return `true` when a weapon is combined with a Material that represents a rune item.

    Next, implement the `Combine` to use the `CreateRandomWeapon` method.
    
1. Update the `Combine` method with the following code:

    ```c#
    public Item? Combine(Item item)
    {
        if (CanCombine(item))
            return CreateRandomWeapon((Material) item);
        
        return null;
    }
    ```

    In this method, you first check if the items can successfully be combined. If the combination is allowed, you use the `CreateRandomWeapon` method to return a new weapon. Otherwise, you return `null`. Next, let's make Food items combinable.

1. In the Visual Studio Code Explorer, open up the **Food.cs** file located in the **Items** folder.

1. Navigate to the class definition and update it to the following code:

    ```c#
    internal class Food : Item, IConsumable, ICombinable
    ```

    Similar to the previous class, this class contains a `CreateRandomFood` method that you can use for the `Combine` implementation.

1. Implement the methods with the following code:

    ```c#
    public bool CanCombine(Item item)
    {
        if (item != null && item is Food food)
            return this.ingredient && food.ingredient;

        return false;
    }

    public Item? Combine(Item item)
    {
        if (CanCombine(item))
            return CreateRandomFood();

        return null;
    }
    ```

    In this code, you check if both items are food ingredients to allow a combination. For simplicity, you make use of the `CreateRandomFood` method to return a new food from the combination, or `null` if the items can't be combined.

1. In the Visual Studio Code Explorer, open up the **Material.cs** file located in the **Items** folder.

1. Navigate to the class definition and update it to the following code:

    ```c#
    internal class Material : Item, ICombinable
    ```

    This class contains several helper methods. `CreatesPotion` and `CreatesWeapon` take an `Item` argument to check if a combination results in a Potion or Weapon item. For simplicity, `CreateRandomPotion` creates a random Potion object. These methods will help you simplify the implementation of the interface methods.

1. Implement the methods with the following code:

    ```c#
    public bool CanCombine(Item item)
    {
        return CreatesPotion(item) || CreatesWeapon(item);
    }
    
    public Item? Combine(Item item)
    {
        if (CreatesPotion(item))
            return CreateRandomPotion();
        
        else if (CreatesWeapon(item))
            return ((Weapon) item).Combine(this);
        
        return null;
    }
    ```

    In the `CanCombine` method, you use the existing `bool` methods `CreatesPotion` and `CreatesWeapon` to check if the item combination results in a Potion or Weapon. If not, the `CanCombine` method returns false. 

    In `Combine`, you check if the item creates a Potion, and if so,  return a random Potion. If the item creates a Weapon, you return the result of `Weapon.Combine()`. 

    Next, let's add a craft button for these items.
    
1. In the Visual Studio Code Explorer, open up the **Model.cs** file.

    This file contains existing logic that is called by the user interface. For this exercise, you'll only focus on two simple methods.

1. Navigate to the `GetItemAction` method.

    This method returns available actions for a selected item in the player's inventory. The default action is "Select." Items also support "Equip," "Unequip," and "Consume." Now add "Craft" to the available actions.

1. Update the method with the following code:

    ```c#
    public string GetItemAction()
    {
        if (selectedItems.Count == 2 && selectedItems[0] is ICombinable)
        {
            return craft;
        }
        else if (selectedItems.Count == 1)
        {
            if (selectedItems[0] is IEquipable)
                return equip;
    
            else if (selectedItems[0] is IConsumable)
                return consume;
        }
        return none;
    }
    ```

    In this code, you check that there's more than one selected item, and if the item is `ICombinable`, then you return the "Craft" string.

    In the next exercise, you'll update the `DoItemAction` method to allow the player to craft items.

## Check your work

In this task, you'll run the code and verify that it's working correctly.

1. Save your work.

1. Right-click the "M02-Implement-Interfaces" folder in the Explorer and click "Open in Integrated Terminal"

1. In the terminal command prompt, enter **dotnet run**

    You should see a windows form dialog appear, populated with game assets. Be sure to check that the form title displays "M02 Inventory"
    :::image type="content" source="../media/04-check-your-work.png" alt-text="Screenshot of the inventory program for this module with two food items selected and a craft button.":::

1. Select two food ingredients, such as "bread," "broccoli," "lettuce," "bell pepper." Use the <kbd>Ctrl</kbd> key to multi-select.

    You should see the "Select" button change to "Craft"

1. Select any rune and any weapon, such as "fire rune" and "gygantallax"

    You should see the "Select" button change to "Craft"

1. Select any two herb items, such as "yarrow flower" and "sage"

    You should see the "Select" button change to "Craft"

1. Select any weapon item.

    The "Select" button should change to "Equip."

    If your code displays different results, review your code to find the error and make updates. Run the code again to see if you fixed the problem. Continue updating and running your code until your code produces the expected results. If you get stuck, try taking a look at the solution code.

> [!IMPORTANT]
> Be sure not to delete any of the code you've written so far. You'll build on this code throughout this training module.
