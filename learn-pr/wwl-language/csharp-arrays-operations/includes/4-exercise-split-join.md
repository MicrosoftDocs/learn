Suppose you work for a system integrator. You're building a series of small programs that will take data from one partner's system, modify the data, then pass it to an internal system in the format it requires.

To perform this transformation on the data, you'll need to accept incoming data as a string, parse it into smaller data elements, then manipulate it to match a different format. But how can you parse the string data into smaller data elements?

## string data type's Array methods

The variables of type `string` have many built-in methods that convert a single string into either an array of smaller strings or an array of individual characters.  

When processing data from other computer systems, sometimes it's formatted or encoded in a way that's not useful for your purposes. In those cases, you can use the `string` data type's `Array` methods to parse a larger string into an array.

### Step 1 - Use the ToCharArray() to reverse a string

Delete or comment out all of the code in the .NET Editor, then add the following code:

```csharp-interactive
string value = "abc123";
char[] valueArray = value.ToCharArray();
```

Here, we're using the `ToCharArray()` method to create an array of `char`. Each element of the array has one character of the original string.

### Step 2 - Reverse, then combine the char array into a new string

Next, we'll reverse the order of the chars in the array, then use the `Write` method to combine them back into a single output:

```csharp-interactive
string value = "abc123";
char[] valueArray = value.ToCharArray();
Array.Reverse(valueArray);
string result = new string(valueArray);
Console.WriteLine(result);
```

The expression `new string(valueArray)` creates a new empty instance of the `System.String` class (which is the same as the `string` data type in C#) and passes in the `char` array as a constructor.  

> [!NOTE]
> What's the `new` keyword? How is the `System.String` class related to the `string` data type in C#? What's a constructor? All great questions that unfortunately are out of scope for this module. We recommend you keep learning about the .NET Class Library, as well as classes and objects in C#, to fully understand what is going on behind the scenes with this expression of code. For now, we recommend you use a search engine and Microsoft Learn to find good examples you can use in situations where you know you want to perform a conversion but are not sure how to do it using C#.

If you run the code now, you'll get the following output:

```output
321cba
```

### Step 3 - Combine all of the chars into a new comma-separated-value string using Join

Perhaps we need to separate each element of the char array using a comma, as is common when working with data that is represented as ASCII text. To do that, we'll comment out the line of code we added in Step 2 and use the `String` class' `Join()` method, passing in the char we want to delimit each segment (the comma) and the array itself. Your code should match the following listing:

```csharp-interactive
string value = "abc123";
char[] valueArray = value.ToCharArray();
Array.Reverse(valueArray);
// string result = new string(valueArray);
string result = String.Join(",", valueArray);
Console.WriteLine(result);
```

When you run the code, you should get the following output:

```output
3,2,1,c,b,a
```

### Step 4 - Split the new comma-separated-value string into an array of strings

Finally, let's use the `Split()` method available to variables of type string to create an array of strings. We'll use the comma as the delimiter to split one long string into smaller strings. Finally, we'll loop through each element of the new array of string.

Add the following lines of code in the .NET Editor:

```csharp
string[] items = result.Split(',');
foreach (string item in items)
{
    Console.WriteLine(item);
}
```

Once you update the code in the .NET Editor, your code should match the following code passage:

```csharp-interactive
string value = "abc123";
char[] valueArray = value.ToCharArray();
Array.Reverse(valueArray);
// string result = new string(valueArray);
string result = String.Join(",", valueArray);
Console.WriteLine(result);

string[] items = result.Split(',');
foreach (string item in items)
{
    Console.WriteLine(item);
}
```

When you run the code, you'll get the following output:

```output
3,2,1,c,b,a
3
2
1
c
b
a
```

## Recap

Here are a few things to remember when working with strings and arrays:

- There are several methods and techniques that allow you to convert a string to an array and from an array to a string.
- Use methods like `ToCharArray()` and `Split()` to create an array.
- Use methods like `Join()`, or create a new string passing in an array of `char` to turn the array back into a single string.
