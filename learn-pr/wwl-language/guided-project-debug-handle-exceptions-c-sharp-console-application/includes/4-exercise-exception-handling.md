



In this exercise, you'll develop a `try` code block and `catch` clause in the top-level statements, create and throw exceptions in the `MakeChange` method, and then complete the `catch` code block using an exception object. You complete the following tasks during this exercise:

1. Update top-level statements: Implement a `try-catch` pattern in the top-level statements. The `try` code block will contain the call to `MakeChange`.
1. Update `MakeChange` method: Create and throw exceptions for "Insufficient till" and "Underpayment" issues.
1. Update the `catch` code block to use properties of the thrown exception.
1. Verification test: perform verification tests for the code that you develop in this exercise.

## Add a `try-catch` pattern to the top-level statements

In this task, you'll enclose the call to the `MakeChange` method inside a `try` statement and create the corresponding `catch` clause.

1. Ensure that the Program.cs file is open in the Visual Studio Code Editor.

1. Locate the following code lines:

    ```csharp
    // MakeChange manages the transaction and updates the till 
    string transactionMessage = MakeChange(itemCost, cashTill, paymentTwenties, paymentTens, paymentFives, paymentOnes);

    // Backup Calculation - each transaction adds current "itemCost" to the till
    if (transactionMessage == "transaction succeeded")
    {
        Console.WriteLine($"Transaction successfully completed.");
        registerCheckTillTotal += itemCost;
    }
    else
    {
        Console.WriteLine($"Transaction unsuccessful: {transactionMessage}");
    }
    ```

1. Take a minute to consider the purpose of this code.

    Notice that `MakeChange` returns a string value. The return value is assigned to a variable named `transactionMessage`. If `transactionMessage` is equal to "transaction succeeded", then the cost of the purchased item is added to `registerCheckTillTotal`. The variable `registerCheckTillTotal` is used to verify the till balance calculated by the `MakeChange` method.

1. To enclose the call to the `MakeChange` method in a `try` statement code block, update your code as follows:

    ```csharp
    try
    {
        // MakeChange manages the transaction and updates the till 
        string transactionMessage = MakeChange(itemCost, cashTill, paymentTwenties, paymentTens, paymentFives, paymentOnes);
    }
    ```

1. Add the following `catch` clause after the `try` statement code block:

    ```csharp
    catch
    {
    }
    ```

    You'll finish developing the `catch` clause once you've created and thrown the exceptions.  

## Create and throw exceptions in the `MakeChange` method

In this task, you'll update `MakeChange` to create and throw custom exceptions when a transaction can't be completed.

The `MakeChange` method includes two issues that should result in exceptions:

- **Underpayment issue**: This issue occurs when the customer offers a payment that is less than the item cost. If the customer hasn't offered sufficient payment, `MakeChange` should throw an exception.

- **Insufficient till issue**: This issue occurs when the till doesn't contain the bills required to produce the exact change. If the till can't make exact change, `MakeChange` should throw and exception.

1. Scroll down to the `MakeChange` method.

1. Locate the following code lines:

    ```csharp
    if (changeNeeded < 0)
        transactionMessage = "Not enough money provided.";
    ```

1. Take a minute to consider the issue that this code is addressing.

    If `changeNeeded` is less than zero, the customer has not provided enough money to cover the purchase price of the item they're buying. The purchase price and the money provided by the customer are parameters of the `MakeChange` method. The method is unable to complete the transaction when the customer doesn't provide enough money. In other words, the operation fails.

    There are two exception types that appear to match these conditions:

    - `InvalidOperationException`: An `InvalidOperationException` exception should only be thrown when the operating conditions of a method don't support the successful completion of a particular method call. In this case the operating conditions are established by the parameters supplied to the method.
    - `ArgumentOutOfRangeException` - An `ArgumentOutOfRangeException` exception should only be thrown when the value of an argument is outside the allowable range of values as defined by the invoked method. In this case the money provided must be greater than the cost of the item.

    Either exception type could work, but `InvalidOperationException` is a slightly better match in the context of this application.

1. Update the code as follows:

    ```csharp
    if (changeNeeded < 0)
        throw new InvalidOperationException("InvalidOperationException: Not enough money provided to complete the transaction.");
    ```

1. Scroll down to locate the following code lines:

    ```csharp
    if (changeNeeded > 0)
        transactionMessage = "Can't make change. Do you have anything smaller?";
    ```

1. Take a minute to consider the issue that this code is addressing.

    If `changeNeeded` is greater than zero after the `while` loops that prepare the change, then the till has run out of bills that can be used to make change. The method is unable to complete the transaction when the till lacks the bills required to make change. In other words, the operation fails.

    The `InvalidOperationException` exception should be used to create the exception.

