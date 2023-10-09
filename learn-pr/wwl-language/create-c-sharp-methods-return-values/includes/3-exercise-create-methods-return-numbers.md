You may often need to return numbers from methods and use the results for other tasks. In this brief exercise, you'll practice returning `int` and `double` data types, and capturing the return values.

## Create a method that returns an integer
    
Suppose you're visiting Vietnam and want to create a brief program that converts currency. You can assume the current exchange rate is `1 USD = 23500 VND`. In this task, you'll write a method that converts USD to VND.

1. In the Visual Studio Code Editor, delete any existing code from the previous exercises.

1. Enter the following code into the Visual Studio Code Editor:

    ```c#
    double usd = 23.73;
    int vnd = UsdToVnd(usd);

    Console.WriteLine($"${usd} USD = ${vnd} VND");

    int UsdToVnd(double usd) 
    {

    }
    ```

    In this step, you initialize two variables to store the USD and VND values. Notice that `vnd` is initialized to the result of the method `UsdToVnd`. The method returns an integer value since VND is typically represented in whole numbers. To display the results of the currency conversion, `Console.WriteLine` is used.

1. Next, you'll add code to perform the conversion. Update the `UsdToVnd` method with the following code:

    ```c#
    int UsdToVnd(double usd) 
    {
        int rate = 23500;
        return (int) (rate * usd);
    }
    ```

    If you omit the cast from the return result, you'll see the following error:

    ```output
    Cannot implicitly convert type 'double' to 'int'.
    ```

    This happens because the compiler attempts to cast the value returned to match the data type specified in the method signature. However, implicit casting is only available when there's no data loss occurring as a result of the conversion. The return value must always match the data type specified in the method signature, so in this case, you must cast the result.

1. If necessary, open Visual Studio Code's Integrated Terminal panel.

1. At the Terminal command prompt, enter **dotnet run** and compare your output with the following:

    ```
    $23.73 USD = $557655 VND
    ```

    If your code displays unexpected results, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.

### Create a method that returns a double

Next, you'll create a method to convert VND back to USD.

1. Create a new blank code line at the end of the `UsdToVnd` method.

1. Enter the following code:

    ```c#
    double VndToUsd(int vnd) 
    {

    }
    ```

1. Update the `VndToUsd` method with the following code:

    ```c#
    double VndToUsd(int vnd) 
    {
        double rate = 23500;
        return vnd / rate;
    }
    ```

    In this case, you need `rate` to be a `double` or else the compiler uses integer division and return a truncated `int` value. USD needs to be represented by a decimal number. 
    
    If you set `rate` to an `int` instead of `double`, you'll notice that the compiler doesn't present you with any errors. This happens because the value of `vnd / rate` is implicitly casted to the `double` data type specified in the method signature. When creating methods that return numeric values, it's important to consider the data types in the operations your method performs.

1. Locate the call to `Console.WriteLine` and append a new blank code line. Then enter the following code to call our new method and print the output:

    ```c#
    Console.WriteLine($"${vnd} VND = ${VndToUsd(vnd)} USD");
    ```

## Check your work

In this task, you'll run our application from the Integrated Terminal and verify your code is working correctly. Let's get started.

1. Compare your code to the following to ensure it's correct:

    ```c#
    double usd = 23.73;
    int vnd = UsdToVnd(usd);

    Console.WriteLine($"${usd} USD = ${vnd} VND");
    Console.WriteLine($"${vnd} VND = ${VndToUsd(vnd)} USD");

    int UsdToVnd(double usd) 
    {
        int rate = 23500;
        return (int) (rate * usd);
    }

    double VndToUsd(int vnd) 
    {
        int rate = 23500;
        return vnd / rate;
    }
    ```

1. Save your work using <kbd>Ctrl</kbd> + <kbd>S</kbd> or using the Visual Studio Code File menu.

1. If necessary, open Visual Studio Code's Integrated Terminal panel.

    In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

1. At the Terminal command prompt, enter **dotnet run**

1. Verify that your code produces the following output:

    ```Output
    $23.73 USD = $557655 VND
    $557655 VND = $23.73 USD
    ```

    If your code displays different results, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.