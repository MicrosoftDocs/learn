Suppose we work in the anti-fraud department of a company that matches online sellers with commission-based advertisers.  Our advertisers have notified us of a rash of recent credit card chargebacks.  These chargebacks occur a few months after commissions were paid out, long after the thieves have vanished. We've been asked to review several orders in hopes of identifying markers of fraud. Maybe our company can use those markers in the future to identify potential fraudulent purchases.

We need to work with a sequence of Order IDs.  These orders are related inasmuch as we want to identify and analyze them looking for common characteristics. Because we don't always know in advance how many orders we'll need to review, we can't create individual variables to hold each Order ID. How can we create a data structure to hold multiple related values?

## What is an array?

An array is a sequence of individual data elements accessible through a single variable name. You use a zero-based numeric index to access each element of an array. As you'll see, arrays allow us to collect together similar data that shares a common purpose or characteristics in a single data structure for easier processing.

## Declaring arrays

An array is a special type of variable that can hold multiple values of the same data type. The declaration syntax is slightly different because you have to specify both the data type and the size of the array.

### Step 1 - Declare a new array

To declare a new array of strings that will hold three elements, type the following C# statement into the .NET Editor.

```csharp-interactive
string[] fraudulentOrderIDs = new string[3];
```

The `new` operator creates a new instance of an array in the computer's memory that can hold three string values. For more information about the `new` keyword, see the module "Call methods from the .NET Class Library using C#".

Notice that the first set of square brackets `[]` merely tells the compiler that the variable named `fraudulentOrderIDs` will be an array, but the second set of square brackets `[3]` contains the number of elements that the array will hold.

> [!NOTE]
> While this example only declares an array of strings, you can create an array of every data type including primitives like int and bool as well as more complex data types like classes. This example uses the simplicity of strings to minimize the number of new ideas you need to grasp as you're getting started.

## Assigning Values to Elements of an Array

At this point, we've declared an array of strings, but each element of the array is empty. To access an element of an array, you use a numeric zero-based index inside of square brackets.

You assign a value using the `=` assignment value as if it were a regular variable.

### Step 2 - Assign values to elements on an array

Modify the code from Step 1 to match the following code snippet. The following code will assign Order IDs to each element of the array.

```csharp-interactive
string[] fraudulentOrderIDs = new string[3];

fraudulentOrderIDs[0] = "A123";
fraudulentOrderIDs[1] = "B456";
fraudulentOrderIDs[2] = "C789";
```

### Step 3 - Attempt to use an index that is out of bounds of the array

It might not seem intuitive at first, but it's important to remember that we're declaring the count of elements in the array. However, we access each element of the array starting with zero. So, to access the second item in the array, we use index `1`.

It's common for beginners to forget that arrays are zero based and attempt to access an element of the array that doesn't exist. When this happens, you'll experience a runtime exception that you attempted to access an element that is outside the boundary of the array.

Let's intentionally break our application by attempting to access a fourth element of our array using the index `3`. Modify the code from Step 2 by adding the following line of code.

```csharp
fraudulentOrderIDs[3] = "D000";
```

The entire code example should now match what you see that follows.

```csharp-interactive
string[] fraudulentOrderIDs = new string[3];

fraudulentOrderIDs[0] = "A123";
fraudulentOrderIDs[1] = "B456";
fraudulentOrderIDs[2] = "C789";
fraudulentOrderIDs[3] = "D000";
```

When you run the app, you'll get a long error message. Focus on the first two lines. You'll see the following error message. Pay particular attention to the sentence that includes the word `array`.

```output
System.Reflection.TargetInvocationException: Exception has been thrown by the target of an invocation. ---> System.IndexOutOfRangeException: Index was outside the bounds of the array.
```

Now, comment out the line of code you just added in this step.

```csharp
// fraudulentOrderIDs[3] = "D000";
```

## Getting Values of Elements in an Array

You get a value from an element of an array in the same manner. Use the index of the element to retrieve its value.

### Step 4 - Retrieve values of an array

Modify the code from Step 3 to write out the value of each fraudulent Order ID using string interpolation. Your code should match the following passage of code.

```csharp-interactive
string[] fraudulentOrderIDs = new string[3];

fraudulentOrderIDs[0] = "A123";
fraudulentOrderIDs[1] = "B456";
fraudulentOrderIDs[2] = "C789";
// fraudulentOrderIDs[3] = "D000";

Console.WriteLine($"First: {fraudulentOrderIDs[0]}");
Console.WriteLine($"Second: {fraudulentOrderIDs[1]}");
Console.WriteLine($"Third: {fraudulentOrderIDs[2]}");
```

