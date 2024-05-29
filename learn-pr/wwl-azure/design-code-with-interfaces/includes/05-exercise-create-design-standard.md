Suppose the game designer wants some items to provide a synergy buff. For example, a sword, helmet, and shield might be part of the same collection, and when equipped simultaneously, they provide a strength or defense bonus. You are tasked with implementing a synergy system for different types of items.

## Exercise - Design a standard to achieve the goal

In this exercise, you'll plan and implement a design standard for the synergy of different items. You'll use what you learned about interfaces and abstraction to implement your design. Let's get started!

1. Identify the purpose of the code you plan to write.

    In this case, the purpose of the code is to enable synergy effects between different items of a collection.

1. Identify conditions that may affect the goal.

    When does the synergy effect take place? It should occur when all of the items of a collection are equipped. So any equip and unequip actions should directly affect the synergy bonus.

1. Identify common functionality.

    Consider the functions items with synergy need to take. These functions are the basis for your methods in the interface.

    Items with synergy capabilities should:
    - Check for synergy with another item
    - Check a list of equipped items to see if synergy applies
    - Activate/deactivate synergy
    - Get synergy active status
    - Get the synergy bonus effect

    You'll also need a means of assigning items to a particular collection.

Now that you created a plan for your code, you're ready to implement your design. 

### Create the code standard

In this task, you'll create and implement the new interface.

1. In the **Items** folder, create a new file with the name "ISynergyEffect.cs"

1. Open the file and enter the following code:

    ```c#
    namespace M03_Implement_Interfaces.Items
    {
        internal interface ISynergyEffect
        {
            public bool HasSynergyWith(Item item);
        }
    }
    ```

    This method allows you to check if an item has synergy with another. Next, you'll add a method to check if the items in a list have synergy with each other.

1. In the interface definition, enter the following code:

    ```c#
    public bool HasSynergyWith(List<Item> items);
    public void ActivateSynergy(bool active);
    public bool SynergyActive();
    ```

    Next, you need to decide how the synergy bonus effect will be retrieved. You want to make sure the effect is straightforward to use, but also open to extension in the future. To do that,  first create a new SynergyBonus type for the interface to return.

1. In the **Items** folder, create a new file with the name "SynergyBonus.cs"

1. Open the file and enter the following code:

    ```c#
    namespace M03_Implement_Interfaces.Items
    {
        public class SynergyBonus
        {
            public string Stat {  get; }
            public int Bonus { get; }

            public SynergyBonus(string stat, int bonus) 
            {
                Stat = stat;
                Bonus = bonus;
            }
        }
    }
    ```

    Here, you define a string to represent the stat that's modified by the synergy bonus, and an integer to represent the amount that the stat is boosted. This implementation is simple enough to achieve the purpose for now.

1. Navigate back to the **ISynergyEffect** interface.

1. Add the following code to the interface definition:

    ```c#
    internal interface ISynergyEffect
    {
        public bool HasSynergyWith(Item item);

        public bool HasSynergyWith(List<Item> items);

        public void ActivateSynergy(bool active);

        public bool SynergyActive();

        public SynergyBonus GetSynergyBonus();
    }
    ```

    Now you successfully created a standard to enable a synergy capability for items. Next, you need a way to assign items to a collection. This is simplified as a string property for this exercise.

1. Navigate to the **Item.cs** file.

1. Add a "Collection" property to the class using the following code:

    ```c#
    public string Collection { get; set; }
    ```

    Now you're ready to implement your interface. For this exercise, you'll implement it in just the `Weapon` class for now.

### Implement the design standard

1. Navigate to the **Weapon.cs** file.

1. Allow `Weapon` to implement the `ISynergyEffect` interface by updating the class definition to the following:

    ```c#
    internal class Weapon : Item, IEquipable, ICombinable, ISynergyEffect
    ```

1. Create the implementation for the first `HasSynergyWith` method with the following code:

    ```c#
    public bool HasSynergyWith(Item item)
    {
        if (this.Collection != null && this.Collection.Equals(item.Collection))
        {
            return true;
        }
        return false;
    }
    ```

    In this code, compare the current Collection name to the given item.

1. Create the implementation for the next `HasSynergyWith` method with the following code:

    ```c#
    public bool HasSynergyWith(List<Item> items)
    {
        if (this.Collection != null)
        {
            return items.All(item => item.Collection.Equals(this.Collection));
        }

        return false;
    }
    ```

    In this code, you return `true` if each item in the list has a matching `Collection` property.

1. Implement the `GetSynergyBonus` method with the following code:

    ```c#
    public SynergyBonus GetSynergyBonus()
    {
        return new SynergyBonus("attack", 20);
    }
    ```

    For now, just apply an attack bonus. This implementation can easily be modified in the future to become more complex.

1. Implement the remaining interface methods with the following code:

    ```c#
    public bool SynergyActive()
    {
        return this.HasSynergyWith(equipped);
    }

    public void ActivateSynergy(bool active)
    {
        SynergyBonus bonus = this.GetSynergyBonus();
        if (bonus != null)
        {
            if (bonus.Stat.Equals("attack"))
            {
                if (active)
                    attack += bonus.Bonus;
                else
                    attack -= bonus.Bonus;
            }
        }
    }
    ```

Now you successfully implemented your design. You used an interface rather than adding individual implementations of synergy to different classes. Your modular design allows more classes to implement `ISynergyEffect`, resulting in consistent, robust code. Great work!
