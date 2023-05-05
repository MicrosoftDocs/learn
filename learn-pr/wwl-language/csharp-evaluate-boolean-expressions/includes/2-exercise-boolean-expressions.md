


Decision logic is used to establish alternative pathways through your code, where the decision about which path to follow is based on the evaluation of an expression. For example, you may write some code that executes one of two paths based on a user's input. If the user enters the letter "a", your code will execute one code block. If they enter the letter "b", your code will execute a different code block. In this example, you're controlling the execution path based on the value assigned to a string. Your code selects an execution path based on an expression, how that expression is evaluated, and the underlying logic used to define the paths.

Examining how to construct and evaluate an expression is a good place to start.

## What is an expression?

An expression is any combination of values (literal or variable), operators, and methods that return a single value. A statement is a complete instruction in C#, and statements are comprised of one or more expressions. For example, the following `if` *statement* contains a single *expression* that returns a single value:

```c#
if (myName == "Luiz")
```

You may have been thinking that the value returned by an expression would be a number or maybe a string. It's true that application developers use different types of expressions for different purposes. In this case, when you're developing an `if` selection statement, you'll be using an expression that returns either `true` or `false`. Developers refer to this type of expression as a Boolean expression. When your code includes a Boolean expression, return value is always a single `true` or `false` value.

Boolean expressions are important because your code can use these expressions to decide which block of code to execute.

There are many different types of operators that you can use within a Boolean expression. For example, the `if` statement above uses the equality operator `==` to check whether a string variable is assigned a particular value. The operator that you choose will depend on the available code paths, the conditions associated with the paths, and the underlying application logic.

## Evaluating equality and inequality

One of the most common code evaluations is a check to see whether two values are equal. When checking for equality, you'll locate the equality operator `==` between the two values being checked. If the values on either side of the equality operator are equivalent, then the expression will return `true`. Otherwise, it will return `false`.

Conversely, you may also need to check whether two values aren't equal. To check for inequality, you'll use the inequality operator `!=` between the two values.

You may wonder why you need both equality and inequality operators. The reason will become clearer as you learn how to create branching statements and begin to write real world code. Two operators that perform opposite tasks allow you to be more expressive and compact.

Now it's time to prepare your coding environment and begin writing code that evaluates Boolean expressions.

### Prepare your coding environment

This module includes hands-on activities that guide you through the process of building and running demonstration code. You are encouraged you to complete these activities using Visual Studio Code as your development environment. Using Visual Studio Code for these activities will help you to become more comfortable writing and running code in a developer environment that's used by professionals worldwide.

1. Open Visual Studio Code.

   You can use the Windows Start menu (or equivalent resource for another OS) to open Visual Studio Code.

1. On the Visual Studio Code **File** menu, select **Open Folder**.

1. In the **Open Folder** dialog, navigate to the Windows Desktop folder.

   If you have a different folder location where you keep code projects, you can use that folder location instead. For this training, the important thing is to have a location that’s easy to locate and remember.

1. In the **Open Folder** dialog, select **Select Folder**.

   If you see a security dialog asking if you trust the authors, select **Yes**.

1. On the Visual Studio Code **Terminal** menu, select **New Terminal**.
   
   Notice that a command prompt in the Terminal panel displays the folder path for the current folder. For example:  

   ```dos   
   C:\Users\someuser\Desktop>   
   ```

   > [!NOTE]
   > If you are working on your own PC rather than in a sandbox or hosted environment and you have completed other Microsoft Learn modules in this C# series, you may have already created a project folder for code samples. If that's the case, you can skip over the next step, which is used to create a console app in the TestProject folder.

1. At the Terminal command prompt, to create a new console application in a specified folder, type **dotnet new console -o ./CsharpProjects/TestProject** and then press Enter.

   This .NET CLI command uses a .NET program template to create a new C# console application project in the specified folder location. The command creates the CsharpProjects and TestProject folders for you, and uses TestProject as the name of your `.csproj` file.

1. In the EXPLORER panel, expand the **CsharpProjects** folder.

   You should see the TestProject folder and two files, a C# program file named Program.cs and a C# project file named TestProject.csproj.

1. In the EXPLORER panel, to view your code file in the Editor panel, select **Program.cs**.

1. Delete the existing code lines.

   You'll be using this C# console project to create, build, and run code samples during this module.

1. Close the Terminal panel.

### Use the equality operator

1. Ensure that you have Visual Studio Code open and Program.cs displayed in the Editor panel.

   > [!NOTE]
   > Program.cs should be empty. If it isn't, select and delete all code lines.

1. Type the following code into the Visual Studio Code Editor.

   ```c#
   Console.WriteLine("a" == "a");
   Console.WriteLine("a" == "A");
   Console.WriteLine(1 == 2);
   
   string myValue = "a";
   Console.WriteLine(myValue == "a");
   ```

1. On the Visual Studio Code **File** menu, select **Save**.

   The Program.cs file must be saved before building or running the code.

1. In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

   A Terminal panel will open. The Terminal should include a command prompt showing that the Terminal is open to your TestProject folder location.

1. At the Terminal command prompt, to run your code, type **dotnet run** and then press Enter.

   > [!NOTE]
   > If you see a message saying "Couldn't find a project to run", ensure that the Terminal command prompt displays the expected TestProject folder location. For example: `C:\Users\someuser\Desktop\csharpprojects\TestProject>`


   You should see the following output.

   ```output
   True
   False
   False
   True
   ```

### Improve the check for string equality using the string's built-in helper methods

You may be surprised that the line `Console.WriteLine("a" == "A");` outputs `false`. When comparing strings, case matters.

Also, consider this line of code:

