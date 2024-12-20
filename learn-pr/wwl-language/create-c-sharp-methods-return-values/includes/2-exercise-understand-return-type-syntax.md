Not only can methods perform operations, they can return a value as well. Methods can return a value by including the return type in the method signature. Methods can return any data type, or they can return nothing at all. The return type must always be specified before the method name. 

Using `void` as the return type means the method only performs operations and doesn't return a value. For example:

```c#
void PrintMessage(string message)
```

When a data type (such as `int`, `string`, `bool`, etc.) is used, the method performs operations and then returns the specified type upon completion. Inside the method, the keyword `return` is used to return the result. In `void` methods, you can also use the `return` keyword to terminate the method.

In this exercise, you'll learn more about using the `return` keyword.

## Prepare your coding environment

This module includes hands-on activities that guide you through the process of building and running demonstration code. You're encouraged to complete these activities using Visual Studio Code as your development environment. Using Visual Studio Code for these activities will help you to become more comfortable writing and running code in a developer environment that's used by professionals worldwide.

1. Open Visual Studio Code.

    You can use the Windows Start menu (or equivalent resource for another OS) to open Visual Studio Code.

1. On the Visual Studio Code **File** menu, select **Open Folder**.

1. In the **Open Folder** dialog, navigate to the Windows Desktop folder.

    If you have different folder location where you keep code projects, you can use that folder location instead. For this training, the important thing is to have a location that’s easy locate and remember.

1. In the **Open Folder** dialog, select **Select Folder**.

    If you see a security dialog asking if you trust the authors, select **Yes**.

1. On the Visual Studio Code **Terminal** menu, select **New Terminal**.

    Notice that a command prompt in the Terminal panel displays the folder path for the current folder. For example:  

    ```dos
    C:\Users\someuser\Desktop>
    ```

    > [!NOTE]
    > If working on your own PC, rather than in a sandbox or hosted environment, and you have completed other Microsoft Learn modules in this C# series, you may have already created a project folder for code samples. If that's the case, you can skip over the next step, which is used to create a console app in the TestProject folder.

1. At the Terminal command prompt, to create a new console application in a specified folder, type **dotnet new console -o ./CsharpProjects/TestProject** and then press Enter.

    This .NET CLI command uses a .NET program template to create a new C# console application project in the specified folder location. The command creates the CsharpProjects and TestProject folders for you, and uses TestProject as the name of the `.csproj` file.

1. In the EXPLORER panel, expand the **CsharpProjects** folder.

    You should see the TestProject folder and two files, a C# program file named Program.cs and a C# project file named TestProject.csproj.

1. In the EXPLORER panel, to view your code file in the Editor panel, select **Program.cs**.

1. Delete the existing code lines.

    You'll be using this C# console project to create, build, and run code samples during this module.

1. Close the Terminal panel.

### Use methods to calculate the total purchase price

The Contoso Shopping Center is having a super sale! Many items have discounted price. You're given a list of item prices and a list of corresponding discounts. The discounts are represented by percentages, for example 50% = 0.5. If a customer spends more than $30.00, they recieve $5.00 of their total purchase. In this task, you'll write code to calculate the customer's total. Let's get started!

1. Enter the following code into the Visual Studio Code Editor:

    ```c#
    double total = 0;
    double minimumSpend = 30.00;

    double[] items = {15.97, 3.50, 12.25, 22.99, 10.98};
    double[] discounts = {0.30, 0.00, 0.10, 0.20, 0.50};

    Console.WriteLine($"Total: ${total}");

    void GetDiscountedPrice(int itemIndex)
    {
        // Calculate the discounted price of the item
    }

    void TotalMeetsMinimum()
    {
        // Check if the total meets the minimum
    }

    void FormatDecimal(double input)
    {
        // Format the double so only 2 decimal places are displayed
    }
    ```

    In this step, you set up the variables your program will need and create placeholder methods that will be used to perform the tasks to get the total purchase price.

1. Change the `GetDiscountedPrice` method to return a `double` by updating your code to the following:

    ```c#
    double GetDiscountedPrice(int itemIndex)
    {
        // Calculate the discounted price of the item
    }
    ```

    Notice that this method yields the compilation error: `not all code paths return a value`. A method with a return type must always return a value of that type. Let's fix this error.

1. Update the `GetDiscountedPrice` method with the following code:

    ```c#
    double GetDiscountedPrice(int itemIndex)
    {
        double result = items[itemIndex] * (1 - discounts[itemIndex]);
        return result;
    }
    ```

    To return a value from a method, add a value or expression after the `return` keyword. The value returned must match the data type specified in the method signature.

    In this code, you calculate the discounted price of the item at `itemIndex` and then return the result. However, the `return` keyword isn't limited to returning variables or literal values. Let's skip the variable and return the expression instead.

