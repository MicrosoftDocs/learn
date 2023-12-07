The following code is one possible solution for the challenge from the previous unit.

    ​```c#
    // IReadable.cs
    namespace M03_Implement_Interfaces.Items
    {
        internal interface IReadable
        {
            public void Read();
            public void MarkAsNew();
            public bool IsRead { get; set; }
        }
    }
    ​```
    
    ​```c#
    // Scroll.cs
    internal class Scroll : Item, IReadable
    {
        public bool IsRead {get; set;}
    
        public Scroll(string resourceName, Bitmap image) : base(ParseResourceName(resourceName), image) 
        { 
            // Nothing to do for now
        }
    
        public void Read()
        {
            IsRead = true;
        }
    
        public void MarkAsNew()
        {
            IsRead = false;
        }
    
        protected override int InternalSortOrder { get { return 5; } }
    }
    ​```
    
    ​```c#
    // Model.cs
     public string GetItemAction()
    {
        // 
        // Placeholder for provided code
        //
        else if (selectedItems[0] is IReadable text)
        {
            return text.IsRead ? markAsNew : read;
        }
        return none;
    }
    
    public Item? DoItemAction()
    {
        //
        // Placeholder for provided code
        //
            else if (selectedItems[0] is IReadable text)
            {
                if (text.IsRead)
                    text.MarkAsNew();
                else
                    text.Read();
            }    
        }
        // Continued...
    }
    
    public List<Item> GetReadables()
    {
        List<Item> items = new();
        foreach (Item item in inventory)
        {
            if (item is IReadable)
                items.Add(item);
        }
        return items;
    }
    ​```

This code is just "*one possible solution*" because you may have added line feeds in different spots, used variables differently, or formatted the code differently.

Regardless of minor code differences, you should have successfully created and implemented the `IReadable` interface with the `Read` and `MarkAsNew` methods and the `IsRead` property. And all readable items should be displayed when the "Readables" tab is clicked in the inventory, and the action buttons should update correctly.

:::image type="content" source="../media/m-03-08-solution.png" alt-text="Screenshot of the inventory program for this module. The inventory contains scrolls.":::

If you completed this challenge, congratulations! You've proven your mastery over interfaces! Continue on to the next unit to check your knowledge.

> [!IMPORTANT]
> If you had trouble completing this challenge, consider reviewing the previous units before you continue on. All new ideas we discuss in other modules will depend on your understanding of the ideas that were presented in this module.