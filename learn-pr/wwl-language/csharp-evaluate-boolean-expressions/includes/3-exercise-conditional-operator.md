


Suppose you need to quickly determine whether a customer's purchase is eligible for a promotional discount. The details for the promotion indicate that when a purchase value is greater than $1000, the purchase is eligible for a $100 discount. If the purchase amount is $1000 or less, the purchase is eligible for a $50 discount.

While you could certainly use the `if ... elseif ... else` branching construct to express this business rule, using the *conditional operator* to evaluate eligibility for the promotional discount may be a better choice. The conditional operator uses a compact format that saves a few lines of code and possibly makes the intent of the code clearer.

## What is the conditional operator?

The *conditional operator* `?:` evaluates a Boolean expression and returns one of two results depending on whether the Boolean expression evaluates to true or false. The *conditional operator* is commonly referred to as the ternary conditional operator.

Here's the basic form:

```c#
<evaluate this condition> ? <if condition is true, return this value> : <if condition is false, return this value>
```

Take a minute to consider how you'ld apply the conditional operator to the promotional discount scenario. Your goal is to display a message to the customer that shows their discount percentage. The amount of their discount will be based on whether they've spent more than $1000 on their purchase.

### Add code that uses a conditional operator

1. Ensure that you have an empty Program.cs file open in Visual Studio Code.
   If necessary, open Visual Studio Code, and then complete the following steps to prepare a Program.cs file in the Editor:
   1. On the **File** menu, select **Open Folder**.
   1. Use the Open Folder dialog to navigate to, and then open, the **CsharpProjects** folder.
   1. In the Visual Studio Code EXPLORER panel, select **Program.cs**.
   1. On the Visual Studio Code **Selection** menu, select **Select All**, and then press the Delete key.

1. Type the following code into the Visual Studio Code Editor.
   
   ```c#
   int saleAmount = 1001;
   int discount = saleAmount > 1000 ? 100 : 50;
   Console.WriteLine($"Discount: {discount}");
   ```

1. On the Visual Studio Code **File** menu, select **Save**.
   
   The Program.cs file must be saved before building or running the code.

1. In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.
   
   A Terminal panel that displays a command prompt should now be open. The command prompt should display the folder path for your TestProject folder location.

1. At the Terminal command prompt, to run your code, type **dotnet run** and then press Enter.
   
   When you run the code, you should see the following output:
   
   ```dos
   Discount: 100
   ```

### Use the conditional operator inline

You can compact this code even more by eliminating the temporary variable `discount`.

1. Update your code in the Visual Studio Code Editor as follows:
  
   ```c#
   int saleAmount = 1001;
   // int discount = saleAmount > 1000 ? 100 : 50;
   
   Console.WriteLine($"Discount: {(saleAmount > 1000 ? 100 : 50)}");
   ```

1. On the Visual Studio Code **File** menu, select **Save**.

1. At the Terminal command prompt, to run your code, type **dotnet run** and then press Enter.

1. Notice that the output is the same.

1. Take a minute to examine the updated `Console.WriteLine()` statement.
   
   Notice that it's necessary to wrap the entire conditional operator statement in parentheses. The parentheses ensure that the runtime understands your intent, which is to display the conditional result rather than the result of evaluating the condition (saleAmount > 1000).
   
   > [!NOTE] 
   > While this particular example is compact and shows what is possible, it is a bit more difficult to read. It's not always a good idea to combine lines of code, especially when it adversely affects the overall readability of your code. This is often a subjective judgment call.

## Recap

You should remember the following facts about the conditional operator:

- You can use the conditional operator to reduce the size of your code, but you should ensure that the resulting code is easily readable.
- You can use the conditional operator when you need to return a value that's based on a binary condition. Your code will return the first option when the condition evaluates to true, and it will return the second option when the condition evaluates to false.