1. Update the code as follows:

    ```csharp
    if (changeNeeded > 0)
        throw new InvalidOperationException("InvalidOperationException: The till is unable to make the correct change.");
    ```

## Complete the `catch` code block

In this task, you'll update the `catch` clause to catch a specific exception type.

1. Scroll up above the `MakeChange` method, and locate the following code:

    ```csharp
    catch
    {
    }    
    ```

1. To catch the exception type thrown in the `MakeChange` method, update the code as follows:

    ```csharp
    catch (InvalidOperationException e)
    {
        Console.WriteLine($"Could not complete transaction: {e.Message}");
    }    
    ```

    The `InvalidOperationException` exception object thrown in `MakeChange` will be caught, but other exception types won't. Since you're not prepared to handle other exception types, it's important to let them be caught lower in the call stack. If you become aware that other exception types are expected within `MakeChange`, you can add additional `catch` clauses.

1. Use the **File** menu to save your updates.

## Convert the MakeChange method from "string" to "void" and access exception properties

In this task, you'll update `MakeChange` to be of type `void`, and then use exception properties to communicate issue details to the user.

1. Scroll to the top of the `MakeChange` method.

1. To convert the `MakeChange` method from type `string` to type `void`, update the code as follows:

    ```csharp
    static void MakeChange(int cost, int[] cashTill, int twenties, int tens = 0, int fives = 0, int ones = 0)
    ```

1. Delete the following variable declaration:

    ```csharp
    string transactionMessage = "";
    ```

1. Scroll to the bottom of the `MakeChange` method.

1. Delete the following code lines:

    ```csharp
    if (transactionMessage == "")
        transactionMessage = "transaction succeeded";

    return transactionMessage;
    ```

1. Scroll up to the top-level statements and locate the `try` code block.

1. Update the `try` code block as follows:

    ```csharp
    try
    {
        // MakeChange manages the transaction and updates the till 
        MakeChange(itemCost, cashTill, paymentTwenties, paymentTens, paymentFives, paymentOnes);

        Console.WriteLine($"Transaction successfully completed.");
        registerCheckTillTotal += itemCost;
    }
    ```

1. Locate and then delete the following code lines:

    ```csharp
    // Backup Calculation - each transaction adds current "itemCost" to the till
    if (transactionMessage == "transaction succeeded")
    {
        Console.WriteLine($"Transaction successfully completed.");
        registerCheckTillTotal += itemCost;
    }
    else
    {
        Console.WriteLine($"Transaction unsuccessful: {transactionMessage}");
    }

    ```

    The `try` and `catch` code blocks are now communicating the transaction "success" and "failure" messages to the user. Since the exception's `Message` property describes the issue, a single `Console.WriteLine()` statement addresses both issues. Your code is easier to read and maintain after these updates.

1. Use the **File** menu to save your updates.

## Check your work

In this task, you'll run your application and verify that your updated code works as intended.

1. Scroll up to find the `while` loop in the top-level statements.

    This loop is used to iterate through the transactions.

1. Locate the following code a few lines before the start of the `while` loop.

    ```csharp
    int transactions = 10;
    
    ```

1. Update the number of transactions to `40` as follows:

    ```csharp
    int transactions = 40;
    
    ```

1. Locate the following code line inside the `while` loop.

    ```csharp
    int itemCost = valueGenerator.Next(2, 20);
    
    ```

1. Update the `itemCost` random number generator as follows:

    ```csharp
    int itemCost = valueGenerator.Next(2, 50);

    ```

    This cost range is a better match for items that customers will be purchasing.

1. Use the **File** menu to save your updates.

1. On the **Run** menu, select **Start Debugging**.

1. Review the output in the TERMINAL panel.

1. Verify that the messages associated with the two exception types are displayed:

    Your transactions report should include the following "Could not make transaction" messages:

    ```output
    Customer is making a $42 purchase
             Using 2 twenty dollar bills
             Using 0 ten dollar bills
             Using 0 five dollar bills
             Using 0 one dollar bills
    Could not make transaction: InvalidOperationException: Not enough money provided to complete the transaction.
    ```

    ```output
    Customer is making a $23 purchase
             Using 2 twenty dollar bills
             Using 0 ten dollar bills
             Using 0 five dollar bills
             Using 1 one dollar bills
    Cashier prepares the following change:
             A five
             A five
             A one
             A one
    Could not make transaction: InvalidOperationException: The till is unable to make change for the cash provided.
    
    ```

Congratulations, you've debugged the cash register application to fix a code logic issue, and you've updated the application to use proper exception handling techniques.

> [!NOTE]
> The reported output shows that the money till is no longer balanced. There are additional logic bugs in the code. A challenge project module is available if you're interested in demonstrating your Visual Studio Code debugging skills!
