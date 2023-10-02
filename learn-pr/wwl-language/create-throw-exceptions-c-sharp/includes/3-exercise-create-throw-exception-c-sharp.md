Developers often need to create and throw exceptions from within a method, and then catch those exceptions further down the call stack where they can be handled. Exception handling helps you to ensure the stability of your applications.

In this exercise, you'll start with a sample application that includes a potential error condition inside a called method. Your updated method will `throw` an exception when it detects the issue. The exception will be handled in a `catch` block of the code that calls the method. The result is an application that provides a better user experience.

## Create a new code project

The first step is to create a code project that you can use during this module.

1. Open a new instance of Visual Studio Code.

1. On the **File** menu, select **Open Folder**.

1. On the **Open Folder** dialog, navigate to your Windows **Desktop** folder.

1. On the **Open Folder** dialog, select **New folder**.

1. Name the new folder **ThrowExceptions101**, and then select **Select Folder**.

1. On the **Terminal** menu, select **New Terminal**.

    You will use a .NET CLI command to create a new console app.

1. At the TERMINAL panel command prompt, enter the following command:

    ```dotnetcli
    dotnet new console
    ```

1. Close the TERMINAL panel.

## Review a sample application

Use the following steps to load and review a sample application.

1. Open the Program.cs file.

1. After a few seconds, notice that a dialog box is displayed asking if you want to load the assets required for building and debugging.

    Visual Studio Code recognizes the C# file extension, `.cs`, and recognizes that your "ThrowExceptions101" project is missing the required assets.

1. To load the required assets, select **Yes**.

1. Replace the contents of the Program.cs file with the following code:

    ```csharp
    // Prompt the user for the lower and upper bounds
    Console.Write("Enter the lower bound: ");
    int lowerBound = int.Parse(Console.ReadLine());
    
    Console.Write("Enter the upper bound: ");
    int upperBound = int.Parse(Console.ReadLine());
    
    decimal averageValue = 0;
    
    // Calculate the sum of the even numbers between the bounds
    averageValue = AverageOfEvenNumbers(lowerBound, upperBound);
    
    // Display the value returned by AverageOfEvenNumbers in the console
    Console.WriteLine($"The average of even numbers between {lowerBound} and {upperBound} is {averageValue}.");
    
    // Wait for user input
    Console.ReadLine();
    
    static decimal AverageOfEvenNumbers(int lowerBound, int upperBound)
    {
        int sum = 0;
        int count = 0;
        decimal average = 0;
    
        for (int i = lowerBound; i <= upperBound; i++)
        {
            if (i % 2 == 0)
            {
                sum += i;
                count++;
            }
        }
    
        average = (decimal)sum / count;
    
        return average;
    }
    ```

1. Take a minute to review the code.

    Notice that the application performs the following tasks:

    1. The top-level statements use `Console.ReadLine()` statements to obtain values for `lowerBound` and `upperBound`.
    1. The top-level statements pass `lowerBound` and `upperBound` as arguments when calling the `AverageOfEvenNumbers` method.
    1. The `AverageOfEvenNumbers` method performs the following tasks:

        1. Declares local variables used in calculations.
        1. Uses a `for` loop to sum the even numbers between `lowerBound` and `upperBound`. The sum is stored in `sum`.
        1. Counts how many numbers are included in the sum. The count is stored in `count`.
        1. Stores the average of the summed numbers in a variable named `average`. The value of `average` is returned.

    1. The top-level statements print the value returned by `AverageOfEvenNumbers` to the console and then pauses execution.

## Configure the debug environment

The sample application reads user input from the console. The DEBUG CONSOLE panel doesn't support reading input from the console. You need to update the launch.json file before you can run this application in the debugger.

1. Use the EXPLORER view to open the launch.json file.

1. In the launch.json file, update the `console` attribute as follows:

    ```json
    // For more information about the 'console' field, see https://aka.ms/VSCode-CS-LaunchJson-Console
    "console":"integratedTerminal",
    ```

    The default value for the `console` attribute is `internalConsole`, which aligns to the DEBUG CONSOLE panel. Unfortunately, the DEBUG CONSOLE panel doesn't support console input. The `integratedTerminal` setting aligns to the TERMINAL panel, which supports console input and output.

1. Save your changes to the launch.json file, and then close the file.

1. On the Visual Studio Code **Run** menu, select **Start Debugging**.

1. Switch to the TERMINAL panel.

1. At the "lower bound" prompt, enter **3**

1. At the "upper bound" prompt, enter **11**

1. Notice that the application displays the following message and then pauses:

    ```output
    The average of even numbers between 3 and 11 is 7.
    ```

