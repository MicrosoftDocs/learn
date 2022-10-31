Previously, we used multiple `if` statements to implement the rules of our game. However, when we left off in the previous unit, there was opportunity for improvement. We can make an improvement to the expressiveness of the code and an improvement to fix a subtle bug in our code. 

## Improve code and fix a bug by adding else and else if statements

Next, we'll use variants of the `if` statement to improve our code and fix a logic bug.

### Step 1 - Use if and else statements instead of two separate if statements

Instead of performing two checks to display the "You win!" or "Sorry, you lose" message, we'll use the `else` keyword. Modify your code to match the following code listing:

```csharp-interactive
Random dice = new Random();

int roll1 = dice.Next(1, 7);
int roll2 = dice.Next(1, 7);
int roll3 = dice.Next(1, 7);

int total = roll1 + roll2 + roll3;

Console.WriteLine($"Dice roll: {roll1} + {roll2} + {roll3} = {total}");

if ((roll1 == roll2) || (roll2 == roll3) || (roll1 == roll3))
{
    Console.WriteLine("You rolled doubles!  +2 bonus to total!");
    total += 2;
}

if ((roll1 == roll2) && (roll2 == roll3))
{
    Console.WriteLine("You rolled triples!  +6 bonus to total!");
    total += 6;
}

if (total >= 15)
{
    Console.WriteLine("You win!");
}
else 
{
    Console.WriteLine("Sorry, you lose.");
}
```

Here, if `total >= 15` is false, the code block after the `else` keyword will execute. Because these two options are related opposites, this scenario is a perfect example of when to use the `else` keyword.

### Step 2 - Use nesting to remove the stacking bonus for doubles and triples

In the previous unit, we saw how we introduced a subtle logic bug into our application. Let's fix bug that by using nesting.

Nesting allows us to place code blocks inside of code blocks. In this case, we'll nest `if` and `else` statements (the check for triples) inside of another `if` statement (the check for doubles) to prevent them both from happening.

We'll nest the check for triples inside of the check for doubles. Modify the code to match the following code listing:

```csharp-interactive
int roll1 = 6;
int roll2 = 6;
int roll3 = 6;

int total = roll1 + roll2 + roll3;

Console.WriteLine($"Dice roll: {roll1} + {roll2} + {roll3} = {total}");

if ((roll1 == roll2) || (roll2 == roll3) || (roll1 == roll3))
{
    if ((roll1 == roll2) && (roll2 == roll3))
    {
        Console.WriteLine("You rolled triples!  +6 bonus to total!");
        total += 6;
    }
    else
    {
        Console.WriteLine("You rolled doubles!  +2 bonus to total!");
        total += 2;
    }
}

if (total >= 15)
{
    Console.WriteLine("You win!");
}
else 
{
    Console.WriteLine("Sorry, you lose.");
}
```

To test the code without running the application dozens of times, you can temporarily hard-code the values of the three `roll` variables by adding the following code before the line where `total` is declared and initialized.

To test that doubles works:

```csharp
roll1 = 6;
roll2 = 6;
roll3 = 5;
```

When you run the code, you should see:

```output
Dice roll: 6 + 6 + 5 = 17
You rolled doubles!  +2 bonus to total!
You win!
```

To test that triples work, modify the value of `roll3`:

```csharp
roll1 = 6;
roll2 = 6;
roll3 = 6;
```

When you run the code, you should see this output:

```output
Dice roll: 6 + 6 + 6 = 18
You rolled triples!  +6 bonus to total!
You win!
```

### Step 3 - Use if, else, and else if statements to give a prize instead of a win-lose message

To make the game more fun, let's change the game from win-or-lose to award fictitious prizes for each score. We'll offer four prizes. The player should win only one prize:

- If the player scores greater or equal to 16, they'll win a new car.
- If the player scores greater or equal to 10, they'll win a new laptop.
- If the player scores exactly 7, they'll win a trip.
- Otherwise, the player wins a kitten.

Modify the code from the previous steps to the following code listing:

```csharp-interactive
Random dice = new Random();

int roll1 = dice.Next(1, 7);
int roll2 = dice.Next(1, 7);
int roll3 = dice.Next(1, 7);

int total = roll1 + roll2 + roll3;

Console.WriteLine($"Dice roll: {roll1} + {roll2} + {roll3} = {total}");

if ((roll1 == roll2) || (roll2 == roll3) || (roll1 == roll3))
{
    if ((roll1 == roll2) && (roll2 == roll3))
    {
        Console.WriteLine("You rolled triples!  +6 bonus to total!");
        total += 6;
    }
    else
    {
        Console.WriteLine("You rolled doubles!  +2 bonus to total!");
        total += 2;
    }
}

if (total >= 16)
{
    Console.WriteLine("You win a new car!");
}
else if (total >= 10)
{
    Console.WriteLine("You win a new laptop!");
}
else if (total == 7)
{
    Console.WriteLine("You win a trip for two!");
}
else
{
    Console.WriteLine("You win a kitten!");
}
```

> [!NOTE]
> Use the technique of temporarily hard-coding the `roll` variables to test each message.

You can use `if`, `else`, and `else if` statements to create multiple exclusive conditions as Boolean expressions. In other words, when you want only one outcome to happen, but you have several possible conditions and results, use as many `else if` statements as you want. If none of the `if` and `else if` statements apply, the final `else` code block will be executed. The `else` is optional, but it must come last.

## Recap

- The combination of `if` and `else` statements allows you to test for a condition and perform code when a Boolean expression is true and run different code when the Boolean expression is false.
- You can nest `if` statements to narrow down a possible condition. However, you should consider using the `if`, `else`, and `else if` statements instead.
- Use `else if` to create multiple exclusive conditions.
- An `else` is optional, but it must always come last.
