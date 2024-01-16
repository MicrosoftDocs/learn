As you continue your development work for a logistics company, you will be building a series of small applications.  Combined, the applications take data from one partner's system, modify the data, then pass it to an internal system in the format it requires.

To perform this transformation on the data, you'll need to accept incoming data as a string, parse it into smaller data elements, then manipulate it to match a different format. But how can you parse the string data into smaller data elements?

## String data type's Array methods

The variables of type `string` have many built-in methods that convert a single string into either an array of smaller strings, or an array of individual characters.

When processing data from other computer systems, sometimes it's formatted or encoded in a way that's not useful for your purposes. In those cases, you can use the `string` data type's Array methods to parse a larger string into an array.

### Use the `ToCharArray()` to reverse a `string`

1. Delete or use the line comment operator `//` to comment out all of the code from the previous exercises.

1. Update your code in the Visual Studio Code Editor as follows:

    ```csharp
    string value = "abc123";
    char[] valueArray = value.ToCharArray();

    ```

Here you're using the `ToCharArray()` method to create an array of `char`, each element of the array has one character of the original string.

### Reverse, then combine the char array into a new string

Next, you'll reverse the order of the chars in the array, then use the `Write` method to combine them back into a single output.

1. Update your code in the Visual Studio Code Editor as follows:

    ```csharp
    string value = "abc123";
    char[] valueArray = value.ToCharArray();
    Array.Reverse(valueArray);
    string result = new string(valueArray);
    Console.WriteLine(result);

    ```

    The expression `new string(valueArray)` creates a new empty instance of the `System.String` class (which is the same as the `string` data type in C#) and passes in the char array as a constructor.

    > [!NOTE]
    > What is the `new` keyword? How is the `System.String` class related to the `string` data type in C#? What is a constructor? All great questions that unfortunately are out of scope for this module. You are recommended to keep learning about the .NET Class Library as well as classes and objects in C# to fully understand what is going on behind the scenes with this expression of code. For now, use a search engine and Microsoft Docs to find good examples you can use in situations like this where you know you want to perform a conversion but are not sure how to do it using C#.

1. On the Visual Studio Code **File** menu, select **Save**.

    The Program.cs file must be saved before building or running the code.

1. In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

    A Terminal panel should open, and should include a command prompt showing that the Terminal is open to your TestProject folder location.

1. At the Terminal command prompt, to run your code, type **dotnet run** and then press Enter.

    > [!NOTE]
    > If you see a message saying "Couldn't find a project to run", ensure that the Terminal command prompt displays the expected TestProject folder location. For example: `C:\Users\someuser\Desktop\csharpprojects\TestProject>`

    You should see the following output:

    ```Output
    321cba

    ```

### Combine all of the chars into a new comma-separated-value string using `Join()`

Perhaps you need to separate each element of the char array using a comma, as is common when working with data that is represented as ASCII text. To do that, you'll comment out the line of code you added in Step 2 and use the `String` class' `Join()` method, passing in the char you want to delimit each segment (the comma) and the array itself.

1. Update your code in the Visual Studio Code Editor as follows:

    ```csharp
    string value = "abc123";
    char[] valueArray = value.ToCharArray();
    Array.Reverse(valueArray);
    // string result = new string(valueArray);
    string result = String.Join(",", valueArray);
    Console.WriteLine(result);

    ```

1. Save your code file, and then use Visual Studio Code to run your code.

    You should see the following output:

    ```Output
    3,2,1,c,b,a

    ```

### `Split()` the comma-separated-value string into an array of strings

To complete the code, you'll use the `Split()` method, which is used with variables of type `string` to create an array of strings.

1. Use the Visual Studio Code Editor to add the following lines of code at the bottom of the file:

    ```csharp
    string[] items = result.Split(',');
    foreach (string item in items)
    {
        Console.WriteLine(item);
    }
    ```

1. Take a minute to review the previous code.

    The comma is supplied to `.Split()` as the delimiter to split one long string into smaller strings. The code then uses a `foreach` loop to iterate through each element of the newly created array of strings, `items`.

1. Check that your code now appears as follows:

    ```csharp
    string value = "abc123";
    char[] valueArray = value.ToCharArray();
    Array.Reverse(valueArray);
    // string result = new string(valueArray);
    string result = String.Join(",", valueArray);
    Console.WriteLine(result);

    string[] items = result.Split(',');
    foreach (string item in items)
    {
        Console.WriteLine(item);
    }

    ```

1. Save your code file, and then use Visual Studio Code to run your code. 

    When you run the code, you'll see the following output:

    ```Output
    3,2,1,c,b,a
    3
    2
    1
    c
    b
    a
    ```

    The `items` array created using `string[] items = result.Split(',');` is used in the `foreach` loop and displays the individual characters from the original `string` contained in the `value` variable.

## Recap

Here's a few things to remember when working with strings and arrays:

- Use methods like `ToCharArray()` and `Split()` to create an array
- Use methods like `Join()`, or create a new string passing in an array of `char` to turn the array back into a single string