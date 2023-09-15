Methods are useful for organizing code, reusing code, and for tackling problems efficiently. You can think of a method like a black box that takes input, performs the named task, and returns output. With this assumption, you can quickly structure programs just by naming your tasks as methods, and then filling in the logic after you've identified all of the necessary tasks. 

When you use plain language to describe steps in code, without strictly adhering to syntax rules, you're using "pseudo-code". Combining methods and pseudo-code is a great way to quickly power through any challenging programming task.

## Use methods to structure code

Suppose you're a candidate in a coding interview. The interviewer wants you to write a program that checks whether an IPv4 address is valid or invalid. You're given the following rules:

- A valid IPv4 address consists of four numbers separated by dots
- Each number must not contain leading zeroes
- Each number must range from 0 to 255

1.1.1.1 and 255.255.255.255 are examples of valid IP addresses.

The IPv4 address is provided as a string. You can assume that it only consists of digits and dots (there are no letters in the string provided).

How would you approach this task?

> [!NOTE] 
> Even if you aren't familiar with IP addresses, don't worry! You can still complete the code in this exercise by following the steps.

### Break down the problem

In this task, you'll identify the steps needed to solve the problem. If you look closely at the rules, you might realize that it only takes three steps to determine whether or not an IPv4 address is valid.

1. In the Visual Studio Code Editor, delete any existing code from the previous exercises.

1. Enter the following pseudo-code into the Editor:

    ```c#
    /*
    if ipAddress consists of 4 numbers
    and
    if each ipAddress number has no leading zeroes
    and
    if each ipAddress number is in range 0 - 255

    then ipAddress is valid

    else ipAddress is invalid
    */
    ```

    Pseudo-code is a great way to begin tackling any problem. Using this comment block, you bridge the gap between the prompt rules and the program code, clarifying the major tasks your code will perform. Pseudo-code doesn't need to be functional or adhere to syntax rules, however, it should be a clear explanation of what the code will do. Now let's turn this into real code!

1. Enter a new blank code line, then type the following code in the Editor:

    ```c#
    if (ValidateLength() && ValidateZeroes() && ValidateRange()) 
    {
        Console.WriteLine($"ip is a valid IPv4 address");
    } 
    else 
    {
        Console.WriteLine($"ip is an invalid IPv4 address");
    }
    ```

    In this step, you transform the `if` statements from your pseudo-code into callable methods and output the results. Don't worry about defining the methods yet; you can assume that each method performs the task its name describes. You'll fix the compilation errors and create the method logic soon, but focus on the big picture for now. When you begin working on a new program, focusing on the overall design helps you stay organized and develop your application faster.

1. Enter a new blank code line below the existing code, then type the following code in the Editor:
    
    ```c#
    void ValidateLength() {}
    void ValidateZeroes() {}
    void ValidateRange() {}
    ```

    Notice how using placeholder methods allowed you to quickly approach the problem and structure your code to develop the solution. Now that you have a structured plan in place, you can continue to solve the problem by filling in the code piece by piece.

### Develop your solution

Now that you have all the placeholder methods needed to solve the problem, you can begin to focus on the details of your solution. Keep in mind that the input format of the IPv4 address will be a string consisting of digits separated by dots. Let's get stared!

1. At the beginning of your program, create variables to store the input and validation statuses:

    ```c#
    string ipv4Input = "107.31.1.5";
    bool validLength = false;
    bool validZeroes = false;
    bool validRange = false;
    ```

1. Update your solution code to use the validation variables as follows:

    ```c#
    ValidateLength(); 
    ValidateZeroes(); 
    ValidateRange();

    if (validLength && validZeroes && validRange) 
    {
        Console.WriteLine($"ip is a valid IPv4 address");
    } 
    else
    {
        Console.WriteLine($"ip is an invalid IPv4 address");
    }
    ```

1. Update the `ValidateLength` method as follows:

    ```c#
    void ValidateLength() 
    {
        string[] address = ipv4Input.Split(".");
        validLength = address.Length == 4;
    };
    ```

    The first rule states that the IPv4 address needs to have four numbers. So in this code, you use `string.Split` to separate the digits and check that there are four of them.

1. Update the `ValidateZeroes` method as follows:
    
    ```c#
    void ValidateZeroes() 
    {
        string[] address = ipv4Input.Split(".");

        foreach (string number in address) 
        {
            if (number.Length > 1 && number.StartsWith("0")) 
            {
                validZeroes = false;
            }
        }

        validZeroes = true;
    }
    ```

    Take a moment to consider how the rule translates to code. 
    
    The second rule states that the numbers in the IPv4 address must not contain leading zeroes. So the method needs to check numbers for leading zeroes while accepting `0` as a valid number. If all the numbers have valid zeroes, `validZeroes` should be equal to `true`, and `false` otherwise. So in this code, you check that each number with more than one digit does not begin with a zero.

    If you look closely, you'll notice that `validZeroes` is set to `true` after the `foreach` loop completes. However, you only want to set `validZeroes` to `true` if no leading zeroes are found. You could correct this bug by setting `validZeroes = true` before the `foreach` loop runs. However, you can also correct this bug using a **return** statement.

1. Update your code to the following:
    
    ```c#
    foreach (string number in address) 
    {
        if (number.Length > 1 && number.StartsWith("0")) 
        {
            validZeroes = false;
            return;
        }
    }
    ```

    The **return** statement terminates execution of the method and returns control to the method caller. Adding a `return` statement after `validZeroes = false` terminates the method after the first invalid zero is found. If no invalid zero is found, the method will terminate after setting `validZeroes` to `true`. Let's move on to the next method.

