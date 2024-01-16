In this exercise, we will "generalize" our Langton's Ant implementation even further so that it can support more than two colors.

## Change the `GeneralizedAnt` rule property to a typical get-set property

Properties can either be `auto` properties that mask the details of a property, or they can be regular `get-set` properties that show the getter and setter methods and the variable for storing the property, as shown here.

1. Open WPF\Game\GeneralizedAnt.cs

1. Examine the Rule "auto" property.

    ```csharp
    public string Rule { get; set; } = "RL";
    ```

1. Modify the property to show the details, as shown here.

    ```csharp
    protected string rule = "LR";

    public string Rule
    {
        get
        {
            return rule;
        }

        set
        {
            rule = value;
        }
    }
    ```

## Add value validation when setting the Rule property

Your setter should validate that the values being passed in are valid. It should validate that the values it sets are from 2-14 characters long and contain only `L` or `R` characters.

1. Modify the setter for the Rule property as shown.

    ```csharp
    protected string rule = "LR";

    public string Rule
    {
        get
        {
            return rule;
        }

        set
        {
            if (!IsRuleValid(value))
                    throw new ArgumentException("The rule can only consist from L and R characters and be longer than 2 characters. Example: LLRR");
                rule = value;
        }
    }
    ```

    > [!NOTE]
    > Some standard exceptions fit common programming scenarios. For instance, ArgumentException is used when an argument passed to a method does not satisfy its expectations.

1. Add the validation method `IsRuleValid` just beneath the rule property.

    ```csharp
    private bool IsRuleValid(string proposedRule)
    {
        return proposedRule != null && Regex.IsMatch(proposedRule, "^[L|R]{2,14}$");
    }
    ```

## Save maximum color value in maxColor field

Now we actually have up to 14 colors with corresponding values from 0 to 13. The number of colors depend on the length of our Rule string. Implement the `maxColor` field according to the following requirements:

- `maxColor` field of an integer type.
- Set `maxColor` when setting Rule property to the length of the value minus one.

1. Select the `GeneralizedAnt.cs` file in the Game folder.

1. Add the `maxColor` int variable with the `protected` keyword, as the variable need not be visible beyond this class. Set its initial value to `1`.

    ```csharp
    public class GeneralizedAnt : Ant
    {
        protected int maxColor = 1;

        public GeneralizedAnt(int i, int j, AntDirection direction) : base(i, j, direction)
        {
        }

        protected string rule = "LR";

        public string Rule
        {
            get { return rule; }
            set
            {
                if (!IsRuleValid(value))
                    throw new ArgumentException("The rule can only consist from L and R characters and be longer than 2 characters. Example: LLRR");
                rule = value;
            }
        }
    }
    ```

1. Add the `maxColor` variable in the setter, so it can be update by the number of arguments.

    ```csharp
    public class GeneralizedAnt : Ant
    {
        protected int maxColor = 1;
        protected string rule = "LR";

        public string Rule
        {
            get { return rule; }
            set
            {
                if (!IsRuleValid(value))
                    throw new ArgumentException("The rule can only consist from L and R characters and be longer than 2 characters. Example: LLRR");
                rule = value;
                maxColor = value.Length - 1;
            }
        }
    }
    ```

## Rotate colors in the Act method

The Act method is currently outdated. It only works with Rule strings with a length of 2, and it switches color values between two colors. Update the Act method so that it:

- Works with Rule properties of arbitrary length;
- Change the active cell's color to color + 1 and, if it's maxColor, change the value to 0.

1. Open `GeneralizedAnt.cs`'

1. In the `Act` method create a new variable called `oldValueNormalized` that holds the value for calculating the new color.

    ```csharp
    public override byte Act(byte oldValue)
    {
        var oldValueNormalized = (byte)(oldValue % (maxColor + 1));
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
    ```

1. Change the first `if` statement to use the new value.

    ```csharp
    public override byte Act(byte oldValue)
    {
        var oldValueNormalized = (byte)(oldValue % (maxColor + 1));
        if (rule[oldValueNormalized] == 'R')
        {
            RotateCW();
        }
        else // == 'L'
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
    ```

1. Remove the `oldValue` code that is no longer needed. Your Act method now should look as seen here.

    ```csharp
    public override byte Act(byte oldValue)
    {
        var oldValueNormalized = (byte)(oldValue % (maxColor + 1));
        if (rule[oldValueNormalized] == 'R')
        {
            RotateCW();
        }
        else // == 'L'
        {
            RotateCCW();
        }
        Move();  
    }
    ```

1. Return the new value.

    ```csharp
    public override byte Act(byte oldValue)
    {
        var oldValueNormalized = (byte)(oldValue % (maxColor + 1));
        if (rule[oldValueNormalized] == 'R')
        {
            RotateCW();
        }
        else // == 'L'
        {
            RotateCCW();
        }
        Move();  
        return (byte)((oldValueNormalized + 1) % (maxColor + 1));
    }
    ```

1. Add the namespace for Regular Expressions used in your setter property for validation.

    ```csharp
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    using System.Text.RegularExpressions;
    
    namespace LangtonsAnt
    {
        ...
    }
    ```

## Check your work

First, build and run the solution and ensure that the game runs as it did before. Then, locate the rule initialization string in the `MainWindow` class of `MainWindow.xaml.cs` and replace it with “LLRR”. After making this change, run the game again.

1. Open a terminal window by selecting View --> Terminal.

1. Change directories to the Starter/WPF directory, if you aren't already in it.

1. Enter `dotnet build` and press Enter.

1. Enter `dotnet run` and press Enter.

1. Select the `MainWindow.xaml.cs` file in the Explorer pane.

1. Replace the rule initialization string `string rule = "LR";` with `string rule = "LLRR";`.

1. Enter `dotnet run` and press Enter.

Hopefully, you can now enjoy a symmetrical ant game with four colors. If the code either failed to build or run, retrace your steps from the beginning of the exercise, building and running your code after each series of steps.
