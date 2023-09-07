

The `string.Format()` method is used to perform composite formatting such as in the example:

```csharp
string first = "Hello";
string second = "World";
string result = string.Format("{0} {1}!", first, second);
Console.WriteLine(result);
```

It may have seemed a bit strange that a keyword that represents a data type has methods you can call in the same way that you call methods on the `Console` class. The fact is that there are many similar methods on the `string` data type and any literal string or variable of type string.

Here's a brief list of categories of these built-in methods so you can get an idea of what's possible.

- Methods that add blank spaces for formatting purposes (`PadLeft()`, `PadRight()`)
- Methods that compare two strings or facilitate comparison (`Trim()`, `TrimStart()`, `TrimEnd()`, `GetHashcode()`, the `Length` property)
- Methods that help you determine what's inside of a string, or even retrieve just a part of the string (`Contains()`, `StartsWith()`, `EndsWith()`, `Substring()`)
- Methods that change the content of the string by replacing, inserting, or removing parts (`Replace()`, `Insert()`, `Remove()`)
- Methods that turn a string into an array of strings or characters (`Split()`, `ToCharArray()`)

## Formatting strings by adding whitespace before or after

The `PadLeft()` method adds blank spaces to the left-hand side of the string so that the total number of characters equals the argument you send it. In this case, you want the total length of the string to be 12 characters.

1. Delete or use the line comment operator `//` to comment out all of the code from the previous exercises.

1. Update your code in the Visual Studio Code Editor as follows:
   ```csharp
	string input = "Pad this";
	Console.WriteLine(input.PadLeft(12));   ```

1. On the Visual Studio Code **File** menu, select **Save**.
   Save the Program.cs file before building or running the code.

1. In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.
   A Terminal panel should open, and should include a command prompt showing that the Terminal is open to your TestProject folder location.

1. At the Terminal command prompt, to run your code, type **dotnet run** and then press Enter.
   > [!NOTE]   > If you see a message saying "Couldn't find a project to run", ensure that the Terminal command prompt displays the expected TestProject folder location. For example: `C:\Users\someuser\Desktop\csharpprojects\TestProject>`
   When you run the code, you observe four characters prefixed to the left of the string bring the length to 12 characters long.

	```Output
		Pad this
	```

1. To add space or characters to the right side of your string, use the `PadRight()` method instead. 1. Update your code in the Visual Studio Code Editor as follows:

	```csharp
	Console.WriteLine(input.PadRight(12));
	```

1. Save your code file, and then use Visual Studio Code to run your code. You won't observe any characters added to the end of the string, but they're there.

### What is an overloaded method?

In C#, an *overloaded method* is another version of a method with different or extra arguments that modify the functionality of the method slightly, as is the case with the overloaded version of the `PadLeft()` method.

You can also call a second *overloaded* version of the method and pass in whatever character you want to use instead of a space. In this case, you fill the extra space with the dash character.

1. Delete or use the line comment operator `//` to comment out all of the code from the previous step. 

1. Update your code in the Visual Studio Code Editor as follows:
   ```csharp   Console.WriteLine(input.PadLeft(12, '-'));   Console.WriteLine(input.PadRight(12, '-'));   ```

1. Save your code file, and then use Visual Studio Code to run your code. You should see four dashes prefixing the left of the string that is 12 characters long.
   ```Output   ----Pad this   Pad this----   ```

Now, apply this newfound knowledge to another real world scenario.

## Working with padded strings

Suppose you work for a payment processing company that still supports legacy mainframe systems. Often, those systems require data to be input in specific columns. For example, store the Payment ID in columns 1 through 6, the payee's name in columns 7 through 30, and the Payment Amount in columns 31 through 40. Also, importantly, the Payment Amount is right-aligned.

You're asked to build an application that will convert data in the relational database management system to the legacy file format. To ensure that the integration works correctly, the first step is to confirm the file format by giving the legacy system maintainers a sample of the output. Later, you build on this work to send hundreds or thousands of payments to be processed via an ASCII text file.

