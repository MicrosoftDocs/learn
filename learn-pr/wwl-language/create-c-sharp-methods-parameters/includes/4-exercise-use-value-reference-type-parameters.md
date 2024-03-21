In C#, variables can be categorized into two main types, value types and reference types. These types describe how variables store their values. 

Value types such as `int`, `bool`, `float`, `double`, and `char` directly contain values. Reference types such as `string`, `array`, and objects (such as instances of `Random`) don't store their values directly. Instead, reference types store an address where their value is being stored.

## Parameters passed by value and passed by reference

When an argument is passed to a method, *value* type variables have their values copied into the method. Each variable has its own copy of the value, so the original variable isn't modified. 

With reference types, the address of the value is passed into the method. The variable given to the method references the value at that address, so operations on that variable affect the value that is referenced by the other.

> [!NOTE]
> It is important to remember that `string` is a reference type, but it is *immutable*. That means once it has been assigned a value, it can't be altered. In C#, when methods and operators are used to modify a string, the result that is returned is actually a new string object.

In this exercise, you'll learn more about passing reference and value type arguments into methods.

### Test pass by value

1. In the Visual Studio Code Editor, delete any existing code from the previous exercises.

1. Enter the following code into the Visual Studio Code Editor:

    ```c#
    int a = 3;
    int b = 4;
    int c = 0;

    Multiply(a, b, c);
    Console.WriteLine($"global statement: {a} x {b} = {c}");

    void Multiply(int a, int b, int c) 
    {
        c = a * b;
        Console.WriteLine($"inside Multiply method: {a} x {b} = {c}");
    }
    ```

    The variables `a`, `b`, and `c` are passed to the `Multiply` method. The values of the variables are printed during the method execution, and printed again after the method is complete. 
    
    Integers are value types, which have their values copied when passed into methods. What do you think the output of `c` will be?

1. Save and run your code to observe the following output:

    ```Output
    inside Multiply method: 3 x 4 = 12
    global statement: 3 x 4 = 0
    ```

    Notice that the value of `c` is only altered within the `Multiply` method. Outside of the method, `c` retains its original value.

### Test pass by reference

1. Delete the previous code from the Visual Studio Code Editor.

1. Enter the following code into the Visual Studio Code Editor:

    ```c#
    int[] array = {1, 2, 3, 4, 5};

    PrintArray(array);
    Clear(array);
    PrintArray(array);

    void PrintArray(int[] array) 
    {
        foreach (int a in array) 
        {
            Console.Write($"{a} ");
        }
        Console.WriteLine();
    }

    void Clear(int[] array) 
    {
        for (int i = 0; i < array.Length; i++) 
        {
            array[i] = 0;
        }
    }
    ```

    The code begins with `array` initialized to contain some integer values. The values are displayed using the `PrintArray` method. The `Clear` method is called on the array, and then the array is printed again. 
    
    Arrays are reference types. Reference types store the address of their values in memory. What do you think the output will be?

1. Save and run your code to observe the following output:

    ```Output
    1 2 3 4 5 
    0 0 0 0 0
    ```

    Notice that the array remains altered outside of the `Clear` method scope. This happens because the `Clear` method updated the values stored at each address.

### Test with strings

Earlier, you learned that strings are an *immutable* type. Even though a string is a reference type, unlike an array, its value can't be altered once it's assigned. You might have noticed this if you've used methods such as `string.Replace` or `string.ToUpper`. In this task, you'll learn to correct a common error found when working with strings.

1. In the Visual Studio Code Editor, delete any existing code from the previous exercises.

1. Enter the following code into the Visual Studio Code Editor:

    ```c#
    string status = "Healthy";

    Console.WriteLine($"Start: {status}");
    SetHealth(status, false);
    Console.WriteLine($"End: {status}");

    void SetHealth(string status, bool isHealthy) 
    {
        status = (isHealthy ? "Healthy" : "Unhealthy");
        Console.WriteLine($"Middle: {status}");
    }
    ```

1. Save and run your code to observe the following output:

    ```Output
    Start: Healthy
    Middle: Unhealthy
    End: Healthy
    ```

    If the `SetHealth` method didn't output the status, you might have assumed the method didn't execute correctly. Instead, a new string with the value "Unhealthy" was created and then lost in the method scope.

    To correct this problem, you can change `SetHealth` to use the global status variable instead.

1. Update your code as follows:

    ```c#
    string status = "Healthy";

    Console.WriteLine($"Start: {status}");
    SetHealth(false);
    Console.WriteLine($"End: {status}");

    void SetHealth(bool isHealthy) 
    {
        status = (isHealthy ? "Healthy" : "Unhealthy");
        Console.WriteLine($"Middle: {status}");
    }
    ```

    In this code, you overwrite the global `status` variable with the new string value.

1. Save and run your code to observe the following output:

    ```Output
    Start: Healthy
    Middle: Unhealthy
    End: Unhealthy
    ```

    Now the updated string is captured and stored correctly.

## Recap

Here's what you've learned about value type and reference type parameters so far:

- Variables can be categorized as value types and reference types.
- Value types directly contain values, and reference types store the address of the value.
- Methods using value type arguments create their own copy of the values.
- Methods that perform changes on an array parameter affect the original input array.
- String is an immutable reference type.
- Methods that perform changes on a string parameter don't affect the original string.