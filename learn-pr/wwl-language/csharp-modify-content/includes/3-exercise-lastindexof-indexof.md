
In this exercise, we use the methods`IndexOf()` and `LastIndexOf()` methods to find the positions of characters and substrings within a given string.

### `IndexOf()` and `LastIndexOf`

The `.IndexOf()` method  returns the index of the first occurrence of a specified character or substring within a given string. The method `.LastIndexOf()` returns the index position of the last occurrence of a character or string within a given string. Both the `Indexof()` and `LastIndexOf()` methods return **-1** if the character or string is **not found**.

1. Select and delete all code lines in the Visual Studio Code Editor.

1. Update your code in the Visual Studio Code Editor as follows:

    ```csharp
    string message = "hello there!";

    int first_h = message.IndexOf('h');
    int last_h = message.LastIndexOf('h');
    
    Console.WriteLine($"For the message: '{message}', the first 'h' is at position {first_h} and the last 'h' is at position {last_h}.");
    ```

1. Save your code file, and then use Visual Studio Code to run your code. You should see the following output:

    ```Output
    For the message: 'hello there!', the first 'h' is at position 0 and the last 'h' is at position 7.
    ```

    The output identifies the first  "**h**" in the string "**h**ello t**h**ere!" at position 0 and the last "**h**" at position 7.

### Retrieve the last occurrence of a sub string

You increase the complexity of the `message` variable by adding multiple sets of parentheses, then write code to retrieve the content inside the **last** set of parentheses.

1. Select and delete all code lines in the Visual Studio Code Editor.

1. Update your code in the Visual Studio Code Editor as follows:

    ```csharp
    string message = "(What if) I am (only interested) in the last (set of parentheses)?";
    int openingPosition = message.LastIndexOf('(');

    openingPosition += 1;
    int closingPosition = message.LastIndexOf(')');
    int length = closingPosition - openingPosition;
    Console.WriteLine(message.Substring(openingPosition, length));
    ```

1. Save your code file, and then use Visual Studio Code to run your code. You should see the following output:

    ```Output
    set of parentheses
    ```

    The key to this example is the use of `LastIndexOf()`, which you use to get the positions of the last opening and closing parentheses. 
    
    > [!NOTE]
    > The previous sample code only runs without error because the `message` string contains properly formatted parenthesis pairs. But the code is fragile and produces errors when no parenthesis pair is present, or when the last parentheses don't form a opening and closing pair.

### Retrieve all instances of substrings inside parentheses

This time, update the `message` to have three sets of parentheses, and write code to extract any text inside of the parentheses. You're able to reuse portions of the previous work, but you need to add a `while` statement to iterate through the string until all sets of parentheses are discovered, extracted, and displayed.

1. Update your code in the Visual Studio Code Editor as follows:

    ```csharp
    string message = "(What if) there are (more than) one (set of parentheses)?";
    while (true)
    {
        int openingPosition = message.IndexOf('(');
        if (openingPosition == -1) break;

        openingPosition += 1;
        int closingPosition = message.IndexOf(')');
        int length = closingPosition - openingPosition;
        Console.WriteLine(message.Substring(openingPosition, length));

        // Note the overload of the Substring to return only the remaining 
        // unprocessed message:
        message = message.Substring(closingPosition + 1);
    }
    ```

1. Save your code file, and then use Visual Studio Code to run your code. You should see the following output:

    ```Output
    What if
    more than
    set of parentheses
    ```

1. Take a minute to observe last line of code inside the `while` loop, pulled out in the following code:

    ```csharp
    message = message.Substring(closingPosition + 1);
    ```

    When you use `Substring()` without specifying a length input parameter, it will return every character after the starting position you specify. With the string being processed, `message = "(What if) there are (more than) one (set of parentheses)?"`, there's an advantage to removing the first set of parentheses `(What if)` from the value of `message`. What remains is then processed in the next iteration of the `while` loop.

1. Take a minute to consider what happens during the final iteration of the `while` loop, when only the final `?` character remains.

    The followings code addresses handling the end of the string:

    ```csharp
    int openingPosition = message.IndexOf('(');
    if (openingPosition == -1) break;
    ```

    The `IndexOf()` method returns `-1` if it can't find the input parameter in the string. You merely check for the value `-1` and `break` out of the loop.

### Work with different types of symbol sets with `IndexOfAny()`

This time, search for several different character symbols, not just a set of parentheses by using `.IndexOfAny()`.

**`.IndexOfAny()`** reports the index of the first occurrence of any character in a supplied array of characters. The method returns **-1** if all characters in the array of characters are **not found**.

