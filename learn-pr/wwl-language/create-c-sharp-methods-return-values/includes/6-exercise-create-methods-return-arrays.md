When developing applications, you'll often need to build and modify sets of data. Methods are useful for performing operations on data, and they're especially powerful tools for building the data sets themselves. Developing methods to create arrays representing your data set helps to keep your code reusable, organized, and simplified. In this exercise, you'll practice returning arrays from methods.

### Find coins to make change

Suppose you have several coins of different values. You're tasked to find two coins whose sum is equal to a target value. In this exercise, the coins available are represented in an integer array. You'll need to return the indices of the two coins in a new array. Let's get started!

1. In the Visual Studio Code Editor, delete any existing code from the previous exercises.

1. Enter the following code into the Visual Studio Code Editor:

    ```c#
    int[] TwoCoins(int[] coins, int target) 
    {
        return  new int[0];
    }
    ```

    In the case where no two coins are found, your method returns an empty array. Take a moment to consider the syntax of the returned result. While you can create a variable to store a new `int[]` array and return the variable, the `return` statement allows you to simultaneously create and return values.

1. There are many approaches to solve this problem. Take a moment to consider how you might search for two numbers in an array whose sum is equal to a given value.

    In this exercise, the following approach will be used:

    1. Choose one number from the array
    1. Check other numbers one at a time to see if they add up to the target value
    1. Return the result as soon as a match is found

1. To check each number in the array, update the `TwoCoins` method with the following code:

    ```c#
    int[] TwoCoins(int[] coins, int target) 
    {
        for (int curr = 0; curr < coins.Length; curr++) 
        {
            for (int next = curr + 1; next < coins.Length; next++) 
            {
                
            }
        }

        return  new int[0];
    }
    ```

    Here, `curr` represents one fixed coin index and `next` represents the subsequent coin indices.  You'll try adding each `next` coin with the fixed `curr` coin to see if they equal the target value.

1. Next, add logic to check the sum of the two coins for the target value. To do so, update the previous `for` loops with the following code:

    ```c#
    for (int curr = 0; curr < coins.Length; curr++) 
    {
        for (int next = curr + 1; next < coins.Length; next++) 
        {
            if (coins[curr] + coins[next] == target) 
            {
                return new int[]{curr, next};
            }

        }
    }
    ```

    In this code, you're checking if the sum of the values at `curr` and `next` in the array are equal to the target value. If the sum is equal, you create an array to store those indices and return it. If they aren't equal, you can ignore them and keep checking.

### Test your solution

In this step, you'll test your code to ensure it's running correctly. First you'll initialize some variables to store the input data, then you'll call the method and print the results.

1. Create a new blank code line above the `TwoCoins` method signature. Then enter the following code:

    ```c# 
    int target = 60;
    int[] coins = new int[] {5, 5, 50, 25, 25, 10, 5};
    int[] result = TwoCoins(coins, target);
    ```

    Recall that the `TwoCoins` method returns an empty array if no change is found. You'll need to check the array size before attempting to print the `result` array.

1. Enter a new blank code line. Then enter the following code:

    ```c#
    if (result.Length == 0) 
    {
        Console.WriteLine("No two coins make change");
    } 
    else 
    {
        Console.WriteLine($"Change found at positions {result[0]} and {result[1]}");
    }
    ```

1. If necessary, open Visual Studio Code's Integrated Terminal panel.

1. At the Terminal command prompt, enter **dotnet run**. Compare your output with the following:

    ```
    Change found at positions 2 and 5
    ```

    If your code displays unexpected results, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.

### Find multiple pairs of coins that make change

In this step, you'll extend the `TwoCoins` method to find more pairs of coins whose sum is equal to the target value. For this exercise, you'll find a maximum of five pairs. This means the return type will be a 2D array instead of a 1D array, and you'll need to modify the way your code returns the results. Let's get started!

1. Change the return type in the method signature from `int[]` to `int[,]` by updating your code to the following:

    ```c#
    int[,] TwoCoins(int[] coins, int target)
    ```

    Next, you'll create an `int[,]` array to store and return your results, and a counter variable to keep track of the number of pairs added to the array. 

1. Update the `TwoCoins` method with the following code:

    ```c#
    int[,] TwoCoins(int[] coins, int target) 
    {
        int[,] result = {{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1}};
        int count = 0;
    ```

    Notice that you initialized the result array elements to `-1`. This will help you later when you want to print the pairs that were found. 

    Next, you'll use the `result` array to store each found pair instead of returning the first match.

1. Update the `TwoCoins` method with the following code:

    ```c#
    int[,] TwoCoins(int[] coins, int target) 
    {
        int[,] result = {{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1}};
        int count = 0;

        for (int curr = 0; curr < coins.Length; curr++) 
        {
            for (int next = curr + 1; next < coins.Length; next++) 
            {
                if (coins[curr] + coins[next] == target) 
                {
                    result[count, 0] = curr;
                    result[count, 1] = next;
                    count++;
                }

            }
        }
    ```

    Notice that `count` is incremented every time a pair is added to the array. This can cause an index out of bounds error if there are more than five pairs found. To prevent this error, you can add code to check the value of `count` and return the result the `result` array is filled.

