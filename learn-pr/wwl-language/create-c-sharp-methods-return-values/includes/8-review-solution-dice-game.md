The following code is one possible solution for the challenge from the previous unit.

```c#
Random random = new Random();

Console.WriteLine("Would you like to play? (Y/N)");
if (ShouldPlay()) 
{
    PlayGame();
}

bool ShouldPlay() 
{
    string response = Console.ReadLine();
    return response.ToLower().Equals("y");
}

void PlayGame() 
{
    var play = true;

    while (play) {
        var target = GetTarget();
        var roll = RollDice();

        Console.WriteLine($"Roll a number greater than {target} to win!");
        Console.WriteLine($"You rolled a {roll}");
        Console.WriteLine(WinOrLose(roll, target));
        Console.WriteLine("\nPlay again? (Y/N)");

        play = ShouldPlay();
    }
}

int GetTarget() 
{
    return random.Next(1, 6);
}

int RollDice() 
{
    return random.Next(1, 7);
}

string WinOrLose(int roll, int target) 
{
    if (roll > target) 
    {
        return "You win!";
    }
    return "You lose!";
}
```

This code is just "*one possible solution*" because you may have added line feeds in different spots, returned values differently, or formatted the code differently.

Regardless of minor code differences, when you run the code, you should see output similar to the following:

```
Would you like to play? (Y/N)
Y
Roll a number greater than 2 to win!
You rolled a 1
You lose!

Play again? (Y/N)
Y
Roll a number greater than 3 to win!
You rolled a 5
You win!

Play again? (Y/N)
Y
Roll a number greater than 2 to win!
You rolled a 3
You win!

Play again? (Y/N)
N
```

If you completed this challenge, congratulations! Continue on to the knowledge check in the next unit.

> [!IMPORTANT]
> If you had trouble completing this challenge, consider reviewing the previous units before you continue on. All new ideas we discuss in other modules will depend on your understanding of the ideas that were presented in this module.