### Add the OrderId to the output

To get started, print the Payment ID in the first six columns. You pick some random payment data that should be adequate for the purposes.

1. Delete or use the line comment operator `//` to comment out all of the code from the previous step.

1. Update your code in the Visual Studio Code Editor as follows:
   ```csharp   string paymentId = "769C";
   var formattedLine = paymentId.PadRight(6);
   Console.WriteLine(formattedLine);   ```
   Reuse the `formattedLine` variable to build the output string.

1. Save your code file, and then use Visual Studio Code to run your code. You should see the following output:
   ```Output   769C      ```

There are three blank spaces to the right that not visible. You'll confirm that they exist in the next step.

### Add the payee name to the output

Next, you add a fictitious Payee Name, padding it appropriately.

1. Update your code in the Visual Studio Code Editor as follows:
   ```csharp   string paymentId = "769C";   string payeeName = "Mr. Stephen Ortega";
   var formattedLine = paymentId.PadRight(6);   formattedLine += payeeName.PadRight(24);
   Console.WriteLine(formattedLine);   ```
   The `+=` operator performs a string concatenation, taking the previous value of the variable `formattedLine` and adding the new value to it. It's a shortened equivalent the following code example:
   ```csharp   formattedLine = formattedLine + payeeName.PadRight(24);   ```

1. Save your code file, and then use Visual Studio Code to run your code. You should see the following output:
   ```Output   769C  Mr. Stephen Ortega         ```

Again, there are quite a few blank spaces after the Payee's Name. Also, there are three blank spaces after the Payment ID from Step 1.

### Add the payment amount to the output

Next, add a fictitious Payment Amount and make sure to use `PadLeft()` to right-align the output.

1. Update your code in the Visual Studio Code Editor as follows:
   ```csharp   string paymentId = "769C";   string payeeName = "Mr. Stephen Ortega";   string paymentAmount = "$5,000.00";
   var formattedLine = paymentId.PadRight(6);   formattedLine += payeeName.PadRight(24);   formattedLine += paymentAmount.PadLeft(10);
   Console.WriteLine(formattedLine);   ```

1. Save your code file, and then use Visual Studio Code to run your code. You should see the following output:
   ```Output   769C  Mr. Stephen Ortega       $5,000.00   ```

This output is pretty close to what you understood the legacy system maintainers were looking for.

### Add a line of numbers above the output to more easily confirm the result

Since it's difficult to count the exact columns where each data element appears, you add a line directly above the output that helps you count the columns.

```csharp
Console.WriteLine("1234567890123456789012345678901234567890");
```

1. Update your code in the Visual Studio Code Editor as follows:
   ```csharp   string paymentId = "769C";   string payeeName = "Mr. Stephen Ortega";   string paymentAmount = "$5,000.00";
   var formattedLine = paymentId.PadRight(6);   formattedLine += payeeName.PadRight(24);   formattedLine += paymentAmount.PadLeft(10);
   Console.WriteLine("1234567890123456789012345678901234567890");   Console.WriteLine(formattedLine);   ```

1. Save your code file, and then use Visual Studio Code to run your code. You should see the following output, that you can send off to the maintainers of the legacy system to confirm the new integration works correctly:
   ```Output   1234567890123456789012345678901234567890   769C  Mr. Stephen Ortega       $5,000.00   ```

Success!

## Recap

There's a few important takeaways from this unit.

- The `string` data type, literal strings, and variables of type string each implement many helper methods to format, modify, and perform other operations on strings.
- The `PadLeft()` and `PadRight()` methods add white space (or optionally, another character) to the total length of a string.
- Use `PadLeft()` to right-align a string.
- Some methods are overloaded, meaning they have multiple versions of the method with different arguments that affect their functionality.
- The `+=` operator concatenates a new string on the right to the existing string on the left.