The following code is one possible solution for the challenge from the previous unit. You can also view the solution project code.

    ```c#
    // IConsumable.cs
    namespace M01_Implement_Interfaces.Items
    {
        internal interface IConsumable
        {
            public void Consume();
            public bool Consumed { get; set; }
        }
    }

    //
    // Food.cs
    //
    internal class Food : Item, IConsumable 
    {
        // previous code...

        public bool Consumed { get; set; }
        public void Consume()
        {
            Consumed = true;
        }
        // continued...

    //
    // Potion.cs
    //
    internal class Potion : Item, IConsumable 
    {
        // previous code...

        public bool Consumed { get; set; }
        public void Consume()
        {
            Consumed = true;
        }
        // continued...

    //
    // Model.cs
    //
    public string GetItemAction()
    {
        if (selectedItems[0] is IEquipable)
            return equip;

        else if (selectedItems[0] is IConsumable)
            return consume;

        else 
            return none;
    }
    
    // continued...

    public List<Item> GetConsumables()
    {
        List<Item> items = new();

        foreach (Item item in inventory)
            if (item is IConsumable)
                items.Add(item);
        
        return items;
    }
    ```

This code is just "*one possible solution*" because you may have added line feeds in different spots, used variables differently, or formatted the code differently.

Regardless of minor code differences, you should have successfully created and implemented the `IComsumable` interface with the `Consume` method and the `Consumed` property. The `Equip` functionality should still function correctly, and all consumable items should be displayed when the "Consumables" button is clicked in the inventory.

If you completed this challenge, congratulations! Continue on to the knowledge check in the next unit.

> [!IMPORTANT]
> If you had trouble completing this challenge, consider reviewing the previous units before you continue on. All new ideas we discuss in other modules will depend on your understanding of the ideas that were presented in this module.