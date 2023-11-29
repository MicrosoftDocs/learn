The following code is one possible solution for the challenge from the previous unit.

    ```c#
    public List<Item> GetCraftables()
    {
        List<Item> items = new();
        foreach (Item item in inventory)
        {
            if (item is ICombinable)
            {
                if (item is Food food && !food.IsIngredient())
                    continue;

                items.Add(item);
            }
        }
        return items;
    }

    ```

This code is just "*one possible solution*" because you may have added line feeds in different spots, written logic differently, used different variable names, or formatted the code differently.

Regardless of minor code differences, you should have checked if the items are of the `ICombinable` type before adding them to the list. When you run the code, clicking the "Craftables" button should update the inventory to display only craftable items.

:::image type="content" source="../media/M02-07-Challenge.png" alt-text="A snapshot of the inventory program for this module":::

If you completed this challenge, congratulations! You're one step closer to mastering interfaces! Continue on to the next unit to check your knowledge.

> [!IMPORTANT]
> If you had trouble completing this challenge, consider reviewing the previous units before you continue on. All new ideas we discuss in other modules will depend on your understanding of the ideas that were presented in this module.