The following code is one possible solution for the challenge from the previous unit.

```csharp
string customerName = "Ms. Barros";

string currentProduct = "Magic Yield";
int currentShares = 2975000;
decimal currentReturn = 0.1275m;
decimal currentProfit = 55000000.0m;

string newProduct = "Glorious Future";
decimal newReturn = 0.13125m;
decimal newProfit = 63000000.0m;

Console.WriteLine($"Dear {customerName},");
Console.WriteLine($"As a customer of our {currentProduct} offering we are excited to tell you about a new financial product that would dramatically increase your return.\n");
Console.WriteLine($"Currently, you own {currentShares:N} shares at a return of {currentReturn:P}.\n");
Console.WriteLine($"Our new product, {newProduct} offers a return of {newReturn:P}.  Given your current volume, your potential profit would be {newProfit:C}.\n");

Console.WriteLine("Here's a quick comparison:\n");

string comparisonMessage = "";

comparisonMessage = currentProduct.PadRight(20);
comparisonMessage += String.Format("{0:P}", currentReturn).PadRight(10);
comparisonMessage += String.Format("{0:C}", currentProfit).PadRight(20);

comparisonMessage += "\n";
comparisonMessage += newProduct.PadRight(20);
comparisonMessage += String.Format("{0:P}", newReturn).PadRight(10);
comparisonMessage += String.Format("{0:C}", newProfit).PadRight(20);

Console.WriteLine(comparisonMessage);
```

This code is merely "*one possible solution*" because a lot depends on how you decided to implement the logic. As long as you used the techniques covered in this module to format strings, pad strings, and so on, and the output matches the challenge output, then you did great!

```Output
Dear Ms. Barros,
As a customer of our Magic Yield offering we are excited to tell you about a new financial product that would dramatically increase your return.

Currently, you own 2,975,000.00 shares at a return of 12.75 %.

Our new product, Glorious Future offers a return of 13.13 %.  Given your current volume, your potential profit would be $63,000,000.00.

Here's a quick comparison:

Magic Yield         12.75 %   $55,000,000.00      
Glorious Future     13.13 %   $63,000,000.00  
```

If you succeeded, congratulations!

### Solution details

You may continue this section for an explanation on how the given solution solves this challenge.

1. Take a minute to review the solution code.

    You can start breaking down the solution and solve first for writing the greeting and opening paragraph to the terminal. The code that follows solves displaying the greeting `Dear Ms. Barros,` using string interpolation. You should now be familiar with the pattern `Console.WriteLine($"Your text {yourVariable}");`:

    ```csharp
    string customerName = "Ms. Barros";
    Console.WriteLine($"Dear {customerName},");
    ```

    The code output is:

    ```output
    Dear Mr, Jones,   
    ```

    Review the sample full solution again. The first half of the solution uses string interpolation to display each part of the first paragraph.

    >[!NOTE]
    >Composite formatting such as `Console.WriteLine("Dear {0},", customerName)` is another possible solution.

1. The second part of the solution displays the comparison table by building a long string step by step using string concatenation, `string.Format()` with composite formatting, format specifiers (percent and currency), and `PadRight()`.

    The following code builds the first line of the table with additions of `Console.WriteLine()` after each step of building the string `comparisonMessage`.

    ```csharp
    string currentProduct = "Magic Yield";
    int currentShares = 2975000;
    decimal currentReturn = 0.1275m;
    decimal currentProfit = 55000000.0m;
    string comparisonMessage = "";
    
    comparisonMessage = currentProduct.PadRight(20);
    Console.WriteLine(comparisonMessage);
    
    comparisonMessage += String.Format("{0:P}", currentReturn).PadRight(10);
    Console.WriteLine(comparisonMessage);
    
    comparisonMessage += String.Format("{0:C}", currentProfit).PadRight(20);
    Console.WriteLine(comparisonMessage);
    ```

    The following sample output  shows how the first line of the comparison table is built in three steps.

    ```output
    Magic Yield
    Magic Yield         12.75%
    Magic Yield         12.75%    $55,000,000.00
    ```

If you had trouble completing this challenge, maybe you should review the previous units before you continue on.
