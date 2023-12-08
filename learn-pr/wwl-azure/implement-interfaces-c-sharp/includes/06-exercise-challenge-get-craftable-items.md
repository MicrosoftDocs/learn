Code challenges reinforce what you learned, and help you gain some confidence before continuing on.

The focus of this challenge is to correctly display items that support a specific action. In this challenge, you'll display craftable items. However, the `Food` class currently contains a caveat. While `Food` implements `ICombinable`, only ingredients are allowed in combinations.

## Challenge: Get craftable items

1. Open the **Model.cs** file and navigate to the `GetCraftables` method.

    This method needs to return a list of all `ICombinable` objects in the player's inventory. Currently, this method doesn't contain any logic to successfully complete its task.

1. Complete the method code so that it only adds items of the `ICombinable` type to the `items` list. 

    Food items that aren't ingredients should **not** be added to this list. `Food` objects contain a method `IsIngredient()` you can call.

    Use what you learned in previous exercises to complete this challenge. If you need a hint, take a look at the `GetEquipables` method.

## Check your work

When you complete the code, test your code with the following steps:

1. Run the project and click "Craftables"

    The inventory should update to only display items that are craftable. Food items displayed should only be ingredients.

Whether you get stuck and need to peek at the solution or you finish successfully, continue to view a solution to this challenge.