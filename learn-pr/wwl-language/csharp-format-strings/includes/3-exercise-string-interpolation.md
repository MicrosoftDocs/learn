You need to create the code to print a receipt for the customer purchasing shares of an investment product. The shares are purchased automatically at the end of the year based on a series of payroll deductions, so the number of shares purchased usually contains a decimal amount. To print the receipt, you would likely need to combine data of different types, including fractional values, currency, and percentages in precise ways.

### Display the invoice number using string interpolation

1. Select and delete all code lines in the Visual Studio Code Editor.

1. Update your code in the Visual Studio Code Editor as follows:

    ```csharp
    int invoiceNumber = 1201;
    decimal productShares = 25.4568m;
    decimal subtotal = 2750.00m;
    decimal taxPercentage = .15825m;
    decimal total = 3185.19m;

    Console.WriteLine($"Invoice Number: {invoiceNumber}");
    ```

1. On the Visual Studio Code **File** menu, select **Save**.

    The Program.cs file must be saved before building or running the code.

1. In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

    A Terminal panel should open, and should include a command prompt showing that the Terminal is open to your TestProject folder location.

1. At the Terminal command prompt, to run your code, type **dotnet run** and then press Enter.

    > [!NOTE]
    > If you see a message saying "Couldn't find a project to run", ensure that the Terminal command prompt displays the expected TestProject folder location. For example: `C:\Users\someuser\Desktop\csharpprojects\TestProject>`

    You should see the following output:

    ```Output
    Invoice Number: 1201
    ```

    >[!NOTE]
    > You may see several warnings such as `warning CS0219: The variable 'productShares' is assigned but its value is never used` for all the variables that were defined but not yet used in the code.

### Display the product shares with one thousandth of a share (0.001) precision

Since you bill the customers using fractions of shares even though the precision is one ten thousandth (0.0001), you'll only display three digits after the decimal point.

1. Add the following code below the code you typed previously:

    ```csharp
    Console.WriteLine($"   Shares: {productShares:N3} Product");
    ```

1. Save your code file, and then use Visual Studio Code to run your code. 

    When you run the code, you should see the following output:

    ```Output
    Invoice Number: 1201
       Shares: 25.457 Product
    ```

### Display the subtotal that you charge the customer formatted as currency

1. Add the following code below the code you typed in steps 1 and 2:

    ```csharp
    Console.WriteLine($"     Sub Total: {subtotal:C}");
    ```

1. Save your code file, and then use Visual Studio Code to run your code.

    When you run the code, you should see the following output:

    ```Output
    Invoice Number: 1201
    Shares: 25.457 Product
        Sub Total: $2,750.00
    ```

    >[!NOTE]
    > The sample shows the "$" but you may see a different regional currency symbol.

### Display the tax charged on the sale formatted as a percentage

1. Add the following code below the code you typed in steps 1 through 3:

    ```csharp
    Console.WriteLine($"           Tax: {taxPercentage:P2}");
    ```

1. Save your code file, and then use Visual Studio Code to run your code.

    When you run the code, you should see the following output:

    ```Output
    Invoice Number: 1201
    Shares: 25.457 Product
        Sub Total: $2,750.00
            Tax: 15.83 %
    ```

## Finalize the receipt with the total amount due formatted as currency

1. Add the following code below the code you typed in steps 1 through 4:

    ```csharp
    Console.WriteLine($"     Total Billed: {total:C}");
    ```

1. The entire code for the exercise should match as follows:

    ```csharp
    int invoiceNumber = 1201;
    decimal productShares = 25.4568m;
    decimal subtotal = 2750.00m;
    decimal taxPercentage = .15825m;
    decimal total = 3185.19m;

    Console.WriteLine($"Invoice Number: {invoiceNumber}");
    Console.WriteLine($"   Shares: {productShares:N3} Product");
    Console.WriteLine($"     Sub Total: {subtotal:C}");
    Console.WriteLine($"           Tax: {taxPercentage:P2}");
    Console.WriteLine($"     Total Billed: {total:C}");
    ```

1. Save your code file, and then use Visual Studio Code to run your code.

    When you run the code, you should see the following output:

    ```Output
    Invoice Number: 1201
       Shares: 25.457 Product
         Sub Total: $2,750.00
               Tax: 15.83%
         Total Billed: $3,185.19
    ```
