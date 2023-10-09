The C# debugger for Visual Studio Code supports the option to configure a breakpoint that only triggers if a condition is met. This type of breakpoint is called a conditional breakpoint. Conditional breakpoints can be configured directly or by editing an existing breakpoint.

> [!NOTE]
> Visual Studio Code also supports a conditional breakpoint that triggers based on the number of times the breakpoint has been "hit".

Suppose you're debugging an application that processes product information in a multidimensional string array. The array includes thousands of data points. The problem that you're debugging seems to occur for products that are marked as `new`. Your code processes the array inside a `for` loop. You need to set a breakpoint inside the loop, but you only want to pause when products are `new`.

## Use a standard breakpoint to examine a data processing application

1. Replace the contents of your Program.cs file with the following code:

    ```csharp
    int productCount = 2000;
    string[,] products = new string[productCount, 2];
    
    LoadProducts(products, productCount);
    
    for (int i = 0; i < productCount; i++)
    {
        string result;
        result = Process1(products, i);
    
        if (result != "obsolete")
        {
            result = Process2(products, i);
        }
    }
    
    bool pauseCode = true;
    while (pauseCode == true) ;
    ```

    This code uses a method named `LoadProducts` to load data into the `products` array. After the data is loaded, the code iterates through the array and calls methods named `Process1` and `Process2`.

1. To generate data for the simulated processes, add the following method to the end of your Program.cs file:

    ```csharp
    static void LoadProducts(string[,] products, int productCount)
    {
        Random rand = new Random();
    
        for (int i = 0; i < productCount; i++)
        {
            int num1 = rand.Next(1, 10000) + 10000;
            int num2 = rand.Next(1, 101);
            
            string prodID = num1.ToString();
            
            if (num2 < 91)
            {
                products[i, 1] = "existing";
            }
            else if (num2 == 91)
            {
                products[i, 1] = "new";
                prodID = prodID + "-n";
            }
            else
            {
                products[i, 1] = "obsolete";
                prodID = prodID + "-0";
            }
    
            products[i, 0] = prodID;
        }
    }
    ```

    The `LoadProducts` method generates 2000 random product IDs and assigns a value of `existing`, `new`, or `obsolete` to a product description field. There is about a 1% chance that the products are marked `new`.

1. To simulate data processing, add the following methods to the end of your Program.cs file:

    ```csharp
    static string Process1(string[,] products, int item)
    {
        Console.WriteLine($"Process1 message - working on {products[item, 1]} product");
        
        return products[item, 1];
    }
    
    static string Process2(string[,] products, int item)
    {
        Console.WriteLine($"Process2 message - working on product ID #: {products[item, 0]}");
        if (products[item, 1] == "new")
            Process3(products, item);
        
        return "continue";
    }
    
    static void Process3(string[,] products, int item)
    {
        Console.WriteLine($"Process3 message - processing product information for 'new' product");
    }
    ```

    The `Process1` and `Process2` methods display progress messages and return a string.

    Notice that the `Process2` method calls `Process3` if the product is `new`.

1. On the Visual Studio Code **File** menu, select **Save**.

1. Near the top of the Program.cs file, set a breakpoint on the following code line:

    ```csharp
    result = Process1(products, i);
    ```

1. Open the RUN AND DEBUG view, and then select **Start Debugging**.

1. Use **Step Into** to walk through the code for `Process1` and `Process2`.

    Notice the updates to the VARIABLES and CALL STACK sections of the RUN AND DEBUG view.

1. Continue to use **Step Into** to walk through the code until you see that `i` is equal to 3.

    The VARIABLES section of the RUN AND DEBUG view displays the value assigned to `i`.

    Notice that `Process1` and `Process2` display messages to the DEBUG CONSOLE panel. A real application may require user interactions as data is being processed. Some interactions may be dependent on the data being processed.

1. Use the **Stop** button to stop code execution.

## Configure a conditional breakpoint using an expression

A standard breakpoint is great for walking through a data processing application. However, in this case you're interested in `new` products and you don't want to walk through the analysis of each product to find the ones that are `new`. This scenario is a good example of when conditional breakpoints should be used.
  
1. Right-click your existing breakpoint, and then select **Edit Breakpoint**.

1. Enter the following expression:

    ```csharp
    products[i,1] == "new";
    ```

1. Notice that the expression is no longer displayed after you press Enter.

1. To display the expression temporarily, hover the mouse pointer over the breakpoint (red dot).

1. To run your application with the conditional breakpoint configured, select **Start Debugging**.

1. Wait for the application to pause at the conditional breakpoint.
  
1. Notice the value of `i` displayed under the VARIABLES section.

1. On the **Debug controls** toolbar, select **Continue**

1. Notice that the value of `i` has been updated the VARIABLES section.

1. Select **Step Into**.

1. Continue selecting **Step Into** until the `Process1` message is displayed.

1. Notice that `Process1` reports that it's working on a **new** product.

1. Take a moment to consider the advantage that conditional breakpoints offer.

    In this simulated data processing scenario, there is about a 1% chance that a product is `new`. If you're using a standard breakpoint to debug the issue, you'ld need to walk through the analysis of about 100 products to find one of the `new` products that you're interested in.

    Conditional breakpoints can save you lots of time when you're debugging an application.

1. Use the **Stop** button to stop code execution.

Congratulations! You successfully configured a conditional breakpoint.

## Recap

Here are two important things to remember from this unit:

- Use a standard breakpoint to pause an application each time a breakpoint is encountered.
- Use a conditional breakpoint to pause an application when a Boolean expression evaluates to `true`.
