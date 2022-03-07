Suppose you need to quickly determine if a customer's purchase is eligible for a promotional discount.  If the amount of the sale is greater than 1000, then discount the purchase by 100 dollars.  If the amount is 1000 or less, only discount the sale by 50 dollars.

While we could certainly use the `if ... elseif ... else` branching construct to express this business rule, we may choose the *conditional operator* to perform the promotional discount.  The conditional operator uses a compact format that saves a few lines of code and possibly makes the intent of the code clearer.

## What is the conditional operator?

The *conditional operator* `?:`, commonly known as the ternary conditional operator, evaluates a Boolean expression, and returns the result of evaluating one of two expressions, depending on whether the Boolean expression evaluates to true or false.

Here's the basic form:

`<evaluate this condition> ? <if condition is true, return this value> : <if condition is false, return this value>`

Let's use the conditional operator to address the scenario in this unit.  We'll display a message to the customer with their promotional discount based on whether they've spent more than $1000 on their purchase.

### Step 1 - Delete or comment out the code you added into the code window in previous exercises.  

Use the techniques you've learned to clear out the .NET Editor.

### Step 2 - Add code that uses a conditional operator

```csharp-interactive
int saleAmount = 1001;

int discount = saleAmount > 1000 ? 100 : 50;

Console.WriteLine($"Discount: {discount}");
```
When you run the code, you should see the following output.

```output
Discount: 100
```

### Step 3 - Use the conditional operator inline

We can compact this code even more by eliminating the temporary variable `discount`.

Modify the code from step 1 to match the following.

```csharp-interactive
int saleAmount = 1001;
// int discount = saleAmount > 1000 ? 100 : 50;

Console.WriteLine($"Discount: {(saleAmount > 1000 ? 100 : 50)}");
```

If you run the code, the output is the same.

It's necessary to wrap the entire conditional operator statement in parentheses so that the runtime doesn't mistake your intent (before evaluating the condition).

While this particular example is nice and compact and shows what is possible, it's not always a good idea to combine lines of code if it adversely affects the overall readability of the line.  This is often a subjective judgment call.

## Recap

You should remember the following about the conditional operator:

- Use the conditional operator when you need to add branching logic inline.
- Use the conditional operator when you need to return a value based on a binary condition ... return this when true, return that when false.
