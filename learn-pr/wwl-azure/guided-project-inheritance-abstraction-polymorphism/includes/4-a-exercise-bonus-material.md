In this lesson you replace `MirrorAnt` with `GeneralizedAnt`, so that it also uses the new `Act` method.

## Replace `MirrorAnt` with `GeneralizedAnt`

1. In the Game folder open the `Game.cs` file.

1. Replace the line that references `MirrorAnt` with  `GenralizedAnt`.

    ```csharp
    Ants = new IAnt[] {
           new Ant(i: size/2 + 2, j: size / 2, direction: AntDirection.Up),
           new GeneralizedAnt(i: size/2 + 2, j: size / 2, direction: AntDirection.Up),
           new GeneralizedAnt(i: size/2 - 2, j: size / 2, direction: AntDirection.Down)
    };
    ```

## Check your work

Now you can check your work again. Your program should work exactly like it did previously.

1. Select VS Code View menu.
1. Select Terminal.
1. Save your work by typing Ctrl-s (saves all open files)
1. Build your code, type 'dotnet build' and press enter.
1. Run your code, type 'dotnet run' and press enter.
