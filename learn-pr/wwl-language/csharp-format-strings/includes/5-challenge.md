



To the sales and marketing company's newest investment products, you send thousands of personalized letters to the company's existing clients. Your job is to write C# code to merge personalized information about the customer. The letter contains information like their existing portfolio and compares their current returns to projected returns if they were to invest in using the new products.

The writers have decided on the following example marketing message. Here's the desired output (using fictitious customer account data).

```Output
Dear Ms. Barros,
As a customer of our Magic Yield offering we are excited to tell you about a new financial product that would dramatically increase your return.

Currently, you own 2,975,000.00 shares at a return of 12.75 %.

Our new product, Glorious Future offers a return of 13.13 %.  Given your current volume, your potential profit would be ¤63,000,000.00.

Here's a quick comparison:

Magic Yield         12.75 %   $55,000,000.00      
Glorious Future     13.13 %   $63,000,000.00  
```

Use your new found knowledge of string formatting to build an application that can merge and format the appropriate content given the previous example output. Pay particular attention to the white space and make sure you accurately represent this exact format using C#.

1. Select and delete all code lines in the Visual Studio Code Editor.

1. In Visual Studio Code, add the following code to get the data for the challenge:

    ```csharp
    string customerName = "Ms. Barros";

    string currentProduct = "Magic Yield";
    int currentShares = 2975000;
    decimal currentReturn = 0.1275m;
    decimal currentProfit = 55000000.0m;

    string newProduct = "Glorious Future";
    decimal newReturn = 0.13125m;
    decimal newProfit = 63000000.0m;

    // Your logic here

    Console.WriteLine("Here's a quick comparison:\n");

    string comparisonMessage = "";

    // Your logic here

    Console.WriteLine(comparisonMessage);
    ```

1. Use the Visual Studio Code Editor to generate the message while using the given variables and code.

    You may not delete any of the existing code except for the comments.

1. Ensure your code outputs the following message:

    ```Output
    Dear Ms. Barros,
    As a customer of our Magic Yield offering we are excited to tell you about a new financial product that would dramatically increase your return.
    
    Currently, you own 2,975,000.00 shares at a return of 12.75 %.
    
    Our new product, Glorious Future offers a return of 13.13 %.  Given your current volume, your potential profit would be ¤63,000,000.00.
    
    Here's a quick comparison:
    
    Magic Yield         12.75 %   $55,000,000.00      
    Glorious Future     13.13 %   $63,000,000.00  
    ```

Good luck!

Whether you get stuck and need to peek at the solution or you finish successfully, continue on to view a solution to this challenge.
