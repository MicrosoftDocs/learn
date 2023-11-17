One of the key features of interfaces is that classes can implement multiple interfaces. Multiple interfaces allow a class to support different behaviors that are independent of each other. To implement multiple interfaces, a class lists all the interfaces it wants to implement separated by commas after the colon following the class name. For example:

```c#
public class MyClass : IMyInterface1, IMyInterface2
{
    // implementation of methods and properties from IMyInterface1 and IMyInterface2
}
```

Implementing multiple interfaces is useful when you need a class to have multiple independent behaviors that may not be related to each other. In this exercise, you'll extend certain item classes so that they implement a "Combine" behavior that can be used to craft new items.

## Prepare your coding environment

This module includes hands-on activities that guide you through the process of building and running demonstration code. You're encouraged to complete these activities using Visual Studio as your development environment. Using Visual Studio for these activities can help you to become more comfortable writing and running code in a developer environment that's used by professionals worldwide.

> [!IMPORTANT]
> You must have a Github account to complete these steps.

> [!NOTE] 
> If you completed previous modules in this Learning Path, you can skip these steps. Instead, load the **Interfaces** solution in Visual Studio. Right-click and unload the **M01-Implement-Interface** project. Then right-click the **M02-Implement-Interface** project and select **Reload Project with Dependencies**.

1. Open Visual Studio.

    You can use the Windows Start menu (or equivalent resource for another OS) to open Visual Studio.

1. Under the Visual Studio **Get Started** section, select **Clone a repository**.

1. Under **Repository Location**, enter `https://github.com/MicrosoftLearning/Implement-interfaces-in-CSharp` 

1. Under **Path**, create a new folder in a location that is easy to locate and remember, such as a folder in your Desktop.

1. Click the **Clone** button.

    You need to be signed in to GitHub to successfully clone the project.

1. Once the project loads, double-click the **Interfaces** solution in the Solution Explorer tab.

1. In the Solution Explorer, right-click the **M02-Implement-Interfaces** project and click **Reload Project with Dependencies**

1. Expand the **M02-Implement-Interfaces** project.

    You should see a list of folders and files, including an Items folder and a Model.cs file.

## Exercise - Implement multiple interfaces

In this exercise, you'll update existing classes to implement multiple interfaces. You'll create an interface that allows some items to be combined to create new ones. The player should be able to combine runes and weapons, food ingredients, and herbs with containers to create new items. Let's get started!

:::image type="content" source="../media/M02-04-Demo.png" alt-text="A snapshot of the inventory program for this module with craftable items":::

1. In the Solution Explorer, right click on the **Items** folder.

1. In the context menu, select "Add" > "New Item"

1. In the "Add New Item" dialog box, select "Interface" from the list of available templates.

1. In the "Name" textbox, enter "ICombinable.cs" and click "Add"

    The new interface file should appear in the code editor with a basic template applied. Next, you'll define which methods and properties the interface should contain.

1. In the interface definition, add the following code:

    ```c#
    internal interface ICombinable
    {
        public Item? Combine(Item item);
        public bool CanCombine(Item item);
    }
    ```

    This interface allows an item to check if it can be combined with another and perform a combination. The `Combine` method returns the new combined item or `null` if there was no combination. Now you're ready to implement the interface.

1. In the Visual Studio Solution Explorer, open up the **Weapon.cs** file located in the **Items** folder.

1. Navigate to the class definition and update it to the following code:

    ```c#
    internal class Weapon : Item, IEquipable, ICombinable
    ```

    Notice that the Weapon class now inherits an abstract class and two interfaces. This class contains a method `CreateRandomWeapon` that returns a new weapon. You can use this method for the `Combine` implementation.
    
1. Implement the interface methods with the following code:

    ```c#
    public bool CanCombine(Item item)
    {
        if (item == null) 
            return false;

        if (item is Material material) 
            return material.GetMaterialType() == MaterialType.Rune;

        return false;
    }

    public Item? Combine(Item item)
    {
        if (CanCombine(item))
            return CreateRandomWeapon((Material) item);
        
        return null;
    }
    ```

    In the `CanCombine` method, you first check if the item is `null`. Then you only return `true` when a weapon is combined with a Material that represents a rune item. In the `Combine` method, you first check if the items can successfully be combined. If the combination is successful, you make use of the `CreateRandomWeapon` method to return a new weapon from the combination action. Otherwise, you return `null`. Next, you'll make Food items combinable.

1. In the Visual Studio Solution Explorer, open up the **Food.cs** file located in the **Items** folder.

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

    In this code, you check if both items are food ingredients to allow a combination. For simplicity, you make use of the `CreateRandomFood` method to return a new food from the combination action or `null` if the items can't be combined.

1. In the Visual Studio Solution Explorer, open up the **Material.cs** file located in the **Items** folder.

1. Navigate to the class definition and update it to the following code:

    ```c#
    internal class Material : Item, ICombinable
    ```

    This class contains several helper methods: `CreatesPotion` and `CreatesWeapon` take an `Item` argument to check if a combination results in a Potion or Weapon item. For simplicity, `CreateRandomPotion` creates a random Potion object. These methods help simplify the implementation of the interface methods.

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

    In this code, you use the existing `bool` methods `CreatesPotion` and `CreatesWeapon` to check if the item combination results in a Potion or Weapon. If not, the `CanCombine` method returns false. 

    Afterwards, you use the helper methods to check if the item creates a Potion or Weapon. If the item creates a Potion, a random Potion is returned. If the item creates a Weapon, you return the result of `Weapon.Combine()`. 
    
1. In the Visual Studio Solution Explorer, open up the **Model.cs** file.

    This file contains existing logic that is called by the user interface. For this exercise, you'll only focus on two simple methods.

1. Navigate to the `GetItemAction` method.

    This method returns available actions for a selected item in the player's inventory. The default action is "Select". Items also support "Equip", "Unequip", and "Consume". Now you'll add "Craft" to the available actions.

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

## Check Your Work

In this task, you'll run the code and verify that it's working correctly.

1. Ensure the Startup Project is set to "M02-Implement-Interfaces"

1. Save your work, then build and run the project.

    You should see a windows form dialog appear, populated with game assets.
    :::image type="content" source="../media/M02-04-CheckYourWork.png" alt-text="A snapshot of the inventory program for this module":::

1. Select two food ingredients, such as "bread", "broccoli", "lettuce", "bell pepper". Use the <kbd>Ctrl</kbd> to multi-select.

    You should see the "Select" button change to "Craft"

1. Select any rune and any weapon, such as "fire rune" and "gygantallax"

    You should see the "Select" button change to "Craft"

1. Select any two herb items, such as "yarrow flower" and "sage"

    You should see the "Select" button change to "Craft"

1. Select any weapon item.

    The "Select" button should change to "Equip".

    If your code displays different results, review your code to find the error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results. If you get stuck, try taking a look at the solution code.

> [!IMPORTANT]
> Be sure not to delete any of the code you've written so far. You'll build on this code throughout this training module.
