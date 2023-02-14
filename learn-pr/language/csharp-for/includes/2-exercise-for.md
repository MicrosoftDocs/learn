On the surface, the `for` statement is another iteration statement that allows you to iterate through a code block, and thereby change the flow of execution of your code. However, once we examine how each statement works, we can better identify the nuances of each iteration statement and when to use them.

## What's the `for` statement?

The `for` statement iterates through a code block a specific number of times. This makes the `for` statement unique among the other iteration statements. The `foreach` statement iterates through a block of code once for each item in a sequence of data like an array or collection. The `while` statement iterates through a block of code until a condition is met.  

Furthermore, the `for` statement gives you much more control over the iteration process by exposing the conditions for iteration.

In this exercise, you'll use the `for` statement, and learn how to control the iteration's pre-condition, completion condition, its iteration pattern, and more. Also, you'll learn of common use cases for the `for` statement.

### Step 1 - Write a basic for statement

The following code listing is a simple `for` statement that loops through its code block ten times, printing the current value of `i`:

```csharp-interactive
for (int i = 0; i < 10; i++)
{
    Console.WriteLine(i);
}
```

When you run this code, you'll get the following output:

```output
0
1
2
3
4
5
6
7
8
9
```

There are six parts to the `for` statement.

- The `for` keyword.
- A set of parentheses that defines the conditions of for iteration. It contains three distinct parts, separated by the end of statement operator, a semi-colon.
- The first part defines and initializes the iterator variable; in this example: `int i = 0`. The documentation refers to this section as the **initializer**.
- The second part defines the completion condition; in this example: `i < 10`. In other words, the runtime will continue to iterate over the code in the code block below the `for` statement while `i` is less than `10`. When `i` becomes equal to `10`, the runtime stops executing the `for` statement's code block. The documentation refers to this section as the **condition**.
- The third part defines the action to take after each iteration. In this case, after each iteration, `i++` will increment the value of `i` by 1. The documentation refers to this section as the **iterator**.
- Finally, the code block. This is the code that will be executed for each iteration. Notice that the value of `i` is referenced inside of the code block. The documentation refers to this section as the **body**.

> [!NOTE]
> All three sections (initializer, condition, and iterator) are optional. However, in practice, typically all three sections are used.

As we stated at the outset, the `for` statement has two unique qualities among iteration statements.

- You should use the `for` statement when you know the number of times you need to iterate through a block of code ahead of time.
- The `for` statement allows you to control the way in which each iteration is handled. We'll see a few examples of this in the rest of the steps in this exercise.

Given our rules for naming variables, you may wonder if `i` is a valid name for the variable that holds the current iteration. In this case, most consider `i` to be valid. Other popular choices are `x` and `counter`. You can also use `j` in those situations when you have an outer `for` statement that uses `i`, and need to create an iteration variable for an inner `for` statement.

### Step 2 - Change the iteration conditions

What if we needed to iterate through a block of code, but want to count down instead of counting up?

Update the code in the .NET Editor to match the following code listing:

```csharp-interactive
for (int i = 10; i >= 0; i--)
{
    Console.WriteLine(i);
}
```

When you run the code, you'll get the following output:

```output
10
9
8
7
6
5
4
3
2
1
0
```

By changing the three parts of the `for` statement, we change its behavior.

- We initialize the iteration variable to `10`.
- We change the completion condition to exit the `for` statement when `i` is less than `0`.
- We change the pattern of the iterator to subtract `1` from `i` each time we complete an iteration.

### Step 3 - Experiment with the iterator's pattern

What if we wanted to skip past certain values in the iterator variable?

Update the code in the .NET Editor to match the following code listing:

```csharp-interactive
for (int i = 0; i < 10; i += 3)
{
    Console.WriteLine(i);
}
```

When you run the code, you'll get the following output:

```output
0
3
6
9
```

Instead of incrementing or decrementing the value of the iterator variable by `1`, we used `i += 3` to skip two values after each iteration.

Admittedly, you won't do this sort of thing often, but hopefully you can appreciate that you have a fine-grained level of control should you ever need it.

### Step 4 - Use the break keyword to break the iteration statement

What if we need to exit the iteration statement prematurely based on some condition? We can use the `break` keyword.

Update the code in the .NET Editor to match the following code listing:

```csharp-interactive
for (int i = 0; i < 10; i++)
{
    Console.WriteLine(i);
    if (i == 7) break;
}
```

When you run the code, you'll get the following output:

```output
0
1
2
3
4
5
6
7
```

We first saw the `break` keyword in the [Branch the flow of code using the switch-case construct in C#](/training/modules/csharp-switch-case/) module. As it turns out, we can use the `break` keyword to exit out of iteration statements as well.

### Step 5 - Loop through each element of an array

A common usage for the `for` statement is to iterate through an array of elements, especially if you need some control over the manner in which the iteration happens. While the `foreach` iterates through every element of the array, you can tweak the `for` statement to provide more customization.

Update the code in the .NET Editor to match the following code listing:

```csharp-interactive
string[] names = { "Alex", "Eddie", "David", "Michael" };
for (int i = names.Length - 1; i >= 0; i--)
{
    Console.WriteLine(names[i]);
}
```

When you run the code, you'll get the following output:

```output
Michael
David
Eddie
Alex
```

In this case, we iterated through the array backwards, something we would be unable to do with the `foreach` statement. We used the `Length` property to initialize the iterator variable and subtract one from `i` with each iteration. Inside the code block, we indexed into the array using the iteration variable.

### Step 6 - Limitation of the foreach statement

What if you want to update a value in the array during a `foreach` iteration?

```csharp-interactive
string[] names = { "Alex", "Eddie", "David", "Michael" };
foreach (var name in names)
{
    // Can't do this:
    if (name == "David") name = "Sammy";
}
```

If you attempt to compile and run this code, you'll get an exception:

```output
Cannot assign to name because it is a 'foreach iteration variable'
```

In other words, you can't reassign the value of `name` because it's part of the `foreach` iteration's inner implementation.

### Step 7 - Overcoming the limitation of the foreach statement using the for statement

However, you can accomplish the same functionality using the `for` statement.

Update the code in the .NET Editor to match the following code listing:

```csharp-interactive
string[] names = { "Alex", "Eddie", "David", "Michael" };
for (int i = 0; i < names.Length; i++)
    if (names[i] == "David") names[i] = "Sammy";

foreach (var name in names) Console.WriteLine(name); 
```

When you run the code, you'll get the following output:

```output
Alex
Eddie
Sammy
Michael
```

Because the array isn't directly part of the iteration statement's implementation, you can change values inside of the array.

Also, in this code example, you may notice we removed the curly braces because the code blocks only contained a single line of code. This is the same technique that we talked about in the [Control variable scope and logic using code blocks in C#](/training/modules/csharp-code-blocks/) module. Some prefer this abbreviated style because it helps them write more succinctly and more expressively. If you don't like this style, feel free to always use curly braces in your code blocks.

## Recap

Here are a few of the takeaways from this unit:

- The `for` iteration statement allows you to iterate through a block of code a specific number of times.
- The `for` iteration statement allows you to control every aspect of the iteration's mechanics by altering the three conditions inside the parenthesis: the initializer, condition, and iterator.
- It's common to use the `for` statement when you need to control how you want to iterate through each item in an array.
- If your code block has only one line of code, you can eliminate the opening and closing curly braces and white space if you wish.
