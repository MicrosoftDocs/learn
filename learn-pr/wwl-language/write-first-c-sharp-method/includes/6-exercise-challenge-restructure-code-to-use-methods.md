Code challenges reinforce what you've learned, and help you gain some confidence before continuing on.

The focus of this challenge is to modify code so that it is reusable and can be executed at any time.

## Tell a fortune

You're helping to develop a massive multiplayer role-playing game. Each player has a luck stat that can affect their odds of finding rare treasure. Each day, a player can speak to an in-game fortune teller that reveals whether their luck stat is high, low, or neutral. 

The game currently has code to generate a player's fortune, but it isn't reusable. Your task is to create a `tellFortune` method that can be called at any time, and replace the existing logic with a call to your method.

In this challenge, you're given some starting code. You must decide how to create and call the `tellFortune` method.

## Code challenge: create a reusable method

In the code that you start with, there's a generic text array, followed by good, bad, and neutral text arrays. Depending on the value of `luck`, one of the arrays is selected and displayed alongside the generic text.

Your challenge is to create a reusable method that prints a player's fortune at any time. The method should contain the logic that is already present in the code provided.

1. Ensure that you have an empty Program.cs file open in Visual Studio Code.

    If necessary, open Visual Studio Code, and then complete the following steps to prepare a Program.cs file in the Editor:

    1. On the **File** menu, select **Open Folder**.

    1. Use the Open Folder dialog to navigate to, and then open, the **CsharpProjects** folder.

    1. In the Visual Studio Code EXPLORER panel, select **Program.cs**.

    1. On the Visual Studio Code **Selection** menu, select **Select All**, and then press the Delete key.

1. Copy and paste the following code into the Editor:

    ```c#
    Random random = new Random();
    int luck = random.Next(100);
    
    string[] text = {"You have much to", "Today is a day to", "Whatever work you do", "This is an ideal time to"};
    string[] good = {"look forward to.", "try new things!", "is likely to succeed.", "accomplish your dreams!"};
    string[] bad = {"fear.", "avoid major decisions.", "may have unexpected outcomes.", "re-evaluate your life."};
    string[] neutral = {"appreciate.", "enjoy time with friends.", "should align with your values.", "get in tune with nature."};

    Console.WriteLine("A fortune teller whispers the following words:");
    string[] fortune = (luck > 75 ? good : (luck < 25 ? bad : neutral));
    for (int i = 0; i < 4; i++) 
    {
        Console.Write($"{text[i]} {fortune[i]} ");
    }
    ```

1. Update the code to use a method to display the fortune.

    Use what you've learned about creating and calling methods to complete the update.

1. Test your code by changing the value of `luck` and calling the method again.

1. Verify that your code produces one of the following messages:

    ```Output A
    A fortune teller whispers the following words:
    You have much to look forward to. Today is a day to try new things! Whatever work you do is likely to succeed. This is an ideal time to accomplish your dreams! 
    ```

    ```Output B
    A fortune teller whispers the following words:
    You have much to appreciate. Today is a day to enjoy time with friends. Whatever work you do should align with your values. This is an ideal time to get in tune with nature. 
    ```

    ```Output C
    A fortune teller whispers the following words:
    You have much to fear. Today is a day to avoid major decisions. Whatever work you do may have unexpected outcomes. This is an ideal time to re-evaluate your life.
    ```

Whether you get stuck and need to peek at the solution or you finish successfully, continue on to view a solution to this challenge.