1. To exit the application, press Enter.

## Throw an exception in the AverageOfEvenNumbers method

The `AverageOfEvenNumbers` method is expecting an upper bound that's greater than the lower bound. A `DivideByZero` error occurs if the lower bound is greater than or equal to the upper bound.

You need to update the `AverageOfEvenNumbers` method to throw an exception when the lower bound is greater than or equal to the upper bound.

1. Take a minute to consider how you want to address the issue.

    One option is to wrap the calculation of `average` inside a `try` code block and `catch` the `DivideByZero` exception when it occurs. You can rethrow the exception and then handle it in the calling code.

    Another option is to evaluate the input parameters before starting the calculations. If `lowerBound` is greater than or equal to `upperBound`, you can throw an exception.

    Evaluating the parameters and throwing an exception before starting the calculations is the better choice.

1. Consider which exception type to throw.

    There are two exception types that align with the issue:

    - `ArgumentOutOfRangeException` - An `ArgumentOutOfRangeException` exception type should only be thrown when the value of an argument is outside the allowable range of values as defined by the invoked method. Although `AverageOfEvenNumbers` doesn't explicitly define an allowable range for `lowerBound` or `upperBound`, the value of `lowerBound` does imply the allowable range for `upperBound`.
    - `InvalidOperationException`: An `InvalidOperationException` exception type should only be thrown when the operating conditions of a method don't support the successful completion of a particular method call. In this case, the operating conditions are established by the input parameters of the method.

    When you have two or more exception types to choose from, select the exception type that fits the issue more closely. In this case, the two exception types are aligned to the issue equally.

    When you have two or more exception types that are aligned to the issue equally, select the most narrowly scoped exception type. The `ArgumentOutOfRangeException` exception type is scoped to the arguments passed to the method. The `InvalidOperationException` exception type is scoped to the operating conditions of the method. In this case, the `ArgumentOutOfRangeException` exception type is more narrowly scoped than the `InvalidOperationException` exception type.

    The `AverageOfEvenNumbers` method should throw an `ArgumentOutOfRangeException` exception.

1. At the top of the `AverageOfEvenNumbers` method, to detect the upper bound issue, update your code as follows:

    ```csharp
    if (lowerBound >= upperBound)
    {

    }
    
    int sum = 0;    
    ```

1. To create and throw an `ArgumentOutOfRangeException` exception, update the `if` code block as follows:

    ```csharp
    if (lowerBound >= upperBound)
    {
        throw new ArgumentOutOfRangeException("upperBound", "ArgumentOutOfRangeException: upper bound must be greater than lower bound.");
    }
    ```

    This code line initializes a new instance of the `ArgumentOutOfRangeException` class with the name of the input parameter that causes the exception and a specified error message.

## Catch the exception in the calling code

Whenever possible, exceptions should be caught at the call stack level where they can be handled. In this sample application, the parameters of the `AverageOfEvenNumbers` method can be managed in the calling method (the top-level statements).

1. Scroll up to the top level statements.

1. To enclose the `AverageOfEvenNumbers` method call and `Console.WriteLine` statement inside a `try` code block, update your code as follows:

    ```csharp
    try
    {
        // Calculate the sum of the even numbers between the bounds
        averageValue = AverageOfEvenNumbers(lowerBound, upperBound);
        
        // Display the result to the user
        Console.WriteLine($"The average of even numbers between {lowerBound} and {upperBound} is {averageValue}.");
    }
    ```

1. To create the associated `catch` clause, enter the following code:

    ```csharp
    catch(ArgumentOutOfRangeException ex)
    {
    
    }
    ```

1. Take a minute to consider how you might handle the exception.

    To handle this exception, your code needs to do the following:

    - Explain the issue to the user.
    - Obtain a new value for `upperBound`.
    - Call `AverageOfEvenNumbers` using the new `upperBound`.
    - Continue to `catch` the exception if the new `upperBound` provided is still less than or equal to `lowerBound`.

    Continuing to `catch` the exception requires a loop. Since you want to call the `AverageOfEvenNumbers` method at least once, a `do` loop should be used.

1. To enclose the `try` and `catch` blocks inside a `do` loop, update your code as follows:

    ```csharp
    do
    {
        try
        {
            // Calculate the sum of the even numbers between the bounds
            averageValue = AverageOfEvenNumbers(lowerBound, upperBound);
    
            // Display the result to the user
            Console.WriteLine($"The average of even numbers between {lowerBound} and {upperBound} is {averageValue}.");
        }
        catch (ArgumentOutOfRangeException ex)
        {

        }
    }
    ```

    A `while` expression is required to define the exit condition of a `do` loop. It's difficult to specify the condition before the contents of the `do` code block are defined. Completing the `catch` code block will help you to define the `while` expression that's needed.

