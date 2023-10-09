In this exercise, you work with integral types. An **integral type** is a simple value type that represents whole numbers with no fraction (such as `-1`, `0`, `1`, `2`, `3`). The most popular in this category is the **`int`** data type.

There are two subcategories of integral types: **signed** and **unsigned** integral types.

A *signed type* uses its bytes to represent an equal number of positive and negative numbers. The following exercise gives you exposure to the signed integral types in C#.

## Prepare your coding environment

This module includes hands-on activities that guide you through the process of building and running demonstration code. You're encouraged to complete these activities using Visual Studio Code as your development environment. Using Visual Studio Code for these activities help you to become more comfortable writing and running code in a developer environment that's used by professionals worldwide.

> [!NOTE]
> If you have completed other Microsoft Learn modules in this C# series, you may have already created a project folder for code samples. If that's the case, you can skip  the following section of steps, and delete the code in the `Project.cs` file used for a previous exercise.

1. Open Visual Studio Code.

    You can use the Windows Start menu (or equivalent resource for another OS) to open Visual Studio Code.

1. On the Visual Studio Code **File** menu, select **Open Folder**.

1. In the **Open Folder** dialog, navigate to the Windows Desktop folder.

    If you have different folder location where you keep code projects, you can use that folder location instead. For this training, the important thing is to have a location that’s easy locate and remember.

1. In the **Open Folder** dialog, select **Select Folder**.

    If you see a security dialog asking if you trust the authors, select **Yes**.

1. On the Visual Studio Code **Terminal** menu, select **New Terminal**.

    Notice that a command prompt in the Terminal panel displays the folder path for the current folder. For example:  

    ```dos
    C:\Users\someuser\Desktop>
    ```

1. At the Terminal command prompt, to create a new console application in a specified folder, type **dotnet new console -o ./CsharpProjects/TestProject** and then press Enter.

    This .NET CLI command uses a .NET program template to create a new C# console application project in the specified folder location. The command creates the CsharpProjects and TestProject folders for you, and uses TestProject as the name of the `.csproj` file.

1. In the EXPLORER panel, expand the **CsharpProjects** folder.

    You should see the TestProject folder and two files, a C# program file named Program.cs and a C# project file named TestProject.csproj.

1. In the EXPLORER panel, to view your code file in the Editor panel, select **Program.cs**.

1. Delete the existing code lines.

    You're using this C# console project to create, build, and run code samples during this module.

1. Close the Terminal panel.

### Use the MinValue and MaxValue properties for each signed integral type

1. Ensure that you have Visual Studio Code open and Program.cs displayed in the Editor panel.

    **Program.cs should be empty.** If it isn't, select and delete all code lines.

1. To see the value ranges for the various data types, type the following code into the Visual Studio Code Editor.

    ```csharp
    Console.WriteLine("Signed integral types:");

    Console.WriteLine($"sbyte  : {sbyte.MinValue} to {sbyte.MaxValue}");
    Console.WriteLine($"short  : {short.MinValue} to {short.MaxValue}");
    Console.WriteLine($"int    : {int.MinValue} to {int.MaxValue}");
    Console.WriteLine($"long   : {long.MinValue} to {long.MaxValue}");
    ```

1. On the Visual Studio Code **File** menu, select **Save**.

    The Program.cs file must be saved before building or running the code.

1. In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

    A Terminal panel should open, and should include a command prompt showing that the Terminal is open to your TestProject folder location.

1. At the Terminal command prompt, to run your code, type **dotnet run** and then press Enter.

    If you see a message saying "Couldn't find a project to run", ensure that the Terminal command prompt displays the expected TestProject folder location. For example: `C:\Users\someuser\Desktop\csharpprojects\TestProject>`

    You should see the following output:

    ```Output
    Signed integral types:
    sbyte  : -128 to 127
    short  : -32768 to 32767
    int    : -2147483648 to 2147483647
    long   : -9223372036854775808 to 9223372036854775807
    ```

For most non-scientific applications, you likely only need to work with `int`. Most of the time, you won't need more than a positive to negative 2.14 billion whole numbers.

## Unsigned integral types

An *unsigned type* uses its bytes to represent only positive numbers. The remainder of the exercise introduces the unsigned integral types in C#.

### Use the MinValue and MaxValue properties for each unsigned integral type

1. Below the previous code passage, add the following code:

    ```csharp
    Console.WriteLine("");
    Console.WriteLine("Unsigned integral types:");
    
    Console.WriteLine($"byte   : {byte.MinValue} to {byte.MaxValue}");
    Console.WriteLine($"ushort : {ushort.MinValue} to {ushort.MaxValue}");
    Console.WriteLine($"uint   : {uint.MinValue} to {uint.MaxValue}");
    Console.WriteLine($"ulong  : {ulong.MinValue} to {ulong.MaxValue}");
    ```

1. Save your code file, and then use Visual Studio Code to run your code.

You should see the following output:

    ```Output
    Signed integral types:
    sbyte  : -128 to 127
    short  : -32768 to 32767
    int    : -2147483648 to 2147483647
    long   : -9223372036854775808 to 9223372036854775807
    
    Unsigned integral types:
    byte   : 0 to 255
    ushort : 0 to 65535
    uint   : 0 to 4294967295
    ulong  : 0 to 18446744073709551615
    ```

While a given data type can be used for many cases, given the fact that the `byte` data type can represent a value from 0 to 255, it's obvious that this is intended to hold a value that represents a *byte* of data. Data stored in files or data transferred across the internet is often in a binary format. When working with data from these external sources, you need to receive data as an array of bytes, then convert them into strings. Many of the methods in the .NET Class Library that deal with encoding and decoding data requires you handle byte arrays.

## Recap

- An integral type is a simple value data type that can hold whole numbers.
- There are signed and unsigned numeric data types. Signed integral types use 1 bit to store whether the value is positive or negative.
- You can use the `MaxValue` and `MinValue` properties of numeric data types to evaluate whether a number can fit in a given data type.