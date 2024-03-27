In this exercise, you'll add a movement rule to your  `GeneralizedAnt` class. Currently, LangtonsAnts is simple. You have two colors, `0` for black and `1` for white. An ant rotates clockwise when standing on a cell with `0` color and counter-clockwise when standing on `1`. When an ant lands on a `0` or `1` cell, the cell color changes from black to white or from white to black.

Let’s make a `GeneralizedAnt` rule so that an ant can turn in either direction, when standing on either a black or white cell.

## Implement Rule property

To start, add a public string value property called Rule to `GeneralizedAnt`. You'll use a string that maps the direction our Ant turns, based on the color of its previous cell. For example, string "R" would mean that we turn "right" (clockwise) on color 0 and "left" (counter-clockwise) on color 1.

1. Open the LangtonsAnts project in VS Code.

1. Select the `Game` folder.

1. Open the `GeneralizedAnt.cs` file.

1. Below the constructor, type `prop`, then press Enter.

1. For the return type, type `string` and press Enter twice.

1. Enter `Rule` for the name, then press Enter to move to the end of the line.

1. At the end of the property, add `= "RL"`

    ```csharp
    namespace LangtonsAnt
    {
        public class GeneralizedAnt : Ant
        {
            public GeneralizedAnt(int i, int j, AntDirection direction) : base(i, j, direction)
            {

            }

            public string Rule { get; set; } = "RL";
        }
    }
    ```

## Implement Act method

Now you need to implement a new version of the Act method that uses your Rule property. The inherited Act method in the `Ant` class always turns an ant clockwise on color 0, and counter-clockwise on 1.

Implement a new version in your `GeneralizedAnt` class that changes the direction of your `GeneralizedAnt` instance, according to the rule set by the `Rule` property. Rather than change direction based on the color of the cell landed on, it will instead change direction based on the previous direction. If an ant went to the right previously, it will now go to the left, etcetera.

You'll also make this version of your `Act` method override the original inherited version in the `Ant` class. To do that, you make the original `Ant` class version of the method virtual, then override the method in `GeneralizedAnt`.

1. Create an `Act` method beneath your Rule property.

    ```csharp
    public byte Act(byte oldValue)
    {
    
    }
    ```

    > [!NOTE]
    > Don't forget, you can right-click in the editor and select Format Document to fix any formatting issues. Shift+Alt+F will also work.

1. Make it "overridable" by adding the keyword `override`.

    ```csharp
    public override byte Act(byte oldValue)
    {
        
    }
    ```

1. Add the rule logic.

    ```csharp
    public override byte Act(byte oldValue)
    {
        public override byte Act(byte oldValue)
        {
            if (Rule[oldValue] == 'R')
            {
                RotateCW();
            }
            else
            {
                RotateCCW();
            }
            Move();
            byte ret;
            if (oldValue == 0)
                ret = 1;
            else // oldValue = 1
                ret = 0;
            return ret;
        }
    }
    ```

1. Open the`Ant.cs` file in your Game folder.

1. Locate the `Act` method and add the `virtual` keyword.

    ```csharp 
    public virtual byte Act(byte oldValue)
    {
        byte ret;
        if (oldValue == 0)
        {
            ret = 1;
            RotateCW();
        }
        else
        {
            ret = 0;
            RotateCCW();
        }
        Move();
        return ret;
    }
    ```

    > [!NOTE]
    > Making a method `virtual` in a base class and overriding it in a derived class results in the derived version being called.

1. Save your work by typing Ctrl+S (saves all open files)

## Check your work

Now you can check your work. The program should work exactly like it did before. You didn't really change anything in terms of playing the game or what is output to the screen. You changed _how_ internally the game does things, adding inheritance.

1. Select VS Code View menu.
1. Select Terminal.
1. Type `cd` and press Enter to go to the Starter directory, if you aren't already in it.
1. Type 'dotnet build' to build your code and press enter.
1. Type 'dotnet run' and press enter.
