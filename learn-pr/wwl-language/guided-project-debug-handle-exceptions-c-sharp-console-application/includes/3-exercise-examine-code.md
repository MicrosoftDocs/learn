



In this exercise, you review and test the code in the Starter project, isolate and fix a logic issue, and then verify that your updated application is working as expected.

You complete the following tasks during this exercise:

1. Code review: review the contents of the Program.cs file.

    The Program.cs includes the following code sections:

    - Top-level statements: the top-level statements simulate a series of transactions using either an array of `testData` or a larger number of randomly generated transactions.
    - LoadTillEachMorning: the `LoadTillEachMorning` method is used to configure the cash register till with a predefined number of bills in each denomination.
    - MakeChange: the `MakeChange` method is used to manage the cash till during purchase transactions.
    - LogTillStatus: the `LogTillStatus` method is used to display the number of bills of each denomination currently in the till.
    - TillAmountSummary: the `TillAmountSummary` method is used display a message showing the amount of cash in the till.

1. Initial testing: verify that `MakeChange` successfully balances the money till when using the `testData` array to simulate transactions.

1. Code debugging: isolate and correct a logic issue that's exposed when using randomly generated data.

1. Verification test: perform a verification test on the code you develop in this exercise.

## Review the contents of the Program.cs file

In this task, you complete a walkthrough of the Starter project code. The Program.cs file contains an application that simulates the conditions for daily transactions. The application calls the `MakeChange` method to manage the money till during each transaction. Other methods are used to initialize the till and generate reporting messages.

1. Ensure that the **GuidedProject** folder is open in Visual Studio Code.

1. In the EXPLORER view, expand the **GuidedProject** and **Starter** folders.

    The **Starter** folder contains the sample application for this Guided project module.

1. Open the Program.cs file in the Visual Studio Code Editor.

1. After a few seconds, notice that a dialog box is displayed asking if you want to load the assets required for building and debugging.

    Visual Studio Code recognizes the C# file extension, `.cs`, and recognizes that your "Starter" project is missing the required assets.

1. To load the required assets, select **Yes**.

1. At the **Select the project to launch** prompt, select the **Starter** project.

    The launch.json file that's created will include a configuration for the Starter project.