1. Update the `GetDiscountedPrice` method with the following code:

    ```c#
    double GetDiscountedPrice(int itemIndex)
    {
        return items[itemIndex] * (1 - discounts[itemIndex]);
    }
    ```

    Since the code `items[itemIndex] * (1 - discounts[itemIndex])` evaluates to a `double` value, this `return` statement is valid.

1. Change the `TotalMeetsMinimum` method to return a `bool` by updating your code to the following:

    ```c#
    bool TotalMeetsMinimum()
    {
        return total >= minimumSpend;
    }
    ```

    In this code, you return the result of the comparison that evaluates to a `bool`. Returning expressions from methods is a great way to make your code organized and improve readability.

1. Change the `FormatDecimal` method to return a `string` by updating your code to the following:

    ```c#
    string FormatDecimal(double input)
    {
        return input.ToString().Substring(0, 5);
    }
    ```

    Notice that you can call other methods in a `return` statement expression. When this method is called, the execution control first evaluates `input.ToString`, then evaluates and returns the substring value. The flexibility of the `return` keyword allows you to create short lines of code packed with functionality.

### Capture the return values

Now that your methods return values, you can capture these values and use them in the rest of your code. Using results returned from methods is a great way to keep your code structured and easy to read. Let's practice!

1. Locate the following line of code in your program: 
    
    `Console.WriteLine($"Total: ${total}");`

1. Update your code to the following:

    ```c# 
    for (int i = 0; i < items.Length; i++)
    {
        total += GetDiscountedPrice(i);
    }

    Console.WriteLine($"Total: ${total}");
    ```

    In this code, you use the `for` loop to get the sum of all of the discounted item prices. Since `GetDiscountedPrice` returns a `double` value, you can use the method to initialize or operate on any other `double` variables. In this case, you use the result of `GetDiscountedPrice` to increment `total`.

1. Enter a new blank code line before `Console.WriteLine`, then add the following code:

    ```c#
    if (TotalMeetsMinimum())
    {
        total -= 5.00;
    }
    ```

    Since `TotalMeetsMinimum` returns a `bool` value, you can call the method inside of the `if` condition. You can also use this method in a ternary expression as follows:

    `total -= TotalMeetsMinimum() ? 5.00 : 0.00;`

1. Use `FormatDecimal` to format the displayed purchase price by updating your code as follows:

    ```c#
    Console.WriteLine($"Total: ${FormatDecimal(total)}");
    ```

    Similar to the previous code, `FormatDecimal` returns a `string` value. So you can call the method in place of using a string variable or literal. In this code, execution control is passed to `FormatDecimal` to evaluate the result before evaluating `Console.WriteLine`. 

## Check your work

In this task, you'll run your application from the Integrated Terminal and verify your code is working correctly. Let's get started.

1. Compare your code with the following to ensure it's correct:

    ```c#
    double total = 0;
    double minimumSpend = 30.00;

    double[] items = {15.97, 3.50, 12.25, 22.99, 10.98};
    double[] discounts = {0.30, 0.00, 0.10, 0.20, 0.50};

    for (int i = 0; i < items.Length; i++)
    {
        total += GetDiscountedPrice(i);
    }

    total -= TotalMeetsMinimum() ? 5.00 : 0.00;

    Console.WriteLine($"Total: ${FormatDecimal(total)}");

    double GetDiscountedPrice(int itemIndex)
    {
        return items[itemIndex] * (1 - discounts[itemIndex]);
    }

    bool TotalMeetsMinimum()
    {
        return total >= minimumSpend;
    }

    string FormatDecimal(double input)
    {
        return input.ToString().Substring(0, 5);
    }
    ```

1. Save your work using <kbd>Ctrl</kbd> + <kbd>S</kbd> or using the Visual Studio Code File menu.

1. If necessary, open Visual Studio Code's Integrated Terminal panel.

    In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

1. At the Terminal command prompt, enter **dotnet run**

1. Verify that your code produces the following output:

    ```Output
    Total: $44.58
    ```

    If your code displays different results, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.

## Recap

Here's what you've learned about the `return` keyword so far:

- Methods can return a value by specifying the return data type, or `void` for no return value
- The `return` keyword can be used with variables, literals, and expressions
- The value returned from a method must match the specified return type
- Data returned from methods can be captured and used by the caller of the method