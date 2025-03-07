In this exercise, you'll get to see how inheritance works and how to implement it. You'll create a new class called `GeneralizedAnt` that inherits from your original `Ant` class.

> [!IMPORTANT]
> You need to have completed the Setup instructions in the previous unit, Prepare, before you begin this Exercise.

## Create a GeneralizedAnt ant class that inherits from Ant

1. Select your `Game` folder.
1. Select the New File icon.
1. Type `GeneralizedAnt.cs` for the name of the file.
1. Press Enter.
1. Create your `GeneralizedAnt` class.

    ```csharp
    namespace LangtonsAnts
    {
        public class GeneralizedAnt
        {

        }
    }
    ```

1. Make `GeneralizedAnt` inherit from the `Ant` class.

    ```csharp
    namespace LangtonsAnts
    {
        public class GeneralizedAnt : Ant
        {

        }
    }
    ```

    Now you need to pass in to the `GeneralizedAnt` constructor the same parameters you were passing in to the `Ant` class constructor.

1. Add a constructor that takes the same parameters as the original `Ant` class.

    ```csharp
    namespace LangtonsAnts
    {
        public class GeneralizedAnt : Ant
        {
            public GeneralizedAnt(int i, int j, AntDirection direction)
            {

            }
        }
    }
    ```

    While you'll be passing these constructor parameters into `GeralizedAnt`, you'll use the constructor from the `Ant` class to initialize `GeneralizedAnt`.

    The `Ant` class is the base class for `GeneralizedAnt`. To make `GeneralizedAnt` use the `Ant` constructor, you modify the `GeneralizedAnt` constructor, telling it to pass the parameters to the `Ant` base class constructor.

1. Make `GeneralizedAnt` use the `Ant` base class constructor, as shown.

    ```csharp
    namespace LangtonsAnts
    {
        public class GeneralizedAnt : Ant
        {
            public GeneralizedAnt(int i, int j, AntDirection direction) : base(i, j, direction)
            {

            }
        }
    }
    ```

    Essentially, what you are doing here's passing in the same parameters you passed into the `Ant` class into your new `GeneralizedAnt` class. You're then inheriting the base class constructor of `GeneralizedAnt`, the `Ant` class constructor, to initialize `GeneralizedAnt`.

1. Replace Ant with `GeneralizedAnt`.

    The last thing you need to do is to use your new class. To do that, you'll modify the `Game` class so that it initializes the `Ants` array is using the new `GeneralizedAnt` class.

    1. Open the `Game.cs` file in your Games folder.
    1. Replace the line in the constructor for the creation of the `Ants` array that creates an `Ant` so that it now creates a `GenerlizedAnt` instead.

    ```csharp
    public Game(int size = 64)
    {
        Field = new byte[size, size];
        Ants = new IAnt[] {
            new GeneralizedAnt(i: size/2 + 2, j: size / 2, direction: AntDirection.Up),
            new MirrorAnt(i: size/2 - 2, j: size / 2, direction: AntDirection.Down)
        };
    }
    ```

1. Save your work by typing Ctrl-s (saves all open files)

## Check your work

Now you can check your work. The program should work exactly like it did before. You didn't really change anything in terms of playing the game or what is output to the screen. You changed _how_ internally the game does things, adding inheritance.

1. Select VS Code View menu.
1. Select Terminal.
1. Build your code, type 'dotnet build' and press enter.
1. Run your code, type 'dotnet run' and press enter.
