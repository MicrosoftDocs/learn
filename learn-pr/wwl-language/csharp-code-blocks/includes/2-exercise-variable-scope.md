A code block is one or more C# statements that define an execution path. The statements outside of a code block affect when, if, and how often that block of code is executed at run time. The boundaries of a code block are typically defined by squiggly braces, `{}`.

In addition to their effect on execution path, code blocks can also affect the scope of your variables. The code samples that you examine during this exercise will help you understand the relationship between code blocks and variable scope.

## Code blocks impact the scope of a variable declaration

Variable *scope* refers to a variable's visibility to the other code in your application. A locally scoped variable is only accessible inside of the code block in which it's defined. If you attempt to access the variable outside of the code block, you'll get a compiler error.

The remainder of this unit explores the relationship between code blocks and variable scope.

### Prepare your coding environment

This module includes hands-on activities that guide you through the process of building and running demonstration code. You are encouraged to complete these activities using Visual Studio Code as your development environment. Using Visual Studio Code for these activities will help you to become more comfortable writing and running code in a developer environment that's used by professionals worldwide.

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

### Create a variable inside of a code block

You will begin by looking at the case when a variable is initialized inside a code block.

1. Ensure that you have Visual Studio Code open and Program.cs displayed in the Editor panel.

    > [!NOTE]
    > Program.cs should be empty. If it isn't, select and delete all code lines.

1. Type the following code into the Visual Studio Code Editor:

    ```c#
    bool flag = true;
    if (flag)
    {
        int value = 10;
        Console.WriteLine($"Inside the code block: {value}");
    }
    ```

1. On the Visual Studio Code **File** menu, select **Save**.

    The Program.cs file must be saved before building or running the code.

1. In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

    A Terminal panel will open. The Terminal should include a command prompt showing that the Terminal is open to your TestProject folder location.

1. At the Terminal command prompt, to run your code, type **dotnet run** and then press Enter.

    > [!NOTE]
    > If you see a message saying "Couldn't find a project to run", ensure that the Terminal command prompt displays the expected TestProject folder location. For example: `C:\Users\someuser\Desktop\csharpprojects\TestProject>`

    You should see the following output:

    ```Output
    Inside the code block: 10
    ```

This is the expected output. But what if you want to access the variable `value` outside of the `if` statement code block?

### Attempt to access a variable outside the code block in which it's declared

1. In the Visual Studio Code Editor, create a new code line below the `if` statement code block.

1. On the blank code line you created, add the following line of code:

    ```c#
    Console.WriteLine($"Outside the code block: {value}");
    ```

1. Verify that your updated code looks like the following:

    ```c#
    bool flag = true;
    if (flag)
    {
        int value = 10;
        Console.WriteLine($"Inside the code block: {value}");
    }
    Console.WriteLine($"Outside the code block: {value}");
    ```

1. Save your code file, and then use Visual Studio Code to run your code.

    Enter `dotnet run` from the Terminal command prompt to run your code.

1. Notice that when you attempt to run the application, you get a compilation error:

    ```Output
    Program.cs(7,46): error CS0103: The name 'value' does not exist in the current context
    ```

The `Program.cs(7,46)` portion of the message tells you that the error is associated with line 7 in the Program.cs file, column 46.

This error is generated because a variable that's declared inside a code block is only accessible (can only be seen) within that code block. Since a variable cannot be accessed outside the code block in which it's declared, `value` cannot be accessed from line 7 of your code.

A variable that's declared in a method code block is referred to as a *local variable*. You may see the term *local variable* used when reviewing articles that discuss variable scope.

### Move the variable declaration above the code block

To access a variable both inside and outside of a code block, you'll need to declare the variable prior to (above) the code block so that the code outside the code block can "see" the variable.

1. Update your code in the Visual Studio Code Editor as follows:

    ```c#
    bool flag = true;
    int value;
    
    if (flag)
    {
        Console.WriteLine($"Inside the code block: {value}");
    }

    value = 10;
    Console.WriteLine($"Outside the code block: {value}");
    ```

1. Take a minute to review the updates.

1. Notice that `value` is now declared (but not initialized) outside the `if` code block.

1. Use Visual Studio Code to save your updates, and then run your code.

1. Notice that you still get a compilation error.

    This time, when you attempt to run the application, you get the following compilation error:

    ```Output
    Program.cs(6,49): error CS0165: Use of unassigned local variable 'value'
    ```

    The error is associated with line 6 inside the code block because `value` is uninitialized (has not been assigned a value). If the code line `value = 10;` was located above the `if` statement code block, the application would compile correctly and everything would be fine. However, since `value` hasn't been initialized, it cannot be accessed inside the code block.

    Ensuring that your variables are initialized before attempting to access them will address this issue.

### Initialize a variable as part of variable declaration

1. To initialize `value` as part of the variable declaration, update your code as follows:

    ```c#
    bool flag = true;
    int value = 0;

    if (flag)
    {
        Console.WriteLine($"Inside the code block: {value}");
    }

    value = 10;
    Console.WriteLine($"Outside the code block: {value}");
    ```

    This code addresses the "unassigned local variable" compilation error by initializing `value` as part of your variable declaration.

1. Use Visual Studio Code to save and run your code.

1. Notice that now, when you run the application, you see the following output:

    ```Output
    Inside the code block: 0
    Outside the code block: 10
    ```

### Examine the compiler's interpretation of your code

To you avoid runtime errors, the C# compiler analyzes your code in the Visual Studio Code Editor and during the build process. However, the compiler may not always interpret your code the same way that you do.

Consider the following two code samples that appear to serve the same purpose:

```c#
// Code sample 1
bool flag = true;
int value;

if (flag)
{
    value = 10;
    Console.WriteLine($"Inside the code block: {value}");
}

Console.WriteLine($"Outside the code block: {value}");
```

```c#
// Code sample 2
int value;

if (true)
{
    value = 10;
    Console.WriteLine($"Inside the code block: {value}");
}

Console.WriteLine($"Outside the code block: {value}");
```

You may feel that these two samples should always produce the same result, but the C# compiler interprets these two code samples differently.

For the first code sample, the compiler interprets `flag` as a Boolean variable that could be assigned a value of either `true` or `false`. The compiler concludes that if `flag` is `false`, `value` will not be initialized when the second `Console.WriteLine()` is executed. Essentially the compiler considers the following two code execution paths to be possible:

```c#
// path when flag = true
int value;
value = 10;
Console.WriteLine($"Inside the code block: {value}");
Console.WriteLine($"Outside the code block: {value}");
```

AND

```c#
// path when flag = false
int value;
Console.WriteLine($"Outside the code block: {value}");
```

Since the compiler considers the second path a possibility (for code sample 1), it generates an error message during the build process. In addition, the code Editor in Visual Studio Code warns you of this issue by displaying a red squiggly line under `value` (below the code block).

For the second code sample, the complier concludes that the contents of the `if` statement code block will always be executed (`true` is always `true`). The compiler doesn't generate a build error because it interprets the second code sample to have a single execution path as follows:

```c#
int value;
value = 10;
Console.WriteLine($"Inside the code block: {value}");
Console.WriteLine($"Outside the code block: {value}");
```

## Recap

Here are a few important things to remember about code blocks:

- When you declare a variable inside a code block, its visibility is local to that code block and that variable cannot be accessed outside of the code block.
- To ensure that a variable is visible both inside and outside of a code block, you must declare the variable prior to the code block (outside and above the code block).
- Ensure that variables are initialized before your code attempts to access them (for all potential code execution paths).