Run the code.  You should see the following output.

```output
First: A123
Second: B456
Third: C789
```

### Step 5 - Reassign the value of an array

The elements of an array are just like any other variable value inasmuch as you can assign, retrieve, and reassign a value to each element of the array.

Add the following lines of code inside to bottom of the .NET Editor. Here, you'll reassign the value of the first element in the array, then print it out.

```csharp
fraudulentOrderIDs[0] = "F000";

Console.WriteLine($"Reassign First: {fraudulentOrderIDs[0]}");
```

Your .NET Editor should match the following passage of code.

```csharp-interactive
string[] fraudulentOrderIDs = new string[3];

fraudulentOrderIDs[0] = "A123";
fraudulentOrderIDs[1] = "B456";
fraudulentOrderIDs[2] = "C789";
// fraudulentOrderIDs[3] = "D000";

Console.WriteLine($"First: {fraudulentOrderIDs[0]}");
Console.WriteLine($"Second: {fraudulentOrderIDs[1]}");
Console.WriteLine($"Third: {fraudulentOrderIDs[2]}");

fraudulentOrderIDs[0] = "F000";

Console.WriteLine($"Reassign First: {fraudulentOrderIDs[0]}");
```

When you run the code, you should see the following output.

```output
First: A123
Second: B456
Third: C789
Reassign First: F000
```

## Initializing an Array

Just like you can initialize a variable at the time you declare it, you can initialize a new array at the time you declare it using a special syntax featuring curly braces.

### Step 6 - Initialize an array

Use a multi-line comment (`/* ... */`) to comment out the lines where you declare the `fraudulentOrderIDs` variable and assign each of its elements a value. Then, add the following line that declares and initializes the array with the same values all in a single line of code.

```csharp
string[] fraudulentOrderIDs = { "A123", "B456", "C789" };
```

So, your code should now match what you see in the following passage.

```csharp-interactive
/*
string[] fraudulentOrderIDs = new string[3];

fraudulentOrderIDs[0] = "A123";
fraudulentOrderIDs[1] = "B456";
fraudulentOrderIDs[2] = "C789";
// fraudulentOrderIDs[3] = "D000";
*/

string[] fraudulentOrderIDs = { "A123", "B456", "C789" };

Console.WriteLine($"First: {fraudulentOrderIDs[0]}");
Console.WriteLine($"Second: {fraudulentOrderIDs[1]}");
Console.WriteLine($"Third: {fraudulentOrderIDs[2]}");

fraudulentOrderIDs[0] = "F000";

Console.WriteLine($"Reassign First: {fraudulentOrderIDs[0]}");
```

When you run the application, there will be no change to the output.

```output
First: A123
Second: B456
Third: C789
Reassign First: F000
```

## Getting the Size of an Array

Depending on how the array is created, you may not know in advance how many elements an array contains. To determine the size of an array, you can use the `Length` property.

### Step 7 - Print the number of fraudulent orders using the array's Length property

Modify the code from Step 6 adding the following line of code to the bottom of the .NET Editor.

```csharp
Console.WriteLine($"There are {fraudulentOrderIDs.Length} fraudulent orders to process.");
```
Your code should now match the following code passage.

```csharp-interactive
/*
string[] fraudulentOrderIDs = new string[3];

fraudulentOrderIDs[0] = "A123";
fraudulentOrderIDs[1] = "B456";
fraudulentOrderIDs[2] = "C789";
// fraudulentOrderIDs[3] = "D000";
*/

string[] fraudulentOrderIDs = { "A123", "B456", "C789" };

Console.WriteLine($"First: {fraudulentOrderIDs[0]}");
Console.WriteLine($"Second: {fraudulentOrderIDs[1]}");
Console.WriteLine($"Third: {fraudulentOrderIDs[2]}");

fraudulentOrderIDs[0] = "F000";

Console.WriteLine($"Reassign First: {fraudulentOrderIDs[0]}");

Console.WriteLine($"There are {fraudulentOrderIDs.Length} fraudulent orders to process.");
```

When you run the code, you should see the following output:

```output
First: A123
Second: B456
Third: C789
Reassign First: F000
There are 3 fraudulent orders to process.
```

## Recap

Here's the most important things to remember when working with arrays.

- An array is a special variable that holds a sequence of related data elements.
- You should memorize the basic format of an array variable declaration.
- Access each element of an array to set or get its values using a zero-based index inside of square brackets.
- If you attempt to access an index outside of the boundary of the array, you'll get a run time exception.
- The `Length` property gives you a programmatic way to determine the number of elements in an array.