1. Take a few minutes to review the top-level statements for this application:

    ```csharp
    /*
    This application manages transactions at a store check-out line. The
    check-out line has a cash register, and the register has a cash till
    that is prepared with a number of bills each morning. The till includes
    bills of four denominations: $1, $5, $10, and $20. The till is used
    to provide the customer with change during the transaction. The item 
    cost is a randomly generated number between 2 and 49. The customer 
    offers payment based on an algorithm that determines a number of bills
    in each denomination. 
    
    Each day, the cash till is loaded at the start of the day. As transactions
    occur, the cash till is managed in a method named MakeChange (customer 
    payments go in and the change returned to the customer comes out). A 
    separate "safety check" calculation that's used to verify the amount of
    money in the till is performed in the "main program". This safety check
    is used to ensure that logic in the MakeChange method is working as 
    expected.
    */
    
    string? readResult = null;
    bool useTestData = true;
    
    Console.Clear();
    
    int[] cashTill = new int[] { 0, 0, 0, 0 };
    int registerCheckTillTotal = 0;
    
    // registerDailyStartingCash: $1 x 50, $5 x 20, $10 x 10, $20 x 5 => ($350 total)
    int[,] registerDailyStartingCash = new int[,] { { 1, 50 }, { 5, 20 }, { 10, 10 }, { 20, 5 } };
    
    int[] testData = new int[] { 6, 10, 17, 20, 31, 36, 40, 41 };
    int testCounter = 0;
    
    LoadTillEachMorning(registerDailyStartingCash, cashTill);
    
    registerCheckTillTotal = registerDailyStartingCash[0, 0] * registerDailyStartingCash[0, 1] + registerDailyStartingCash[1, 0] * registerDailyStartingCash[1, 1] + registerDailyStartingCash[2, 0] * registerDailyStartingCash[2, 1] + registerDailyStartingCash[3, 0] * registerDailyStartingCash[3, 1];
    
    // display the number of bills of each denomination currently in the till
    LogTillStatus(cashTill);
    
    // display a message showing the amount of cash in the till
    Console.WriteLine(TillAmountSummary(cashTill));
    
    // display the expected registerDailyStartingCash total
    Console.WriteLine($"Expected till value: {registerCheckTillTotal}\n\r");
    
    var valueGenerator = new Random((int)DateTime.Now.Ticks);
    
    int transactions = 10;
    
    if (useTestData)
    {
        transactions = testData.Length;
    }
    
    while (transactions > 0)
    {
        transactions -= 1;
        int itemCost = valueGenerator.Next(2, 20);
    
        if (useTestData)
        {
            itemCost = testData[testCounter];
            testCounter += 1;
        }
    
        int paymentOnes = itemCost % 2;                 // value is 1 when itemCost is odd, value is 0 when itemCost is even
        int paymentFives = (itemCost % 10 > 7) ? 1 : 0; // value is 1 when itemCost ends with 8 or 9, otherwise value is 0
        int paymentTens = (itemCost % 20 > 13) ? 1 : 0; // value is 1 when 13 < itemCost < 20 OR 33 < itemCost < 40, otherwise value is 0
        int paymentTwenties = (itemCost < 20) ? 1 : 2;  // value is 1 when itemCost < 20, otherwise value is 2
    
        // display messages describing the current transaction
        Console.WriteLine($"Customer is making a ${itemCost} purchase");
        Console.WriteLine($"\t Using {paymentTwenties} twenty dollar bills");
        Console.WriteLine($"\t Using {paymentTens} ten dollar bills");
        Console.WriteLine($"\t Using {paymentFives} five dollar bills");
        Console.WriteLine($"\t Using {paymentOnes} one dollar bills");
    
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
    
        Console.WriteLine(TillAmountSummary(cashTill));
        Console.WriteLine($"Expected till value: {registerCheckTillTotal}\n\r");
        Console.WriteLine();
    }
    
    Console.WriteLine("Press the Enter key to exit");
    do
    {
        readResult = Console.ReadLine();
    
    } while (readResult == null);
    ```

    The top-level statements code completes the following tasks:

    - Configures the application data and environment variables used to test the `MackChange` method.
    - Calls the `LoadTillEachMorning()`, `LogTillStatus()`, and `TillAmountSummary()` methods to prepare the money till and print status messages to the console.
    - Uses a `while` loop to simulate a series of transactions.
    - Calls the `MackChange` method from inside the code block of the `while` loop.
    - Reports the status of the money till after each transaction.

    > [!NOTE]
    > The top-level statements include a `Console.ReadLine()` statement. The `launch.json` file will need to be updated before debugging.

1. Take a moment to review the `LoadTillEachMorning()` method.

    ```csharp
    static void LoadTillEachMorning(int[,] registerDailyStartingCash, int[] cashTill)
    {
        cashTill[0] = registerDailyStartingCash[0, 1];
        cashTill[1] = registerDailyStartingCash[1, 1];
        cashTill[2] = registerDailyStartingCash[2, 1];
        cashTill[3] = registerDailyStartingCash[3, 1];
    }
    ```

