The following code is one possible solution for the challenge from the previous unit.

```c#
Random random = new Random();
int luck = random.Next(100);

string[] text = {"You have much to", "Today is a day to", "Whatever work you do", "This is an ideal time to"};
string[] good = {"look forward to.", "try new things!", "is likely to succeed.", "accomplish your dreams!"};
string[] bad = {"fear.", "avoid major decisions.", "may have unexpected outcomes.", "re-evaluate your life."};
string[] neutral = {"appreciate.", "enjoy time with friends.", "should align with your values.", "get in tune with nature."};

TellFortune();
luck = random.Next(100);
TellFortune();

void TellFortune() 
{
    Console.WriteLine("A fortune teller whispers the following words:");
    string[] fortune = (luck > 75 ? good : (luck < 25 ? bad : neutral));
    for (int i = 0; i < 4; i++) 
    {
        Console.Write($"{text[i]} {fortune[i]} ");
    }
}
```

This code is just "*one possible solution*" because you may have added line feeds in different spots or you may have formatted the code differently.

Regardless of minor code differences, when you run the code, you should see two of the following output messages:

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

If you completed the challenge, congratulations! Continue on to the knowledge check in the next unit.

> [!IMPORTANT]
> If you had trouble completing this challenge, consider reviewing the previous units before you continue on. All new ideas we discuss in other modules will depend on your understanding of the ideas that were presented in this module.