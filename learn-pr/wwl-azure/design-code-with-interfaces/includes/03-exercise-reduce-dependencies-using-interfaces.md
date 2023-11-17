Tightly coupled code occurs when different parts of the code are highly dependent on each other. When components rely heavily on each other's implementation details, changes made in one area can have a significant impact on other areas. Tightly coupled code can reduce flexibility, increase the risk of introducing bugs, and make the codebase harder to maintain. 

Interfaces can mitigate these issues, but it is important that they are implemented correctly. In this exercise, you'll work with a class that has a less than ideal implementation of an interface. You'll correct the implementation and improve the modular design of the code. Let's get started!

## Prepare your coding environment

This module includes hands-on activities that guide you through the process of building and running demonstration code. You are encouraged to complete these activities using Visual Studio as your development environment. Using Visual Studio for these activities will help you to become more comfortable writing and running code in a developer environment that's used by professionals worldwide.

> [!IMPORTANT]
> You must have a Github account to complete these steps.

> [!NOTE] 
> If you completed previous modules in this Learning Path, you can skip these steps. Instead, load the **Interfaces** solution in Visual Studio. Right-click and unload the **M02-Implement-Interface** project. Then right-click the **M03-Implement-Interface** project and select **Reload Project with Dependencies**.

1. Open Visual Studio.

    You can use the Windows Start menu (or equivalent resource for another OS) to open Visual Studio.

1. Under the Visual Studio **Get Started** section, select **Clone a repository**.

1. Under **Repository Location**, enter `https://github.com/MicrosoftLearning/Implement-interfaces-in-CSharp` 

1. Under **Path**, create a new folder in a location that is easy to locate and remember, such as a folder in your Desktop.

1. Click the **Clone** button.

    You'll need to be signed in to GitHub to successfully clone the project.

1. Once the project loads, double-click the **Interfaces** solution in the Solution Explorer tab.

1. In the Solution Explorer, right-click the **M03-Implement-Interfaces** project and click **Reload Project with Dependencies**

1. Expand the **M03-Implement-Interfaces** project.

    You should see a list of folders and files, including an Items folder and a Model.cs file.

## Exercise - Fix tightly coupled code

In this exercise, you'll correct the implementation of the `Food` items in an inventory for a fantasy role-playing game. Currently, `Food` items can be consumed and combined, and the `Food` class implements both `IConsumable` and `ICombinable`. However, the game designer wants to allow food combinations for ingredients only. 

To satisfy the game designer's requirement, the `Food` implementation of `ICombinable` checks if the type of food is an ingredient before allowing a combination. However, another developer raised a concern after seeing non-combinable food items included in the list of `ICombinable` items.

Since the combination action is exclusive to ingredients, you'll improve the implementation by using a new `Ingredient` class. You'll add code to create a separate implementation for ingredient items. Let's get started!

1. In the Solution Explorer, expand the **Items** folder.

1. Open up the **Ingredient.cs** file.

1. Make the `Ingredient` class inherit from the `Food` class by adding the following code:

    ```c#
    internal class Ingredient : Food
    ```

    In this step, you replace the `Item` base class with the `Food` base class, since this game classifies ingredients as a type of food.

    > [!NOTE] 
    > Since `Food` provides the implementation for the abstract method `InternalSortOrder`, you can choose to remove the implementation from this `Ingredient` class.

1. Implement the `ICombinable` interface by adding the following code:

    ```c#
    internal class Ingredient : Food, ICombinable
    ```

    This interface allows you to check if an item can be combined with another. Next, you'll implement the interface to allow combinations of ingredients.

1. Copy and paste the following methods to implement the `ICombinable` interface:

    ```c#
    public bool CanCombine(Item item)
    {
        if (item != null && item is Ingredient)
            return true;

        return false;
    }

    public Item? Combine(Item item)
    {
        if (CanCombine(item))
            return CreateRandomFood();

        return null;
    }
    ```

    In the `CanCombine` method, you first check if the item is `null`. Then you only return `true` when this ingredient object is combined with another ingredient. In the `Combine` method, you first check if the items can successfully be combined. If the combination is successful, you make use of the `CreateRandomFood` method to return a new food from the combination action. Otherwise, you return `null`. 

    Now that the `Ingredient` class correctly implements the `ICombinable` interface, you can remove the implementation from the base `Food` class.

1. In the constructor, initialize the `healthBoost` property with the following code:

    ```c#
    healthBoost = 5 + random.Next(0, 5);
    ```

    You want the player to receive less hit points from consuming ingredients over food. In this code, you set the `healthBoost` to a minimum of five, plus a random number between zero and five.

1. In the Solution Explorer, open up the **Food.cs** file.

1. Remove `ICombinable` from the class definition:

    ```c#
    internal class Food : Item, IConsumable
    ```

1. Remove the `CanCombine` and `Combine` methods from the class.

1. Remove all references of the boolean `ingredient`, including the `isIngredient` method

    Now that you've corrected the interface's implementation, let's see your design in action!

## Check Your Work

In this task, you'll run the code and verify that it's working correctly.

1. Ensure the Startup Project is set to "M03-Implement-Interfaces"

1. Save your work, then build and run the project.

1. Select two ingredients, such as "bread", "broccoli", "lettuce", "bell pepper". Use the <kbd>Ctrl</kbd> to multi-select.

    You should see the "Select" button change to "Craft"

1. Click the "Craft" button.

    A new food item should appear in the inventory and replace a selected ingredient.

1. Select two foods, such as "beef stew", "birthday cake", "burger", "macaroni". Use the <kbd>Ctrl</kbd> to multi-select.

    You should see the "Craft" button change to "Select"

    If your code produces different results, review your code to find the error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results. If you get stuck, try taking a look at the solution code.

> [!IMPORTANT]
> Be sure not to delete any of the code you've written so far. You'll build on this code throughout this training module.