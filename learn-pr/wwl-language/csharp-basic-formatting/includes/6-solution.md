


The following code is one possible solution for the challenge from the previous unit.

```csharp
string projectName = "ACME";
string englishLocation = $@"c:\Exercise\{projectName}\data.txt";
Console.WriteLine($"View English output:\n\t\t{englishLocation}\n");

string russianMessage = "\u041f\u043e\u0441\u043c\u043e\u0442\u0440\u0435\u0442\u044c \u0440\u0443\u0441\u0441\u043a\u0438\u0439 \u0432\u044b\u0432\u043e\u0434";
string russianLocation = $@"c:\Exercise\{projectName}\ru-RU\data.txt";
Console.WriteLine($"{russianMessage}:\n\t\t{russianLocation}\n");
```

This code represents "*one possible solution*". You may have some variations in naming variables or in the character escape sequences you used. You might use `Console.Write` instead of `Console.WriteLine`, or you might combine the values instead of using several variables.

However, as long as your code follows the instructions from the challenge and produces the desired output, then congratulations! Continue to the knowledge check in the next unit.

> [!IMPORTANT]
> If you had trouble completing this challenge, maybe you should review the previous units before you continue on.