1. Update the `ValidateRange` method as follows:
    
    ```c#
    void ValidateRange() 
    {
        string[] address = ipv4Input.Split(".");

        foreach (string number in address) 
        {
            if (int.Parse(number) > 255) 
            {
                validRange = false;
                return;
            }
        }
        validRange = true;
    }
    ```

    The third rule states that each number in the IPv4 address must range from 0 to 255. So in this code, you check that each number is less than 255, and if not, terminate execution after setting `validRange` to `false`. Since the input string only contains digits and dots, you don't need to check for negative numbers.

    However, there might be a case where no digits are present between dots. For example, "255...255". In this case, `string.Split(".")` would return empty entries, causing `int.Parse` to fail. You can prevent this by specifying `StringSplitOptions`.

1. Update your code as follows:

    ```c#
    string[] address = ipv4Input.Split(".", StringSplitOptions.RemoveEmptyEntries);
    ```

    Using `StringSplitOptions.RemoveEmptyEntries` omits empty entries from the `address` array and prevent attempts to parse empty strings.

### Complete your solution

Now that you have all the methods completed to validate an IP address, it's time to revisit your initial solution. In this task, you'll add more input values and prepare to test your code.

1. Locate the following code you wrote earlier in the program:

    ```c#
    string ipv4Input = "107.31.1.5";
    ```

1. Update the code as follows:

    ```c#
    string[] ipv4Input = {"107.31.1.5", "255.0.0.255", "555..0.555", "255...255"};
    ```
    
    When developing a solution, it is important to test your code with different input cases. In this code, you provide a decent range of test values. Now that you've updated your test input, you'll need to update your code to use the new values. Since the values are in an array, you'll need to update your code to test each one using a loop.

1. Update your code as follows:

    ```c#
    foreach (string ip in ipv4Input) 
    {
        ValidateLength(); 
        ValidateZeroes(); 
        ValidateRange();

        if (validLength && validZeroes && validRange) 
        {
            Console.WriteLine($"{ip} is a valid IPv4 address");
        } 
        else 
        {
            Console.WriteLine($"{ip} is an invalid IPv4 address");
        }
    }
    ```

    Lastly, you need to fix the input data each method uses since you updated `ipv4Input` from a string to an array. Since each method uses `string.Split`, you can declare a variable to store the result of `string.Split` and use it in each method instead.

1. Add a variable to store the current IPv4 address that each method will reference:

    ```c#
    string[] ipv4Input = {"107.31.1.5", "255.0.0.255", "555..0.555", "255...255"};
    string[] address;
    bool validLength = false;
    bool validZeroes = false;
    bool validRange = false;
    ```

1. Initialize `address` using `string.Split` as follows:

    ```c#    
    foreach (string ip in ipv4Input) 
    {
        address = ip.Split(".", StringSplitOptions.RemoveEmptyEntries);
    ```

1. Remove references to `string.Split` from each of the validation methods so that they use the global `address` variable instead. For example:

    ```c#   
    void ValidateLength() 
    {
        validLength = address.Length == 4;
    };
    ```

## Check Your Work

In this task, you'll run your application from the Integrated Terminal and verify your code is working correctly. Let's get started.

1. Compare your code with the following to ensure it is correct:

    ```c#
    string[] ipv4Input = {"107.31.1.5", "255.0.0.255", "555..0.555", "255...255"};
    string[] address;
    bool validLength = false;
    bool validZeroes = false;
    bool validRange = false;

    foreach (string ip in ipv4Input) 
    {
        address = ip.Split(".", StringSplitOptions.RemoveEmptyEntries);

        ValidateLength(); 
        ValidateZeroes(); 
        ValidateRange();

        if (validLength && validZeroes && validRange) 
        {
            Console.WriteLine($"{ip} is a valid IPv4 address");
        } 
        else 
        {
            Console.WriteLine($"{ip} is an invalid IPv4 address");
        }
    }

    void ValidateLength() 
    {
        validLength = address.Length == 4;
    };

    void ValidateZeroes() 
    {
        foreach (string number in address) 
        {
            if (number.Length > 1 && number.StartsWith("0")) 
            {
                validZeroes = false;
                return;
            }
        }

        validZeroes = true;
    }

    void ValidateRange() 
    {
        foreach (string number in address) 
        {
            if (int.Parse(number) > 255) 
            {
                validRange = false;
                return;
            }
        }
        validRange = true;
    }
    ```

1. Save your work using <kbd>Ctrl</kbd> + <kbd>S</kbd> or using the Visual Studio Code File menu.

1. If necessary, open Visual Studio Code's Integrated Terminal panel.

    In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

1. At the Terminal command prompt, enter **dotnet run**

1. Verify that your code produces the following output:

    ```Output
    107.31.1.5 is a valid IPv4 address
    255.0.0.255 is a valid IPv4 address
    555..0.555 is an invalid IPv4 address
    255...255 is an invalid IPv4 address
    ```

    If your code displays different results, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.

## Recap

Here's what you've learned about using methods so far:

- Methods can be used to quickly structure applications
- The `return` keyword can be used to terminate method execution
- Each step of a problem can often be translated into its own method
- Use methods to solve small problems to build up your solution
