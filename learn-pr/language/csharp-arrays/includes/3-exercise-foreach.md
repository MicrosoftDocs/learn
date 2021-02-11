Suppose we work for a manufacturer and need to take an inventory of our warehouse to determine the current number of finished products we have that are ready to ship.  In addition to the total number of finished products, we may also want to print out a count and running total of each individual bin in our warehouse where our finished products are stored.  This running total printout would create an audit trail so we can double-check our work and identify shrinkage.

## Looping through an array using foreach

The foreach statement loops through each element in an array, running the code block below its declaration, substituting the value in a temporary variable for the value of the array that the current loop represents.

Here's a simple example:

```csharp-interactive
string[] names = { "Bob", "Conrad", "Grant" };
foreach (string name in names)
{
    Console.WriteLine(name);
}
```
Below the `foreach` keyword, the code block that contains the `Console.WriteLine(name);` will execute once for each element of the `names` array.  As the .NET runtime loops through each element of the array, the value stored in the current element of the `names` array is assigned to the temporary variable `name` for easy access inside of the code block.

If you run the code, you would see the following result.

```output
Bob
Conrad
Grant
```

Let's use the foreach statement to create a sum of all the items on hand in each bin of our warehouse.

### Step 1 - Create and initialize an array of int

Delete or comment out any code from previous exercises and add the following code to create an array of `int` that will store the number of finished products in each bin.

```csharp-interactive
int[] inventory = { 200, 450, 700, 175, 250 };
```

### Step 2 - Add a foreach statement to iterate through the array

Next, add a foreach statement that iterates through each element of the `inventory` array, temporarily assigning the value of the current element to the variable `items`. Your code should match the following listing.

```csharp-interactive
int[] inventory = { 200, 450, 700, 175, 250 };

foreach (int items in inventory)
{

}
```

### Step 3 - Add a variable to sum the value of each element in the array

Define a new variable that represents the sum of all finished products in our warehouse.  Make sure to add it **outside** of the `foreach` statement.

```csharp
int sum = 0;
```

**Inside** of the `foreach` statement, add the following line of code that adds the current value stored in `items` to the `sum` variable.

```csharp
sum += items;
```

Make sure your code matches the following passage of code.

```csharp-interactive
int[] inventory = { 200, 450, 700, 175, 250 };
int sum = 0;
foreach (int items in inventory)
{
    sum += items;
}
```

### Step 4 - Display the final value of sum

**Below** the foreach statement's code block, add the following statement that prints the final sum of items in inventory.

```csharp
Console.WriteLine($"We have {sum} items in inventory.");
```
Make sure your code matches the following passage of code.

```csharp-interactive
int[] inventory = { 200, 450, 700, 175, 250 };
int sum = 0;
foreach (int items in inventory)
{
    sum += items;
}

Console.WriteLine($"We have {sum} items in inventory.");
```

When you run the code, you should see the following output.

```output
We have 1775 items in inventory.
```

### Step 5 - Create a variable to hold the current bin number and display the running total

To fulfill the final requirement, we'll need to create a variable that will hold the current iteration of the `foreach` statement so we can display the bin and the count of finished items in that bin, along with the running total of all items of bins accounted for so far.

Above the `foreach` statement, declare and initialize a new variable of type `int` to store the current number of the bin whose inventory is being processed.

```csharp
int bin = 0;
```

**Inside** of the `foreach` code block, increment the bin each time the code block is executed.

```csharp
bin++;
```
The `++` operator increments the value of the variable by 1.  Its shortcut to writing `bin = bin + 1`.

Finally, inside of the foreach, display the bin, its count of finished products, and the running total of finished products in a nicely formatted message.

```csharp
Console.WriteLine($"Bin {bin} = {items} items (Running total: {sum})");
```
Make sure your code matches the following passage of code.

```csharp-interactive
int[] inventory = { 200, 450, 700, 175, 250 };
int sum = 0;
int bin = 0;
foreach (int items in inventory)
{
    sum += items;
    bin++;
    Console.WriteLine($"Bin {bin} = {items} items (Running total: {sum})");
}
Console.WriteLine($"We have {sum} items in inventory.");
```

When you run the code, you should see the following output.

```output
Bin 1 = 200 items (Running total: 200)
Bin 2 = 450 items (Running total: 650)
Bin 3 = 700 items (Running total: 1350)
Bin 4 = 175 items (Running total: 1525)
Bin 5 = 250 items (Running total: 1775)
We have 1775 items in inventory.
```

## Recap

Here's a few things to remember about the `foreach` statement and other things we learned about in this unit.

- Use the `foreach` statement to iterate through each element in an array, executing the associated code block once for each element in the array.
- The `foreach` statement sets the value of the current element in the array to a temporary variable, which you can use in the body of the code block.
- Use the `++` increment operator to add 1 to the current value of a variable.

