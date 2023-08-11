





The following example of a debug process is one possible solution for the challenge from the previous unit.

## Implement the C# debugger tools to identify the issue

The following debug process implements a breakpoint and then monitors the value of `x` in the VARIABLES section of RUN AND DEBUG view.

1. Set a breakpoint on the following code line:

    ```csharp
    int x = 5;
    ```

1. Open the RUN AND DEBUG view.

1. At the top of the RUN AND DEBUG view, select **Start Debugging**.

1. In the VARIABLES section of the **Run and Debug** view, make note of the value assigned to `x`.

1. On the **Debug control** toolbar, select **Step Into**.

1. Track the value assigned to `x` as you step through each code line.

1. Notice that the value of `x` doesn't change as execution enters and exits the `ChangeValue` method.

    The `ChangeValue` method is passed the value of `x`, rather than a reference to `x`, so the change to `value` inside the method doesn't affect the original variable `x`.

## Consider a code update based on debugging results

If you want the `ChangeValue` method to change the value in the calling code, you need to update your code. One way to achieve your intended result would be to update the `ChangeValue` method to return an integer value, and update the code that calls `ChangeValue` so that it assigns the return value to `x`.

For example:

```csharp
int x = 5;
x = ChangeValue(x);
Console.WriteLine(x);

int ChangeValue(int value) 
{
    value = 10;
    return value;
}
```

If you succeeded in this challenge, congratulations! Continue on to the knowledge check in the next unit.

> [!IMPORTANT]
> If you had trouble completing this challenge, maybe you should review the previous units before you continue on.