In the following example, the index of the first found character of the characters 'a', 'e', or 'i' is returned. 

1. Update your code in the Visual Studio Code editor as follows:

    ```csharp
    string message = "Hello, world!";
    char[] charsToFind = { 'a', 'e', 'i' };

    int index = message.IndexOfAny(charsToFind);

    Console.WriteLine($"Found '{message[index]}' in '{message}' at index: {index}.");
    ```

1. Save your code file, and then use Visual Studio Code to run your code.

    You should see the following output:

    ```output
    Found 'e' in 'Hello, world!' at index: 1.
    ```

    Update the `message` string, adding different types of symbols like square `[]` brackets and curly braces `{}`. To search for multiple symbols simultaneously, use `.IndexOfAny()`. You search with `.IndexOfAny()` to return the index of the first symbol from the array `openSymbols` found in the `message` string.

1. Update your code in the Visual Studio Code editor as follows:

    ```csharp
    string message = "Help (find) the {opening symbols}";
    Console.WriteLine($"Searching THIS Message: {message}");
    char[] openSymbols = { '[', '{', '(' };
    int startPosition = 5;
    int openingPosition = message.IndexOfAny(openSymbols);
    Console.WriteLine($"Found WITHOUT using startPosition: {message.Substring(openingPosition)}");

    openingPosition = message.IndexOfAny(openSymbols, startPosition);
    Console.WriteLine($"Found WITH using startPosition {startPosition}:  {message.Substring(openingPosition)}");
    ```

1. Save your code file, and then use Visual Studio Code to run your code.

    You should see the following output:

    ```output
    Searching THIS message: Help (find) the {opening symbols}
    Found WITHOUT using startPosition: (find) the {opening symbols}
    Found WITH using startPosition 5:  (find) the {opening symbols}
    ```

1. Take a minute to review the code previously entered.

    You used `.IndexOfAny()` *without*, and then *with*, the starting position overload.

    Now that you found an opening symbol, you need to find its matching closing symbol.

1. Update your code in the Visual Studio Code Editor as follows:

    ```csharp
    string message = "(What if) I have [different symbols] but every {open symbol} needs a [matching closing symbol]?";

    // The IndexOfAny() helper method requires a char array of characters. 
    // You want to look for:

    char[] openSymbols = { '[', '{', '(' };

    // You'll use a slightly different technique for iterating through 
    // the characters in the string. This time, use the closing 
    // position of the previous iteration as the starting index for the 
    //next open symbol. So, you need to initialize the closingPosition 
    // variable to zero:

    int closingPosition = 0;

    while (true)
    {
        int openingPosition = message.IndexOfAny(openSymbols, closingPosition);

        if (openingPosition == -1) break;

        string currentSymbol = message.Substring(openingPosition, 1);

        // Now  find the matching closing symbol
        char matchingSymbol = ' ';

        switch (currentSymbol)
        {
            case "[":
                matchingSymbol = ']';
                break;
            case "{":
                matchingSymbol = '}';
                break;
            case "(":
                matchingSymbol = ')';
                break;
        }

        // To find the closingPosition, use an overload of the IndexOf method to specify 
        // that the search for the matchingSymbol should start at the openingPosition in the string. 
        
        openingPosition += 1;
        closingPosition = message.IndexOf(matchingSymbol, openingPosition);

        // Finally, use the techniques you've already learned to display the sub-string:

        int length = closingPosition - openingPosition;
        Console.WriteLine(message.Substring(openingPosition, length));
    }
    ```

1. Take a few minutes to examine the previous code and to read the comments that help explain the code.

1. Continue examining the code and locate the following line of code using `IndexOf()` to define `closingPosition`:

    ```csharp
    closingPosition = message.IndexOf(matchingSymbol, openingPosition);
    ```

    The variable `closingPosition` is used to find the length passed into the `Substring()` method, and to find the next `openingPosition` value:

    ```csharp
    int openingPosition = message.IndexOfAny(openSymbols, closingPosition);
    ```

    For this reason, the `closingPosition` variable is defined outside of the `while` loop scope and initialized to `0` for the first iteration.

1. Save your code file, and then use Visual Studio Code to run your code. You should see the following output:

    ```Output
    What if
    different symbols
    open symbol
    matching closing symbol
    ```

## Recap

Here are two important things to remember:

- `LastIndexOf()` returns the last position of a character or string inside of another string.
- `IndexOfAny()` returns the first position of an array of `char` that occurs inside of another string.