```c#
Console.WriteLine("a" == "a ");
```

Here you've added a space character at the end of the string. This expression will also output `false`.

In some cases, having a space character before or after the text might be perfectly acceptable. However, if you need to accept a match that isn't exact, you can "massage" the data first. "Massaging" the data means that you perform some cleanup before you perform a comparison for equality.

For example, consider the case when you're collecting user input inside a loop. After each value is entered, you could provide the user with a prompt to determine if they want to continue, such as `Do you want to continue (Y/N)?`. If the user wants to continue, they will probably enter either `y` or `Y`. You'll want your code to interpret both values equally, even though `y` isn't equivalent to `Y`.

Before you check two string values for equality, especially when one or both values were entered by a user, you should:

- Make sure both strings are all upper-case or all lower-case using the `ToUpper()` or `ToLower()` helper method on any string value.
- Remove any leading or trailing blank spaces using the `Trim()` helper method on any string value.

You can improve the previous equality check by chaining these two helper methods on both values, as shown in the following code listing:

1. Replace the code in the Visual Studio Code Editor with the following code:

   ```c#
   string value1 = " a";
   string value2 = "A ";
   Console.WriteLine(value1.Trim().ToLower() == value2.Trim().ToLower());
   ```

1. Save your code file, and then use Visual Studio Code to run your code.

1. Notice that when you run the code this time, it outputs **True**.

### Use the inequality operator

1. Use the line comment operator `//` to comment out all of the code from the previous step.

1. Type the following code into the Visual Studio Code Editor.

   ```c#
   Console.WriteLine("a" != "a");
   Console.WriteLine("a" != "A");
   Console.WriteLine(1 != 2);

   string myValue = "a";
   Console.WriteLine(myValue != "a");
   ````

1. Save your code file, and then use Visual Studio Code to run your code.

   You should see the following output.

   ```output
   False
   True
   True
   False
   ```

As you would expect, the result when using the inequality operator is the opposite of what you saw when using the equality operator. That means that your code will branch in the opposite manner as well, which can be exactly what you want.

## Evaluating comparisons

When working with numeric data types, you may want to determine if a value is larger or smaller than another value. Use the following operators to perform these types of comparisons:

- Greater than `>`
- Less than `<`
- Greater than or equal to `>=`
- Less than or equal to `<=`

Naturally, the `==` and `!=` operators that you used to compare string values above will also work when comparing numeric data types.

### Use the Comparison operators

1. Use the line comment operator `//` to comment out all of the code from the previous task.

1. Type the following code into the Visual Studio Code Editor.

     ```c#
     Console.WriteLine(1 > 2);
     Console.WriteLine(1 < 2);
     Console.WriteLine(1 >= 1);
     Console.WriteLine(1 <= 1);
     ```

1. Save your code file, and then use Visual Studio Code to build and run your code.

      You should see the following output:

      ```output
      False
      True
      True
      True
      ```

## Methods that return a Boolean value

Some methods return a Boolean value (`true` or `false`). In the following exercise, you'll use a built-in method of the `String` class to determine whether or not a larger string contains a specific word or phrase that's significant to your application.

> [!NOTE]
> Some data types have methods that perform helpful utility tasks. The `String` data type has many of these. Several return a Boolean value including `Contains()`, `StartsWith()`, and `EndsWith()`. You can learn more about them in the Microsoft Learn module "Manipulate alphanumeric data using String class methods in C#".

### Use a method that returns a Boolean

1. Use the line comment operator `//` to comment out all of the code from the previous step.

1. Type the following code into the Visual Studio Code Editor.
   
   ```c#
   string pangram = "The quick brown fox jumps over the lazy dog.";
   Console.WriteLine(pangram.Contains("fox"));
   Console.WriteLine(pangram.Contains("cow"));
   ```

1. Save your code file, and then use Visual Studio Code to build and run your code.
   
   You should see the following output.
   
   ```output
   True
   False
   ```

## What is logical negation?

The term "Logical Negation" refers to the `!` operator. Some people call this operator the "not operator". When you place the `!` operator before a conditional expression (or any code that's evaluated to either `true` or `false`), it forces your code to ensure that the expression is false.

Here is an example that may help you to see the connection between these ideas. The following two lines of code produce the same result. The second line is more compact.

```c#
// These two lines of code will create the same output

Console.WriteLine(pangram.Contains("fox") == false);
Console.WriteLine(!pangram.Contains("fox"));
```

### Use the Logical Negation operator

1. Use the line comment operator `//` to comment out all of the code from the previous step.

1. Type the following code into the Visual Studio Code Editor.
  
   ```c#
   string pangram = "The quick brown fox jumps over the lazy dog.";
   Console.WriteLine(!pangram.Contains("fox"));
   Console.WriteLine(!pangram.Contains("cow"));
   ```

1. Save your code file, and then use Visual Studio Code to build and run your code.
   
   You should see the following output.
   
   ```output
   False
   True
   ```

## Recap

Here's the main takeaways you learned about evaluating Boolean expressions so far:

- There are many different kinds of expressions that evaluate to either `true` or `false`.
- Evaluate equality using the `==` operator.
- Evaluating equality of strings requires you to consider the possibility that the strings have different case and leading or trailing spaces. Depending on your situation, use the `ToLower()` or `ToUpper()` helper methods, and the `Trim()` helper method to improve the likelihood that two strings are equal.
- Evaluate inequality using the `!=` operator.
- Evaluate greater than, less than and similar operations using comparison operators like `>`, `<`, `>=`, and `<=`.
- If a method returns a bool, it can be used as a Boolean expression.
- Use the logical negation operator `!` to evaluate the opposite of a given expression.