1. Update the logic in the `TwoCoins` method with the following code:

    ```c#
    for (int next = curr + 1; next < coins.Length; next++) 
    {
        if (coins[curr] + coins[next] == target) 
        {
            result[count, 0] = curr;
            result[count, 1] = next;
            count++;
        }
        if (count == result.GetLength(0)) 
        {
            return result;
        }
    }
    ```

    Lastly, you'll need to update the final return statement to return the correct result if no matches are found at all, or if fewer than five matches have been found.

1. Navigate to the `return` statement in the `TwoCoins` method. Modify the `return` statement to match the following code:

    ```c#
    if (count == 0) 
    {
        return new int[0,0];
    }
    return result;
    ```

    You can also shorten this return code using the ternary operator like so:

    ```c#
    return (count == 0) ? new int[0,0] : result;
    ```

    > [!IMPORTANT]
    > The flexibility of the `return` keyword allows you to return the value of an expression, as long as the result matches the specified return type of the method.

1. At this point, the `TwoCoins` method should match the following code:

    ```c#
    int[,] TwoCoins(int[] coins, int target) 
    {
        int[,] result = {{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1}};
        int count = 0;

        for (int curr = 0; curr < coins.Length; curr++) 
        {
            for (int next = curr + 1; next < coins.Length; next++) 
            {
                if (coins[curr] + coins[next] == target) 
                {
                    result[count, 0] = curr;
                    result[count, 1] = next;
                    count++;
                }
                if (count == result.GetLength(0)) 
                {
                    return result;
                }
            }
        }
        return (count == 0) ? new int[0,0] : result;
    }
    ```

### Capture the new return array

Now that your method is returning a 2D array, you can update your code to retrieve and print the results. Since the result array elements were initialized to `-1`, you can add a check to print all pairs until a `-1` value is found.

1. Navigate to the beginning of your program where the `target` variable is defined. Modify your code as follows:

    ```c# 
    int target = 30;
    int[] coins = new int[] {5, 5, 50, 25, 25, 10, 5};
    int[,] result = TwoCoins(coins, target);
    ```

    Next, you'll update the call to `Console.WriteLine` to correctly print the `result` values.

1. Navigate to the `Console.WriteLine` call. Update your code to match the following:

    ```c#
    if (result.Length == 0) 
    {
        Console.WriteLine("No two coins make change");
    } 
    else 
    {
        Console.WriteLine("Change found at positions:");
        for (int i = 0; i < result.GetLength(0); i++) 
        {
            if (result[i,0] == -1) 
            {
                break;
            }
            Console.WriteLine($"{result[i,0]},{result[i,1]}");
        }
    }
    ```

    Here, you keep the check for an empty array as-is, and print the values of the 2D array in a for-loop. When a `-1` value is found, you break out of the loop since there are no next pairs.

## Check your work

In this task, you'll run your application from the Integrated Terminal and verify your code is working correctly. Let's get started.

1. Compare your code with the following to ensure it's correct:

    ```c#
    int target = 30;
    int[] coins = new int[] {5, 5, 50, 25, 25, 10, 5};
    int[,] result = TwoCoins(coins, target);

    if (result.Length == 0) 
    {
        Console.WriteLine("No two coins make change");
    } 
    else 
    {
        Console.WriteLine("Change found at positions:");
        for (int i = 0; i < result.GetLength(0); i++) 
        {
            if (result[i,0] == -1) 
            {
                break;
            }
            Console.WriteLine($"{result[i,0]},{result[i,1]}");
        }
    }

    int[,] TwoCoins(int[] coins, int target) 
    {
        int[,] result = {{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1}};
        int count = 0;

        for (int curr = 0; curr < coins.Length; curr++) 
        {
            for (int next = curr + 1; next < coins.Length; next++) 
            {    
                if (coins[curr] + coins[next] == target) 
                {
                    result[count, 0] = curr;
                    result[count, 1] = next;
                    count++;
                }
                if (count == result.GetLength(0)) 
                {
                    return result;
                }
            }
        }
        return (count == 0) ? new int[0,0] : result;
    }
    ```

1. Save your work using <kbd>Ctrl</kbd> + <kbd>S</kbd> or using the Visual Studio Code File menu.

1. If necessary, open Visual Studio Code's Integrated Terminal panel.

    In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

1. At the Terminal command prompt, enter **dotnet run**

1. Verify that your code produces the following output:

    ```Output
    Change found at positions:
    0,3
    0,4
    1,3
    1,4
    3,6
    ```

    If your code displays different results, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.

1. Next, update the value of `target` to a value of `80`:

    ```c#
    int target = 80;
    ```

1. Save your work then enter **dotnet run** at the Terminal command prompt

1. To verify that your code is working as expected, compare the output of your application with the following output:

    ```Output
    No two coins make change
    ```

   If your code displays different results, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.