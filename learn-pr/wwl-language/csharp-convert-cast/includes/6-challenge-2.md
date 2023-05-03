



Here's a second chance to use what you've learned about casting and conversion to solve a coding challenge.

The following challenge helps you to understand the implications of casting values considering the impact of narrowing and widening conversions.

1. Delete or comment out all of the code from the earlier exercise

1. Enter the following "starter" code:

    ```csharp
    int value1 = 12;
    decimal value2 = 6.2m;
    float value3 = 4.3f;

    // Your code here to set result1
    // Hint: You need to round the result to nearest integer (don't just truncate)
    Console.WriteLine($"Divide value1 by value2, display the result as an int: {result1}");

    // Your code here to set result2
    Console.WriteLine($"Divide value2 by value3, display the result as a decimal: {result2}");

    // Your code here to set result3
    Console.WriteLine($"Divide value3 by value1, display the result as a float: {result3}");
    ```

1. Replace the code comments in the starter code with your own code to solve the challenge:

    - Solve for `result1`: Divide `value1` by `value2`, display the result as an `int`
    - Solve for `result2`: Divide `value2` by `value3`, display the result as a `decimal`
    - Solve for `result3`: Divide `value3` by `value1`, display the result as a `float`

    Solve the challenge so that your output resembles:

    ```Output
    Divide value1 by value2, display the result as an int: 2
    Divide value2 by value3, display the result as a decimal: 1.4418604651162790697674418605
    Divide value3 by value1, display the result as a float: 0.3583333
    ```

1. On the Visual Studio Code **File** menu, select **Save**.

    The Program.cs file must be saved before building or running the code.

1. In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

    A Terminal panel should open, and should include a command prompt showing that the Terminal is open to your TestProject folder location.

1. At the Terminal command prompt, to run your code, type **dotnet run** and then press Enter.

    You should see the following output:

    ```Output
    Divide value1 by value2, display the result as an int: 2
    Divide value2 by value3, display the result as a decimal: 1.4418604651162790697674418605
    Divide value3 by value1, display the result as a float: 0.3583333
    ```

    > [!NOTE]
    > If you see a message saying "Couldn't find a project to run", ensure that the Terminal command prompt displays the expected TestProject folder location. For example: `C:\Users\someuser\Desktop\csharpprojects\TestProject>`

Whether you get stuck and need to peek at the solution or you finish successfully, continue on to view a solution to this challenge.
