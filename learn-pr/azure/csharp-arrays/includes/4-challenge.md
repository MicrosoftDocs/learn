Previously, we set out to write code that would store Order IDs belonging to potentially fraudulent orders.  Our hope is to find fraudulent orders as early as possible and flag them for deeper analysis.  

Our team found a pattern -- orders that start with the letter "B" encounter fraud 25 times the normal rate.  We will write new code that will output the Order ID of new orders where the Order ID starts with the letter "B".  This will be used by our fraud team to investigate further.

### Step 1 - Delete the code from the previous exercises.

Select all of the code, then select the backspace or `del` key on your keyboard.

### Step 2 - Declare and initialize a new array to hold fake Order IDs.

Here's the fake Order ID data that you should use to initialize your array.

```
B123
C234
A345
C15
B177
G3003
C235
B179
```

### Step 2 - Iterate through each element of the array.

Use a `foreach` statement to iterate through each element of the array you just declared and initialized.

### Step 3 - If the fake Order ID starts with "B", the print the Order ID to the output.

Evaluate each element of the array.  Identify and print to output the potentially fraudulent Order IDs looking for those orders that start with the letter "B".  The output should match the following output:

```output
B123
B177
B179
```

> [!IMPORTANT]
> Here's a hint:  As you loop through each element in your array, you'll need an `if` statement.  The `if` statement will need to use a method on the string class to determine if a string starts with a specific letter.  If you're not sure how to use an `if` statement, please see the module "Add decision logic to your code using the if-elseif-else statement in C#".

> [!IMPORTANT]
> Second hint: Use the string's `StartsWith()` method to identify the orders that start with the letter "B".  You may need to reference docs.microsoft.com to look up the `String.StartsWith()` method.  If you're not sure how to do this, see the module "Call methods from the .NET Class Library using C#".

Whether you get stuck and need to peek at the solution or you finish successfully, continue on to view a solution to this challenge.