1. Take a couple minutes to review the `MakeChange()` method.

    ```csharp
    static string MakeChange(int cost, int[] cashTill, int twenties, int tens = 0, int fives = 0, int ones = 0)
    {
        string transactionMessage = "";
    
        cashTill[3] += twenties;
        cashTill[2] += tens;
        cashTill[1] += fives;
        cashTill[0] += ones;
    
        int amountPaid = twenties * 20 + tens * 10 + fives * 5 + ones;
        int changeNeeded = amountPaid - cost;
    
        if (changeNeeded < 0)
            transactionMessage = "Not enough money provided.";
    
        Console.WriteLine("Cashier Returns:");
    
        while ((changeNeeded > 19) && (cashTill[3] > 0))
        {
            cashTill[3]--;
            changeNeeded -= 20;
            Console.WriteLine("\t A twenty");
        }
    
        while ((changeNeeded > 9) && (cashTill[2] > 0))
        {
            cashTill[2]--;
            changeNeeded -= 10;
            Console.WriteLine("\t A ten");
        }
    
        while ((changeNeeded > 4) && (cashTill[1] > 0))
        {
            cashTill[2]--;
            changeNeeded -= 5;
            Console.WriteLine("\t A five");
        }
    
        while ((changeNeeded > 0) && (cashTill[0] > 0))
        {
            cashTill[0]--;
            changeNeeded--;
            Console.WriteLine("\t A one");
        }
    
        if (changeNeeded > 0)
            transactionMessage = "Can't make change. Do you have anything smaller?";
    
        if (transactionMessage == "")
            transactionMessage = "transaction succeeded";
    
        return transactionMessage;
    }
    ```

    The `MakeChange` method manages the money till during each purchase transaction. The transaction process relies on the following resources and conditions:

    - **Cash transaction**: The `MakeChange` method accepts a cash payment from the customer and then determines how many bills of each denomination must be returned to the customer in change. `MakeChange` must first ensure that the customer has provided enough money to cover the transaction. If the payment is sufficient, the "make change" process begins with the largest bill denomination and works down to the smallest denomination. At each stage, `MakeChange` ensures that the current denomination is less than the change owed. `MakeChange` also ensures that a bill of the required denomination is available in the till before adding it to the change returned to the customer.

    - **Input parameters**: The `MakeChange` method uses the following input parameters:

        - An integer representing the cost of the item being purchased: `itemCost`
        - An integer array containing the number of bills in the till for each denomination: `cashTill`
        - The payment offered by the customer, where the number of bills for each denomination is specified separately: `paymentTwenties`, `paymentTens`, `paymentFives`, `paymentOnes`

    - **Cash available in till**: The bills offered as payment by the customer must be included in the bills of each denomination that are available for making change.

    - **Change owed to customer**: The change owed to the customer is calculated using the amount paid by the customer minus the cost of the item.

    - **Underpayment**: If the customer hasn't provided sufficient payment, `MakeChange` returns a descriptive message, and the transaction is canceled.

    - **Insufficient till**: If the till is unable to make exact change, `MakeChange` returns a descriptive message, and the transaction is canceled.

1. Take a moment to review the `LogTillStatus()` method.

    ```csharp
    static void LogTillStatus(int[] cashTill)
    {
        Console.WriteLine("The till currently has:");
        Console.WriteLine($"{cashTill[3] * 20} in twenties");
        Console.WriteLine($"{cashTill[2] * 10} in tens");
        Console.WriteLine($"{cashTill[1] * 5} in fives");
        Console.WriteLine($"{cashTill[0]} in ones");
        Console.WriteLine();
    }
    ```

    The `LogTillStatus` method uses the `cashTill` array to report the current contents of the till.

1. Take a moment to review the `TillAmountSummary()` method.

    ```csharp
    static string TillAmountSummary(int[] cashTill)
    {
        return $"The till has {cashTill[3] * 20 + cashTill[2] * 10 + cashTill[1] * 5 + cashTill[0]} dollars";
    
    }
    ```

    The `TillAmountSummary` method uses the `cashTill` array to calculate of the current cash balance that's available in till.

That completes your review of the existing code project.

## Verify that `MakeChange` successfully manages the money when using the `testData` array

In this task, you simulate transactions using the `testData` array and verify that `MakeChange` successfully balances the money till.

1. On the Visual Studio Code **Run** menu, select **Start Debugging**.

1. Notice that an `IOException` error occurs.

    The DEBUG CONSOLE doesn't support `Console.Clear()` or `Console.ReadLine()` methods. You need to update the launch.json file before debugging.

1. On the **Debug toolbar**, select **Stop**.

1. Use the EXPLORER view to open the launch.json file.

1. In the launch.json file, update the `console` attribute as follows:

    ```json
    // For more information about the 'console' field, see https://aka.ms/VSCode-CS-LaunchJson-Console
    "console":"integratedTerminal",
    ```

    The default value for the `console` attribute is `internalConsole`, which aligns to the DEBUG CONSOLE panel. Unfortunately, the DEBUG CONSOLE panel doesn't support some console methods. The `integratedTerminal` setting aligns to the TERMINAL panel, which supports console input and output.

1. Save your changes to the launch.json file.

1. On the Visual Studio Code **Run** menu, select **Start Debugging**.

1. Review the output generated by the application in the TERMINAL panel.

    Switch from the DEBUG CONSOLE panel to the TERMINAL panel to review the output.

