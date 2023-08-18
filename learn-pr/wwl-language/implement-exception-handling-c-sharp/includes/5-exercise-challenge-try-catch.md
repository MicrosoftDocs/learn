




Code challenges in this module are used to reinforce what you've learned and help you gain some confidence before continuing on.

## Try-Catch challenge

Implement exception handling to satisfy the following challenge parameters:

1. Start with the following application code:

    ```csharp
    try
    {
        Process1();
    }
    catch
    {
        Console.WriteLine("An exception has occurred");
    }
    
    Console.WriteLine("Exit program");
    
    static void Process1()
    {
        WriteMessage();
    }
    
    static void WriteMessage()
    {
        double float1 = 3000.0;
        double float2 = 0.0;
        int number1 = 3000;
        int number2 = 0;
    
        Console.WriteLine(float1 / float2);
        Console.WriteLine(number1 / number2);
    }
    ```

1. Update the `Process1` method to catch the exception that's thrown in the `WriteMessage` method.  

1. The `Process1` method should print the following message to console when the exception is caught:

    ```output
    Exception caught in Process1
    ```

1. Don't change any code outside the `Process1` method.

1. When you run your updated application, it should generate the following output:

    ```output
    ∞
    Exception caught in Process1
    Exit program
    ```

    For the purposes of this challenge, you can ignore the output messages created by the debugger. For example, you can ignore the following messages:

    ```output
    Exception thrown: 'System.DivideByZeroException' in Exceptions101.dll

    The program '[436] Exceptions101.dll' has exited with code 0 (0x0).
    ```
