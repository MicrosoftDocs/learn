Code challenges throughout these modules reinforce what you learned, and help you gain some confidence before continuing on.

The focus of this challenge is to correctly create and implement an interface to make food and potions consumable by the player. In this challenge, you'll update player stats based on which item is consumed.

## Challenge: Make objects consumable

1. In the **Items** folder, create a new interface named `IConsumable`.
   
    - Remember to include the namespace "M01_Implement_Interfaces.Items"
    - Add a method named `Consume` that takes no parameters and returns no data.
    - Add a boolean property named `Consumed`. The property must be "gettable" and "settable."

1. Implement the `IConsumable` interface in the `Food` and `Potion` classes.

    - When `Consume` is called, set the `Consumed` property to true.
    
1. After implementing the `IConsumable` methods, open up the **Model.cs** file

1. Navigate to the `GetItemAction` method and add logic to check if `selectedItems[0]` can be consumed. 
   
    If the object can be consumed, return the `consume` string.

1. Navigate to the `GetConsumables` method and add logic to only return items that are `IConsumable`.

    Hint: You can use the GetEquipables method as a reference.

## Check your work

When you complete the code, test your code with the following steps:

1. Run the project and click the "Consumables" button.

    The inventory should update to only display items that are consumables.

1. Click a potion item.

    The "Select" button should display the text "Consume"

    :::image type="content" source="../media/m-01-07-challenge.png" alt-text="Screenshot of a potion selected with the option to consume.":::

1. Click a food item.

    The "Select" button should display the text "Consume"

1. Click the "All" button and click a weapon or shield item

    The "Select" button should display the text "Equip"

Whether you get stuck and need to peek at the solution or you finish successfully, continue to view a solution to this challenge.