1. To explain the issue to the user and obtain a new `upperBound`, update your `catch` code block as follows:

    ```csharp
    catch (ArgumentOutOfRangeException ex)
    {
        Console.WriteLine("An error has occurred.");
        Console.WriteLine(ex.Message);
        Console.WriteLine($"The upper bound must be greater than {lowerBound}");
        Console.Write($"Enter a new upper bound: ");
        upperBound = int.Parse(Console.ReadLine());
    }
    ```

    The updated `catch` code block describes the issue and requires the user to enter a new upper bound. However, what if the user doesn't have a valid upper bound value to enter? What if the user needs to exit the loop rather than enter a value?

1. To provide the user with an option to exit the loop rather than enter a new upper bound, update your `catch` code block as follows:

    ```csharp
    catch (ArgumentOutOfRangeException ex)
    {
        Console.WriteLine("An error has occurred.");
        Console.WriteLine(ex.Message);
        Console.WriteLine($"The upper bound must be greater than {lowerBound}");
        Console.Write($"Enter a new upper bound (or enter Exit to quit): ");
        string? userResponse = Console.ReadLine();
        if (userResponse.ToLower().Contains("exit"))
        {

        }
        else
        {
            upperBound = int.Parse(userResponse);
        }
    }
    ```

    The updated `catch` code block includes two paths, an "exit" path and a "new upper bound" path.

1. Take a minute to consider the `while` expression required for the `do` loop.

    If the user enters "Exit" at the prompt, the code should exit the loop. If the user enters a new upper bound, the loop should continue. A `while` expression that evaluates a Boolean could be used. For example:

    ```csharp
    while (exit == false);
    ```

    The proposed `while` expression will establish the following behavior:

    - the `do` loop will continue to iterate as long as the Boolean `exit` is equal to `false`.
    - the `do` loop will stop iterating as soon as the Boolean `exit` is equal to `true`.

1. To instantiate a Boolean variable named `exit`, and use `exit` to set the exit condition of the `do` loop, update your code as follows:

    ```csharp
    bool exit = false;

    do
    {
        try
        {
            // Calculate the sum of the even numbers between the bounds
            averageValue = AverageOfEvenNumbers(lowerBound, upperBound);
    
            // Display the result to the user
            Console.WriteLine($"The average of even numbers between {lowerBound} and {upperBound} is {averageValue}.");
    
            exit = true;
        }
        catch (ArgumentOutOfRangeException ex)
        {
            Console.WriteLine("An error has occurred.");
            Console.WriteLine(ex.Message);
            Console.WriteLine($"The upper bound must be greater than {lowerBound}");
            Console.Write($"Enter a new upper bound (or enter Exit to quit): ");
            string? userResponse = Console.ReadLine();
            if (userResponse.ToLower().Contains("exit"))
            {
                exit = true;
            }
            else
            {
                exit = false;
                upperBound = int.Parse(userResponse);
            }
        }    
    } while (exit == false);
    ```

1. Save your updated code.

1. On the **Run** menu, select **Start Debugging**.

1. Switch to the TERMINAL panel.

1. At the "lower bound" prompt, enter **3**

1. At the "upper bound" prompt, enter **3**

1. Notice that the following output is displayed in the TERMINAL panel:

    ```output
    Enter the lower bound: 3
    Enter the upper bound: 3
    An error has occurred.
    ArgumentOutOfRangeException: upper bound must be greater than lower bound. (Parameter 'upperBound')
    The upper bound must be greater than 3
    Enter a new upper bound (or enter Exit to quit):
    ```

1. At the prompt for a new upper bound, enter **11**

1. Notice that the following output is displayed in the TERMINAL panel:

    ```output
    Enter the lower bound: 3
    Enter the upper bound: 3
    An error has occurred.
    ArgumentOutOfRangeException: upper bound must be greater than lower bound. (Parameter 'upperBound')
    The upper bound must be greater than 3
    Enter a new upper bound (or enter Exit to quit): 11
    The average of even numbers between 3 and 11 is 7.
    ```

1. To exit the application, press Enter.

Congratulations! You've successfully thrown, caught, and handled an exception.

## Recap

Here are a few important things to remember from this unit:

- Ensure that your debug environment is configured to support your application requirements.
- Method code should throw an exception when an issue or condition is detected.
- Exceptions should be caught at a level in the call stack where they can be resolved.