1. Notice that `MakeChange` successfully balances the till when using the `testData` array to simulate transactions.

    You should see the following lines listed at bottom of the reported output:

    ```output
    The till has 551 dollars
    Expected till value: 551
    
    
    Press the Enter key to exit
    ```

    Notice that the reported and expected till values are both 551.

1. To exit out of the application, press Enter.

## Identify and fix logic issues

In this task, you use simulated transactions to expose a code logic issue, and then use the Visual Studio Code debugger tools to isolate and fix the issue.

1. To run the code using randomly generated transactions, change the value assigned to `useTestData` to `false`.

    You can find the `useTestData` variable near the top of the top-level statements.

1. Save the Program.cs file, and then run the application in the debugger.

1. Review the output in the TERMINAL panel.

1. Notice the discrepancy in the till balance.

    The final till balance calculated by `MakeChange` and the balance maintained in the top-level statements are reported at the bottom of the output. For example:

    ```output
    Transaction successfully completed.
    The till has 379 dollars
    Expected till value: 434
    
    
    Press the Enter key to exit
    ```

    > [!NOTE]
    > The application randomly generates the cost of purchase items. Therefore, the till values reported in your output are different.

1. To exit the application, press Enter.

1. Close the TERMINAL panel.

## Debug the code

In this task, you use the Visual Studio Code debugger tools to isolate and then fix the logic issue.

1. Near the end of the top-level statements, locate the following code line:

    ```csharp
    Console.WriteLine();
    ```

1. Set a breakpoint on selected code line.

1. On the Visual Studio Code **Run** menu, select **Start Debugging**.

1. Notice that code execution pauses on the breakpoint.

1. On the **Debug controls** toolbar, select **Step Into**.

1. Review the output in the TERMINAL panel.

1. If the reported and expected till values are equal, select **Continue** on the **Debug controls** toolbar.

1. Repeat the previous step until you see a discrepancy between the reported and expected till values.

1. Once you see a discrepancy, take a minute to examine the details of the transaction.

1. Notice that the reported cash received and change returned are correct, but the till is short by five dollars.

    This shortage suggests that the `cashTill` array is being updated incorrectly, even though the reporting is correct.

1. Stop the debug session and close the TERMINAL panel.

1. Scroll to the bottom of the `MakeChange` method.

    The `while` statements used to "make change" are located at the end of the `MakeChange` method.

1. Review the `while` statement code blocks that are used to make change.

    Since the till is off by five dollars, the issue is likely to be in the `while` code block that's used to return five dollar bills.

1. Notice the following code:

    ```csharp
    while ((changeNeeded > 4) && (cashTill[1] > 0))
    {
        cashTill[2]--;
        changeNeeded -= 5;
        Console.WriteLine("\t A five");
    }    
    ```

    The `cashTill[]` array is used to store the number of bills of each denomination that are currently available. Array element `1` is used to manage the number of five dollar bills in the till. The expression in the `while` statement refers to `cashTill[1]` correctly. However, the statement inside the code block decrements `cashTill[2]` rather than `cashTill[1]`. Specifying an index value of `2` means that a ten dollar bill is being removed from the till rather than a five dollar bill.

1. Update the `while` code block as follows:

    ```csharp
    while ((changeNeeded > 4) && (cashTill[1] > 0))
    {
        cashTill[1]--;
        changeNeeded -= 5;
        Console.WriteLine("\t A five");
    }    
    ```

1. Save the Program.cs file.

## Check your work

In this task, you run your application and verify that your updated code works as intended.

1. On the Visual Studio Code **Run** menu, select **Remove All Breakpoints**.

1. On the **Run** menu, select **Start Debugging**.

1. Review the output in the TERMINAL panel.

1. Verify that the reported till value is equal to the expected till value:

    The final till balance calculated by `MakeChange` and the balance maintained in the top-level statements are reported at the bottom of the output. For example:

    ```output
    Transaction successfully completed.
    The till has 452 dollars
    Expected till value: 452
    
    
    Press the Enter key to exit
    ```

    The application randomly generates the cost of purchase items. Therefore, the till values reported in your output are different. As long as the two values are equal, you've succeeded in fixing the logic issue.
