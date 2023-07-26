





Code challenges in this training are used to reinforce what you've learned and help you gain some confidence before continuing on.

## Variable state challenge

In this challenge, you're provided with a code sample that isn't producing the expected result. You need to use breakpoints and the VARIABLES section of the RUN AND DEBUG view to help you figure out the issues.

1. Enter the following code sample into the Visual Studio Code Editor:

    ```csharp
    /*  
    This code instantiates a value and then calls the ChangeValue method
    to update the value. The code then prints the updated value to the console.
    */
    int x = 5;

    ChangeValue(x);

    Console.WriteLine(x);
    
    void ChangeValue(int value) 
    {
        value = 10;
    }
    ```

1. The code comment describes the desired functionality.

1. Run the application in the Visual Studio Code debugger.

1. Check the output produced.

1. Use the C# debugger tools to isolate the issue.

1. Consider how you might update the code to match the desired functionality.
