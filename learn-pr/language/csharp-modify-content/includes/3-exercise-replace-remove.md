In the previous unit, we learned how to locate the position of a character or string within another string. We used the position to extract a substring.

Sometimes, we'll need to modify the contents of the string, removing or replacing characters. While we could do this with the tools we already know, it requires a bit of temporarily storing and stitching strings back together. Fortunately, the `string` data type has additional built-in methods for these specialized scenarios.

## Exercise - Use the Remove() and Replace() methods

In this exercise, we'll remove characters from a string using the `Remove()` method, and replace characters using the `Replace()` method.

### Step 1 - Write code to remove characters in specific locations from a string

You'd typically use `Remove()` when there's a standard and consistent position of the characters you want to remove from the string.

Sometimes, data stored in older files is fixed length, where character positions are allocated for certain fields of information. In this first step of our exercise, we have such a fictitious record of information. The first five digits represent a customer identification number. The next 20 digits contain a customer's name. The next six positions represent the customer's latest invoice amount, and the last three positions represent the number of items ordered on that invoice.

Perhaps we need to remove the customer's name to format the data so that it can be sent to a separate process. Since we know the exact position and length of the user's name, we can easily remove it using the `Remove()` method.

Comment out or delete all of the code in the .NET Editor. Then, write code in the .NET Editor that matches the following code listing:

```csharp-interactive
string data = "12345John Smith          5000  3  ";
string updatedData = data.Remove(5, 20);
Console.WriteLine(updatedData);
```

When you run the code, you'll get the following output:

```output
123455000  3  
```

The `Remove()` method works similarly to the `Substring()` method. You'll supply a starting position and the length to remove those characters from the string.

### Step 2 - Write code to remove characters no matter where they appear in a string

You'd use the `Replace()` method when you must replace one or more characters with a different character (or no character). The `Replace()` method is different from the other methods we've used so far because it will replace every instance of the given characters, not just the first or last instance.

Delete the code from step 1 and add the code from the following listing:

```csharp-interactive
string message = "This--is--ex-amp-le--da-ta";
message = message.Replace("--", " ");
message = message.Replace("-", "");
Console.WriteLine(message);
```

When you run the code, you should get the following output:

```output
This is example data
```

Here, we used the `Replace()` method twice. The first time we replaced the string `--` with an empty space. The second time we replaced the string `-` with an empty string, which completely removes the character from the string.

## Recap

Here are the most important things to remember from this unit:

- The `Remove()` method works like the `Substring()` method, except that it deletes the specified characters in the string.
- The `Replace()` method swaps all instances of a string with a new string.
