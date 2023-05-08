

Code challenges in this module are used to reinforce what you've learned and help you gain some confidence before continuing on.

## Create and throw exceptions challenge

In this challenge, you start with a sample application that uses a series of method calls to process data. The top-level statements create an array of user input values and call a method named `Workflow1`. `Workflow1` represents a high-level workflow that loops through the array and passes user input values to a method named `Process1`. `Process1` uses the user input data to calculate a value.

Currently, when `Process1` encounters an issue or error, it returns a string describing the issue rather than throwing an exception. Your challenge is to implement exception handling in the sample application.

Use the following steps to complete the challenge:

1. Use the following code as your starting sample application:

    ```csharp
    string[][] userEnteredValues = new string[][]
    {
                new string[] { "1", "2", "3"},
                new string[] { "1", "two", "3"},
                new string[] { "0", "1", "2"}
    };
    
    string overallStatusMessage = "";
    
    overallStatusMessage = Workflow1(userEnteredValues);
    
    if (overallStatusMessage == "operating procedure complete")
    {
        Console.WriteLine("'Workflow1' completed successfully.");
    }
    else
    {
        Console.WriteLine("An error occurred during 'Workflow1'.");
        Console.WriteLine(overallStatusMessage);
    }
    
    static string Workflow1(string[][] userEnteredValues)
    {
        string operationStatusMessage = "good";
        string processStatusMessage = "";
    
        foreach (string[] userEntries in userEnteredValues)
        {
            processStatusMessage = Process1(userEntries);
    
            if (processStatusMessage == "process complete")
            {
                Console.WriteLine("'Process1' completed successfully.");
                Console.WriteLine();
            }
            else
            {
                Console.WriteLine("'Process1' encountered an issue, process aborted.");
                Console.WriteLine(processStatusMessage);
                Console.WriteLine();
                operationStatusMessage = processStatusMessage;
            }
        }
    
        if (operationStatusMessage == "good")
        {
            operationStatusMessage = "operating procedure complete";
        }
    
        return operationStatusMessage;
    }
    
    static string Process1(String[] userEntries)
    {
        string processStatus = "clean";
        string returnMessage = "";
        int valueEntered;
    
        foreach (string userValue in userEntries)
        {
            bool integerFormat = int.TryParse(userValue, out valueEntered);
    
            if (integerFormat == true)
            {
                if (valueEntered != 0)
                {
                    checked
                    {
                        int calculatedValue = 4 / valueEntered;
                    }
                }
                else
                {
                    returnMessage = "Invalid data. User input values must be non-zero values.";
                    processStatus = "error";
                }
            }
            else
            {
                returnMessage = "Invalid data. User input values must be valid integers.";
                processStatus = "error";
            }
        }
    
        if (processStatus == "clean")
        {
            returnMessage = "process complete";
        }
    
        return returnMessage;
    }
    ```

1. Verify that the sample application prints the following messages to the console:

    ```output
    'Process1' completed successfully.
    
    'Process1' encountered an issue, process aborted.
    Invalid data. User input values must be valid integers.
    
    'Process1' encountered an issue, process aborted.
    Invalid data. User input values must be non-zero values.
    
    An error occurred during 'Workflow1'.
    Invalid data. User input values must be non-zero values.
    ```

1. Update the sample application using the following requirements:

    - All methods must be converted from `static string` methods to `static void` methods.
    - The `Process1` method must throw exceptions for each type of issue encountered.
    - The `Workflow1` method must catch and handle the `FormatException` exceptions.
    - The top-level statements must catch and handle the `DivideByZeroException` exceptions.
    - The `Message` property of the exception must be used to notify the user of the issue.

1. Your completed solution must print the following messages to the console:

    ```output
    'Process1' completed successfully.
    
    'Process1' encountered an issue, process aborted.
    Invalid data. User input values must be valid integers.
    
    An error occurred during 'Workflow1'.
    Invalid data. User input values must be non-zero values.
    ```

Good luck!
